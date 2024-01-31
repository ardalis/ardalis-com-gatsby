---
templateKey: blog-post
title: "Log Request Headers Middleware for ASP.NET Core"
date: 2024-01-31
description: "Recently I ran into a weird problem with how Visual Studio was sending API requests and I really wanted to see exactly what headers were being sent to my ASP.NET Core app. So I wrote this simple bit of middleware to do the job."
path: blog-post
featuredpost: false
featuredimage: /img/log-request-headers-middleware.png
tags:
  - dotnet
  - .NET
  - ASP.NET Core
  - Middleware
category:
  - Software Development
comments: true
share: true
---

Recently I ran into a weird problem with how Visual Studio was sending API requests and I really wanted to see exactly what headers were being sent to my ASP.NET Core app. So I wrote this simple bit of middleware to do the job.

## What is Middleware

If you're not familiar with middleware, it's a set of functions ("request delegates") that are executed in a particular order as part of every request that is made to an ASP.NET Core application. It's an example of the [Chain of Responsibility design pattern](https://deviq.com/design-patterns/chain-of-responsibility-pattern). I talk about [useful ways you can use the Chain of Responsibility pattern in this video](https://www.youtube.com/watch?v=eSQHpfaYspw&ab_channel=dotnetFlix).

[Read the ASP.NET Core Middleware docs](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/middleware/) (which I wrote the original version of back when ASP.NET Core was prerelease)

## Request Headers

In ASP.NET Core, every request sends some headers with it. Headers are just one part of how HTTP works. In the problem I encountered that led to this middleware, I was explicitly sending an Authorization header, but the tooling wasn't showing that header as having been sent. If I sent an "Authorization2" header, that showed up fine. Somehow the Authorization header was disappearing! It was pretty frustrating, and I needed more data to help me diagnose the problem. Request headers disappearing seemed to be a key component of the problem, so I decided to log all of the headers the application was actually getting.

## The LogHeadersMiddleware

Here's the middleware. It's pretty simple - just copy this file into your web project to have access to it. I'll show how to wire it up in a moment.

```csharp
public class LogHeadersMiddleware
{
  private readonly RequestDelegate _next;
  private readonly ILogger<LogHeadersMiddleware> _logger;

  public LogHeadersMiddleware(RequestDelegate next, ILogger<LogHeadersMiddleware> logger)
  {
    _next = next;
    _logger = logger;
  }

  public async Task InvokeAsync(HttpContext context)
  {
    foreach (var header in context.Request.Headers)
    {
      _logger.LogInformation("Header: {Key}: {Value}", header.Key, header.Value);
    }

    await _next(context);
  }
}

// Extension method to make it easy to add the middleware to the pipeline
public static class LogHeadersMiddlewareExtensions
{
  public static IApplicationBuilder UseLogHeaders(this IApplicationBuilder builder)
  {
    return builder.UseMiddleware<LogHeadersMiddleware>();
  }
}
```

## Using the LogHeadersMiddleware

Ok so how do you use this? Well you need to add `app.UseLogHeaders()` to your `Program.cs` file (or `Startup.cs` if your app still uses that). It's important that you do this in the right place, though, since the order of middleware is very important. I recommend adding it to the very top of your middleware pipeline, so it might look something like this:

```csharp
var app = builder.Build();

app.UseLogHeaders(); // add here right after you create app

app.UseHttpsRedirection();

// other middleware
```

You might also opt to only include it if you're running in Debug (not Production) since it will have a small impact on performance. Really **you probably should just immediately delete the call to it once you've identified the problem you're struggling with**, since there's not usually much reason to always log all of a request's headers (especially not one log entry per header).

## Summary

Writing custom middleware is pretty simple to do in ASP.NET Core. If you're having trouble figuring out what's going on in your application, keep this approach in mind as a way to get more info. Another approach you can try is turning up the built-in logging for ASP.NET Core, but then you're likely to get way more information than you need. That's why I opted for this solution, as it only took me a couple of minutes to come up with this code, and soon after that I'd identified the problem I was running into with Visual Studio's tooling (but that's another article...).

Do you have a favorite piece of custom middleware you use? Leave a comment below and tell me about it!
