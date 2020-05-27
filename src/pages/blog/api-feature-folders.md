---
templateKey: blog-post
title: API Feature Folders
date: 2018-02-28
path: blog-post
featuredpost: false
featuredimage: /img/api-feature-folders.png
tags:
  - asp.net
  - asp.net core
  - web api
category:
  - Software Development
comments: true
share: true
---

I've written about [feature folders for ASP.NET Core](https://ardalis.com/msdn-feature-slices-for-aspnet-core-mvc) before, and how [Razor Pages does a great job of solving this problem](https://ardalis.com/aspnet-core-razor-pages-worth-checking-out) for page/view-based endpoints. However, I wanted to take a moment to address APIs, which are an increasingly important part of modern web applications.

In ASP.NET Core (and unlike ASP.NET 5 / Web API 2), Web API controllers are just controllers. You don't need to inherit from a different base type or anything like that. What's more, your API controllers should be returning DTOs that are separate from your underlying domain or data model. In a typical, default project you might have something like this:

[![api-default-project](/img/api-default-project.png)](/img/api-default-project.png)

Over time, this tends to grow and can become unwieldy. It's not unusual to have a dozen or more controllers, and your models will likely include things like NewWhateverModel, UpdateWhateverModel, WhateverSummaryModel, etc. as you create models specific to particular API needs. You might start to have a project structure that looks something like this:

[![api-default-project-later](/img/api-default-project-later.png)](/img/api-default-project-later.png)

What I've found to be a better organization is to do away with the Controllers folder (or keep it around if you're using view-based controllers) and instead use feature folders for your APIs. I'm partial to having a root level API folder but if you'd prefer to put your features in the root of the project that would work, too. Within each feature folder, you include the controller along with any model types it needs to work with, like this:

[![api-feature-folders](/img/api-feature-folders.png)](/img/api-feature-folders.png)

Obviously one benefit of this approach is that it's more cohesive. Things that change together are located physically next to one another, and the friction involved in moving between different folders with too many files in them is greatly reduced. Another nice thing about this approach is that it just works. Unlike view-based controllers (which need something like [this](https://www.nuget.org/packages/Ardalis.CoreFeatureFolders/)), you don't need to change anything about how ASP.NET Core is configured to have this organization structure work for you.

I'm curious, how many of you are using a non-default organization structure for your ASP.NET (Core) projects? What are the pros and cons you see of your approach?
