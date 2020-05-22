---
templateKey: blog-post
title: Debugging ASPNET Core Routes
path: blog-post
date: 2017-08-23T21:39:00.000Z
description: Routing in ASP.NET MVC apps has often presented challenges to
  developers, resulting in a bunch of different route debugging tools and nuget
  packages.
featuredpost: false
featuredimage: /img/routedebugging.png
tags:
  - asp.net core
  - razor pages
category:
  - Software Development
comments: true
share: true
---
Routing in ASP.NET MVC apps has often presented challenges to developers, resulting in a bunch of different route debugging tools and nuget packages. In ASP.NET Core, there tends to be less routing confusion because of the emphasis on attribute routing, rather than the traditional routing tables. With ASP.NET Core 2.0 and Razor Pages, this trend continues since Razor Pages use convention-based routing by default, so you don’t even need to create your own route attributes. That said, you can still easily inspect the routes for your app if you need to do so. One nice feature of Razor Pages is that they let you easily pack up some functionality, including view and controller/action logic, and consumers can drop these files into a single location (rather than having to create Views subfolders, etc.). To that end, I’ve created a simple Route Debugger Razor Page that you can get from this [AspNetCoreRouteDebugger GitHub repository](https://github.com/ardalis/aspnetcoreroutedebugger).

The repository includes a separate folder with just the Razor Page (2 files – it’s using the codebehind model style), and a folder with a sample. If you run the sample and navigate to the /routes route, you should see a table like this one:

![](/img/routedebugging.png)

Any ASP.NET Core 2.0 project can use this, even if it’s not otherwise using Razor Pages. Just drop the files into a /Pages folder and they should work. If you don’t want to use Razor Pages, or you’re still on 1.x of ASP.NET Core, you can easily convert the code into traditional Controller/Action/View bits. There’s a Routes2Controller in the sample that should get you most of the way there (and you can give me a pull request if you want to get it up to feature parity with the Razor Page implementation).