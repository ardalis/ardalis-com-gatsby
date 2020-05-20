---
templateKey: blog-post
title: How Do I Use StructureMap with ASP.NET MVC 3
path: blog-post
date: 2014-06-25T15:25:00.000Z
description: "As I write this, the best resource for official documentation on
  ASP.NET MVC 3 is of course MSDN. You can also learn more about ASP.NET MVC 3
  here. "
featuredpost: false
featuredimage: /img/asp-mvc_grande.png
tags:
  - asp.net
  - mvc
  - structuremap
category:
  - Software Development
comments: true
share: true
---
**Update**: If you want to use [StructureMap with ASP.NET MVC 5, I have a walkthrough on this](http://ardalis.com/resolving-dependencies-in-asp.net-mvc-5-with-structuremap) now as well.

As I write this, the best resource for official documentation on [ASP.NET MVC 3 is of course MSDN](http://msdn.microsoft.com/en-us/library/gg416514%28v=VS.98%29.aspx). You can also [learn more about ASP.NET MVC 3 here](http://www.asp.net/mvc). However, neither of those mention how to properly set up an [IOC Container](http://en.wikipedia.org/wiki/Inversion_of_control) (like [StructureMap](http://structuremap.net/structuremap/index.html)) with ASP.NET MVC 3. After some searching, I was able to get things working using the RTM version of ASP.NET MVC 3. Here’s what I had to do.

## Step One – Global.asax – Application_Start()

First, you need to wire things up when your application starts. You can put all of your container registration stuff right into your Global.asax, but that violates SRP. I typically have a separate project in my solution devoted to DependencyResolution and this project exposes an EnsureDependenciesRegistered() method that makes sure all of my types are wired up. This project handles everything below the UI level, so any UI-specific wireup that is needed (like, say, MVC ControllerActivators) needs to still happen within the UI project, so I do end up with one line of configuration in my Global.asax. Here are the two methods involved:

```
protected void Application_Start()
{
    AreaRegistration.RegisterAllAreas();
    RegisterGlobalFilters(GlobalFilters.Filters);
    RegisterRoutes(RouteTable.Routes);
    InitializeContainer();
}
 
public void InitializeContainer()
{
    DependencyRegistrar.EnsureDependenciesRegistered();
    var container = (IContainer) IoC.GetContainer();
    DependencyResolver.SetResolver(new StructureMapDependencyResolver(container));
}
```

## Step Two – StructureMapDependencyResolver implementation of IDependencyResolver

You need one of these. You can cut and paste this one, or you might find one already in a project like [MVCContrib](http://mvccontrib.codeplex.com/).

```
public class StructureMapDependencyResolver : IDependencyResolver
{
    public StructureMapDependencyResolver(IContainer container)
    {
        _container = container;
    }
 
    public object GetService(Type serviceType)
    {
        if (serviceType.IsAbstract || serviceType.IsInterface)
        {
            return _container.TryGetInstance(serviceType);
        }
        else
        {
            return _container.GetInstance(serviceType);
        }
    }
 
    public IEnumerable<object> GetServices(Type serviceType)
    {
        return _container.GetAllInstances<object>()
 
            .Where(s => s.GetType() == serviceType);
    }
 
    private readonly IContainer _container;
}
```

**Update: Thanks to Jeremy’s comment below and some emails exchanged with [K. Scott Allen](http://odetocode.com/), I’ve updated the above code to streamline it and also removed the implementation of IControllerActivator, which is not needed here.**One thing that bugs me when I grab code from the internet is when it doesn’t work because I don’t have the right using statements or references. To avoid this issue, here are my using statements for the above code to work:

```
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Core;
using Core.Interfaces;
using DependencyResolution;
using StructureMap;
using IDependencyResolver = System.Web.Mvc.IDependencyResolver;
```

The one last bit that you are likely missing is the static method for IoC.GetContainer(). I have a static helper class called IoC that handles all of my dependency resolution in a container-agnostic manner. In the above code the only thing I’m using it for is to get an instance of my container, which you can easily do using whatever technique you like (you may just new it up in your InitializeContainer() method). I also found this article on [Dependency Injection in MVC 3 with Unity to be helpful](http://blogs.microsoft.co.il/blogs/gilf/archive/2010/10/17/dependency-injection-in-mvc-3-was-made-easier.aspx).