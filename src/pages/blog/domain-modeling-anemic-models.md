---
templateKey: blog-post
title: Domain Modeling - Anemic Models
path: blog-post
date: 2022-05-11
description: When building a domain model, proper object-oriented design and encapsulation should be applied as much as possible. Some teams choose to intentionally create anemic models with little encapsulation, which can lead to problems.
featuredpost: false
featuredimage: /img/domain-modeling-anemic-models.png
tags:
  - architecture
  - domain-driven design
  - ddd
  - domain modeling
category:
  - Software Development
comments: true
share: true
---

When building a domain model, proper object-oriented design and encapsulation should be applied as much as possible. Some teams choose to intentionally create [anemic models](https://deviq.com/domain-driven-design/anemic-model) with little encapsulation, which can lead to problems. Some of my past [NimblePros](https://nimblepros.com) clients have even had coding conventions and standards that basically required every domain entity be essentially a DTO, with no methods and a bunch of public properties. This results in essentially procedural programming, not OOP, and fails to leverage many of the OO features of .NET and C#.

Let's look at an example. You'll find [the source code for this article on GitHub](https://github.com/ardalis/DomainModeling). Start in the `Endpoints/Anemic` folder for this article. For a more detailed view into domain modeling, check out my [DDD Fundamentals Course on Pluralsight](https://www.pluralsight.com/courses/fundamentals-domain-driven-design).

## An Anemic Model

The model for this example is quite simple (intentionally). There is a `Project` with a name, and there are a set of tasks called `ToDoItem`s that are associated with a `Project`.

```csharp
public class Project : BaseEntity
{
  public string Name { get; set; } = "";
  public List<ToDoItem> ToDoItems {get; set;} = new();
}
public class ToDoItem : BaseEntity
{
  public string Name { get; set; } = "";
  public string Description { get; set; } = "";
  public bool IsDone { get; set; }
}
public abstract class BaseEntity
{
  public int Id { get; set; }
}
```

A few things to note:

- Project directly exposes a `List<ToDoItem>`. [Don't do this](https://ardalis.com/avoid-collections-as-properties/).
- Every property has a setter, and there are no methods, making these [DTOs](https://ardalis.com/dto-or-poco/).

This domain model serves an application, and that application hosts a set of Web APIs to allow working with the domain model. The APIs include:

- GET a Project by Id
- PUT to update a ToDoItem on a Project
- PATCH to complete an entire Project

These are configured and working if you grab the source from GitHub (see above) and run the application:

![Swagger Screenshot](/img/domain-modeling-swagger-v1.png)

The sample code just uses a static in-memory collection for the data, which is reset every time the app starts. Here's an example [endpoint](https://github.com/ardalis/ApiEndpoints):

```csharp
using Ardalis.ApiEndpoints;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace DomainModeling.Web.Endpoints.Anemic;

public class GetById : EndpointBaseAsync
		.WithRequest<int>
		.WithActionResult<Project>
// https://ardalis.com/your-api-and-view-models-should-not-reference-domain-models/
{
	/// <summary>
	/// Gets a Project with its ToDoItems
	/// </summary>
	/// <param name="id">A Project Id</param>
	/// <param name="cancellationToken"></param>
	/// <returns></returns>
	[HttpGet("[namespace]/projects/{id}")]
	[SwaggerOperation(Tags = new[] { "Anemic" })]
	public override async Task<ActionResult<Project>> HandleAsync(int id,
		CancellationToken cancellationToken = default)
	{
		var project = (await Data.Projects).FirstOrDefault(p => p.Id == id);
		if (project == null) return NotFound();
		return Ok(project);
	}
}
```

**Note** for this sample I'm just using my domain model for my API wire protocol. [Don't do this in real code](https://ardalis.com/your-api-and-view-models-should-not-reference-domain-models/
).

## Add Some Behavior

With the above code any client app (SPA, mobile, desktop, etc.) can leverage the APIs to work with the existing sample Project and its associated ToDoItems. Let's assume some client app(s) exist and have been released into the hands of users, who now have a new feature request:

> When a ToDoItem is completed, a notification should be sent to interested users.

For the sake of simplicity, we'll assume that somewhere else in the domain model we're tracking which users are interested in which ToDoItems. For our purposes it will suffice to use a common notification service like this one:

```csharp
public static class NotificationService
{
	public static void NotifyToDoItemCompleted(ToDoItem item)
	{
		Console.WriteLine($"Item {item.Name} is complete.");
	}
}
```

Pretend that that's actually sending emails and/or text messages to every individual who has "followed" that item.

Again, in real code, you would ideally not take a direct static dependency on a method that deals with I/O or other infrastructure. But that's not the point of this article.

Now, to implement the feature request, you just need to go to the endpoint where tasks are updated, and add the appropriate line of code to send the notification:

```csharp
using Ardalis.ApiEndpoints;
using Microsoft.AspNetCore.Mvc;

namespace DomainModeling.Web.Endpoints.AnemicV2;

public class UpdateToDoItem : EndpointBaseAsync
				.WithRequest<UpdateToDoItemRequest>
				.WithActionResult<Project>
{
	/// <summary>
	/// Updates a ToDoItem
	/// </summary>
	/// <param name="request"></param>
	/// <param name="cancellationToken"></param>
	/// <returns></returns>
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
}
```

Another feature done! Ship it and walk out the door!

### Wait a sec

Is the design above missing anything? For instance, what happens if some client code allows a user to change the name of a ToDoItem that's already marked as done?

At a minimum the above code should probably do a check to verify the status is actually changing before it sends out notifications.

And I know I said this isn't how we'd do it in real code, but it's worth noting here that this code is going to be awful to try to test. Again, not the point, but make sure you recognize it.

But the really nasty problem is one that you probably don't see here. You might not even see it if you pull down the source code and look at the whole thing, or even run it. In fact it's quite likely that nobody will notice it at all until the code is in production, when eventually some user will (somehow) notice that they weren't notified that a particular ToDoItem had been marked complete.

And you might not be able to figure out why, especially if you start looking for clues in the code above. "How, " you ask, "is someone hitting this endpoint, marking a ToDoItem as complete, and yet it's not triggering a notification?".

Some investigation and grey hair later, it dawns on you.

This isn't the only way to mark a ToDoItem as complete. The API also lets users mark a whole project as done. You didn't work on that part of the app, and it's not used that often, but it's still there. Here's the code:

```csharp
using Ardalis.ApiEndpoints;
using Microsoft.AspNetCore.Mvc;
using Swashbuckle.AspNetCore.Annotations;

namespace DomainModeling.Web.Endpoints.AnemicV2;

public class Complete : EndpointBaseAsync
				.WithRequest<int>
				.WithActionResult<Project>
{
	/// <summary>
	/// Completes a project and all of its todo items
	/// </summary>
	/// <param name="projectId"></param>
	/// <param name="cancellationToken"></param>
	/// <returns></returns>
	[HttpPatch("[namespace]/projects/{projectId}")]
	[SwaggerOperation(Description = "Complete a Project", Summary = "Complete a Project", Tags = new[] { "Anemic" })]
	public override async Task<ActionResult<Project>> HandleAsync(int projectId,
	CancellationToken cancellationToken = default)
	{
		var project = (await Data.Projects)
				.FirstOrDefault(p => p.Id == projectId);
		if (project == null) return NotFound();
		project.ToDoItems.ForEach(item => item.IsDone = true); // Notifications should be sent here but aren't

		return project;
	}
}
```

I put a comment in the source to help folks find the problem.

## Principles That Apply

The biggest problem here is the complete lack of [encapsulation](https://deviq.com/principles/encapsulation) on the part of the domain model types. Without encapsulation, changes to the model can come from anywhere, and any rules about whether or how changes should occur or what they might trigger need to be applied outside of the model. Repeatedly.

Which leads to the [Don't Repeat Yourself or DRY principle](https://deviq.com/principles/dont-repeat-yourself). Don't design your domain model in such a way that requires repetition in order to apply the model's rules. The rules should exist in one place and your design should force operations for which the rule applies through a single gateway that enforces the rules.

In this case, the problem is one of [Tell, Don't Ask](https://deviq.com/principles/tell-dont-ask). The calling code in the API endpoints is checking the state of the ToDoItem (or at least, it should be, to ensure the state was changed) in question, and then wrapping behavior around it. The fact that the domain model is just an anemic DTO means there is nowhere for the logic of the rules of the operation to exist except in the calling code. The higher level operation of marking an incomplete item as complete isn't available in the model; the model only exposes a boolean property and a setter. It's up the calling code to do all of the work of enforcing the appropriate behavior around this primitive construct.

Instead, the ToDoItem should have exposed a method, "MarkComplete()" (or similar), that would do all of the work in a consistent manner.

I'll write a follow-up article describing how this design works, compared to the anemic one considered here.

## Summary

Domain models are meant to include the business rules of an application, not just the data model. When you relegate your business logic to services that operate on an anemic, behavior-free domain model, your domain model types are nothing but DTOs and you're more likely to have problems with your model. Applying proper object-oriented design and principles can help avoid this trap.
