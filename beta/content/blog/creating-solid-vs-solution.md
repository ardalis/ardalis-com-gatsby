---
title: Creating a SOLID Visual Studio Solution
date: "2011-06-14T00:00:00.0000000"
description: The SOLID acronym describes five object-oriented design principles that, when followed, produce code that is cleaner and more maintainable. The last principle, the Dependency Inversion Principle, suggests that details depend upon abstractions. Unfortunately, typical project relationships in.NET applications can make this principle difficult to follow. In this article, I'll describe how one can structure a set of projects in a Visual Studio solution such that DIP can be followed, allowing for the creation of a SOLID solution. You can download the sample solution and use it as a starting point for your new solutions if you like.
featuredImage: /img/solid-vs-solution.png
---

## Introduction

The SOLID acronym describes five object-oriented design principles that, when followed, produce code that is cleaner and more maintainable. The last principle, the Dependency Inversion Principle, suggests that details depend upon abstractions. Unfortunately, typical project relationships in.NET applications can make this principle difficult to follow. In this article, I'll describe how one can structure a set of projects in a Visual Studio solution such that DIP can be followed, allowing for the creation of a SOLID solution. You can download the sample solution and use it as a starting point for your new solutions if you like.

## Dependency Inversion

The [Dependency Inversion Principle](https://deviq.com/principles/dependency-inversion-principle) states that "High-level modules should not depend on low-level modules. Both should depend on abstractions. Abstractions should not depend on details. Details should depend on abstractions." What does this mean, in plain old C# English? Abstractions in this case means interfaces (generally - sometimes base classes). Details means specific, concrete implementations of functionality. High-level modules are your business logic - the big picture of What Your App Does, while low-level modules are the implementation details - How Little Things Are Done. The goal here is to decouple how things are done from what you need to do, and to make sure your infrastructure implementations depend upon your high level modules and abstractions, not the other way around.

## Data Centric Solution Organization

Far too many.NET solutions have a design where everything depends on the Data Access Layer. Since this layer is responsible for the details of how it communicates with your database, it's a low-level module full of details. It's exactly the kind of thing the DI principle is saying NOT to have your high level modules (business logic) depend on.

## Domain Centric Solution Organization

A better approach, and the one we'll be building here, is to construct your solution so that your Core or Business Logic project has no dependencies on other projects.

How do you do this? Typically by following the Strategy pattern. You define interfaces in your core project for things like `IRepository<Customer>` and then you implement these in your Data or Infrastructure project with a particular implementation like `SqlCustomerRepository`. The Data assembly will need to be in the UI's bin folder at runtime in order for it to be used, and a simple way to achieve this is to add the reference from UI to Data. But you want to avoid at all costs any direct calls from UI to the Data project directly, as this will eliminate the benefits of following the Dependency Inversion Principle (by adding tight coupling between UI and Data).

## Solution Organization

Our solution is going to include the following projects:

### Core

The Core project holds almost all of the interfaces used, as well as your Model objects, which should be [Plain Old CLR Objects](https://ardalis.com/dto-or-poco/) (POCOs).

### Infrastructure

The Infrastructure project holds your implementations of various interfaces for things that need to communicate outside of your process. These include web services, database access repositories, email routines, system clocks, file system, etc. Just about [anything that I've discussed on my blog as being a dependency](http://www.google.com/search?sourceid=chrome&ie=UTF-8&q=steve+smith+blog+dependencies) should have its implementation in the Infrastructure project.

Infrastructure depends on Core.

### UI

Your UI project. This might be a web project, Windows Form, WPF, Silverlight, or even Console Application. You might even have multiple UIs within your solution.

UI depends on Core and Infrastructure (at least transitively). If you are not using a separate DependencyResolution project, then UI will need to provide the actual implementations from Infrastructure to plug into the interfaces it uses.

These are the only projects you *need* to have. However, I usually include the following as well:

### Unit Tests

You might create multiple unit test projects. However, unit tests should not reference Infrastructure, typically, because they are meant to only test your code, not dependent code. Integration tests (see below) should be used to test how your code interacts with other systems. If you only create one UnitTests project for your whole solution, you will want it to reference Core and any other project you are testing.

### Integration Tests

Integration tests are automated tests that verify how your application works with other systems (like your database) outside of your running process. It should reference your Core, Infrastructure, and DependencyResolution projects and should ideally use the same object graph that you will use in production (or something close to it).

### Dependency Resolution

This project is simply responsible for handling registration of types and interfaces and resolving types that have dependencies. That is, if you use the Strategy pattern to say that a particular class requires an IFileSystem as part of its constructor, you can wire up the WindowsFileSystem class to the IFileSystem interface in the DR project, and then use the DR project to create your class such that it will automatically have its dependency provided (as a WindowsFileSystem instance). This project will generally comprise just a few classes and your Inversion of Control Container of choice (e.g. StructureMap, Unity, NInject, etc).

Dependency Resolution should reference Core and Infrastructure.

You can learn more about [creating a multi-project solution template for VS2010 here](http://msdn.microsoft.com/en-us/library/ms185308(v=VS.100).aspx).

## Conclusion

[The SOLID OOP Principles](https://deviq.com/principles/solid)

[Download the Sample Application as a Zip File](http://aspalliance.com/download/solidtemplate.zip)

By starting with a SOLID foundation, you'll be much better-equipped to produce maintainable code than if you begin with a data-centric solution organization and try to produce loosely coupled code from there.

Originally published on [ASPAlliance.com](http://aspalliance.com/2064_Creating_a_SOLID_Visual_Studio_Solution)

