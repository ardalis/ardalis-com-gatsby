---
templateKey: blog-post
title: Your API and View Models Should Not Reference Domain Models
path: blog-post
date: 2017-10-03T21:00:00.000Z
description: If you’re organizing your application following Clean Architecture
  and Domain-Driven Design, with your Core domain model in one project that is
  referenced by your UI and Infrastructure projects, you should be careful what
  you expose in your client-facing models.
featuredpost: false
featuredimage: /img/apimodels.png
tags:
  - asp.net
  - asp.net core
  - ddd
  - design
  - design patterns
  - mvc
category:
  - Software Development
comments: true
share: true
---
If you’re organizing your application following Clean Architecture and Domain-Driven Design, with your Core domain model in one project that is referenced by your UI and Infrastructure projects, you should be careful what you expose in your client-facing models. Client facing models typically reside in the UI layer as ViewModels or ApiModels, or they may be called DTOs (Data Transfer Objects). In any event, they should not directly reference types from your domain model, which will consist primarily of entities and value objects (see [DDD Fundamentals](https://www.pluralsight.com/courses/domain-driven-design-fundamentals) for more on these concepts). [Learn more about kinds of models here](http://deviq.com/kinds-of-models/).

## Why shouldn’t DTOs and related types reference domain model entities?

To answer this question, let’s back up and talk about why we’re using DTOs and ViewModels/ApiModels in the first place. Why should we have multiple types for describing what is probably the same thing in our system? For instance, let’s say I have a website where users can come and take tests. Each test has a name, a description, and a collection of questions. My domain model for the test includes some business logic for things like ensuring there is at least one question, that there aren’t duplicate questions, that the name follows a particular convention, etc.

Now in my web project, I need a way for an admin user to add a new test to the system, or update one that already exists. When they do so, I don’t necessarily want to let them touch every single property of the test. For example, maybe I only want the user to create a test with a name and description, and when they do an update maybe the name is immutable but they can add or remove questions or update the description. Depending on whether I’m letting the user perform this work using plain MVC or via an API, I will create ViewModel or ApiModel types that map to the operations the user can perform. If they’re going to be able to create a new test with just a name, I might have class like this one:

```
public class CreateTestViewModel
{
    public string Name { get; set; }
    public string Description { get; set; }
}
```

My actual domain entity for a Test might look more like this, though:

```
public class Test : BaseEntity<Guid> // defines a public T Id property
{
    public string Name { get; set; }
    public string Description { get; set; }
    public ApplicationUser Author { get; set; }
    public List<Exercise> Exercises { get; set; }
}
```

What if instead of writing my action method to accept a CreateTestViewModel, I skipped that and just accepted a Test? Well, then end users could potentially access the full state of the Test entity. Model binding will map whatever JSON or Form data the user sends into my model type. My form or my published API documentation might say that only the Name and Description should be passed in, but a malicious user might be able to guess at my underlying model and realize they can also create Authors (or modify things on Authors, like their roles) and Exercises. If the server-side code isn’t written carefully, it might silently accept whatever the user sends and then persist it to the data store using simple EF commands like Add() and SaveChanges().

If you’re writing API code and you want to help out your end users by giving them useful, live documentation on your API, look at Swagger and related tools. Using Swagger, you can support an endpoint on your web application that will provide an interactive view of all of your public API endpoints and their expected data signatures. By using separate API models, you can ensure that your API is as simple as possible, making your consumers’ lives easier. You can also cut down on how much data you send over the wire, improving performance and saving money on bandwidth by ensuring your API models are as lean as possible.

Another reason to avoid referencing domain model types from your DTOs and ViewModels/APIModels is serialization. It’s not unusual to lock down domain model types by giving them private constructors and pulling in required fields through constructors. This is especially true for immutable value objects, which should always take in their state at construction time. If you try to use these types as your wire protocol for APIs or MVC model binding, you’re likely to run into problems with deserialization, since the types lack a default public constructor. Using models dedicated to your front end once again avoids this issue.

## Tip: Look at Using Statements

The simplest way to avoid having your domain model seep into your wire protocol types is to look at the using statements for these classes:

![](/img/apimodels.png)

Often, domain model references end up in your DTOs because they’re added as properties. Make sure your property data types are, themselves, DTOs (or ViewModels or ApiModels, etc.). Watch for having your Core.Entites or similar namespace being used in your DTO class definitions. You can just look for this during code reviews,[pull requests](https://ardalis.com/github-pull-request-checklist), etc., or you can create a rule in a tool like[NDepend](https://www.ndepend.com/)that will warn you if such a reference is found in classes that match a certain naming convention or belong to a particular namespace.