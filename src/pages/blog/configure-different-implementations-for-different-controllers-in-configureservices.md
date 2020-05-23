---
templateKey: blog-post
title: Configure Different Implementations for Different Controllers in ConfigureServices
date: 2019-10-09
path: /configure-different-implementations-for-different-controllers-in-configureservices
featuredpost: false
featuredimage: /img/configure-different-services-for-controllers.png
tags:
  - asp.net core 
  - dependency injection
  - di
  - ef core
category:
  - Software Development
comments: true
share: true
---

You may find yourself in a position where you need to have two (or more) different implementations of the same interface within your ASP.NET Core application. This may be because your application is too big to allow you to fully replace one implementation with another all at once, so you're rolling out the updates one type at a time. Let's say the services in question relate to persistence, and you're using some variation of the Repository pattern for the interface. You can easily create separate implementation-specific classes that implement your Repository interface - but how do you dynamically determine which endpoints in your system will use which implementations?

Your basic ConfigureServices code for just wiring up a repository to a single implementation looks something like this:

services.AddScoped(typeof(IAsyncRepository<>), typeof(EfRepository<>));

You can see an example of this approach in the [eShopOnWeb reference application](https://github.com/dotnet-architecture/eShopOnWeb/blob/master/src/Web/Startup.cs).

## Using Different Services in Different Controllers

The problem arises when you have multiple controllers and you want to use different services with each one. There are actually several ways you can address this problem. One approach assuming you're using a generic repository is to vary your implementation with the type of the entity, rather than with the controller. For example, you could have one entity use an EfRepository while another uses a DapperRepository, like so:

// specify specific repo implementation types per entity
services.AddScoped, EfAsyncRepository\>();
services.AddScoped, DapperProductRepository>(x => new DapperProductRepository(Configuration.GetConnectionString("DefaultConnection"))); 

With this approach, everywhere in your application that you use a repository to fetch an entity, if that entity is a `Customer` then you'll use EF Core to get it, but if it's a `Product` then you'll use Dapper to get it.

This may be sufficient or perhaps preferable to configuring the services per Controller, but of course you can do that, too.

To do so, add some variation of this code to ConfigureServices:

// specify specific repo implementation to use per controller
services.AddScoped\>();
services.AddScoped(x => new CarsController(x.GetRequiredService\>())); 

Now when the CarsController is accessed, it will specifically use the EF Repository (of Car) instead of whatever the default implementation might be for the generic repository.

**Note:** For this to work, you need to add controllers as services using `services.AddMvc().AddControllersAsServices();`

You can see the code and [download and run the sample from its GitHub repo here](https://github.com/ardalis/RepoMultiImplementation).
