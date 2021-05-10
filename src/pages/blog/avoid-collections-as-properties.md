---
templateKey: blog-post
title: Avoid Exposing Collections Directly as Properties
date: 2011-02-22
path: blog-post
description: .NET makes it easy to create strongly typed collections and expose them as properties of our classes. However, this generally results in a design that fails at encapsulation and exposes too much of the class's internal state. Learn a few simple techniques to keep from going down this path in this article.
featuredpost: false
featuredimage: /img/avoid-collections-as-properties.png
tags:
  - encapsulation
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

Sometimes your domain objects have one-to-many or many-to-many relationships with other objects.  For instance, your Customers might have collections of Orders associated with them.  The simplest way to model this is to expose a `List<Order>` field or property off of your Customer class.  Unfortunately, this has a number of negative consequences because of how it breaks encapsulation.  Fortunately, there are some effective ways to shield yourself from these issues while still exposing the collection's data to your class's clients.

## Doing It Wrong

Doing it the simplest way that could possibly work would mean simply exposing the internal state of the Customer class by creating a public field of `List<Order>`.

At first glance, this appears to solve the requirements of the system.  But, this approach has its weaknesses.

## Guarding Against Destructive Actions

The current implementation would allow a user of Customer to set its `OrderHistory` field to null. This is a problem.

The simplest fix to this is to change our `OrderHistory` to use a property, and to make it readonly by giving it a private setter.  With this change in place, we should be safe from this problem.

However, users of the system can still perform destructive actions on the `OrderHistory` by using the `List<Order>` type's methods.  For instance, they can `Clear()` the collection.

In order to remove access to the `List<T>` class's methods, we can hide the implementation details of our internal representation behind a read-only interface, like `IEnumerable`.  However, changing to `IEnumerable` also means we can no longer add directly to `OrderHistory` - this is also a good thing, since that was exposing too much internal state.  Thus we add a method to `Customer` specifically for adding orders to the order history.

## Overriding Intended Behavior

Even if you only expose your type as an `IEnumberable`, sneaky clients of your class can still get to its underlying methods if they guess correctly.  If a consumer of your class is able to guess (or determine through reflection or a decompiler) the actual underlying type of your interface, then all bets are off and they can destroy your data at will.

We can probably safely say that any developer who so blatantly overcomes your attempts at encapsulating data deserves the bugs they create by doing so.  However, there is one more alternative approach.

## Wrapping Collections

The built-in .NET class, `ReadOnlyCollection<T>` is the standard way to wrap a collection and make available only a read-only version of the collection's contents.  The collection lives in the `System.Collections.ObjectModel` namespace.  Once we update our `Order` class to expose this collection as the type of its `OrderHistory` property, the above problem should be fixed.

## Summary

Encapsulation of object state is fundamental to proper object oriented programming and design.  C# makes it very easy to create properties and to work with strongly typed collections of objects, and often this results in object models that expose too much functionality when it comes to collections.  By using interfaces or wrapper classes like the `ReadOnlyCollection<T>`, we can ensure our classes' internal state remains safe from calling code that might inadvertently introduce bugs by changing it inappropriately.

Originally published on [ASPAlliance.com](http://aspalliance.com/2046_Avoid_Exposing_Collections_Directly_as_Properties)
