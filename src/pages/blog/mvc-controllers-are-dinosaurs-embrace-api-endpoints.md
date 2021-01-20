---
templateKey: blog-post
title: MVC Controllers are Dinosaurs - Embrace API Endpoints
path: /mvc-controllers-are-dinosaurs-embrace-api-endpoints
date: 2020-01-20
featuredpost: false
featuredimage: /img/embrace-api-endpoints.png
description: A simpler approach to building API endpoints with ASP.NET Core.
tags:
  - MVC
  - ASP.NET
  - ASP.NET Core
  - Web API
  - API
  - Microservices
  - Architecture
category:
  - Software Development
comments: true
share: true
---
I've been programming web applications using the MVC pattern for a very long time. What's more, I've been helping companies dig themselves out of technical debt for an even longer time, and I work with a wide variety of teams every year. So, I've seen things. And while I would absolutely never want to return to the old Web Forms way of building apps, I can tell you that more often than not, MVC Controllers are a source of pain in ASP.NET/ASP.NET Core projects.

MVC Controllers are essentially an antipattern. They're dinosaurs. They are collections of methods that never call one another and rarely operate on the same state. They're not *cohesive*. They tend to become bloated and to grow out of control. Their private methods, if any, are usually only called by a single public method. Most developers recognize that controllers should be as small as possible ([unscientific poll](https://twitter.com/ardalis/status/1223312390391058432)), but they're the only solution offered out of the box, so that's the tool 99% of ASP.NET Core developers use.

![Dino Comics MVC](/img/dino-comics-mvc-experienced.jpg)

You can use tools like MediatR to mitigate the problem. You can read a [detailed article about how to migrate from Controllers to Endpoints using MediatR](https://ardalis.com/moving-from-controllers-and-actions-to-endpoints-with-mediatr). The short version is that MediatR enables you to have single-line action methods that route commands to handlers. This is objectively a better approach, resulting in more cohesive classes that better follow OO principles. But what if you didn't even need that extra plumbing?

Now, to be clear, I'm talking about APIs here. What if you're still building things that respond directly to browser requests with HTML built on the server with Razor? Then you should probably be using Razor Pages or Blazor, both of which have already solved this problem.

## Why Should I Use This Non-Standard Framework?

Well, here's the thing. API Endpoints are really just Controllers with a few constraints applied to them. I mean, literally, they inherit from [ControllerBase](https://github.com/ardalis/ApiEndpoints/blob/master/src/Ardalis.ApiEndpoints/BaseAsyncEndpoint.cs#L32). So, they're not non-standard in any way, and everything that works with Controllers, like routing, model binding, model validation, dependency injection, filters, etc. all works just fine with API Endpoints because, that's right, they're controllers.

## But I don't need this constraint - I can do it myself!

Yes, it's true. You could just create controllers that followed [Single Responsibility Principle](https://deviq.com/principles/single-responsibility-principle) and only did one thing. **But you don't.** Don't fall into the trap of thinking constraints are a bad thing - they're not. Constraints are a useful design tool that can lead to better quality.

Let's consider global, mutable state in software. Pretty much everybody agrees that directly modifying global state from many different functions, classes, and modules is a poor practice that leads to bugs that are hard to find and fix. So most languages offer some kind of scope for local variables and arguments, and most object-oriented languages like C# take this even further and offer a variety of ways to protect and encapsulate variables using keywords like `private`, `protected`, and `internal`. "But we don't need these constraints - we can just use a naming convention on our global variables to do the same thing!"

Yeah, you could. Let me know how that works out. The rest of us will be using constraints to help guide our teams and our software into the pit of success.

## Ok I'm Interested - How Do I Get Started

Easy. I suggest reading the [repo's README file](https://github.com/ardalis/ApiEndpoints) as a good place to start. It covers a bit of the same things I've covered here, but has code listings and more as well. The repo also has a sample project you can look at to see some ways to use the Request-EndPoint-Response or REPR pattern.

If you want to see some other open source projects that use the approach, have a look at my [Clean Architecture solution template](https://github.com/ardalis/cleanarchitecture) and the [eShopOnWeb reference app from Microsoft](https://github.com/dotnet-architecture/eShopOnWeb).

If you have a project already and you just want to get started using API Endpoints instead of Controllers (and possibly MediatR), just [add the Ardalis.ApiEndpoints NuGet package](https://www.nuget.org/packages/Ardalis.ApiEndpoints/) and then create endpoints by inheriting from the `BaseEndpoint` or `BaseAsyncEndpoint` types.

## Tell Me What You Think

If you try this approach, please let me know how it works for you. If you need a feature that's somehow not supported, please add an issue and/or a pull request. If you find that it's working well and helping you write simpler code with smaller classes that each do just one thing, share the project on social media. And of course, you can always leave a comment below.

Thanks!
