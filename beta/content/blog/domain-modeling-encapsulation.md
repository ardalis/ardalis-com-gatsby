---
title: Domain Modeling - Encapsulation
date: "2022-05-18T00:00:00.0000000"
description: Domain models should encapsulate logic operations so that there is only one way to perform a given logical operation. That means avoiding exposing entity state and ensuring operations flow through specific methods. By funneling specific operations through specific code pathways, you can be sure constraints around the operations are enforced.
featuredImage: /img/domain-modeling-encapsulation.png
---

Domain models should encapsulate logic operations so that there is only one way to perform a given logical operation. That means avoiding exposing entity state and ensuring operations flow through specific methods. By funneling specific operations through specific code pathways, you can be sure constraints around the operations are enforced.

In the [previous article](/domain-modeling-anemic-models/), I demonstrated some of the problems that result when one tries to use an anemic domain model. Some developers even go so far as to mandate as a coding standard that all logic live in services, rather than in domain objects or entities. I don't recommend this procedural style of coding to.NET and C# developers.

## Where is the logic

Ok, so recall from the last article that there are Projects, and Projects have ToDoItems, and a new requirement is that when a ToDoItem is completed, users who are interested in it should get some notification. In the previous article we had to resort to putting this new behavior in the UI code of the API endpoints, rather than keeping it in our domain model:

```csharp
[HttpPut("[namespace]/projects")]
public override async Task<ActionResult<Project>> HandleAsync(UpdateToDoItemRequest request,
	CancellationToken cancellationToken = default)
{
	var project = (await Data.Projects)
			.FirstOrDefault(p => p.Id == request.ProjectId);
	if (project == null) return NotFound();
	var item = project.ToDoItems
			.FirstOrDefault(i => i.Id == request.ToDoItemId);
	if (item == null) return NotFound();
	if (request.UpdatedIsDone)
	{
		NotificationService.NotifyToDoItemCompleted(item);
	}
	item.IsDone = request.UpdatedIsDone;
	item.Name = request.UpdatedName;

	return project;
}
```

