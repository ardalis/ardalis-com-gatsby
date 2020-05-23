---
templateKey: blog-post
title: When Should You Upgrade to ASP.NET Core?
path: blog-post
date: 2017-05-02T03:06:00.000Z
description: ASP.NET Core 1.0 shipped last summer. Then ASP.NET Core 1.1 shipped
  last fall. Overall, the framework and server-side components have been pretty
  solid, with few major bugs reported, and a bunch of nice features added to
  both ASP.NET and Entity Framework Core in the 1.1 release.
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - .net core
  - asp.net core
  - visual studio
category:
  - Software Development
comments: true
share: true
---
ASP.NET Core 1.0 shipped last summer. Then ASP.NET Core 1.1 shipped last fall. Overall, the framework and server-side components have been pretty solid, with few major bugs reported, and a bunch of nice features added to both ASP.NET and Entity Framework Core in the 1.1 release. However, the tooling story lagged for a while (as is typical), and while normally this wouldn’t be such a big barrier to adoption (if it were just Visual Studio), in this case the affected tooling included the dotnet CLI as well. There were also breaking changes to the project system, which was painful, but was necessary in order for Core projects to interact with every other project type in Visual Studio. But the wait is nearly over. Visual Studio 2017 was released recently, and appears to be stable. I was able to migrate my existing project.json-based projects to the new MSBuild project file format without issue. There have also been some nice new improvements to the dotnet CLI, which I’ve also written about ([here](http://ardalis.com/how-to-add-a-nuget-package-using-dotnet-add) and [here](http://ardalis.com/how-to-manage-solution-projects-using-dotnet-cli)). It’s been a long wait, but we’re now in a world where .NET Core (and ASP.NET Core) have been around for a while, and there are robust, productive developer tools available to work with them. **If you’re a company who’s been waiting for .NET Core to stop being on the bleeding edge, this is your cue to start paying attention.**

So, now that ASP.NET Core is a viable option, when should you start upgrading your projects to use it? Here are some options and my opinion on each one.

## New Projects

If you’re starting a new project and plan on using MVC and/or Web API, then it’s almost certain you should use ASP.NET Core. There are a bunch of improvements that make ASP.NET Core an improvement over its predecessor. It now has first-class built-in dependency injection. ASP.NET Core MVC has Tag Helpers. You can easily write full-stack tests using TestServer that run in-memory and don’t use the network stack (so they don’t break due to firewall configurations, etc., but can test routes and filters). Web API support is built right into ASP.NET Core MVC, instead of being a side-by-side feature with a bunch of confusing almost-duplicate components. It’s also much faster and has many more deployment options than MVC5/WebAPI2, which is pretty much tied to IIS.

**What if you have a dependency on legacy libraries (your own or third-party) that require the full .NET Framework (they haven’t been ported to .NET Core)?** No problem. ASP.NET Core can target the full .NET Framework. Want to keep using your EF6 or NHibernate data access layer? Go ahead – it’ll still run just fine and you can call it from ASP.NET Core. The only thing you give up by continuing to use the full .NET Framework is the ability to run on a non-Windows host (and that’s where you’d be if you stayed on MVC5, too, so it’s not a strike against Core).

**I don’t have time to train my team on ASP.NET Core!** Fortunately, getting up to speed on ASP.NET Core doesn’t take much time at all if your team is already familiar with ASP.NET MVC and/or Web API. The core concepts all port over. There are still controllers and views. Views still use Razor. Routing is pretty much the same and is actually simpler since attribute-based routing is the standard convention. Filters are pretty much the same, as is Web API and its features (made simpler by being fully integrated with MVC now). There are subtle differences, of course, but overall your developers will be able to leverage their existing experience. A couple of new features, like how apps start up and how [middleware](http://ardalis.com/using-custom-middleware-to-record-and-fix-404s-in-aspnet-core-apps) works, are worth learning about, but most of your team could be productive without ever knowing the details of these aspects of the framework. Sign your team up for my [ASP.NET Core Quick Start course](http://deviq.com/aspnetcore-quickstart) and they’ll be good to go in no time!

**I want to host my app in a container running Linux!** You want ASP.NET Core, then. You won’t be able to use some libraries that require the full .NET Framework (and Windows), but as long as you stick to .NET Core packages your apps will “just work” on Linux and MacOS in addition to Windows. And yes, you can host them on Azure running Linux, too.

## Existing ASP.NET MVC 5 and/or Web API 2 Applications

The decision is a bit less clear-cut for existing apps that are running on the latest non-Core version of ASP.NET. If these apps are running and working fine, there may not be much ROI on converting them to use ASP.NET Core in the short term. Some reasons you might look to migrate such apps to Core include:

**Self-host support**. If you’d like to be able to deploy the app and its server together, without the need to install IIS, you might consider Core.

**Non-Windows host support.** You may find cheaper hosting on non-Windows servers (or cloud instances). You may have heard about this (relatively) new container thing, and want to take advantage of it. Core supports these options. Core also has a better story when it comes to container (Docker) support. For example, check out this [eBook](http://aka.ms/MicroservicesEbook) and [sample application on microservices with ASP.NET Core and containers](http://aka.ms/MicroservicesArchitecture).

**Greater app density**. Do you host multiple instances of the app yourself? You’ll be able to host many more instances of the same app on the same hardware running on Core than on traditional ASP.NET.

**Performance**. If performance is crucial and you know your performance bottlenecks are in your web stack (not the database or other out-of-process calls, and not client-side dependencies), then ASP.NET Core may help. Its performance, especially for very high throughput scenarios, [can be substantially faster than ASP.NET 4.x on IIS](https://github.com/aspnet/benchmarks).

**Testing and Domain-Driven Design**. If your team is really interested in [DDD](http://bit.ly/PS-DDD), following [SOLID principles](https://www.pluralsight.com/courses/principles-oo-design), and writing testable software, then ASP.NET Core (and EF Core) have a lot of nice features that make it much easier to do this. If you find that you’re fighting with the framework while trying to do these things in ASP.NET, you might want to give ASP.NET Core a look. If you do, you might find my [Clean Architecture ASP.NET Core solution template](https://github.com/ardalis/CleanArchitecture) helpful. Also check out my [Microsoft eBook on building ASP.NET Core apps](http://aka.ms/WebAppEbook) (without containers).

## Web Forms Applications

If you have applications that are running classic/legacy ASP.NET web forms, odds are you’re best off staying on that platform. Microsoft is continuing to invest in web forms and is shipping new features. There are ways to improve the quality of your web forms code, including injecting dependencies to reduce coupling in your codebehind files, but moving to ASP.NET Core MVC will be as much of an undertaking as moving to ASP.NET MVC 5 (or 4/3/2/1) would be. What’s worse, you could run your web forms pages side-by-side with MVC 5, but that’s not an option on ASP.NET Core MVC. I recommend remaining on Web Forms until the app is worth replacing entirely. If it’s very heavy on data entry, it’s likely a rewrite would involve using a SPA-style app with much more client-side code and a framework like Angular 2 or React, with the server side mostly consisting of API calls.

## Other Considerations

Although Visual Studio is a great tool that I highly recommend, it’s not free (except for Community Edition, which \*is\* free and can be used for a lot of things), and it only runs on Windows (there is a VS for Mac, but it’s a different app). If you’d rather not spend the money on VS, or if your team prefers lighter-weight tools (or non-Windows dev machines), .NET Core may make more sense for your team. You can run Visual Studio Code on Mac and Linux (as well as Windows), and the dotnet CLI tools provide a very productive experience across each of these platforms.

Similarly, if your developers and/or your apps are more and more client-side focused, you may find ASP.NET Core’s lighter weight and cleaner implementation of Web API functionality makes it a better fit. While many front-end developers have embraced NodeJS for its speed (and ability to run JavaScript on the server), ASP.NET Core actually [outperforms node.js on the server](https://github.com/aspnet/benchmarks) (and[you could still run JavaScript on the server](https://channel9.msdn.com/Blogs/Technology-and-Friends/tf441) if you really wanted to). Running TechEmpower benchmarks, ASP.NET Core on Kestrel handles over 1M requests per second on the same hardware and same application that NodeJS manages 175k requests/sec.

## Summary

Obviously your mileage may vary and there are many factors that play into the decision about whether and when to upgrade to a new application platform. And of course ASP.NET Core isn’t the only option available – there are plenty of other web frameworks you could build your next app on. However, the subject of this article is ASP.NET Core, which I’ve had the dubious pleasure of working with over the last two years as a Microsoft MVP, Insider, and contractor. I’ve written a great deal of the [official ASP.NET Core documentation](http://docs.asp.net/) and I currently mentor a number of clients as they make this transition ([contact me if your team needs some training or you’d like a review of your application](http://services.ardalis.com/)). I do not recommend upgrading to a new application framework just because it’s new and shiny. There should be measurable benefits to the business and/or the application’s users that justify the time, effort, and risk involved in such a move. I hope I’ve helped outline some of the considerations that should go into making such a decision.

Please leave your own experiences below, or feel free to join me in conversation [on twitter (@ardalis)](https://twitter.com/ardalis). Remember you can get up to speed with ASP.NET Core quickly by [watching this Quick Start course](http://aspnetcorequickstart.com/).

## What’s Next?

ASP.NET Core 2.0 is coming. You can [check out the official ASP.NET Core Roadmap](https://github.com/aspnet/Home/wiki/Roadmap), and I’m sure you’ll hear more about what will be included next week at Build. I’m looking forward to an updated SignalR, and the new [razor pages](https://github.com/aspnet/Mvc/tree/dev/src/Microsoft.AspNetCore.Mvc.RazorPages) functionality should be interesting as well.