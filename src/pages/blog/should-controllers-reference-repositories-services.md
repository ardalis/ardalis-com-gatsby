---
templateKey: blog-post
title: Should Controllers Reference Repositories or Services
date: 2021-09-14
description: A common question students ask when learning about Clean Architecture, SOLID, and/or DDD is whether controllers (or razor pages or API endpoints) should work with repositories directly, or if they should only communicate with services. As with many questions in software, the answer is, "it depends", but I can offer some recommendations.
path: blog-post
featuredpost: false
featuredimage: /img/should-controllers-reference-repositories-services.png
tags:
  - mvc
  - api endpoints
  - asp.net
  - asp.net core
  - solid
  - ddd
  - clean architecture
  - software architecture
category:
  - Software Development
comments: true
share: true
---

**Last updated: 13 October 2023**

A common question students ask when learning about [Clean Architecture](https://www.nuget.org/packages/Ardalis.CleanArchitecture.Template/), [SOLID](https://www.pluralsight.com/courses/csharp-solid-principles), and/or [Domain-Driven Design (DDD)](https://www.pluralsight.com/courses/fundamentals-domain-driven-design) is whether controllers (or razor pages or [API Endpoints](https://www.nuget.org/packages/Ardalis.ApiEndpoints/) should work with repositories directly, or if they should only communicate with services. As with many questions in software, the answer is, "it depends", but I can offer some recommendations. A related question to this one, at more of an architectural level, is whether your Clean Architecture-using app needs a separate Application Layer, since often it's the Application Layer that would house the services we'll discuss here. We'll touch on that as well.

In web applications, the entry point is typically a controller action, a razor page handler, or an API Endpoint (a more SOLID version of a controller action - I'll just use the term endpoint to apply to any of these going forward). If you're following a clean architecture approach, your app should consist of several class libraries, typically Web, Core/Domain, and Infrastructure. As much as possible, the Web project should not depend on the Infrastructure project, but instead both Infrastructure and Web should depend on the Core project and its abstractions and domain model. If you're following DDD, this domain model should hold nearly all of the app's business logic, and so many operations will involve working with entities and aggregates in the domain model by fetching them from persistence, calling methods on them, and then saving their updated state. Both the Core and Infrastructure projects will have services in them, typically. Domain services in Core, and various adapters for working with out-of-process resources in Infrastructure. Repositories, for instance, are simply a service for working with out-of-process persistence stores, but it's faster and more clear to use the more specific pattern name.

All of this is background for the question at hand: when is it OK to just use a repository directly (in an API endpoint or MVC action), and when would it be better to use a service?

## Just use a repository

Say you have an API that works with a product catalog for an online store. Maybe it's used by a mobile app, desktop app, and/or SPA to fetch product details for a particular view. It might have a route like `GET /products/{id}`, which returns a JSON-encoded representation of a product. The actual code might look something like this:

```csharp
[HttpGet("products/{id}")]
public ActionResult<ProductResult> GetById(int id)
{
  var product = _repo.GetById(id);
  var result = Mapper.Map<ProductResult>(product);

  return Ok(result);
}
```

An even simpler endpoint might support deleting a product:

```csharp
[HttpDelete("products/{id}")]
public ActionResult Delete(int id)
{
  var product = _repo.GetById(id);
  _repo.Delete(product);
  
  return NoContent();
}
```

 **Note** This is pseudo code; ignore any typos.

What's common about these two methods is that they have absolutely no business logic in them. In the GetById case, there's both persistence and mapping taking place (because you should NEVER expose your domain/data model as your API wire protocol), and in the Delete case there's not even mapping to consider. Assume that common checks like 404s and other error handling are being dealt with via filters (and of course mapping could also be performed with a filter).

Given that there is no business logic and all that's happening is basic CRUD, a service wouldn't really add much value. It might drop the lines of code from 3 down to 2 but that hardly justifies creating and maintaining services and associated methods for every action that looks like these and is merely doing CRUD operations.

### What about domain logic in entities?

But what if there's some real logic happening in the entities that are involved? Maybe instead of just viewing or deleting products, the API is responsible for something more interesting. What if the API is responsible for the user adding an item to their cart. Some actual logic might be tied to this behavior. Instead of just adding an entry to a list or inserting a record in a database, if the item already exists, its quantity should be increased. Maybe special pricing rules kick in based on how many of an item were purchased, or what other items are in the cart. Perhaps UI updates or some analytics are driven by domain events that are dispatched as part of the operation.

But if the domain model is well-designed and is not anemic, all of this logic can be performed in the domain model's entities and aggregates themselves. Pulling logic out of these and putting it into a separate application service typically just results in a more anemic domain model with less encapsulation. One that doesn't follow the [Tell, Don't Ask principle](https://deviq.com/principles/tell-dont-ask) as well, since some external service must now make decisions based on the state of the model.

In a case like this one, it may make sense to simply grab the current cart from persistence and call its `AddItem` method, with an endpoint that might look like this one:

```csharp
[HttpPost("cart/AddItem")]
public ActionResult AddItem(AddItemRequest request)
{
  var cart = _repo.GetById(request.CartId);
  cart.AddItem(request.ProductId, request.Quantity);
  _repo.Update(cart);
  
  return Ok();
}
```

At this point we're up to 3 lines of code: fetch the aggregate, call a method on it, save the aggregate. You can move this to a service but it only saves you 2 lines of code per endpoint, so in my opinion unless you have a lot of these, it's not necessarily worth it for the effort involved. It's really a tossup, though, and if there's any additional logic beyond what this shows, that quickly starts to push it over the edge toward using a service.

## Use a service

Ok so if it's literally just CRUD, a service is perhaps overkill. And if there is logic but it's all done in the app's domain model, then it may be fine to just work directly with the domain model from the endpoint. The problem arises when a little more logic is required. The endpoint should follow the Single Responsibility Principle, and for a typical endpoint that responsibility is to validate the incoming request (perhaps with the help of filters like `[ApiController]`), execute the app logic needed for the endpoint, and then return a response. Frequently there's mapping required from the request and/or to form the response, and while ideally this should be a separate responsibility it's often included in the endpoint, especially if the details are defined elsewhere.

What if the operation is more involved, though? There's not just one call to persistence required, but several. There response isn't just a simple 1-for-1 mapping from an entity but is a custom DTO built from multiple domain types? In situations like these, an application service makes sense. The goal is to keep the endpoint from growing too big and complex, and from having too many responsibilities. Recall that mapping is already a stretch, and if that grows from being just a trivial call to something like `Mapper.Map<T>` it's usually best to get that complexity out of the endpoint code.

Let's look at an example. This endpoint builds a viewmodel for a store application's main product catalog view. It supports paging, so in addition to returning the details of the products to display, it also needs to include any necessary data required to render the paging UI elements, like current page, total pages, and total items.

```csharp
public async Task<CatalogIndexViewModel> GetCatalogItems(int pageIndex, int itemsPage, int? brandId, int? typeId)
{
  _logger.LogInformation("GetCatalogItems called.");

  var filterSpecification = new CatalogFilterSpecification(brandId, typeId);
  var filterPaginatedSpecification =
      new CatalogFilterPaginatedSpecification(itemsPage * pageIndex, itemsPage, brandId, typeId);

  // the implementation below using ForEach and Count. We need a List.
  var itemsOnPage = await _itemRepository.ListAsync(filterPaginatedSpecification);
  var totalItems = await _itemRepository.CountAsync(filterSpecification);

  var vm = new CatalogIndexViewModel()
  {
    CatalogItems = itemsOnPage.Select(i => new CatalogItemViewModel()
    {
      Id = i.Id,
      Name = i.Name,
      PictureUri = _uriComposer.ComposePicUri(i.PictureUri),
      Price = i.Price
    }).ToList(),
    Brands = (await GetBrands()).ToList(),
    Types = (await GetTypes()).ToList(),
    BrandFilterApplied = brandId ?? 0,
    TypesFilterApplied = typeId ?? 0,
    PaginationInfo = new PaginationInfoViewModel()
    {
      ActualPage = pageIndex,
      ItemsPerPage = itemsOnPage.Count,
      TotalItems = totalItems,
      TotalPages = int.Parse(Math.Ceiling(((decimal)totalItems / itemsPage)).ToString())
    }
  };

  vm.PaginationInfo.Next = (vm.PaginationInfo.ActualPage == vm.PaginationInfo.TotalPages - 1) ? "is-disabled" : "";
  vm.PaginationInfo.Previous = (vm.PaginationInfo.ActualPage == 0) ? "is-disabled" : "";

  return vm;
}
```

There are two [specifications](https://github.com/ardalis/Specification) here and two repository method calls, the results of which are used to build up a fairly complicated viewmodel type that includes catalog items, paging data, as well as data used to populate UI selection lists for brands and types. The latter two lists have their own application service methods (which I haven't included for space reasons). You'll find [the latest version of this service in the eShopOnWeb reference app](https://github.com/dotnet-architecture/eShopOnWeb/blob/main/src/Web/Services/CatalogViewModelService.cs).

I hope you agree that having all of this logic within a single endpoint would be way too much for one method, especially in addition to the routing, model validation, and other responsibilities of an endpoint. In these kinds of scenarios, I think it's more than appropriate to use a service rather than just a respository as the abstraction level with which the endpoint code works.

But this leads to more questions, because nobody likes inconsistency or answers that aren't as simple as "Always do this" and "Never do that".

### What about consistency of my controller's dependencies

Your methods and, ideally, your classes should operate at a single, consistent level of abstraction. One way you can identify classes that don't follow this principle is by looking at the dependencies they accept through their constructor (which of course they define there because they follow the Explicit Dependencies Principle, right?). If the constructor takes in infrastructure adapter services like repositories and file access services and email sending services, that's all consistent. And if it only works with application services or even domain services, that's fine, too. The trouble comes when you mix-and-match, and your class now depends on high level domain abstractions as well as low level infrastructure adapters (even if only as interfaces). One way to avoid this would be to declare across the board that all controllers only work with application level services (because consistency!). But if you only have a handful of endpoints that do substantial logic and most of them are really just CRUD, this results in a lot of extra work for no real benefit, creating a new application service method that's basically just a pass-through to the repository call.

While I can get behind having some level of consistency of abstraction within a method, and also within a cohesive class, I'm not a fan of trying to enforce consistency across all classes just for consistency's sake. Use the level of abstraction most appropriate to the code at hand, and if you want to avoid having multiple levels of abstraction in your controller stemming from different methods having different needs, then maybe consider [ditching controllers and just using endpoints instead](https://ardalis.com/mvc-controllers-are-dinosaurs-embrace-api-endpoints/) to avoid these kinds of problems.

### What about using MediatR

You can use [MediatR](https://github.com/jbogard/MediatR) to reduce the total code in your controllers. You still need to make the same decisions about what types your handlers will work with, though. Also if the only thing you're using MediatR for is to slim down your controllers, just get rid of MediatR **and** the controllers by using [ApiEndpoints](https://github.com/ardalis/ApiEndpoints).

### Where should application services live in Clean Architecture solutions

The last frequently asked question is, where to put application service classes when you decide you want to use one. Ideally such classes should define methods that accept the request coming into a given endpoint and should return a response type that is already mapped and ready to return. Why is this important? Well, if we know what the signature of the application service's methods looks like, it can help us decide where it can or should live in our solution. Usually API models live in the web project, or sometimes in a separate class library (such as a shared library in a Blazor Clint app). In order for the application service to be able to use these types, the service classes must be defined in the same project, or they must be defined in a project that depends on the project with the request and response DTOs. That means they can't go in Core/Domain or Infrastructure - they have to go into Web or some separate library that Web references.

My usual preference is to simply create a Services folder in the UI project and add any app services there. Some teams prefer to push the DTOs up into the code domain project, but I try to avoid this if I can since it introduces a dependency between the pure domain model and a particular UI implementation.

## Summary

Should your controller actions work with repositories or services? It depends! You can go with just services for all the things, but you're probably going to be writing a lot of trivial pass-through services. Alternately, you can choose to use the approach that best fits what a given endpoint method is doing. In that case you might find that simple CRUD operations work just fine with direct repository access, as do endpoints that delegate to a single method on a single domain entity. If you have more going on than that, though, you probably really do want to use an application service, for which you should define and implement an interface and then inject it into your endpoint's class.

