---
templateKey: blog-post
title: Clean Architecture with ASP.NET Core
date: 2021-11-30
description: Clean Architecture is a way of structuring a solution such that dependencies and infrastructure concerns are kept separate from business logic and the domain model. It's frequently used with Domain-Driven Design and can easily be built with ASP.NET Core using a solution template described in this article.
path: blog-post
featuredpost: false
featuredimage: /img/clean-architecture-asp-net-core.png
tags:
  - asp.net
  - asp.net core
  - dotnet
  - .net core
  - architecture
  - visual studio
category:
  - Software Development
comments: true
share: true
---

I late 2021, I presented a 30-minute session at [dotNetConf](https://www.dotnetconf.net/) on the topic of [Clean Architecture with ASP.NET Core 6](https://www.youtube.com/watch?v=lkmvnjypENw). At the time of writing this 2 weeks later, the video has 82k views, making it the most-watched YouTube video of the conference (not necessarily during the live event). You can check it out here if you're interested:

<iframe width="560" height="315" src="https://www.youtube.com/embed/lkmvnjypENw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

In this article, I want to go into a bit more depth on the topic of Clean Architecture with ASP.NET Core.

## What is Clean Architecture

Briefly, [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) is the most recent (2012) name for a style of application organization that has been around for nearly two decades. Its earlier names included Ports and Adapters, which is fairly descriptive, and [Hexagonal](https://en.wikipedia.org/wiki/Hexagonal_architecture_(software)), which IMO is a silly name based entirely on some shapes used in a diagram long ago as far as I can tell. These are credited to Alistair Cockburn. [Jeffrey Palermo later coined the term Onion Architecture](https://jeffreypalermo.com/2008/07/the-onion-architecture-part-1/) in 2008, but the concepts are essentially the same. All of these are examples of a domain-centric, rather than data-centric, approach to application architecture.

> NOTE: If you prefer video, I talk about the differences between data-centric and domain-centric architectures in my Pluralsight courses on [Creating N-Tier Applications in C#](https://www.pluralsight.com/courses/n-tier-apps-part1). They're retired but still relevant and you can get to them from [my author page](https://www.pluralsight.com/authors/steve-smith) if you're interested.

The guiding principle of these very similar approaches is the [Dependency Inversion Principle](https://deviq.com/principles/dependency-inversion-principle), part of the [SOLID principles of object-oriented design](https://deviq.com/principles/solid). This principles states that high level modules should not depend on low level modules, but instead both should depend on abstractions. High level modules are things like business rules and domain models. Low level modules are closer to out-of-process communication, such as through the user interface or communicating with services or the file system.

The principle goes on to state that abstractions shouldn't depend on details, but that details should depend on abstractions. What this means is that your abstractions shouldn't "leak" any information about their implementations. For instance, you wouldn't want to have a method definition called `ListCustomers` that returned a `SqlDataReader` because it would make it difficult to implement that method using an implementation that didn't rely on a SQL Server database.

Given the dependency inversion principle and its rules, the goal of Clean Architecture is to ensure that high level modules and their associated abstractions live in an assembly or project that doesn't depend on low level modules or details. This project is frequently called Core or perhaps Domain, and the main rule of the architecture is that this project doesn't depend on any other project in the solution, but instead the other projects depend on it.

Low level implementation detail classes that implement the abstractions defined in Core are defined in a separate project which is typically called Infrastructure. This project should depend on Core in order to access the interfaces and domain model types defined there. Because Infrastructure depends on Core, it's impossible for the reverse to be true. This is one reason why the architecture utilizes several projects, to ensure this rule is followed and enforced by the compiler, not just by developer diligence or discipline. [Some might argue that this is over-engineered](https://stackoverflow.com/a/70178190/13729) but the end result is typically just 3 projects and I've never found that to be too many for any application of non-trivial complexity.

The third project is the UI project. Assuming you're building an ASP.NET Core app, this will be an ASP.NET Core project called Web or something similar. It doesn't really matter if it's using Razor Pages or MVC or [API Endpoints](https://www.nuget.org/packages/Ardalis.ApiEndpoints/); the important thing is that the project references Core and avoids using any types from Infrastructure directly outside of its composition root.

An app's composition root is where all of the services in the app's dependencies are defined and "wired up". In ASP.NET Core this typically happens in Startup.cs or Program.cs in a ConfigureServices method or section. Other than that one location, the Web project shouldn't use any types from Infrastructure.

Although it's rarely done (because using a reference is easier), you should be able to completely eliminate any project reference between Web and Infrastructure, and just copy the Infrastructure DLL into the Web project's *bin* folder after it's compiled. Then, your composition root can use reflection to read the types from the Infrastructure DLL and wire them up as usual, but without any compile-time dependency on the project. I've [demonstrated how to avoid directly referencing infrastructure in Visual Studio solutions in legacy .NET 4.x apps](/avoid-referencing-infrastructure-in-visual-studio-solutions/). You can do something similar in .NET Core if you wish.

## ASP.NET Core and Clean Architecture

Ok, so there are basically three projects: Core, Infrastructure, and Web. The last one should use ASP.NET Core, which will be the app's composition root and starting point. But how do you know what to put in each project? Let's start from the app itself and work our way down into its dependencies.

### What belongs in the Web project?

In the Web app, you're going to have any and all of your ASP.NET Core and ASP.NET Core MVC types. These will include Controllers, Views, Pages, Filters, TagHelpers, Middleware, etc. If it has a dependency on ASP.NET Core packages, it probably belongs in this project. In addition, any DTO types you're using specifically to communicate over the wire such as ViewModels, API Models, and the like, should go here by default. There are reasons why you might want to define these in another project, such as if you're using Blazor WebAssembly and you want to share the DTOs between the client and the server. But by default they belong in the Web project until you find a good reason to move them.

What shouldn't be in the Web project? Data access concerns including how you're communicating with the data source and how you're building queries. There should be minimal LINQ expressions for data queries. There should be zero use of `DbContext` types or other Entity Framework or Dapper or (insert your data access library here) references. The only place these should be used (if at all) is in your app's composition root.

#### What about use cases or application services?

I typically will put use cases, application services, and other services that live between my UI and my domain model in the UI (Web) project, along with any interfaces that implement. You can see an example of this in the [eShopOnWeb reference application, which uses a service to build up a complex viewmodel and then also leverages the Decorator pattern to add caching to that same service](https://github.com/dotnet-architecture/eShopOnWeb/tree/main/src/Web/Services).

I tend to only leverage these services on an as-needed basis. Most of the time I prefer to work with my domain model directly.

### What belongs in the Infrastructure project?

Anything that communicates out of your app's process belongs in Infrastructure. The biggest and most obvious one being data access, but also anything that sends emails, sends SMS messages, talks to files, communicates with web APIs, etc. would belong here. One of the major benefits of Clean Architecture is extreme testability for the most important parts of the app, the domain model and business logic. Infrastructure dependencies are notoriously difficult to unit test, so by placing all such dependencies in their own project and ensuring the Core project doesn't have any direct dependencies on these libraries or the types that use them is the main way Clean Architecture ensures the domain model remains free of nasty dependencies.

### What belongs in the Core project?

If you're following [Domain-Driven Design](https://www.pluralsight.com/courses/fundamentals-domain-driven-design), then this is where all of your domain model types belong. This will include entities as well as potentially value objects, aggregates, domain events, [specifications](https://www.nuget.org/packages/Ardalis.Specification), factories, and more. I'm a fan of using well-defined custom exceptions and [guard clauses](https://www.nuget.org/packages/Ardalis.GuardClauses/) as well as [custom validators](https://www.nuget.org/packages/FluentValidation/), all of which would be defined in the domain model as well.

### What about sharing between apps?

If you have common abstractions or base classes that you intend to use across many apps, it can be useful to maintain a separate Shared Kernel library for this purpose. The Shared Kernel library should only be updated with consensus from all of the application teams that depend on it. Ideally it should be distributed as a NuGet package so that teams and opt into breaking changes rather than being immediately broken by them. Because the Shared Kernel package will be consumed by multiple Core projects in various app solutions, it is especially important that no infrastructure dependencies exist in Shared Kernel.

> NOTE: I talk about all of these concepts and more in my free ebook, [Architecting Modern Web Applications with ASP.NET Core and Microsoft Azure](https://ardalis.com/architecture-ebook).

## Getting Started with Clean Architecture and ASP.NET Core

The quickest way to get started using Clean Architecture for your next ASP.NET Core app is to install a template and then create a new solution from the template. You can [view all of my published templates using this NuGet query](https://www.nuget.org/packages?packagetype=template&sortby=relevance&q=ardalis&prerel=True). For this purpose, you want the [Ardalis.CleanArchitecture.Template package](https://www.nuget.org/packages/Ardalis.CleanArchitecture.Template/). On that page, you'll find a simple dotnet CLI command you can run to install the template. If you omit the version you'll get the latest version:

```powershell
dotnet new --install Ardalis.CleanArchitecture.Template
```

You should see output similar to this, depending on if you've previously installed a version of the template:

```powershell
The following template packages will be installed:
   Ardalis.CleanArchitecture.Template::6.0.9

Ardalis.CleanArchitecture.Template is already installed, version: 5.0.0, it will be replaced with version 6.0.9.
Ardalis.CleanArchitecture.Template::5.0.0 was successfully uninstalled.
Success: Ardalis.CleanArchitecture.Template::6.0.9 installed the following templates:
Template Name                        Short Name  Language  Tags
-----------------------------------  ----------  --------  ------------------------------
ASP.NET Clean Architecture Solution  clean-arch  [C#]      Web/ASP.NET/Clean Architecture
```

Note that a new template with short name `clean-arch` was installed. To create a new project using the template, you can just run this command:

```powershell
dotnet new clean-arch -o Your.ProjectName
```

Whatever you specify for "Your.ProjectName" will be used for the solution name as well as your default namespace hierarchy.

## Summary

Clean Architecture is a great way to organize application of moderate to high complexity. It ensure dependencies are kept isolated from business logic and the application's domain model. ASP.NET Core works very well with the Clean Architecture approach, provided that the initial solution is set up properly. Using a solution template can help ensure you get your application started on the right track.
