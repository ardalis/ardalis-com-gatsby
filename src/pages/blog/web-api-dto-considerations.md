---
templateKey: blog-post
title: Web API DTO Considerations
date: 2022-01-25
description: When designing web APIs, it's important to think about how the data being passed to and from the endpoint will be structured. How important is reuse in these considerations, and how much reuse can you get away with before it starts causing other problems?
path: blog-post
featuredpost: false
featuredimage: /img/web-api-dto-considerations.png
tags:
  - software architecture
  - software design
  - web api
  - REST
category:
  - Software Development
comments: true
share: true
---

When designing web APIs, it's important to think about how the data being passed to and from the endpoint will be structured. How important is reuse in these considerations, and how much reuse can you get away with before it starts causing other problems?

Recently someone in my [devBetter coaching group](https://devBetter.com) asked:

> Why do you create Request and Response classes in your ApiEndPoints? Is just a DTO not enough?

The question is referring to my [API Endpoints package](https://www.nuget.org/packages/Ardalis.ApiEndpoints/) and samples, which provide generic types for API request and result types (though they could both refer to the same DTO, if desired). Let's back up for a moment, review what DTOs are and some guidance on what NOT to use for your wire protocol and your APIs, and then wrap up by answering the question.

## What's a DTO and why use them for Web APIs

A DTO, or Data Transfer Object, is a type that has no behavior, only state. DTOs aren't expected to follow typical object-oriented design rules like encapsulation, but rather should simply consist of a set of public properties. Record types in C# provide an easy, succinct way to define DTOs in the latest versions of the language. DTOs are frequently used to transfer data over some medium, being serialized and then deserialized in the process. The actual class definition can exist on both ends of this transfer, as long as it includes the expected set of properties. Behavior (methods, logic) doesn't transfer, and in fact can be completely different on either end of the exchange.

The DTO provides a *contract* for the shape of the data. Since behavior doesn't transfer between client and server, and since client and server may not even use the same platform, framework, or language, it's best to use a simple DTO (that can serialize to JSON or another format) for web API requests and results.

By definition, DTOs only contain data, not behavior.

> **A DTO that contains behavior is not a DTO.**

Finally, [don't confuse DTOs with POCOs](https://ardalis.com/dto-or-poco/).

## Reusing entities as web api contracts

Most data-driven apps use *entities* at the domain model or data model layer (or both). Domain entities should include business logic, and so are ill-suited to being used as API models. If your domain entities are DTOs, then it's likely you have an [anemic domain model](https://deviq.com/domain-driven-design/anemic-model), which (among other things) may indicate you don't actually need to be applying [Domain-Driven Design](https://www.pluralsight.com/courses/fundamentals-domain-driven-design). Also, it's quite common for there to be security issues caused by exposing your app's interior structure (domain model, data model) through its API model.

In short, [avoid (re)using your entities directly as your web api's model](https://ardalis.com/your-api-and-view-models-should-not-reference-domain-models/).

## Web API DTO Design

So we're saying that web APIs should use DTOs for their contracts. DTOs should have no behavior, only state. And these DTOs should not be (or reference) entities in our domain and/or data models.

Back to the original question, why would we need more than one DTO for a given resource, like a Customer? Why should API endpoints have custom types for requests and results?

Let's look at a very simple Customer DTO:

```csharp
public class CustomerDTO
{
  public int Id { get; set;}
  public string Name { get; set; }
  public DateTime DateCreated { get; set; }
}
```

## Get By Id

Now let's think about how we might design certain API endpoints around this DTO. First, a simple GET endpoint that returns a customer given a valid ID:

```http
GET /customers/123
```

The request for this endpoint should be an `int` or `long` or some type that includes a numeric `Id` property, so it can be used to look up the appropriate customer. The result could be a `CustomerDTO` or it could be a `404 Not Found` or other result, so typically the endpoint would return at least `ActionResult<CustomerDTO>`, and not simply `CustomerDTO`, to allow for this flexibility. Something like this:

```csharp
Task<ActionResult<CustomerDTO>> GetById(int id);
```

Let's say that's good enough and move on to a list of customers.

## List

```http
GET /customers
```

The simplest approach to returning a list of customers is to do the same thing as for a single customer, but as a list:

```csharp
Task<ActionResult<List<CustomerDTO>>> List();
```

This might be fine if there aren't many customers, but if there are thousands or more it might make sense to incorporate more parameters into the request. Things like paging, implemented with skip and take, are pretty common to add, resulting in something more than this parameterless method. On the result side, it's not unusual to construct a result that includes paging data in it, as well as other metadata like the total record count. Sure, the result will *also* include some collection of `CustomerDTO` instances, but neither the DTO nor a simple collection of the DTO will be the result. The method might end up looking something like this:

```csharp
Task<ActionResult<CustomerPagedListResult>> List();

// this could be a record if preferable
public class PagedCustomerListResult
{
  public int TotalRecords { get; set; }
  public int PageSize { get; set; }
  public int PageIndex {get; set; }
  public List<CustomerDTO> Customers { get; set; }
}
```

## Create

What about mutating methods? Can we just use the DTO for those? Let's start with creating a new record.

```http
POST /customers
```

This one's easy, right? Just pass the DTO and we're done:

```csharp
Task<ActionResult<CustomerDTO>> Create(CustomerDTO newCustomer);
```

Actually, it *is* this easy, if you're using client-generated keys. Replace the `int Id` with a `Guid Id` and this signature is perfect. You could probably even simplify it to not return the DTO with the response, since in any successful case it should be the same.

Or should it?

There are actually two things about our DTO as we defined it above that are best set on the server: `Id` and `DateCreated`. If we're using persistence-generated keys (e.g. IDENTITY column), then that will be set server-side. And the creation date is frequently something we don't want set on the client, either. For one thing, the client's time zone could result in dates being entered into our system that are all over the place (we might [fix this by using DateTimeOffset instead of DateTime](https://ardalis.com/why-use-datetimeoffset/)). More importantly, if we're using that creation date for important auditing or even business rules, we never want the client to be able to set its value. Imagine if someone could become eligible for a big discount as a loyal customer who'd been with the company for 20 years just by setting that value using Postman...

It turns out, the only thing we need to create a Customer in this case is a `Name`. In a real app there would probably be a bunch more things, but `Id` and `DateCreated` shouldn't be among them. So we might need something closer to this:

```csharp
Task<ActionResult<CustomerDTO>> Create(CreateCustomerRequest newCustomer);

// see how compact records are?
public record CreateCustomerRequest(string name);
```

## Update

Now let's look at performing an update. Let's consider a typical HTTP endpoint for this operation:

```http
PUT /customers/123
```

Given this route, you'll see endpoint definitions like this one:

```csharp
Task<ActionResult<CustomerDTO>> Update(int id, CustomerDTO newCustomer);
```

Do you see the problem with this "typical" approach?

An API is a very specific contract. It shouldn't contain any ambiguity. The above signature accepts an `id` from the route. However, the `CustomerDTO` also contains an `Id` property. Which one should be used? What if more than one is used? Why design an API that has ambiguity baked into it and creates confusion and additional error handling? Design it so there is only one right way of doing things:

```http
PUT /customers
```

and

```csharp
Task<ActionResult<CustomerDTO>> Update(CustomerDTO newCustomer);
```

Great. Now there's still the `DateCreated` problem, though (just like for Create, above) so we'll need another `Request` object:

```csharp
Task<ActionResult<CustomerDTO>> Update(UpdateCustomerRequest newCustomer);

public record UpdateCustomerRequest(int customerId, string name);
```

What about deletion?

## Delete

The typical delete route:

```http
DELETE /customers/123
```

and endpoint signature:

```csharp
Task<ActionResult> Delete(int customerId);
```

This works great without changes! Yes, some developers will try to pass the DTO, but you don't need all that. And some might try to return the DTO, but the client already has it so that's not necessary, either. And sometimes folks will just return `void` or `Task` but then you don't have any way to return other results like `Bad Request` or `Server Error` or even `Not Found` if you're checking for that before performing the delete.

In general, it's a good idea to always return some kind of `IActionResult` or `ActionResult` so that you have flexibility in what you return, especially in non-success cases.

## How did our DTO work out

Ok so our final interface for these 5 CRUD operations looks like this:

```csharp
Task<ActionResult<CustomerDTO>> GetById(int id);
Task<ActionResult<CustomerPagedListResult>> List();
Task<ActionResult<CustomerDTO>> Create(CreateCustomerRequest newCustomer);
Task<ActionResult<CustomerDTO>> Update(UpdateCustomerRequest newCustomer);
Task<ActionResult> Delete(int customerId);
```

Each method has request inputs and an output type, for a total of ten possible type. If we were going for maximum reuse of the `CustomerDTO` we would expect to see it twice on every line for a total of 10/10 possible uses. Counting up the total in the method signatures above, we get 3/10. So, there is some reuse value in the standard DTOs we choose for our API, but we shouldn't aim to just blindly copy them across every endpoint.

## Summary

At first glance, it might seem that API endpoints could all make use of a single DTO representing any given resource. However, in practice there are often a lot of tradeoffs and disadvantages to this naive approach. It's simpler, yes. It's more consistent, yes. But it's also more restrictive in what it allows endpoints to return to the client and not restrictive enough in what it allows clients to send.

Think about your non-API methods. Do you try to reuse a single parameter object for dozens of methods and their return types? With rare exceptions (like return types on the [Builder pattern](https://deviq.com/design-patterns/builder-pattern)), this isn't a good practice. Why not? Because you don't want to be passing around instances that have more properties than you need for a particular operation. So simply apply that same logic as you design the contracts on your web API endpoints.

If you found this useful, please sign up for my [tips](/tips) newsletter and [follow me on twitter, where I'm @ardalis](https://twitter.com/ardalis). Thanks!
