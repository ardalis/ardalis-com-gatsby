---
title: Registering Open Generics in ASPNET Core Dependency Injection
date: "2017-04-29T23:09:00.0000000-04:00"
description: >
featuredImage: /img/aspnetcore-logo.png
---

If you have a generic interface and implementation that you want to configure for dependency injection in ASP.NET Core startup, there is a simple way to do so. If you only use the generic methods for adding services, such as:

`services.AddScoped<IImageService,ImageService>();`

then you will not find a way to do it. You can't do this:

`// does not work `\
`services.AddScoped<IGenericRepository<T>,EFRepository<T>>();`

Instead, you need to use the non-generic overload of the `Add [Lifetime]` method, and use the `typeof` keyword to specify your open generic interface and implementation. Here's an example:

`// this works `\
`services.AddScoped(typeof(IGenericRepository<>), typeof(EFGenericRepository<>));`

