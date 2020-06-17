---
templateKey: blog-post
title: The Singleton Design Pattern
path: blog-post
date: 2020-06-17T02:26:41.622Z
description: The Singleton Design Pattern is one of the original creational
  patterns described in the Gang of Four's book, Design Patterns. It is often
  considered an anti-pattern today, though, due to its often negative impact on
  coupling and testability, among other reasons.
featuredpost: false
featuredimage: /img/singleton-design-pattern.png
tags:
  - design pattern
  - design patterns
  - c#
  - dotnet
  - singleton
category:
  - Software Development
comments: true
share: true
---
The Singleton Design Pattern is a fairly simple creational pattern used to ensure that there is only ever a single instance of a class in an object-oriented language. It's useful for ensuring expensive class instances are only created once and to eliminate the need to try and orchestrate between multiple class instances that are each trying to access a single shared resource, such as a file or printer. The pattern achieves this goal by having the class itself responsible for enforcing this constraint, which it does by making its constructor private and then by exposing a static property (often called \`Instance\`) for referencing the (only) instance of the class. Typically the instance isn't created until something tries to access it, allowing for what's called lazy instantiation.

Unfortunately, this pattern is very easy to get wrong. In multi-threaded scenarios, like web applications in general and ASP.NET (Core) in particular, the naive implementation can have multiple threads each creating the instance at the same time. Eventually, only one instance "wins" but in some cases it can be important that multiple instances aren't created, ever, even when the app is first starting up.

The pattern also adds additional responsibilities to the class involved, forcing it to violate the Single Responsibility Principle. The class presumably has some reason for existing, and now in addition to that responsibility it is also responsible for its lifetime. I cover the Single Responsibility Principle extensively in my Pluralsight courses, [SOLID Principles for C# Developers](https://www.pluralsight.com/courses/csharp-solid-principles) and [SOLID Principles of Object Oriented Design](https://www.pluralsight.com/courses/principles-oo-design). The latter also includes coverage of the Don't Repeat Yourself principle, which the Singleton pattern also typically violates since the logic for ensuring singleton behavior must exist in every class that requires such behavior.

More recently, I've published a full course that dives into using the Singleton pattern for C# developers. This course demonstrates multiple different ways to implement the pattern, weighing the pros and cons of each and eventually settling on a couple that both perform well and support multi-threading correctly.  However, even beyond that, I cover alternative approaches to achieve singleton behavior without necessarily using the pattern itself. In most of the applications I work with today, I recommend using these alternative approaches.

Check out the course, [C# Design Patterns: Singleton](https://www.pluralsight.com/courses/c-sharp-design-patterns-singleton) and let me know what you think. The samples, complete with performance benchmarks, are available on GitHub.