---
templateKey: blog-post
title: Dependency Injection Book Reviewed
date: 2021-09-16
description: "A review of Manning's Dependency Injection: Principles, Practices, and Patterns by Steven von Deursen and Mark Seemann."
path: blog-post
featuredpost: false
featuredimage: /img/dependency-injection-book-reviewed.png
tags:
  - book
  - book review
  - dependency injection
  - .net
  - .net core
category:
  - Software Development
comments: true
share: true
---

I like to use an index card as a bookmark when I'm reading non-fiction books, so that I can come back to interesting topics later or review certain points in an article of my own, like this one. Usually one index card is sufficient, but in reading [Dependency Injection: Principles, Practices, and Patterns by Steven von Deursen and Mark Seemann](https://amzn.to/39adnrx)(affiliate link) I filled two front and back. There is a lot of great content packed into this unfortunately-named book. I say unfortunately-named because I agree with one of the quotes on the back cover: 

> Actually three books in one: a really good introduction to DI in .NET, an even better one to DI in general, and an absolutely excellent introduction to OO principles and software design." - Mikkel Arentoft, Danske Bank

Mikkel [buries the lede](https://style.mla.org/dont-bury-the-lede/#:~:text=A%20writer%20%E2%80%9Cburies%20the%20lede,the%20fire%20before%20the%20deaths.) with his comment. This book is first and foremost an excellent guide to writing better software. It achieves this by focusing on the importance of managing dependencies, and because of that, covers different approaches to dependency management, most notably DI.

I'm sure part of the reason for this mismatch is due to the authors' definition of dependency injection. While I typically describe it as a practice or technique (i.e. "the act of injecting a dependency"), the authors define it thusly:

> DEFINITION: Dependency injection is a set of software design principles and patterns that enable you to develop loosely coupled code.

The book goes on to describe the set of principles and patterns that make up dependency injection.

Want an explanation fit for five-year-old? The book cites [this popular Stack Overflow answer](https://stackoverflow.com/a/1638961/13729):

> When you go and get things out of the refrigerator for yourself, you can cause problems. You might leave the door open, you might get something Mommy or Daddy doesn't want you to have. You might even be looking for something we don't even have or which has expired.
> What you should be doing is stating a need, "I need something to drink with lunch," and then we will make sure you have something when you sit down to eat.

[![Manning Dependency Injection Book](/img/manning-dependency-injection-book.jpg)](https://amzn.to/39adnrx)

## Key Takeaways

Look, if you're looking to improve as a software developer using .NET (or a similar language, like Java), then this book will not disappoint you. You can stop reading right here and just order it already. However, here are some (not all) brief takeaways I noted as I read the book.

Loose coupling makes code extensible; extensible code is more maintainable code.

Four [design patterns](https://www.pluralsight.com/courses/design-patterns-overview) are described extensively: Decorator, Composite, Adapter, Null Object. (Personally I was surprised Strategy wasn't mentioned, since that pattern essentially *is* dependency injection, the technique, but it was omitted).

The [SOLID Principles](https://www.pluralsight.com/courses/csharp-solid-principles) are covered, not for their own sake, but along the way as the book encounters them, starting with [LSP](https://deviq.com/principles/liskov-substitution-principle) in the first chapter.

A favorite pattern of mine, [Guard Clauses](https://deviq.com/design-patterns/guard-clause), are used extensively throughout the book's examples.

The book reinforces something I teach frequently, which is that choosing dependencies is a responsibility. Classes that directly control their dependencies tend to violate [SRP](https://deviq.com/principles/single-responsibility-principle). To quote the authors in Chapter 1:

> As developers, we gain control by removing a class's control over its dependencies. This is an application of the Single Responsibility Principle. Classes shouldn't have to deal with the creation of their dependencies.

The book introduces the idea of an app's *composition root*, and recommends that only the composition root should have any knowledge of how dependencies are wired up (or of a DI container, if one is used).

In the chapter on DI patterns, different DI approaches are described, including constructor injection. Constructor injection is preferred over property and method injection for a variety of reasons. Though you should avoid the code smell of *constructor over-injection*, it's still the best place for a class to describe and request what it needs. See also the [Explicit Dependencies Principle](https://deviq.com/principles/explicit-dependencies-principle), which the book didn't cite but which is very relevant here.

Chapter 4 includes a good example covering the *temporal coupling* code smell, as well as an example of using method injection to enable [domain events](https://www.youtube.com/watch?v=95CxduH1b8A).

The authors make the case for using property injection (with sensible defaults) in library code, but favoring in constructor injection in apps.

The book describes the *control freak* antipattern, which they describe as the opposite of *inversion of control*. It's also closely related to the [static cling](https://deviq.com/antipatterns/static-cling) antipattern and my memorable phrase, [new is glue](https://ardalis.com/new-is-glue/).

Other antipatterns and code smells covered include *service locator*, *ambient context*, and *constrained construction*. It's good to have names for these and to be able to recognize them when you see them in your apps.

Returning to the topic of constructor over-injection and the problem of too many constructor parameters, the authors note their personal limit is four. If you have have more than 3 or 4 dependencies being injected into a class, it's a code smell that may indicate the class is doing too much or isn't properly abstracted. Chapter 6 covers this in detail and how to address it through various [refactoring techniques](https://www.pluralsight.com/courses/refactoring-csharp-developers).

Refactoring low-level dependencies into higher-level services helps to improve the overall design of the system, identifying concepts that work together. It's a way to make implicit relationships explicit as part of the system's design.

Chapter 6 demonstrates the [proxy design pattern](https://www.pluralsight.com/courses/c-sharp-design-patterns-proxy) as a means of delaying instantiation of an expensive dependency.

Another code smell covered is overuse of abstract factories.

Chapter 7 focuses on application composition, and demonstrates how you can use [generic constraints in C#](https://www.pluralsight.com/courses/working-c-sharp-generics-best-practices) to narrow down the number of services that can be used to satisfy a given dependency.

If you want to really understand DI, start without using a container (called *Pure DI* by the authors). If you're building ASP.NET Core MVC apps, the authors demonstrate how to sue Pure DI in Chapter 7 by building a custom controller activator.

The authors offer a paraphrase of [LSP](https://deviq.com/principles/liskov-substitution-principle) in Chapter 7: "Methods that consume abstractions must be able to use any class derived from that abstraction without noticing the difference."

Chapter 8 catalogs the various *lifestyles* of dependencies. Soemtimes referred to as lifetimes or life cycles, this describes whether a requested dependency should reuse an existing instance or create a new one. For example, [here's how to register dependencies with different lifetimes in ASP.NET Core](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-5.0#lifetime-and-registration-options). Notably, this chapter demonstrates how to achieve different behaviors using a Pure DI approach, so you get a better understanding of what your DI container is actually doing under the covers when you choose one of the lifestyle/lifetime options for a dependency.

The program's composition root can use a *composer* class to compose the app's object graph. One is shown in chapter 8.

Another code smell to watch out for with DI is *captive dependencies*, which some DI containers can detect automatically.

Avoid tying the lifetime of a dependency to the lifetime of a thread.

Chapter 9 introduces the important concept of *interception* and demonstrates the use of the decorator pattern as the preferred means to achieve it.

Decorators are useful for applying cross-cutting concerns, such as auditing, logging, performance monitoring, validation, security, caching, error handling, and fault tolerance.

Another use case for interception is the implementation of the [circuit breaker pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker), demonstrated in Chapter 9.

Chapter 10 focuses on Aspect-Oriented Programming (AOP), but through design rather than through techniques like IL weaving. The authors highly favor their design approach, saying "Compile-time weaving is the antithesis of DI."

Chapter 10 connects the dots between SOLID and AOP, demonstrating how the application of the principles is used to enable control of different aspects of the app's overall behavior.

The last few chapters of the book cover several specific DI containers, including Autofac, Simple Injector, and the built-in Microsoft.Extensions.DependencyInjection container.

With Autofac, the authors demonstrate a fairly common problem, called *torn lifestyles*. I found each of the container-specific chapters to be worthwhile, though reading them back to back was a challenge since there was a fair bit of repetition between them. I'd recommend reading at least one, especially if you're using one of the covered containers.

## Summary

If you've read this far, hopefully you're convinced that this is a worthwhile book. I was very impressed with its overall quality and it's jumped into my list of required reading for .NET developers. It's already pretty high on my [devBetter group coaching program's](https://devbetter.com/) list of popular books, too. If you have a favorite part of the book, or a question, please leave a note in the comments below.








