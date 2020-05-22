---
templateKey: blog-post
title: ASPNET Core InMemoryDatabase Upgrade Breaking Change
path: blog-post
date: 2017-10-05T20:56:00.000Z
description: There’s a minor breaking change in ASP.NET Core 2.0 that I’ve
  encountered while updating my Clean Architecture sample.
featuredpost: false
featuredimage: /img/digitization-5140055_1280.jpg
tags:
  - asp.net core
  - ef core
  - entity framework core
  - testing
category:
  - Software Development
comments: true
share: true
---
There’s a minor breaking change in ASP.NET Core 2.0 that I’ve encountered while updating my Clean Architecture sample.

In 1.x, you could configure EF Core to use an In Memory database, and when you did so, you could optionally specify a name:

```
// 1.x Code
services.AddDbContext<AppDbContext>(options =>
    options.UseInMemoryDatabase());
 
// or
 
services.AddDbContext<AppDbContext>(options =>
    options.UseInMemoryDatabase("database"));
```

One of the most common scenarios for using an in memory database is for testing. Unfortunately, the state of the in memory database is not reset between test runs, even if you re-create your application on each test run. One way to help with this is by specifying a unique name for your database, using code like this:

```
services.AddDbContext<AppDbContext>(options =>
    options.UseInMemoryDatabase(Guid.NewGuid().ToString()));
```

This works and runs fine in 1.x. However, in 2.x if you use this same code, you’ll find that every instantiation of your DbContext will be created using a differently-named database. And so essentially you won’t have any persistence. Apparently the change is that the options lambda is executed every time a request is made for an AppDbContext, instead of just once on app startup.

To fix this, specify a fixed string. I think the test issues from 1.x are largely gone in 2.x, so you shouldn’t need to create a new unique name every time, but if you want to do so, you should be able to use code like this:

```
string dbName = Guid.NewGuid().ToString();
services.AddDbContext<AppDbContext>(options =>
    options.UseInMemoryDatabase(dbName));
```

Note that I haven’t fully verified that InMemoryDatabase works the way I would like in all integration test scenarios in 2.x, but my tests in CleanArchitecture all pass now, and I figured others might run into this same issue, so I’m sharing it as-is.