We don't want business logic about notifications in our UI layer, but we also don't want to tightly couple our domain model to the notification service implementation (shown here as a static but nothing really changes if it's an instance class).

## Time for a Domain Service?

One approach that many developers will immediately reach for is a domain service. A domain service is simply a service that lives in your domain model and operates on your domain objects (aggregates and entities). Unlike the stateful domain objects, stateless domain services are created with the application's DI container, and thus can have dependencies injected into them. Thus, when you have a requirement that needs a dependency (like a notification service), it's often a pretty easy leap to make to say"I know! Let's use a domain service!"

Unfortunately, doing this does nothing to help an anemic domain model. All it does is require that the domain service have more and more access into the internals of the domain model objects. As a larger and larger proportion of logic lives in services that operate *on* the objects rather than *in* the objects, the objects get closer and closer to being just DTOs (if they didn't start out that way).

Also, consider the experience from the client of the domain - the code that calls your domain model. Imagine that a ToDoItem has two methods:

- MarkComplete()
- MarkIncomplete()

Working with this model is straightforward:

- Get an item
- Call MarkComplete/Incomplete
- Save the item

But then along comes a new requirement - completed items need to send notifications. So, out comes the trusty domain service to the rescue. The service provides a new `public void MarkComplete(ToDoItem item)` method and is able to send notifications using a service injected into it. Hurray!

But now how do you work with the domain model?

Well, if you're marking an item complete, you do this:

- Get an item
- Get a ToDoItemService
- Call the service's MarkComplete method, passing it the item
- Save the item? Or did the service do that?

But if you're marking it incomplete, then it's still just:

- Get an item
- Mark Incomplete
- Save the item

**What you now have is an inconsistent, confusing interface.**

Given that you're not able to inject services into an entity and you need a service to send notifications, obviously *the only way to regain consistency is to move everything to domain services*. **Congratulations**, your domain objects are just DTOs and **you have all the problems of the [previous article](/domain-modeling-anemic-models/).**

## Encapsulation

[Encapsulation](https://deviq.com/principles/encapsulation) is an incredibly important concept in computer science as well as software engineering and design. Why? Because you can't trust any object that doesn't leverage encapsulation effectively, which means your code is either riddled with validation checks or simply prone to errors.

The basic idea of encapsulation is that the public interface of a type can serve as a contract while the internal implementation details are a black box and are inaccessible from outside. A key point is that the internal state or data of an object instance is inaccessible from the outside. And thus, any behavior that depends on changes to this state can be placed within the object, rather than having to remember to apply it from the outside in:

> Object: I'm in this state.
> Outsider: Did you change?
> Outsider: Did you change?
> Outsider: Did you change?
> Outsider: Oh, you did? Then run this logic.

As mentioned in the previous article, this leads to violations of the [Tell, Don't Ask principle](https://deviq.com/principles/tell-dont-ask). Instead of constantly checking the object's state (or directly mutating it), give it higher level operations to perform and let it deal with any logic that should apply as a result, too.

> Object: I'm in this state.
> Outsider: Good to know. Please do this (calls method on Object).

That's it. If there's more logic to run as a result of the operation, it's not the outside calling code's responsibility to ensure it happens. Which means that we can't forget to do it! We can rely on it happening any time the state change requires it.

## Domain Events Pattern

There are many ways to achieve this sort of behavior. One I'm quite fond of is the domain events pattern, which Julie Lerman and I discuss in our [Pluralsight DDD Fundamentals course](https://www.pluralsight.com/courses/fundamentals-domain-driven-design). A domain event is simply an event that is raised in response to some operation that takes place in the domain. When you're listening to stakeholders describe how a system should behave, listen for phrases like"when that happens, the system should...". That's usually a good indicator that a domain event might be a good fit.

I've also described [different kinds](https://www.youtube.com/watch?v=95CxduH1b8A&ab_channel=weeklydevtips) of [domain events](https://www.youtube.com/watch?v=j2oLdaK19dQ&ab_channel=weeklydevtips) in my [WeeklyDevTips podcast](https://www.youtube.com/channel/UC1OeiOnqUZHVinzRK5MuHsA). Check it out if you're not familiar or need a refresher.

Domain events are [value objects](https://deviq.com/domain-driven-design/value-object). They're immutable. They happened in the past (so name them that way). And handling them shouldn't raise exceptions. Although I don't always like C# records for value objects, for domain events they typically work just fine.

## Domain Event Types

```csharp
using MediatR;

namespace DomainModeling.Web.Endpoints.Encapsulated;

public abstract record DomainEventBase: INotification
{ }
```

Here's a simple `DomainEventBase` class that can be used by any Domain Events defined for a given domain model. I usually define domain events in the same folder as the aggregate that raises them. In the sample used for this article, there is a `Project` aggregate which contains a collection of `ToDoItem`s. There's some behavior that should occur whenever an item is completed, so we'll define a domain event for that:

```csharp
public record ToDoItemCompletedEvent(ToDoItem ToDoItem): DomainEventBase;
```

With these in place we have the events, but we need a way to store and publish them at the proper time. I like to store them in a collection on the entity base type:

```csharp
namespace DomainModeling.Web.Endpoints.Encapsulated;

public abstract class EntityBase
{
 public int Id { get; set; }

 private List<DomainEventBase> _events = new();
 internal IEnumerable<DomainEventBase> Events => _events.AsReadOnly();

 protected void RegisterDomainEvent(DomainEventBase domainEvent) => _events.Add(domainEvent);
 internal void ClearDomainEvents() => _events.Clear();
}
```

The `EntityBase` type that all entities inherit stores a collection of domain events. It supports registering new events as well as clearing the events when needed.

We need to ensure that any time a ToDoItem is completed, the event is registered. We don't want to trigger events when the item is already complete, or if it's changed from incomplete to complete. The best way to achieve this is to make the property private and provide a single method for setting it to true, `MarkComplete`. Inside `MarkComplete` we can register the domain event, as shown here:

```csharp
public void MarkComplete()
{
 if (IsDone) return;

 IsDone = true;
 RegisterDomainEvent(new ToDoItemCompletedEvent(this));
}
```

Remember, registering the event just adds it to a collection. We need some additional code to dispatch the events and trigger their handlers.

The last piece of plumbing you need is some way to publish events, invoking their handlers. I'm using [MediatR](https://github.com/jbogard/MediatR) for this, although you can write your own reflection-based implementation if you'd rather. For the use case we're looking at, post-persistence events make the most sense, so I will publish the events on entities after I've successfully saved them. The code below is just sample code, [a real implementation can be found here](https://github.com/ardalis/CleanArchitecture/blob/main/src/Clean.Architecture.Infrastructure/Data/AppDbContext.cs#L36-L60).

```csharp
 public IMediator Mediator { get; }

 public DataService(IMediator mediator)
 {
 Mediator = mediator;
 }

 public async Task SaveChanges()
 {
	// this would loop through tracked objects if done in a DbContext
 foreach (var project in _projects)
 {
 foreach (var item in project.ToDoItems)
 {
 foreach (var domainEvent in item.Events)
 {
 await Mediator.Publish(domainEvent);
 }
 item.ClearDomainEvents();
 }
 }
 }
```

(for a complete example of this using EF Core, check out my [Clean Architecture solution template](https://github.com/ardalis/cleanarchitecture))

Once MediatR publishes the event(s) that are stored in the entities, the handlers are executed. This happens in memory, sequentially, in the same process. There's no message queue or bus or anything like that involved. You can step from the `Publish` call to the handler methods directly in the debugger, and a given event can have multiple handlers. This is one reason why your events shouldn't throw exceptions, because if they do it may leave the model in an inconsistent state, with some handlers having fired successfully and others not.

The final piece of the puzzle is the handler. Handlers usually go in the same folder as the aggregate they operate on, and often it can be beneficial to put the handler **inside the entity that raises the event** so that it has access to that entity's private state if needed.

> Does this break encapusulation?

No, because the nested handler class really is part of the entity that contains it, so the entity is still responsible for all of its behavior.

Here's an example of a domain event handler that's defined inside of an entity. In this case it doesn't really need access to any of the entity's private state, but if it did it would have that access. ([click here to see the full class](https://github.com/ardalis/DomainModeling/blob/main/src/DomainModeling.Web/Endpoints/Encapsulated/ToDoItem.cs))

```csharp
 /// <summary>
 /// ToDoItem.CompletedItemHandler
 /// Handlers within domain entity classes can access private state of entities
 /// </summary>
 public class CompletedItemHandler: INotificationHandler<ToDoItemCompletedEvent>
 {
 public CompletedItemHandler() // TODO: Inject INotificationService here
 {
 }
 public Task Handle(ToDoItemCompletedEvent domainEvent, CancellationToken cancellationToken)
 {
 NotificationService.NotifyToDoItemCompleted(domainEvent.ToDoItem);

 return Task.CompletedTask;
 }
 }
```

## Working with the domain model

Whether your work with your entities from an application service or directly from your UI logic, it's nice to be able to have a safe, consistent API to use. When working with the domain model, you no longer have to remember to add behavior *around* it. You can count on the business rules to be safely implemented *within* the domain model itself. Thus, in the endpoint responsible for updating a ToDoItem, the code looks like this:

```csharp
 [HttpPut("[namespace]/projects")]
 public override async Task<ActionResult<Project>> HandleAsync(UpdateToDoItemRequest request,
 CancellationToken cancellationToken = default)
 {
 var project = (await DataService.Projects)
.FirstOrDefault(p => p.Id == request.ProjectId);
 if (project == null) return NotFound();
 var item = project.ToDoItems
.FirstOrDefault(i => i.Id == request.ToDoItemId);
 if (item == null) return NotFound();
 if (request.UpdatedIsDone)
 {
 item.MarkComplete();
 }
 item.Name = request.UpdatedName;

 await _dataService.SaveChanges();
 return project;
 }
```

Essentially, the steps are:

- Get a project
- Get the appropriate item
- If the request is marking its IsDone property to true, call MarkComplete
- Perform any other operations on the project/item
- Save changes

I haven't implemented a MarkIncomplete method but you can expect it will follow this same pattern - no domain service required!

You can [download the latest version of domain modeling coding series here](https://github.com/ardalis/DomainModeling).

## Summary

Avoid creating anemic domain models, or models that lack encapsulation. Don't be too quick to reach for domain services. Consider a pattern like domain events, or sometimes something simpler like passing a required service as a method parameter. Try to guard against invalid inputs wherever possible, and ensure that logical requirements exist in only one place, and that your design funnels all logic that needs this operation to call it through the API you've chosen to expose.

Good luck!

