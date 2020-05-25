---
templateKey: blog-post
title: Real World ASPNET Core MVC Filters
path: blog-post
date: 2016-08-08T05:37:00.000Z
description: Filters are a great, often underutilized feature of ASP.NET MVC and
  ASP.NET Core MVC. They provide a way to hook into the MVC action invocation
  pipeline, which makes them ideal for pulling common repetitive tasks out of
  your actions.
featuredpost: false
featuredimage: /img/aspnetcore-1.png
tags:
  - asp.net core
  - filter
  - msdn
category:
  - Software Development
comments: true
share: true
---
Filters are a great, often underutilized feature of ASP.NET MVC and ASP.NET Core MVC. They provide a way to hook into the MVC action invocation pipeline, which makes them ideal for pulling common repetitive tasks out of your actions. Often, an app will have a standard policy that it applies to how it handles certain conditions, especially those that might generate particular HTTP status codes. Or it might perform error handling or application-level logging in a specific fashion, in every action. These kinds of policies represent cross-cutting concerns, and if possible, you want to follow the [Don’t Repeat Yourself (DRY) principle](http://deviq.com/don-t-repeat-yourself/) and pull them out into a common abstraction. Then, you can apply this abstraction globally or wherever appropriate within your application. Filters provide an elegant way to achieve this.

Read more in my latest [MSDN feature: ASP.NET Core – Real-World ASP.NET Core MVC Filters](https://msdn.microsoft.com/magazine/mt767699).

You can also check out my article in the official [ASP.NET Core docs](http://docs.asp.net/) on [ASP.NET MVC Core Filters](https://docs.asp.net/en/latest/mvc/controllers/filters.html).