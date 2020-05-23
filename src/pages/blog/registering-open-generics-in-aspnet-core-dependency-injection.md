---
templateKey: blog-post
title: Registering Open Generics in ASPNET Core Dependency Injection
path: blog-post
date: 2017-04-30T03:09:00.000Z
description: >
  If you have a generic interface and implementation that you want to configure
  for dependency injection in ASP.NET Core startup, there is a simple way to do
  so. If you only use the generic methods for adding services, such as:
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - asp.net core
  - dependencies
  - dependency injection
  - di
category:
  - Software Development
comments: true
share: true
---
If you have a generic interface and implementation that you want to configure for dependency injection in ASP.NET Core startup, there is a simple way to do so. If you only use the generic methods for adding services, such as:

`services.AddScoped<IImageService,ImageService>();`

then you will not find a way to do it. You can’t do this:

`// does not work `\
`services.AddScoped<IGenericRepository<T>,EFRepository<T>>();`

Instead, you need to use the non-generic overload of the `Add[Lifetime]` method, and use the `typeof` keyword to specify your open generic interface and implementation. Here’s an example:

`// this works `\
`services.AddScoped(typeof(IGenericRepository<>), typeof(EFGenericRepository<>));`