---
templateKey: blog-post
title: ASPNET Core 2 Preview 1
path: blog-post
date: 2017-05-12T02:57:00.000Z
description: This week a public preview of ASP.NET Core 2 was made available at
  Microsoft’s /BUILD event. You can install it side-by-side with your existing
  ASP.NET Core install, and you can also install Visual Studio 2017 update 3 to
  go with it.
featuredpost: false
featuredimage: /img/vs2017-previewlogo.png
tags:
  - asp.net core
  - visual studio
category:
  - Software Development
comments: true
share: true
---
This week a public preview of ASP.NET Core 2 was made available at Microsoft’s /BUILD event. You can install it side-by-side with your existing ASP.NET Core install, and you can also install Visual Studio 2017 update 3 to go with it. Download both here:

* [.NET Core 2.0 Preview 1 SDK](https://www.microsoft.com/net/core/preview#windowscmd)
* [Visual Studio 2017 Preview Version 15.3 Download](https://www.visualstudio.com/vs/preview/)

## Highlights of What’s New

Packages for the framework have been consolidated – you won’t have 10 different packages each with separate versions. There’s just one ASP.NET Core package your project needs to reference.

The Startup story for new apps has been simplified. Configuration is no longer set up in the Startup.cs file by default, but instead is done by default using WebHostBuilder in Program.cs. I personally prefer this approach, and was hoping to see both configuration and logging defaults moved into WebHostBuilder so they’re available in Startup methods. In this new approach, the config system is set up in the dependency injection container by default. In addition to cleaning up how much repetitive code ends up in Startup.cs, this change also means the configuration system is more readily used by ASP.NET Core intrinsics, like how Kestrel works. This is following a convention over configuration, but does mean that the behavior of the configuration system is not quite as obvious (if you’re not familiar with the conventions being used). For example, knowing that appsettings.Development.json will be used when you’re in the Development environment used to be clear from actual code in Startup.cs. Now, you’ll need to read the docs to discover this behavior, I suspect.

**Razor Pages**

Razor pages use the same extension as views (.cshtml), but they’re not views. You can place code inside of them, similar to classic ASP (and ASP.NET Web Forms) pages. By default, these pages should be placed in a folder called Pages. Requests that match the name of a page in this folder will be routed to that razor page. These razor pages literally are using MVC under the covers, they’re just combining everything into a single file. Within a razor page, you can define the route and route parameters (as you would in a \[Route] attribute in a controller), and specify the action methods within it. Essentially, the code within the Razor page is a combination of a Controller (and one more more actions) and the View, in a single file.

Razor pages combine a number of things into a single file, making it easier to get started building simple applications. This page model can be used for proofs of concept, or to teach developers who are new to ASP.NET Core, or for very simple sites that don’t need the [architectural best practices of ASP.NET Core MVC](http://aspnetcorequickstart.com/) and [Clean Architecture](https://github.com/ardalis/CleanArchitecture). However, because it’s using MVC under the covers, you can easily shift from Razor Pages to an MVC structure with [separation of concerns](http://deviq.com/separation-of-concerns/) if and when the application grows to require it.

**Perf and Deployment**

Of course, ASP.NET Core 2 is faster. The deployed cross-generated packages (optimized for different platforms) are also much smaller than the packages produced by dotnet 1.x.

**Other Improvements**

There’s better integration with App Insights and Azure and Visual Studio. There’s also better integration with Azure authentication options, so that you don’t just have the option of storing accounts in your app’s database, but you can also choose to store the identity accounts in Azure. Basically, the whole account aspect of new MVC web apps can now be configured to either work with your local ASP.NET Identity provider (with Entity Framework Core), or it can be configured to run against Azure. Thus, you can switch between local and Azure user accounts with one line of code (in Startup). And it’s not just Azure – this works with any compliant OpenID provider, like [IdentityServer](https://www.identityserver.com/).

**Learn more**

You can [watch a recording from Build where the preview is introduced](https://channel9.msdn.com/Events/Build/2017/b8048). [Learn more about ASP.NET Core from my ASP.NET Core Quick Start course](http://aspnetcorequickstart.com/).