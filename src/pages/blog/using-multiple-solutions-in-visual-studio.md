---
templateKey: blog-post
title: Using Multiple Solutions in Visual Studio
date: 2019-08-14
path: /using-multiple-solutions-in-visual-studio
featuredpost: false
featuredimage: /img/using-multiple-solutions-in-visual-studio.png
tags:
  - .net
  - .net core
  - continuous integration
  - visual studio
category:
  - Software Development
comments: true
share: true
---

I've given this advice quite a number of times so I figured it was time to put it into an online article. If you're a .NET developer you probably use or have used Visual Studio. Visual Studio has two kinds of project organization file formats: projects and solutions. Solutions are essentially groups of projects. Most software applications involve more than one project, and so virtually every software application has a solution file organizing said projects.

Sometimes, solutions have more than one application in them. Or they have lots of unrelated projects in them. One company I worked with had every project the company had ever done (over 10 years and over 100 projects) in their one and only solution file. Building that solution took at least 15 minutes so you had to be very careful not to hit ctrl-shift-b unless you were ready to take a break.

Here's the thing - you can create your own solution file. Just for you. It can have just the projects you're working on right now, or just the ones you care about. You don't need to use the bloated one that's checked into source control. You don't even need to check your slimmed down version into source control if you think that'll cause problems. Just keep a local solution so you can develop in a streamlined fashion and watch your productivity and happiness increase dramatically.

"But what about the benefits of one ginormous solution file?" you ask? The only real benefit is that you get immediate integration of any changes you make with all those other projects you're not actually working on right now. And yes, there's some value in that. But that's what your build server is for. If you make some changes that don't break your solution but cause a break for some other project that relies on a library you modified, your build server can notify you of this. And if this is a common scenario and you have too much coupling between disparate projects in your company, you can usually solve this with an internal NuGet server (which I think I'll write about next).

If you're working with ASP.NET Core and want to see a good solution template for new projects that follow [SOLID principles](https://www.pluralsight.com/courses/csharp-solid-principles) and Clean Architecture, [check out my Clean Architecture solution template on GitHub](https://github.com/ardalis/CleanArchitecture). If your team needs some training on the subject [here's a workshop I provide](https://ardalis.com/clean-architecture-with-aspnet-core). And if you didn't know, you can also [create solution files from the command line with the dotnet CLI](https://ardalis.com/how-to-manage-solution-projects-using-dotnet-cli). Finally, if you want to see a real project that uses multiple solution files, [check out the eShopOnContainers sample](https://github.com/dotnet-architecture/eShopOnContainers).
