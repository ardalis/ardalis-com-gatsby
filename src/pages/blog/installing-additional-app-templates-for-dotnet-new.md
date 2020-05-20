---
templateKey: blog-post
title: Installing Additional App Templates for dotnet new
path: blog-post
date: 2017-06-28T01:33:00.000Z
description: When you install the .NET Core SDK, you get the dotnet CLI (command
  line interface), which can be used for a host of different things, including
  creating new projects. You can see which templates are already installed by
  running
featuredpost: false
featuredimage: /img/dotnet-new-h.png
tags:
  - .net core
  - dotnet
  - tip
category:
  - Software Development
comments: true
share: true
---
When you install the[.NET Core SDK](https://www.microsoft.com/net/download/core), you get the dotnet CLI (command line interface), which can be used for a[host](http://ardalis.com/how-to-add-a-nuget-package-using-dotnet-add)of[different](http://ardalis.com/automate-testing-and-running-apps-with-dotnet-watch)[things](http://ardalis.com/how-to-manage-solution-projects-using-dotnet-cli), including creating new projects. You can see which templates are already installed by running

```
dotnet new -h
```

![](/img/dotnet-new-h.png)

By default the SDK installs about 8 templates, with support for C# and F# (and blank solution files). However, there are quite a few additional templates available, and installing them is just a matter of running a simple dotnet command, too. For example, to install the [ASP.NET Core SPA templates](https://blogs.msdn.microsoft.com/webdev/2017/02/14/building-single-page-applications-on-asp-net-core-with-javascriptservices/), run

```
dotnet new -i Microsoft.AspNetCore.SpaTemplates::*
```

This will install a few things…

![](/img/dotnet-new-install.png)

When it’s done, it will list your new set of available templates:

![](/img/dotnet-new-template-list.png)

The new package installs six new templates, covering Angular, Aurelia, Knockout, React, React/Redux, and Vue. But that isn’t the only template pack you can add. There are also templates available for ASP.NET MVC Boilerplate, NancyFX, NUnit 3, PowerShell, ServiceStack, and even templates for creating new templates. You can find all of these and more on the [dotnet templating wiki (on GitHub)](https://github.com/dotnet/templating/wiki/Available-templates-for-dotnet-new), and if you create your own, you can add them there as well.

You can see how to use the Aurelia templates that are installed in this [Channel 9 video by Rob Eisenberg on Getting Started with Aurelia and ASP.NET Core](https://channel9.msdn.com/Events/Build/2017/T6032).