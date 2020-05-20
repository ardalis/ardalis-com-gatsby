---
templateKey: blog-post
title: Writing Clean Code in ASPNET Core with DI
path: blog-post
date: 2016-05-27T06:43:00.000Z
description: "I’ve started writing a series on ASP.NET Core for MSDN Magazine.
  If you’re not a subscriber to the dead trees version, you can read them
  online. "
featuredpost: false
featuredimage: /img/may-msdn-cleancode.png
tags:
  - asp.net core
  - clean code
  - solid
  - unit testing
category:
  - Software Development
comments: true
share: true
---
I’ve started writing a series on ASP.NET Core for [MSDN Magazine](https://msdn.microsoft.com/en-us/magazine/). If you’re not a subscriber to the dead trees version, you can read them online. My first article is on [Writing Clean Code in ASP.NET Core with Dependency Injection](https://msdn.microsoft.com/en-us/magazine/mt703433), in the May 2016 issue. Here’s a brief intro:

> ASP.NET Core 1.0 is a complete rewrite of ASP.NET, and one of the main goals for this new framework is a more modular design. That is, apps should be able to leverage only those parts of the framework they need, with the framework providing dependencies as they’re requested. Further, developers building apps using ASP.NET Core should be able to leverage this same functionality to keep their apps loosely coupled and modular. With ASP.NET MVC, the ASP.NET team greatly improved the framework’s support for writing loosely coupled code, but it was still very easy to fall into the trap of tight coupling, especially in controller classes.

My next articles cover [middleware](https://docs.asp.net/en/latest/fundamentals/middleware.html) and [filters](https://docs.asp.net/en/latest/mvc/controllers/filters.html), and should appear in the June and July issues, respectively. You can also learn more about [dependency injection](https://docs.asp.net/en/latest/fundamentals/dependency-injection.html) from my article in the ASP.NET Core docs, or at a higher level,[dependency injection on DevIQ](http://deviq.com/dependency-injection/).