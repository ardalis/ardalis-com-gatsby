---
templateKey: blog-post
title: C# Generics Best Practices
date: 2021-06-08
description: C# Generics have been around since 2005, but a few new features have been added over the years, along with a bunch of built-in classes that leverage the feature. This article provides an overview of my latest Pluralsight course, which reviews proven best practices for leveraging generics in your C# and .NET applications.
path: blog-post
featuredpost: false
featuredimage: /img/csharp-generics-best-practices.png
tags:
  - programming
  - c#
  - generics
  - csharp
  - course
  - pluralsight
category:
  - Software Development
comments: true
share: true
---

There was a time when C# didn't support generics. It was a dark time. Ragged bands of .NET developer roamed the harsh landscape, copy-pasting strongly typed list implementations to avoid the evils of primitive boxing operations. Forced to choose between loose typing and explicit casts at every turn, would-be developers of strongly-typed object models somehow managed to endure and ship (mostly) working software.

Then, like a light in the darkness, a new version of C# became available, offering .NET developers the ability to define the types of classes *where they're declared*, not just when they're defined. Suddenly, collections could contain non-object types, and could enforce this behavior with no custom coding or third-party libraries. And there was much rejoicing.

In the (many) years since, few features have had as great an impact on C# and its capabilities as generic support has. Any that you might think of, probably derive at least part of their implementation from the existence of generics, such as LINQ, which benefits immensely from the strong typing generics affords to its interfaces and extension methods.

Having a strong understanding of what generics are, and how to use them both in your own types and through types provided in the framework, is critical to being an effective .NET developer today. Don't be surprised to find questions about generics in technical interviews for more senior positions. It's worth spending a little time making sure you're up to speed with the entirety of the feature and its capabilities. And that's what my latest Pluralsight course is all about.

[Working with C# Generics: Best Practices](https://www.pluralsight.com/courses/working-c-sharp-generics-best-practices) is all about leveraging years of experience to build better solutions using C# and generics. The course starts with a comically brief overview of what the feature is (you're kind of expected to know this already) and then dives right into how to design better software using it. From a starting point of interfaces, both your own and provided ones, you'll learn how to use generics to improve your application's design. By the end of the module, you'll understand how generic constraints help force users of your design into the "pit of success" by baking design decisions into rules the compiler will enforce on your behalf.

The next module shows how to instantiate and call methods on generic types using reflection, and then dives into covariance and contravariance. If you're confused about these two terms, you're not alone, but by the end of this module you should have a firm graph of both, along with the general idea of variance in C#.

Next up it's class design with generics, including how best to apply inheritance. Does your generic class need a non-generic base class? Should your generic class have a non-generic child class? Where should static methods and extension methods for your generic type live? All this and more are covered. But wait, there's more! You also learn the fluent generics pattern, which provides a builder-like way to specify generic types, and a whole section on generic methods as an alternative design to generic classes, and some of the tradeoffs between the two.

The last module covers generic events and delegates, which many developers don't use as often as they probably could. In addition to language support for generic `event` and `delegate` keywords, built-in framework types like `Predicate<T>`, `Action<T>`, and `Func<T>` provide a lot of functionality to apps that apply them properly.

I wrap up the course with a brief review of some of the [NuGet packages I author](https://www.nuget.org/profiles/ardalis) that leverage generics, all of which are open source and available for you to use to learn more about real world ways generics can be used.

I hope you'll check out the course, and if you enjoy it, leave a rating and/or tell your friends on Twitter or LinkedIn. Thanks!
