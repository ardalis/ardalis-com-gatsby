---
templateKey: blog-post
title: Keep Tests Short and DRY with Extension Methods
date: 2021-02-09
description: Many automated tests end up being more verbose than necessary, with a lot of plumbing and setup code. Using simple extension methods is one technique you can use to keep tests shorter without making them harder to read and comprehend.
path: blog-post
featuredpost: false
featuredimage: /img/keep-tests-short-and-dry-with-extensions.png
tags:
  - clean code
  - testing
  - functional tests
  - web api
  - http
  - integration tests
  - asp.net core
  - xunit
category:
  - Software Development
comments: true
share: true
---

Today as I was writing functional tests for [API endpoints](https://github.com/ardalis/ApiEndpoints) again I created some helpers to assist with the boilerplate code involved in such tests. When you're testing an API endpoint, you typically need to write code that looks like this:

- Create data to send in request (optional)
- Make an HTTP request to a route/URL
- Verify the response is successful
- Capture the response as a string
- Convert the string into a type
- Make assertions that the type is what you expected

Here's an example of such a functional test, using [xUnit](https://xunit.net/) and [System.Text.Json](https://docs.microsoft.com/en-us/dotnet/api/system.text.json?view=net-5.0) (with full class for reference):

```csharp
public class DoctorsList : IClassFixture<CustomWebApplicationFactory<Startup>>
{
  private readonly HttpClient _client;
  private readonly ITestOutputHelper _outputHelper;

  public DoctorsList(CustomWebApplicationFactory<Startup> factory, ITestOutputHelper outputHelper)
  {
    _client = factory.CreateClient();
    _outputHelper = outputHelper;
  }

  [Fact]
  public async Task Returns3Doctors()
  {
    var response = await _client.GetAsync("/api/doctors");
    response.EnsureSuccessStatusCode();
    var stringResponse = await response.Content.ReadAsStringAsync();
    _outputHelper.WriteLine(stringResponse);
    var result = JsonSerializer.Deserialize<ListDoctorResponse>(stringResponse,
      Constants.DefaultJsonOptions);

    Assert.Equal(3, result.Doctors.Count());
    Assert.Contains(result.Doctors, x => x.Name == "Dr. Smith");
  }
}
```

## Functional tests and Integration tests

As an aside, the [docs (which I wrote the initial versions of) refer to these as integration tests](https://docs.microsoft.com/en-us/aspnet/core/test/integration-tests?view=aspnetcore-5.0), which isn't wrong, but I prefer the term functional tests because it's more specific. Any test that involves several classes or talks to some infrastructure is no longer a unit test, but an integration test (or perhaps some other kind). Need to test that your DbContext can actually insert and fetch data from a real data source? Use an integration test. What differentiates a *functional* test from other kinds of integration tests is that it's testing *most of* the app's functionality from the outside. In the case of ASP.NET Core MVC apps, these functional tests aren't just testing an action method or a controller (or endpoint type), but are also testing routing, filters, model binding, model validation, dependency injection, and more! And they're doing it all in memory without the need for a separate web server, browser client, or network layer (so, no firewall or port or security issues to contend with!).

But back to the topic at hand...

## Duplication in Tests

Some duplication in tests is fine, if it makes the tests more readable and less magic. You want a new developer to be able to look at a failing test and immediately be able to determine what the problem is. Having tests that are completely abstract and magic can make this difficult. However, in my experience the bigger problem is duplication in tests. Excessive duplication in tests leads to [code smells and antipatterns like shotgun surgery](https://deviq.com/antipatterns/code-smells), in which a small change to a method or constructor signature in the system under tests results in hundreds of compilation errors as test methods everywhere fail to build because they all were hardwired to use that signature.

I'm a fan of keeping test classes small and focused, and tests neat and to-the-point as well. I follow a [test naming and organization convention](https://ardalis.com/unit-test-naming-convention/) that yields one test class per method being tested, and for functional tests of APIs this works out to one test class per API route or endpoint. However, long tests with a lot of repetition make it harder to pick out the signal from the noise when you're reviewing a set of tests. Imagine the code listing above, but with another half dozen tests all very similar but for a few tiny changes in their assertions or something similar.

## Helper methods

One tried and true approach to keeping tests clean and DRY is to use helper methods. You absolutely should do this wherever it makes sense. I do it all the time. However, helper methods usually are only useful within the test class where they reside. As such, they usually take the form of a standard method/function, rather than an extension method (which must reside in its own static class). Occasionally they'll make sense for a set of tests or even a whole project.

But what if you have something you'd like to reuse across many test projects?

## Extension methods

Extension methods provide a way to add functionality as needed to existing types. They work basically the same as helper methods, but the syntax is a little cleaner and they're easier to share via NuGet packages than other approaches since all that's needed to use them is a using statement. In the example above, if you looked at the `Returns3Doctors` test and compared it to another test of another endpoint called `Returns2Items` (or whatever), what would need to change between the two tests?

- The API route/URL
- The type being deserialized into
- The assertions

I very rarely move assertions out of tests, since the assertion is one of the most important parts of a test and something I want to keep very clear. Developers shouldn't have to go searching for what a test is asserting. But the rest of the steps involved in this test could easily be refactored into a method that took in a route string and returned an instance of a type. That could take 5+ (+ because line wrapping) lines of code down to 1 (or maybe 1+).

Here's what such an extension method might look like:

```csharp
public static async Task<T> GetAndDeserialize<T>(this HttpClient client, string requestUri, ITestOutputHelper output = null)
{
    var response = await client.GetAsync(requestUri);
    output?.WriteLine($"Requesting {requestUri}");
    response.EnsureSuccessStatusCode();
    var stringResponse = await response.Content.ReadAsStringAsync();
    output?.WriteLine($"Response: {stringResponse}");
    var result = JsonSerializer.Deserialize<T>(stringResponse,
      Constants.DefaultJsonOptions);

    return result;
}
```

This method is optionally taking in the xUnit `ITestOutputHelper` class which is needed to write to the console in xUnit tests. Being able to see the actual string output from APIs is often helpful, since frequently minor issues in schema or JSON conventions can result in getting back `null` for the object result even though valid JSON was returned from the request.

Now this method can be used as an extension on `HttpClient`, which of course the test already has and must use:

```csharp
[Fact]
public async Task Returns3Doctors()
{
  var result = await _client.GetAndDeserialize<ListDoctorResponse>("/api/doctors", _outputHelper);

  Assert.Equal(3, result.Doctors.Count());
  Assert.Contains(result.Doctors, x => x.Name == "Dr. Smith");
}
```

## Sharing on NuGet

How is an extension method that much better than a simple helper method, again? Well, it turns out you can create a NuGet package in just a few minutes so that it's really easy to share your method between projects, and even with the community as a whole. Maybe you're the only one who will find your method useful, but who knows?

To take this simple method and put it on NuGet, I did the following steps:

- Created a [new GitHub repo](https://github.com/ardalis/HttpClientTestExtensions)
- Cloned it locally
- Created a new .NET Standard Class Library
- Put the extension method in it
- Modified its [project file to add NuGet properties](https://github.com/ardalis/HttpClientTestExtensions/blob/main/src/Ardalis.HttpClientTestExtensions/Ardalis.HttpClientTestExtensions.csproj) (I cheated and copied them from another project)
- Right-click on project in Visual Studio, choose Pack (or use `dotnet pack`)
- Logged into NuGet.org
- Chose Upload Package (.nupkg file created by `pack`)

That's it. A few minutes later, [the package was on NuGet.org](https://www.nuget.org/packages/Ardalis.HttpClientTestExtensions), and I could start using it in my test project as a NuGet reference instead of more code for me to maintain in my test project. Now I'll never have to write this same helper method again (this wasn't my first time, mind you), and hopefully this will help out a few others as well!

## Future work

As of today this NuGet package literally has one extension method in it. That's kind of the point of this article is that it's *really easy* to publish a package even if it's something as simple as just one extension method you find useful.

But in this case, I do plan on there being more extensions in this package. Most APIs have more than just GET endpoints, and right now I don't have extensions for building POST, PUT, DELETE, etc. with built-in logging for xUnit and automatic serialization/deserialization via System.Text.Json. I expect to add those quickly, since in the next day or two I'll be writing tests for those kinds of endpoints for the samples for my [Pluralsight DDD Fundamentals course update](https://app.pluralsight.com/profile/author/steve-smith). Look for the new course in spring 2021; in the meantime the existing DDD course on my author page covers the material but uses .NET 4.x for its samples.

If you find these extensions useful, please [leave a star in the repo](https://github.com/ardalis/HttpClientTestExtensions) and feel free to add any issues or pull requests for features you'd like to see added. Thanks!
