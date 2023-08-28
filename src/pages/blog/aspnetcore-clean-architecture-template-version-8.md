---
templateKey: blog-post
title: ASP.NET Core Clean Architecture Template v8 Released
date: 2023-08-28
description: Clean Architecture provides a standard way to avoid tight coupling and external dependencies in complex software applications. The Ardalis.CleanArchitecture.Template NuGet package provides a useful starting point for solutions that wish to use this approach for API development.
path: blog-post
featuredpost: false
featuredimage: /img/aspnetcore-clean-architecture-template-v8.png
tags:
  - dotnet
  - ASP.NET
  - ASP.NET Core
  - Clean Architecture
category:
  - Software Development
comments: true
share: true
---

I've just published a new version of my Clean Architecture Solution Template for ASP.NET Core applications. This is version 8 of the template, though to be clear it is still targeting the current version of .NET (.NET 7). I'll create another update once .NET 8 ships in November 2023.

## What's New

This version introduces some pretty major changes, which I'll highlight here. The biggest ones have to do with:

- Streamlining the template so it has less code
- Focusing on APIs (not razor pages or views)
- Introducing a new UseCases project
- Removing the SharedKernel project.
 
I've also added a separate sample application so users can see examples of how they might want to organize their code (without that necessarily being in the template's output).

### Streamlining the template

I removed a bunch of code from the template to reduce how much you need to delete whenever you create a new solution from it. If you want to see more details about what should go where or how to oranize things, check out the sample in the repo.

### Focusing on APIs

In version 8 of the Clean Architecture Solution Template I'm focusing on APIs using minimal APIs and the [Fast Endpoints library](https://fast-endpoints.com/). In previous versions of the template I included APIs and server-rendered pages using MVC and Razor Pages. There was support for [controller-based API Endpoints using my library](https://www.nuget.org/packages/Ardalis.ApiEndpoints/) as well as Fast Endpoints using the newer minimal API approach.

I removed everything except the last item. If you need Razor Pages for some server-side rendered code, you can easily just add a /Pages folder and update *Program.cs* to bring in the necessary services and middleware. I'd [avoid MVC](https://ardalis.com/mvc-controllers-are-dinosaurs-embrace-api-endpoints/), but you can do the same thing to bring it in, if you really want. 

### The UseCases Project

If you're familiar with Clean Architecture you've probably heard about its *use cases* layer, which previous versions of my template lacked. In the years since I created the template, there have been [issues](https://github.com/ardalis/CleanArchitecture/issues/21) related to [use cases](https://github.com/ardalis/CleanArchitecture/issues/82), but I didn't want to add to the size of the template by supporting them as a separate project, until now. So, what changed?

One thing I've been wanting to better support in the template is [CQRS])(https://deviq.com/design-patterns/cqrs-pattern). Leveraging a separate Use Cases project makes it much easier to have a single place where *commands* and *queries* used by the UI layer can be defined. Initially, I even considered having folders for /Commands and /Queries as the top level folders within the UseCases project, but after some consideration (as well as an online poll) I opted to organize by feature instead. In the template, the "features" are mostly just CRUD operations on a single entity but in real apps you can certainly use domain language for each use case if you prefer (e.g. RegisterUser instead of CreateUser, etc.).

In other presentations and samples related to Clean Architecture I've frequently used the term *application services* instead of use cases. These are basically the same thing, operating at the same level of abstraction. I chose to use *use cases* as the term in the latest version because it's preferred in the "official" clean architecture literature, it's been requested as a feature by that name, and I'm not writing typical "services" but rather handlers for Commands and Queries (so application "services" didn't sound right, and "application handlers" didn't sound better).

### Removing SharedKernel

I've talked about [referencing SharedKernel as a separate NuGet Package](https://dev.to/weeklydevtips/shared-kernel-as-a-package) for many years. The previous versions of the Clean Architecture template recommended this approach as well, but still every time you created a new solution using the template, it would create a SharedKernel project. Which probably isn't what you wanted, especially if this wasn't the first time you were using the template and you'd followed the advice and created a package.

So, now there is no SharedKernel project. Problem solved. But wait - where did all the base types and shared abstractions from that project go? Well, I've created a new public [NuGet package called Ardalis.SharedKernel](https://www.nuget.org/packages/Ardalis.SharedKernel), and referenced it from the template. You **should absolutely replace this reference with a reference to your own SharedKernel package** although there's nothing really *wrong* with just using this one. Note that I have no intention of providing support or additional features to this package - it's only there to support the basic functionality in the template. [Fork it or copy it](https://github.com/ardalis/Ardalis.SharedKernel) and create your very own Acme.SharedKernel and do you custom code there.

### Sample Application

There is now [a separate sample application in the GitHub repo](https://github.com/ardalis/CleanArchitecture/tree/v8/sample).

**Pro Tip:** Hit the '.' key in a GitHub repo while signed in and it will open it up in a VS Code like online IDE.

The sample application has more functionality in it, including multiple related aggregates and features, and leverages more DDD patterns than the template. Rather than bulk up the template with more educational content I shifted a bunch of it here. There are also a bunch of tests, showing how you can easily test all the different components in the architecture.

## Try It!

Try it out and let me know what you think! You can add issues to the repo or leave me a comment here. To get started you just need to install the latest version of the template:

```powershell
dotnet new install Ardalis.CleanArchitecture.Template
```

 Then create a new solution (which will go into a subfolder from wherever you run this):

 ```powershell
 dotnet new clean-arch -o Your.ProjectName
 ```

From there you can build/run/test from the command line or open up the solution file in your IDE of choice.
