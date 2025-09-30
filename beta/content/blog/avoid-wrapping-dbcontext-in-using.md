---
title: Avoid Wrapping DbContext in Using (and other gotchas)
date: "2020-12-01T16:20:00.0000000-05:00"
description: You can avoid a lot of problems by not putting you Entity Framework or Entity Framework Core DbContext instance in a using statement.
featuredImage: /img/avoid-wrapping-dbcontext-in-using.png
---

EF and EF Core DbContext types implement `IDisposable`. As such, best practice programming suggests that you should wrap them in a `using()` block (or [new C# 8 using statement](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/using-statement)). Unfortunately, doing this, at least in web apps, is generally a bad idea.

I work with a lot of clients who are migrating from.NET Framework to.NET Core and.NET 5. Some of them weren't using dependency injection in their legacy apps, or weren't using it consistently. As a result, many of them have a TON of instantiations of their `DbContext` classes. Doing this has its own issues, not the least of which is the tight coupling it introduces (see [New is Glue](/new-is-glue/)).

> In Web Apps, there should be exactly one DbContext per web request.

If you follow the above rule, everything works nicely. If you don't, you're likely to encounter a lot of pain. You'll run into problems with [how entities are tracked](https://stackoverflow.com/questions/56240764/ef-core-another-instance-is-already-being-tracked) or with tracked entities not saving when you think they should (more on this in a moment). Especially if you use async code, you'll discover situations where the [DbContext has been disposed](https://stackoverflow.com/questions/18635508/dbcontext-has-been-disposed/46271570), which may take some time to sort out.

> The ideal way to configure a DbContext in ASP.NET or ASP.NET Core is via a DI container.

You can avoid literally all of this pain if you just let a DI container (like [Autofac](https://autofac.org/)) manage your DbContext instances and their lifetime for you. If you also use a repository or similar abstraction, be sure to set its lifetime to match your DbContext lifetime. The built-in ASP.NET Core DI container and helpers configure EF Core correctly with a Scoped lifetime. This means there is one new instance of the DbContext created per request. This same instance is shared by any types requesting a DbContext within that request. It is cleaned up and disposed at the end of the request. If you're using Autofac and EF 6, the equivalent of Scoped is InstancePerRequest.

## Using statements and DbContexts

The specific problems with `using` statements are:

- You dispose a DbContext and are left with an entity that can't be saved
- You pass the DbContext to another service asynchronously; the original using block disposes it before it is used
- They add duplication and clutter to your code when constructor injection and a single line in ConfigureServices or an Autofac module will set the right behavior app-wide

## Problems with multiple DbContexts

Closely related to the issue of `using` statements and DbContexts is the case where there are multiple DbContexts (since usually the `using` statement creates a new instance).

> You're in for a world of hurt if you have multiple DbContexts trying to work with the same entity instances.

Consider this simple example that includes a controller and a service, both of which use a dbContext.

```csharp
public ActionResult Index()
{
 var db = new ApplicationDbContext();

 var falcon = db.Starships.FirstOrDefault(s => s.Id == 1);

 var service = new StarshipService();

 service.UpdateStarship(falcon);

 return View();
}

public class StarshipService
{
 public void UpdateStarship(Starship starship)
 {
 var db = new ApplicationDbContext();
 starship.Name = starship.Name + "*";
 db.SaveChanges();
 }
}
```

Let's assume the starship's name is"Millenium Falcon" when it's read from the database in the Index method. The next time `Index` is hit, what will the name be?

> The SaveChanges() call does nothing. The `db` instance in StarshipService isn't tracking the entity.

The name will remain unchanged.

Ok, we can fix this. Let's attach the entity. Here's the updated service:

```csharp
 public class StarshipService
 {
 public void UpdateStarship(Starship starship)
 {
 var db = new ApplicationDbContext();
 starship.Name = starship.Name +"*";
 db.Starships.Attach(starship);
 db.SaveChanges();
 }
 }
```

Run it again. Now what will the name be?

> SaveChanges() still does nothing. The entity wasn't being tracked when its name was updated.

Ok, let's try this one more time:

```csharp
 public class StarshipService
 {
 public void UpdateStarship(Starship starship)
 {
 var db = new ApplicationDbContext();
 db.Starships.Attach(starship);
 starship.Name = starship.Name +"*";
 db.SaveChanges();
 }
 }
```

NOW, will it work? What do you think?

Yes, now the name is updated to"Millenium Falcon*", and the next time"Millenium Falcon**", etc.

That's a lot of work to try and get just right to get the expected behavior. The code's brittle, full of duplication, and worse has non-obvious temporal dependencies. Oof. What would it take to get this legacy MVC 5 / EF6 code to work using Autofac?

### Install Nuget Package

Install [Autofac.MVC5 nuget package](https://www.nuget.org/packages/Autofac.Mvc5/). Unlike many.NET Framework nuget packages, it doesn't add a bunch of classes. You still need to wire it up. Go to your `global.asax` and update `Application_Start()`:

```csharp
protected void Application_Start()
{
 var builder = new ContainerBuilder();
 builder.RegisterControllers(typeof(MvcApplication).Assembly);
 builder.RegisterType<ApplicationDbContext>()
.InstancePerRequest();
 builder.RegisterType<StarshipService>()
.InstancePerRequest();
 var container = builder.Build();
 DependencyResolver.SetResolver(new AutofacDependencyResolver(container));

 AreaRegistration.RegisterAllAreas();
 FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
 RouteConfig.RegisterRoutes(RouteTable.Routes);
 BundleConfig.RegisterBundles(BundleTable.Bundles);
}
```

Once you have it working you can move it to a module and/or put it in a helper in your `App_Start` directory. What did this just do?

- Configure Autofac's dependency container
- Set it to be used to create Controllers
- Set it to be used to create `ApplicationDbContext`
- Set it to be used to create `StarshipService`
- Set both of these to use `InstancePerRequest`
- Configured MVC5 to use the Autofac to resolve its dependencies

Ok that took about 5 minutes. What's left to update the original messy code? Well, the service just looks like this now:

```csharp
public class StarshipService
{
 private readonly ApplicationDbContext _dbContext;

 public StarshipService(ApplicationDbContext dbContext)
 {
 _dbContext = dbContext;
 }
 public void UpdateStarship(Starship starship)
 {
 starship.Name = starship.Name +"*";
 _dbContext.SaveChanges();
 }
}
```

Likewise, the controller now looks like this:

```csharp
public class HomeController: Controller
{
 private readonly ApplicationDbContext _dbContext;
 private readonly StarshipService _starshipService;

 public HomeController(ApplicationDbContext dbContext, StarshipService starshipService)
 {
 _dbContext = dbContext;
 _starshipService = starshipService;
 }
 public ActionResult Index()
 {
 var falcon = _dbContext.Starships.FirstOrDefault(s => s.Id == 1);

 _starshipService.UpdateStarship(falcon);

 ViewBag.Name = falcon.Name;

 return View();
 }
 // other actions
}
```

Note that both of these types now follow the [Explicit Dependencies Principle](https://deviq.com/explicit-dependencies-principle). Also note the total absence of the `new` keyword in the revised code. This is related to the Explicit Dependencies Principle.

> Methods and classes should explicitly require (typically through method parameters or constructor parameters) any collaborating objects they need in order to function correctly.

Don't surprise consumers of your classes with hidden dependencies. If your class needs it, it should ask for it in its constructor. And if"it" couples the class to infrastructure, it should be asking for an abstraction (interface) not creating an instance directly using new and not calling a static method.

## Summary

EF and EF Core can save you a lot of time and make it much easier for you to just worry about your domain model rather than low-level database concerns. But if you don't use them properly, they can also cause no end of headaches as you try to track down why they're misbehaving. Avoiding direct instantiation and avoiding `using` blocks will both make your code much easier to work with. For ASP.NET (Core) apps, you should be sure to only have a single instance of a DbContext per request, and the best way to achieve this is through the use of a DI container like Autofac (or the built-in ASP.NET Core `ServiceCollection`).

