---
templateKey: blog-post
title: Moving from Controllers and Actions to Endpoints with MediatR
date: 2019-11-20
path: /moving-from-controllers-and-actions-to-endpoints-with-mediatr
featuredpost: false
coverImage: /img/moving-from-controllers-actions-endpoints.png
tags:
  - architecture
  - asp.net
  - asp.net core
  - asp.net mvc
  - endpoints
  - mediatr
  - mvc
category:
  - Software Development
comments: true
share: true
---

_(or Controllers are dinosaurs - it's time to embrace Endpoints)_

**Update Feb 2020**: I've started a [GitHub repo](https://github.com/ardalis/ApiEndpoints) and [NuGet package](https://www.nuget.org/packages/Ardalis.ApiEndpoints/) to implement Endpoints in ASP.NET Core (without MediatR and with file linking in Visual Studio). Check it out after reading this and see what you think.

Controllers are a key part of the MVC pattern. They're the entry point, responsible for interacting with one or more Models and returning a View. Although these days it seems MVC is used more for APIs than for Views, so it's more like Model-View-Result or Model-View-JSON. Whatever. The point is, they've been around a while and they're pretty central to a lot of web applications out there, especially in the .NET space. But their dominance is probably over.

In fact, even if you're actually using Model-VIEW-Controller, the writing was on the wall when the .NET team released Razor Pages, a better-organized way to achieve the same thing with fewer files and all the same architectural benefits. Seriously, if you're fumbling through a deeply nested Views folder and then scrolling up to your Controllers folder all day long, you should [give Razor Pages a look](https://ardalis.com/aspnet-core-razor-pages-worth-checking-out).

One common issue with (many, not all) Controllers that I see in customers' applications is that they are simply too big. They do too much. They have too many dependencies. They have too many responsibilities. They start small, but there's nothing in the MVC pattern or the ASPNET framework or the C# language constraining them from growing larger and larger. The best you can say is that a given controller might appear "bloated" or "too big" and likely that it violates [SOLID principles like Single Responsibility or Open Closed](https://www.pluralsight.com/courses/csharp-solid-principles). If you're really disciplined you might use static analysis tools like [NDepend](https://www.ndepend.com/) to catch controllers with too many constructor arguments (dependencies) or too many lines of code, but this is pretty rare in practice.

The issue isn't that Controllers are bad, it's just that they don't lead developers into the "pit of success". The easy, obvious, lazy way to add functionality to an MVC application 9 times out of 10 is to add another action to an existing Controller. Fast forward this behavior a few years and you have a great deal of technical debt in many existing codebases.

Controllers are a little bit odd as objects, too. Most objects that have several methods on them are likely to have clients that might call more than one method, or to have methods that might call one another. Controllers only ever have a single Action method invoked (by the web application), and very rarely would one Action method invoke another. The Action methods are essentially standalone functions grouped into classes solely for organizational purposes, and to share dependencies and filters (which is not always a benefit, it turns out).

So, how can we adjust things today to address this issue, and what might the ASP.NET Core team do in the future to minimize the issue for future applications built on ASP.NET Core?

## MediatR

I've written before about [how to wire up MediatR with ASP.NET Core](https://ardalis.com/using-mediatr-in-aspnet-core-apps). More recently, I've started including coverage of MediatR in my workshops and conference talks on Clean Architecture. We've recently included it in the [Microsoft eShopOnWeb reference application as well](https://github.com/dotnet-architecture/eShopOnWeb/blob/master/src/Web/Controllers/OrderController.cs), so more developers become familiar with it. Just a few days ago, I created a GitHub repository that demonstrates how to migrate from traditional Controller-Action based behavior toward using MediatR and a single handler class per route. You can [download or view the MediatR sample here](https://github.com/ardalis/MediatRAspNetCore), but if you keep reading I'll walk you through it and then circle round to what future versions of ASP.NET Core might do to help with this.

Let's start with a minimal Controller-Action approach to creating a new record as part of an API. Imagine that this controller actually has half a dozen more actions on it, and probably a bunch of additional constructor parameters.

_Note: Apologies for any code formatting issues._

```
[Route("/[controller]/[action]")]
public class Movie0Controller : Controller
{
    private readonly IMovieRepository _movieRepository;

    public Movie0Controller(IMovieRepository movieRepository)
    {
        _movieRepository = movieRepository;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody]NewMovieDTO newMovie)
    {
        var movie = new Movie
        {
            Id = newMovie.Id,
            Name = newMovie.Name
        };
        _movieRepository.Create(movie);
        return Ok(movie);
    }
}
```

So, again, imagine more actions and more dependencies being injected in the constructor. Typically, when this happens, most actions only use a subset of the injected dependencies. If we were to pull out this action into its own class, the number of dependencies it needed would likely be less than the total being injected into the controller. Incidentally, having a ton of dependencies injected into any service is usually a good indicator that it's violating the Single Responsibility Principle.

Enter MediatR. We add the nuget package and we add one line to ConfigureServices so that it can be injected. I talk about how to add it and how it works [in this article](https://ardalis.com/using-mediatr-in-aspnet-core-apps) so I won't rehash it here, but here's what the Controller looks like after the change:

```
[Route("/[controller]/[action]")]
public class Movie1Controller : Controller
{
    private readonly IMediator _mediator;

    public Movie1Controller(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody]NewMovieDTO newMovie)
    {
        var command = new NewMovieCommand
        {
            Id = newMovie.Id,
            Name = newMovie.Name
        };
        var result = await _mediator.Send(command);
        return Ok(result);
    }
}
```

Notice that the repository dependency has been removed from the controller. **If we follow this refactoring for every action method, every dependency would be removed from the controller**, and replaced with just one: **IMediator**.

Instead of doing "the work" (in this case, saving the entity via a repository, but "the work" could be anything the endpoint was doing) in this action method, the action method is simply creating a command DTO that can be passed to a separate handler via the \_mediator.Send() method. That handler class is shown here:

```
public class NewMovieHandler : IRequestHandler<NewMovieCommand,Movie>
{
    private readonly IMovieRepository _movieRepository;

    public NewMovieHandler(IMovieRepository movieRepository)
    {
        _movieRepository = movieRepository;
    }

    Task<Movie> IRequestHandler<NewMovieCommand, Movie>.Handle(NewMovieCommand newMovieCommand, 
        CancellationToken cancellationToken)
    {
        var movie = new Movie
        {
            Id = newMovieCommand.Id,
            Name = newMovieCommand.Name
        };
        _movieRepository.Create(movie);

        return Task.FromResult(movie);
    }
}
```

It just does exactly what the action method used to do, but now it's in its own class with only its own dependencies. It follows SRP and is now much easier to reason about in isolation. None of the other action methods in the controller had any bearing on the work this one was doing, so why make it hard to find this endpoint's logic and focus on it alone?

Ok so this is great, our controller has only one dependency, and every action method now just needs to translate its incoming model into a command DTO. Oh wait, we can leverage model binding for that and save a step:

```
[Route("/[controller]/[action]")]
public class Movie2Controller : Controller
{
    private readonly IMediator _mediator;

    public Movie2Controller(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody]NewMovieCommand command)
    {
        var result = await _mediator.Send(command);
        return Ok(result);
    }
}
```

Now every action method is literally just 2 lines of code. It's honestly hard to get much smaller than that. But hang on, that constructor is going to get pretty repetitive when literally every controller has the same, single dependency. Let's fix that:

```
public class Movie3Controller : BaseApiController
{
    [HttpPost]
    public async Task<IActionResult> Create([FromBody]NewMovieCommand command)
    {
        var result = await Mediator.Send(command);
        return Ok(result);
    }
}
```

Two things to notice are that we switched our base class to use a new BaseApiController (shown below) and our reference to the class level \_mediator field switched to using the Mediator property (declared in the base class).

```
[Route("/[controller]/[action]")]
[ApiController]
public abstract class BaseApiController : ControllerBase
{
    public IMediator Mediator { get; set; }
}
```

You probably should be using a BaseApiController class anyway for your APIs, because it's a good place to put your default route convention and the [\[ApiController\] filter that was added in ASP.NET Core 2.1](https://docs.microsoft.com/en-us/aspnet/core/web-api/?view=aspnetcore-3.0#apicontroller-attribute). All this one does is add the IMediator property so that all controllers will have access to it.

**Ok, but what sets that property?**

If you're using ASP.NET Core you're probably familiar with dependency injection, and in particular _constructor_ dependency injection. This class is using _property_ dependency injection. Property dependency injection isn't supported by the default ServiceCollection type in ASP.NET Core, but most third-party containers support it. In my sample, I'm using **Autofac** which has the ability to perform this via its **PropertiesAutowired** feature. This is the code needed in ConfigureServices in my sample:

```
services.AddMvc().SetCompatibilityVersion(CompatibilityVersion.Version_2_1).AddControllersAsServices();
ContainerBuilder builder = new ContainerBuilder();

builder.Populate(services);//Autofac.Extensions.DependencyInjection

var controllersTypesInAssembly = typeof(Startup).Assembly.GetExportedTypes()
    .Where(type => typeof(ControllerBase).IsAssignableFrom(type)).ToArray();

builder.RegisterTypes(controllersTypesInAssembly).PropertiesAutowired();
return new AutofacServiceProvider(builder.Build());
```

The above code first makes sure Controllers are created via the DI framework (they're not, by default). Then it gets all of the controllers in the current assembly and instructs Autofac to populate any properties on controllers that it are defined in the Autofac services container.

## One Endpoint, One File

If you're only concerned about how to do things today, you can stop here - the rest is me offering some suggestions for ways in which this might be made easier in .NET 5 or later.

With the approach shown here, you can pretty easily minimize what's happening in your controllers and follow SOLID principles such that each individual HTTP endpoint in your ASP.NET application maps to exactly one handler class. But at this point, why even have controllers? The ASP.NET Core team is already moving toward allowing Endpoints as first-class concepts in the framework. Currently endpoints are a way to consolidate different kinds of ASP.NET Core services like Controllers, Razor Pages, SignalR hugs, health checks, etc. But in a future update I could see these being extended (perhaps using another name, but I like Endpoint) to allow support for Endpoint classes that would map one-to-one with a route.

There are of course design questions about how this might work:

- How would routing work, would you still need attribute routing on the Endpoint classes?
- Would they support multiple endpoints per class?
- Are these really different enough from Controllers to justify adding to the "concept count" of ASP.NET Core?

My answers to these would be to have a new base class that Endpoints would use. These would support attribute routing but I could see them also potentially using convention-based routing similar to Razor Pages. You might name them CustomerPostEndpoint, CustomerGetEndpoint, CustomerGetByIdEndpoint, etc.

I'd avoid supporting multiple endpoints per Endpoint class. If you allowed that, you'd basically have Controllers, which we already have. The whole point of this pattern would be to help developers follow SOLID when building web apps. One endpoint per route makes it very easy to minimize the dependencies and responsibilities of each endpoint, helping developers fall into the pit of success.

Finally, I think having a new term for these kinds of things makes sense. They're not Controllers or Actions or Pages - they're Endpoints. If we constrain them to only having a single method (that can handle or _respond_ to a request), it may make sense to have a single method name corresponding to this, such as Respond. What does that method signature look like? What does it return, and what can it accept?

I like C# and strong typing as much as anyone, but one option the team could adopt would be to take a page from the Startup class and simply use a naming convention rather than strong typing. You may have noticed that Startup's Configure and ConfigureServices methods don't adhere to any base class or interface, but have very flexible signatures. ConfigureServices might return void or a service provider. Configure might take any number of dependencies as arguments. So too could the Respond method support several kinds of return types (I recommend ActionResult<T> personally) and whatever parameters it needs (just like any Action method would).

Another option would be to have Response<TInput, TResponse> in which these are set somewhere, but I don't know that that buys much over the more flexible Startup-like approach. And it could be that we try out both and see which one the community prefers.

What do you think? Do you see issues with Controllers tending to grow out of control in your projects? Do tools like MediatR look like they might help with that? Would it make sense to you to have future ASP.NET Core project templates ship with Endpoints as their default way of managing, well, endpoints, rather than the traditional controller-centric approach? Leave a comment or join the conversation on twitter by sharing and/or replying to this post:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Moving from Controllers and Actions to Endpoints with MediatR in <a href="https://twitter.com/hashtag/aspnetcore?src=hash&amp;ref_src=twsrc%5Etfw">#aspnetcore</a> <a href="https://t.co/OltDoEw1DJ">https://t.co/OltDoEw1DJ</a></p>— Steve "ardalis" Smith (@ardalis) <a href="https://twitter.com/ardalis/status/1196972080102694914?ref_src=twsrc%5Etfw">November 20, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Thanks!
