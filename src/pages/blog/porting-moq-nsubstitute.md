---
templateKey: blog-post
title: Porting Moq to NSubstitute
date: 2023-08-10
description: "If for some reason you find yourself wanting to switch from Moq to another test double framework, here's how to do it." 
path: blog-post
featuredpost: false
featuredimage: /img/porting-moq-nsubstitute.png
tags:
  - testing
  - unit tests
  - moq
  - mocks
  - mocking
  - nsubstitute
  - tdd
category:
  - Software Development
comments: true
share: true
---

If *for some reason* you find yourself wanting to switch from [Moq](https://nuget.org/packages/Moq) to another test double framework like [NSubstitute](https://www.nuget.org/packages/NSubstitute), here's how to do it.

## Working with Moq

I've used Moq for many years and am comfortable with it. I also appreciate that it has a short name, which makes it easier to type, say, etc. than longer names with 4+ syllable. I've heard of NSubstitute but never used it until literally today, when I decided to try it out.

I found porting from Moq to NSubstitute to be trivial and actually I like the fact that NSubstitute uses the same types as the ones it's substituting.

Here's an example of a method for which I would use a test double to test some behavior:

```csharp
public class DeleteContributorService : IDeleteContributorService
{
  private readonly IRepository<Contributor> _repository;
  private readonly IMediator _mediator;
  private readonly ILogger<DeleteContributorService> _logger;

  public DeleteContributorService(IRepository<Contributor> repository,
    IMediator mediator,
    ILogger<DeleteContributorService> logger)
  {
    _repository = repository;
    _mediator = mediator;
    _logger = logger;
  }

  public async Task<Result> DeleteContributor(int contributorId)
  {
    _logger.LogInformation("Deleting Contributor {contributorId}", contributorId);
    var aggregateToDelete = await _repository.GetByIdAsync(contributorId);
    if (aggregateToDelete == null) return Result.NotFound();

    await _repository.DeleteAsync(aggregateToDelete);
    var domainEvent = new ContributorDeletedEvent(contributorId);
    await _mediator.Publish(domainEvent);
    return Result.Success();
  }
}
```

This class has three dependencies: a repository, a mediator, and a logger. I want to test that when the repository returns null, the method returns a NotFound result. I also want to test that when the repository returns a valid aggregate, the method returns a Success result. Finally, I want to test that when the method returns a Success result, it publishes a domain event.

Here's how I would do that with Moq (showing just the first test):

```csharp
public class DeleteContributorService_DeleteContributor
{
  private readonly Mock<IRepository<Contributor>> _mockRepo = new Mock<IRepository<Contributor>>();
  private readonly Mock<IMediator> _mockMediator = new Mock<IMediator>();
  private readonly Mock<ILogger<DeleteContributorService>> _mockLogger = new Mock<ILogger<DeleteContributorService>>();
  private readonly DeleteContributorService _service;

  public DeleteContributorService_DeleteContributor()
  {
    _service = new DeleteContributorService(_mockRepo.Object, _mockMediator.Object, _mockLogger.Object);
  }

  [Fact]
  public async Task ReturnsNotFoundGivenCantFindContributor()
  {
    var result = await _service.DeleteContributor(0);

    Assert.Equal(Ardalis.Result.ResultStatus.NotFound, result.Status);
  }
}
```

This works fine, but notice that all of the types in question or `Mock<T>` and that injecting them into the SUT requires using their `.Object` property. I've been doing this for at least a decade using Moq so I'm pretty used to it, but when compared to NSubstitute it's more verbose and requires more typing.

## The NSubstitute Version

```csharp
public class DeleteContributorService_DeleteContributor
{
  private readonly IRepository<Contributor> _repository = Substitute.For<IRepository<Contributor>>();
  private readonly IMediator _mediator = Substitute.For<IMediator>();
  private readonly ILogger<DeleteContributorService> _logger = Substitute.For<ILogger<DeleteContributorService>>();

  private readonly DeleteContributorService _service;

  public DeleteContributorService_DeleteContributor()
  {
    _service = new DeleteContributorService(_repository, _mediator, _logger);
  }

  [Fact]
  public async Task ReturnsNotFoundGivenCantFindContributor()
  {
    var result = await _service.DeleteContributor(0);

    Assert.Equal(Ardalis.Result.ResultStatus.NotFound, result.Status);
  }
}
```

This test also passes - the behavior is the same. Notice that the only difference is that I'm using `Substitute.For<T>()` instead of `Mock<T>()`. I'm also not using the `.Object` property to get the actual object to inject into the SUT. I'm injecting the test doubles directly. This is a small difference, but it's one I like. I also like that the test doubles are the same types as the ones they're substituting. This makes it easier to remember what they are and what they do.

## What About Setup?

I didn't show any setup in the above examples, but it's pretty similar. Here's how I would set up a test double to return a value in Moq:

```csharp
_mockRepo.Setup(r => r.GetByIdAsync(It.IsAny<int>()))
  .ReturnsAsync(new Contributor());
```

Here's how I would do the same thing in NSubstitute:

```csharp
_repository.GetByIdAsync(Arg.Any<int>())
  .Returns(Task.FromResult<new Contributor()>());
```

Note once more that the latter is less verbose and doesn't require using a lambda, which many developers, especially new developers, find confusing at first (I've taught testing and TDD for many years).

## Summary and Resources

If you already have tests that use Moq and you're happy sticking with it, that's great. If you're looking for a new test double framework, NSubstitute is a good choice. It's easy to use and has a lot of features. It's also easy to port from Moq to NSubstitute, as I've shown here.

- [NSubstitute on NuGet](https://www.nuget.org/packages/NSubstitute/)
- [Moq on NuGet](https://www.nuget.org/packages/Moq/)
