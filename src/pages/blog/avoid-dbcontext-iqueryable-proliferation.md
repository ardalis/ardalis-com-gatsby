---
templateKey: blog-post
title: Avoid Proliferating DbContext or IQueryable in .NET Apps
date: 2023-05-10
description: Most .NET apps use EF Core and a DbContext for data access, but maintainability can suffer when the use of a DbContext or an IQueryable derived from it is allowed to spread throughout an application.
path: blog-post
featuredpost: false
featuredimage: /img/avoid-dbcontext-iqueryable-proliferation.png
tags:
  - dotnet
  - ef core
  - aspnet
  - asp.net
  - ef
  - entity framework
category:
  - Software Development
comments: true
share: true
---

Most .NET apps use EF Core and a DbContext for data access, but maintainability can suffer when the use of a DbContext or an IQueryable derived from it is allowed to spread throughout an application. Let's briefly describe how IQueryable works with EF Core and then consider how restricting access to IQuerable (or not) affects the overall maintainability of an app.

## What is IQueryable

The `IQueryable` and `IQueryable<T>` interfaces in .NET allow queries to be described as expression trees, which upon execution can be traversed and translated by a query provider. In the case of EF Core, [IQueryable interfaces](https://learn.microsoft.com/en-us/dotnet/api/system.linq.iqueryable?view=net-7.0) are used to allow for dynamic SQL query generation. This in turn allows for granular and efficient queries to be executed on the database, rather than pulling more data than needed into application memory and then filtering the result in memory.

In the following code snippet, a set of Orders from a particular date range is created. In the first example, all orders in the database are transferred to the application, and then filtered. In the second, a dynamic SQL query is used, allowing the database to return only the matching records.

```csharp
DateTime sinceDate = new DateTime(2023,1,1);

// filter in memory
var allOrders = dbContext.Orders.ToList();
var recentOrders1 = allOrders
                .Where(o.OrderDate > sinceDate)
                .ToList();

// filter with SQL at database
var recentOrders2 = dbContext.Orders
                .Where(o.OrderDate > sinceDate)
                .ToList();
```

Obviously the speed and efficiency of the second approach will almost always make it the preferred method.

It's also possible to build up an IQueryable expression over a series of statements, even across different functions, classes, or projects. When it was first announced, Microsoft lauded this capability because it meant that developers would be able to construct the appropriate query "just in time" wherever they needed to do so, ensuring only the necessary data was returned when the query ultimately executed. While this is true, the trade-offs of this approach are pretty big.

## IQueryable All The Way Down

![Passing IQueryable everywhere vs. passing dbcontext everywhere meme - they're the same](/img/iqueryable-dbcontext-everywhere.jpg)

Imagine you have an application that has several logical layers. It doesn't matter if it's all in one project or spread across several projects in an [N-Tier](https://www.pluralsight.com/courses/n-tier-apps-part1) or [Clean Architecture](https://github.com/ardalis/CleanArchitecture) manner - the effect is the same. Let's say it's an ASPNET Razor Page or MVC View-based application that uses Razor to generate HTML on the server. Following separation of concerns, perhaps there's a data service that knows how to get data, and it exposes a method like this one:

```csharp
public class OrderDataService
{
  // other things omitted

  public async Task<IQueryable<Order>> ListOrders()
  {
      return await _dbContext.Orders.AsQueryable();
  }
}
```

In addition to some data services, there are also business services that perform additional business logic. In this case maybe canceled orders should generally not be included in query results, so the business service takes care of this.

```csharp
public class OrderBusinessService
{
  // OrderDataService is injected into this service
  public async Task<IQueryable<Order>> ListActiveOrders()
  {
    var allOrders = await _orderDataService.ListOrders();

    return await allOrders
                .Where(o => !o.IsCanceled)
                .AsQueryable();
  }
}
```

Now we come to the Page/Controller class, where some code exists to call the business service and bind the result to a ViewModel that will be used by the Razor page/view:

```csharp
// inside a GET action or OnGet handler:
var viewModel = await _orderBizSvc.ListActiveOrders()
                        .Where(o => o.CreatedBy = username)
                        .AsQueryable();

return View(viewModel); // or Page
```

Finally, we get to the Razor code that will generate the HTML for the page, where of course we can continue to modify the query:

```csharp
foreach(var order in model.Orders.Where(o => o.WasShipped()))
{
  // HTML to display shipped orders
}
```

All of the above code snippets exist in separate files, possibly in separate projects, and every one of them modifies the query that ultimately will execute. The full query essentially looks like this:

```csharp
_dbContext.Orders
  .Where(o => !o.IsCanceled &&
      o.CreatedBy == username &&
      o.WasShipped);
```

This is great if you compare it to a naive implementation in which the data service simply returned all orders, and the subsequent rules filtered the data in memory. But that's a silly way to build the system, it's a [straw man argument](https://en.wikipedia.org/wiki/Straw_man). There are better ways to organize this code while still making efficient queries.

## Impact of IQueryable Everywhere

When you pass IQueryable everywhere, you allow your data access logic (the queries and filters themselves) to proliferate throughout your codebase. There is no [encapsulation](https://deviq.com/principles/encapsulation) of your data access logic and rules. Even if the organization of the application into logically distinct services like "data" and "business" exists, the app is still not following the principle of [Separation of Concerns](https://deviq.com/principles/separation-of-concerns) because it's allow data logic to taint every part of the system.

What's more, code outside of the data layer may not even be aware that it's dealing with `IQueryable`, because the `IQueryable` interface inherits `IEnumerable`. Methods could be working with IEnumerable, expecting in memory only behavior, but actually manipulating the expression tree of an IQueryable. This can result in unexpected runtime exceptions, especially if results are filtered using code that EF cannot translate to SQL (such as any custom function).

IQueryable data is harder to reason about. It's difficult to know if a given instance of some data type coming from another service will be a detached, in memory collection or an expression tree that hasn't yet begun execution. Basic code understanding suffers, as does debugging, troubleshooting, and testing.

## When does IQueryable make sense

The place for IQueryable is in the data layer. If your application is using an abstraction for data access (which it probably should be), that abstraction is usually referred to as a [Repository](https://deviq.com/design-patterns/repository-pattern). The implementation of your Repository is the right place to use IQueryable, provided that it's not part of your abstraction or your type's public interface. That is, it's perfectly fine to use IQueryable within your public methods, or to have private methods that return IQueryable. But it shouldn't be part of the public interface of your data layer or Repository.

## What about passing around a DbContext or DbSet

Since your `DbContext` or `DbSet<T>` can be used to get an IQueryable at any time, passing these around outside of your data layer has the same (negative) impact on separation of concerns and encapsulation as passing around `IQueryable<T>`.

## How do you efficiently filter data

Since it's now clear there are serious problems with returning essentially an open query from your data layer (in order to build up the query before it executes), what's the alternative if you want efficient filtering on the database side?

There are a couple of options. First, you can pass in an expression tree to your data service and use it inside of the implementation. Such an interface might look like this:

```csharp
public IOrderRepository
{
  List<Order> List(Expression<Func<Order,bool>> filter);
}
```

With this approach, you create the filter up front, it runs inside of the data service implementation, and the returned result is always an in memory collection.

An even better approach is to use the [Specification design pattern](https://deviq.com/design-patterns/specification-pattern). In that case, instead of passing in a bunch of LINQ, you would pass in an instance of a specification, and the LINQ would be a part of the specification's definition.

I have an open source NuGet package, [Ardalis.Specification](https://github.com/ardalis/specification), that works with both EF 6 and EF Core specifically for this purpose. You can [read the docs here](http://specification.ardalis.com/).

Using a specification as part of your interface, the above method would instead look like this:

```csharp
public IOrderRepository
{
  List<Order> List(Specification<Order> spec);
}
```

Of course this can easily be modified to [leverage C# generics](https://www.pluralsight.com/courses/working-c-sharp-generics-best-practices):

```csharp
public IRepository<TEntity> where TEntity : IEntity
{
  List<TEntity> List(Specification<TEntity> spec);
}
```

What does the calling code look like if you use this approach? Well, instead of tacking on additional `Where` statements throughout the codebase, you define the specification you need as part of your domain model, and then you use it at the point where you need the data:

```csharp
public class ShippedOrdersForUser : Specification<Order>
{
  public ShippedOrdersForUserSpec(string username)
  {
    Query.Where(o => !o.IsCanceled &&
      o.CreatedBy == username &&
      o.WasShipped);
  }
}

// in the controller action / page handler
var spec = new ShippedOrdersForUserSpec(username);
var viewModel = await _repo.ListAsync(spec);
```

Using the above code, the query is still executed on the database, but IQueryable is no longer exposed anywhere outside of the repository implementation. There's a sample repository interface and EF repository implementations in the related [Ardalis.Specification.EntityFrameworkCore](https://www.nuget.org/packages/Ardalis.Specification.EntityFrameworkCore) and [Ardalis.Specification.EntityFramework6](https://www.nuget.org/packages/Ardalis.Specification.EntityFramework6) packages.

You can see examples of this pattern at work in my [CleanArchitecture solution template](https://github.com/ardalis/CleanArchitecture) or the Microsoft reference architecture sample, [eShopOnWeb](https://github.com/dotnet-architecture/eShopOnWeb). I also demonstrate these approaches, and several others, in my [].NET Data Access Tour github repo](https://github.com/ardalis/DotNetDataAccessTour).

## Conclusion

Exposing IQueryable throughout your application allows queries to be extended from anywhere. This is both a blessing and a curse, and meets the definition of an antipattern since at first it's something seen as worthwhile but in practice it's often painful. The solution is not to simply fetch unfiltered data and then filter it on the application server, but rather to identify the specific queries individual pages or endpoints will need and define them as first class abstractions in the application's domain model. The Specification and Repository patterns work together beautifully to achieve this design and provide a much more maintainable and testable result.
