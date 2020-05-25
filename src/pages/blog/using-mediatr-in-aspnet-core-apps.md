---
templateKey: blog-post
title: Using MediatR in ASPNET Core Apps
path: blog-post
date: 2017-08-30T21:13:00.000Z
description: If you haven’t used MediatR before, or if you’re looking for a
  quick intro on how to set it up for ASP.NET Core, keep reading (if not, how
  did you get here? Was the title not clear?).
featuredpost: false
featuredimage: /img/nuget-mediatr.jpg
tags:
  - asp.net core
  - ddd
  - mediatr
category:
  - Software Development
comments: true
share: true
---
I’ve started looking at using [MediatR](https://github.com/jbogard/MediatR) for my domain events implementations. To that end, I created a quick sample project using ASP.NET Core 2.0. Overall things were pretty easy to get going. If you haven’t used MediatR before, or if you’re looking for a quick intro on how to set it up for ASP.NET Core, keep reading (if not, how did you get here? Was the title not clear?).

## Installing MediatR

Assuming you’re using Visual Studio, you can use the UI to add these two projects:

![](/img/nuget-mediatr.jpg)

If you’re not using Visual Studio, you can [add nuget packages using the dotnet CLI](https://ardalis.com/how-to-add-a-nuget-package-using-dotnet-add).

## Configuring MediatR in Startup

Next, go into your Startup.cs and modify the ConfigureServices method as follows:

```
services.AddMediatR();
 
// if you have handlers/events in other assemblies
// services.AddMediatR(typeof(SomeHandler).Assembly, 
//                     typeof(SomeOtherHandler).Assembly);
```

For my sample I only had one project/assembly, so no need to add others. If you do, you can add a list of assemblies, which you can grab using a type that you know lives in that assembly, as shown above.

Note: Initially I used [Steve Gordon’s helpful article to register my types](https://www.stevejgordon.co.uk/cqrs-using-mediatr-asp-net-core), but the [MediatR.Extensions.Microsoft.DependencyInjection package](https://www.nuget.org/packages/MediatR.Extensions.Microsoft.DependencyInjection/) is better supported and more robust (not to mention less code). I recommend sticking with it.

## Seeing MediatR in Action

Of course, you’ll want to confirm that MediatR is working in your ASP.NET Core application. The simplest way to do this is to set up a few simple types and verify you see the expected behavior. MediatR supports two kinds of messages: Request/Response and Notification. Mostly what I’m looking to use it for currently is the notification behavior, since I’m looking to use it to model domain events (if you’re not familiar with domain events, Julie Lerman and I cover them in our [DDD Fundamentals course](https://www.pluralsight.com/courses/domain-driven-design-fundamentals)). The expected behavior with notifications is that you define some type as implementing INotification, and one or more handlers of type INotificationHandler<SomeType>. When you *publish* a notification, every handler is called in response. You can see this in action using the following code, which you can just add to your HomeController if you’re following along with a new project:

```
public class SomeEvent : INotification {
    public SomeEvent(string message)
    {
        Message = message;
    }
 
    public string Message { get; }
}
 
public class Handler1 : INotificationHandler<SomeEvent>
{
    private readonly ILogger<Handler1> _logger;
 
    public Handler1(ILogger<Handler1> logger)
    {
        _logger = logger;
    }
    public void Handle(SomeEvent notification)
    {
        _logger.LogWarning($"Handled: {notification.Message}");
    }
}
public class Handler2 : INotificationHandler<SomeEvent>
{
    private readonly ILogger<Handler2> _logger;
 
    public Handler2(ILogger<Handler2> logger)
    {
        _logger = logger;
    }
    public void Handle(SomeEvent notification)
    {
        _logger.LogWarning($"Handled: {notification.Message}");
    }
}
 
 
public class HomeController : Controller
{
 
    private readonly IMediator _mediator;
 
    public HomeController(IMediator mediator)
    {
        this._mediator = mediator;
    }
    public async Task<IActionResult> Index()
    {
        await _mediator.Publish(new SomeEvent("Hello World"));
        return View();
    }
// more code omitted
}
```

Now, with this code in place, run the sample using Kestrel (you can use dotnet run from a console, or change the runner in Visual Studio to be the project name instead of IIS Express). Look at the console output when the home page is executed, and you should see your log statements:

![](/img/mediatr-notification-handlers.jpg)

If you just want to use MediatR to publish events, that’s pretty much it. If you also want to see it used for request/response, you just need to implement a couple more types for that behavior:

```
public class Ping : IRequest<string> { }
public class PingHandler : IRequestHandler<Ping, string>
{
    public string Handle(Ping request)
    {
        return "Pong";
    }
}
// optional to show what happens with multiple handlers
public class Ping2Handler : IRequestHandler<Ping, string>
{
    public string Handle(Ping request)
    {
        return "Pong2";
    }
}
```

The above code defines a request and its return type (in this case, string, using IRequest<string>). Handlers must implement a handle method that returns the expected response. When you *send* a request, one and only one handler will be called and will return a response of the appropriate type. The behavior as of this writing has the last Request Handler discovered being the one that is called, but a pull request I sent to the [MediatR.Extensions.Microsoft.DependencyInjection package](https://www.nuget.org/packages/MediatR.Extensions.Microsoft.DependencyInjection/) should modify that behavior so that only the first handler discovered is used (because only the first one is added to the services collection). It doesn’t really make sense to have more than one handler for a given request. The current behavior doesn’t throw an exception, but it wouldn’t surprise me if that is added in the future.

In any case, to work with the above types, you can just modify the About() method in the standard MVC template as follows:

```
public async Task<IActionResult> About()
{
    // example of request/response messages
    var result = await _mediator.Send(new Ping());
    ViewData["Message"] = $"Your application description page: {result}";
 
    return View();
}
```

Viewing the /About page in your browser, you should see the result of the call. With version 3.0.0 of the DI extensions, the second handler is called, so I see “Pong2”. I expect one I update to the next version of the extensions, it will display “Pong” since only the first handler will be registered.

That should be all you need to get started with MediatR. I will most likely incorporate it into the .NET Core 2.0 refresh I’m working on for the Microsoft Architecture eBook and sample guidance I’m working on currently. Check out [Microsoft’s architecture learning hub](https://www.microsoft.com/net/learn/architecture) to access these resources and others.

> Are you looking to get up to speed with ASP.NET Core as quickly as possible? Check out my new course, the [ASP.NET Core Quick Start](http://aspnetcorequickstart.com/), for the fastest way to become proficient in ASP.NET Core.