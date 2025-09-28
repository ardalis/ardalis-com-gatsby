---
title: Immediate Domain Event Salvation with MediatR
date: "2020-07-08T00:00:00.0000000"
description: How to wire up immediate pre persistence domain events in ASP.NET Core with MediatR.
featuredImage: /img/immediate-domain-event-salvation-with-mediatr.png
---

Domain events are one of my favorite patterns and one Julie Lerman and I cover in our [DDD Fundamentals course, on Pluralsight](https://www.pluralsight.com/courses/domain-driven-design-fundamentals). I differentiate between two kinds of domain events: pre-persistence and post-persistence. You'll find a good implementation of post-persistence domain events (using MediatR) in my Clean Architecture solution template. However, until recently, I hadn't built an immediate, pre-persistence implementation of domain events for.NET using MediatR. This is meant to follow a similar approach to [Udi Dahan's classic static helper](http://udidahan.com/2009/06/14/domain-events-salvation/), which relied on StructureMap and static methods.

## Adding Immediate Domain Events to an ASP.NET Core App

First, you probably want to add MediatR to your app. If you haven't used MediatR before, here's a quick article showing [how to add MediatR to ASP.NET Core](https://ardalis.com/using-mediatr-in-aspnet-core-apps/). Once you have MediatR, you might find that you can [use MediatR to clean up your controllers significantly](https://ardalis.com/moving-from-controllers-and-actions-to-endpoints-with-mediatr/), perhaps eventually even leading you to [use Api Endpoints and the REPR pattern instead of Controllers](https://github.com/ardalis/ApiEndpoints). But that's all at the Web/UI level, not the domain model. In this article, we'll talk about how to wire up MediatR for domain events in your domain model.

Because we want to trigger these events from our entities and domain model, and because we can't easily inject services or dependencies into these types, we're going to need a static helper class. This class should live in your Core project, or perhaps SharedKernel, so that it is accessible from your domain model types. Here's an example of such a class:

```csharp
public static class DomainEvents
{
 [ThreadStatic] // ensure separate func per thread to support parallel invocation
 public static Func<IMediator> Mediator;
 public static async Task Raise<T>(T args) where T: INotification
 {
 var mediator = Mediator.Invoke();
 await mediator.Publish<T>(args);
 }
}
```

Obviously for this to work, you'll also need to take a dependency on MediatR in your Core or SharedKernel class. You'll also need to wire it up in your front end application (in this case, ASP.NET Core). Note that the Mediator static property is a factory method that returns the current scoped instance of MediatR. We'll see how that's wired up at the end of this article.

With this in place, you can work with domain events easily from your domain model. For example, let's say you want to verify that an entity's name is unique. You can't easily do this using data annotations or within the entity itself, and you need to make this check prior to saving the entity (assuming you're not relying on a database constraint to catch this for you). You could implement your update logic like this:

```csharp
public void Update(string name)
{
 DomainEvents.Raise(new UpdatingNameEvent(this.Id, name)).Wait();

 Name = name;
}
```

Disregarding the fact that this Update method probably should be async since it's calling an async method, this approach lets us perform some work in a handler before we set the name to a new value. Using MediatR, we can wire up a handler to look for duplicates. This isn't quite as easy as it sounds, because you can't just check the table to see if a record exists with the name. You have to check that it's a different record that has the name - otherwise your updates will fail if you ever try to do an update to the current value (which would probably be a no-op when your ORM's change tracker got involved anyway).

So, here's what a handler might look like that would do the duplicate check. Note that this handler also can live in the Core project:

```csharp
public class ValidateUniqueCatalogItemNameHandler: INotificationHandler<UpdatingNameEvent>
{
 private readonly IAsyncRepository<CatalogItem> _asyncRepository;

 public ValidateUniqueCatalogItemNameHandler(IAsyncRepository<CatalogItem> asyncRepository)
 {
 _asyncRepository = asyncRepository;
 }

 public async Task Handle(UpdatingNameEvent notification, CancellationToken cancellationToken)
 {
 var allItems = (await _asyncRepository.ListAllAsync()).ToList();

 var duplicateItem = allItems.FirstOrDefault(i => i.Name == notification.NewName && i.Id!= notification.Id);

 if(duplicateItem!= null)
 {
 throw new DuplicateCatalogItemNameException("Duplicate name not allowed", duplicateItem.Id);
 }
 }
}
```

Note that domain event handlers can have dependencies, so this is a nice way to perform operations in your domain entities that require dependencies. This is much nicer than shifting all behavior that has dependencies to services and requiring clients of your model to know whether they need to use a service method or an entity method to perform an operation on the entity.

Here's what the event looks like in this scenario:

```csharp
public class UpdatingNameEvent: INotification
{
 public UpdatingNameEvent(int id, string newName)
 {
 Id = id;
 NewName = newName;
 }

 public int Id { get; }
 public string NewName { get; }
}
```

## Wiring it up

The last thing you need to do is wire things up in the application's startup. This is made slightly more difficult because we're trying to use MediatR statically, so we need a way to get the current scoped instance of it. We're doing this in Startup.cs in ConfigureServices.

**NOTE:** This needs to happen per-thread since we're using `[ThreadStatic]` which means at a minimum non-Core apps will need to configure the Func in `Application_BeginRequest` and Core apps might need it to be set up in some middleware that runs before ASP.NET Core MVC kicks in. I haven't had a chance to update the associated GitHub repo with any of these findings, so use at your own risk.

```csharp
services.AddMediatR(typeof(CatalogItem).Assembly);
ServiceLocator.SetLocatorProvider(services.BuildServiceProvider());
DomainEvents.Mediator = () => ServiceLocator.Current.GetInstance<IMediator>();
```

For the service locator, I used [the class in this article](https://dotnetcoretutorials.com/2018/05/06/servicelocator-shim-for-net-core/) and it worked well for me. Repeating it below just for completeness here.

```csharp
public class ServiceLocator
{
 private ServiceProvider _currentServiceProvider;
 private static ServiceProvider _serviceProvider;

 public ServiceLocator(ServiceProvider currentServiceProvider)
 {
 _currentServiceProvider = currentServiceProvider;
 }

 public static ServiceLocator Current
 {
 get
 {
 return new ServiceLocator(_serviceProvider);
 }
 }

 public static void SetLocatorProvider(ServiceProvider serviceProvider)
 {
 _serviceProvider = serviceProvider;
 }

 public object GetInstance(Type serviceType)
 {
 return _currentServiceProvider.GetService(serviceType);
 }

 public TService GetInstance<TService>()
 {
 return _currentServiceProvider.GetService<TService>();
 }
}
```

And with that, it works! I probably can replace the ServiceLocator with something else or a Nuget package but for now this is all working with the code shown above. Eventually I'll probably incorporate this into the code in eShopOnWeb or CleanArchitecture, though as of today it's not there yet.

**NOTE** I'm still testing this; it might have issues in highly concurrent scenarios. And I'm still not sure I'm a fan of the service location going on here. But it does seem like a modernized version of Udi's classic pattern (which as far as I know works without issues).

## More references

- [DDD Fundamentals on Pluralsight](https://www.pluralsight.com/courses/domain-driven-design-fundamentals)
- [SOLID Principles for C# Developers on Pluralsight](https://www.pluralsight.com/courses/csharp-solid-principles)

