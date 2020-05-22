---
templateKey: blog-post
title: Resolving Dependencies in ASP.NET MVC 5 with StructureMap
path: blog-post
date: 2014-06-25T15:31:00.000Z
description: In a previous post I showed how to use StructureMap with ASP.NET
  MVC 3. It’s been a couple of years, so I figured it was time to update that
  article with the steps for getting StructureMap working in ASP.NET MVC 5.
featuredpost: false
featuredimage: /img/dependency-injection-760x360.png
tags:
  - asp.net
  - mvc
  - structuremap
category:
  - Software Development
comments: true
share: true
---
In a previous post I showed how to use [StructureMap with ASP.NET MVC 3](http://ardalis.com/How-Do-I-Use-StructureMap-with-ASP.NET-MVC-3). It’s been a couple of years, so I figured it was time to update that article with the steps for getting StructureMap working in ASP.NET MVC 5. If you’re interested in learning more about how to develop applications in a loosely coupled fashion, I highly recommend my [course on SOLID Principles of Object Oriented Design](http://www.pluralsight.com/training/Courses/TableOfContents/principles-oo-design) to learn more (in particular, the [Dependency Inversion Principle](http://deviq.com/dependency-inversion-principle)).

StructureMap is my preferred IOC container / dependency injection tool for .NET applications. It’s free, performs very well, and has a number of very useful features that make it very productive to work with. One example of a great use of StructureMap can be found in my [CachedRepository article](http://ardalis.com/building-a-cachedrepository-via-strategy-pattern).

Assuming you’re starting with a new ASP.NET MVC 5 application, the easiest way to get StructureMap is using Nuget. You can open the Package Manager Console and run this command:

**install-package StructureMap.MVC5**

which should result in something like this:

![](/img/package-manager-console.png)

You can also locate and install the package using the Manage NuGet Projects option, available by right-clicking on the web project in Solution Explorer:

![](/img/image_thumb_1.png)

Once StructureMap is installed, you’ll notice several additions to your web project:

![](/img/image_thumb_dependencies.png)

Most of these you can safely ignore. The one file you’ll need to be concerned with is the IoC.cs class. When you open it, you’ll see a single Initialize method where you will configure your interfaces and the types that should be used for them for this application.

![](/img/image_thumb_dependencies-3.png)

To verify that things work, the simplest approach is to create an interface and an implementation of that interface, and wire them up in a controller. If you’re using the default ASP.NET MVC 5 project template, the HomeController includes an About action that sets ViewBag.Message to a string, which is in turn displayed on the corresponding View. We can demonstrate that everything works by replacing this string with the result of a method call via an interface. Below is the revised code for the HomeController:

![](/img/image_thumb_dependencies_4.png)

Run the application and visit the About page and you should see:

![](/img/image_thumb_dependencies_5.png)

**NOTE**: We didn’t tell StructureMap how to resolve the IMessageProvider interface, or let it know anything about the MessageProvider implementation. How did it figure this out?

In the default configuration in the IoC.cs file, there is a line of code that reads:

**scan.WithDefaultConventions();**

This code will automatically attempt to resolve any interface named IWhatever with an instance type named Whatever. That is, the same name, but without the “I” prefix. Of course you can still explicitly specify types that do not follow this convention, but you can save a lot of time if you want to write decoupled code but do not want to constantly have to update your container mapping information.

If you want to learn more about building loosely coupled applications using dependency injection, please check out my [video training classes on N-Tier applications and Domain-Driven Design](http://ardalis.com/training-classes).