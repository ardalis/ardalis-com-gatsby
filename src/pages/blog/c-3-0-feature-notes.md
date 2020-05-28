---
templateKey: blog-post
title: C# 3.0 Feature Notes
path: blog-post
date: 2006-12-06T21:08:57.545Z
description: Anders Heljsberg has been giving us an overview of new C# 3.0
  features this morning. I’ve made a few notes. Most of this info is available
  elsewhere, and I’m not re-typing the code from his demos, but there might be
  some useful tidbits here for some folks.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - C#
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Anders Heljsberg has been giving us an overview of new C# 3.0 features this morning. I’ve made a few notes. Most of this info is available elsewhere, and I’m not re-typing the code from his demos, but there might be some useful tidbits here for some folks.

First by way of background, Anders noted the evolution of C# and the key feature that defined each version:

C# 1.0 – Managed Code\
C# 2.0 – Generics\
C# 3.0 – Language Integrated Query (LINQ)

**Some C# 3.0 Design Goals (partial list):**

·Integrate objects, data, xml

·Increase concision of the language

·Add functional programming constructs

**Extension Methods**

Allow adding methods to any classes that have a particular signature. In fact, it is simply a compiler-enabled illusion that simplifies calling static methods. For example, if you have a static method like this one:

public static string Concatenate(IEnumerable<string> strings, string separator) {…}

You could call it like so:\
**string result = SomeClass.Concatenate(myListOfStrings, mySeparator);**

Using Extension methods you would alter your Concatenate method like so:

public static string Concatenate(**this** IEnumerable<string> strings, string separator) {…}

This static method must reside in a static class. It is brought into scope by using the using Namespace; syntax. Once its namespace is in scope, the above code could be rewritten as:

**string result = myListOfStrings.Concatenate(mySeparator);**

The way this works is the compiler will look to see if myListOfStrings actually has a method of its own called Concatenate. If it doesn’t find one, then it will search through all of the static classes in scope to see if any apply to that type (in this case IEnumerable<string>). If so, then it will essentially rewrite the code into the static method call that passes the object as the first parameter to the static method.

One very cool thing about these, which may not be immediately obvious, is that they can reference a wide variety of types. If the first parameter were *object*, for instance, then it could be applied to any type in the framework (not that this would necessarily be wise…).

**LINQ Note**

LINQ for SQL does not support SQL Cache Invalidation, unfortunately. SQL Cache Invalidation against SQL 2005 is currenty done in ADO.NET using the SqlCommand object, which no doubt is used somewhere along the line as LINQ communicates with the database. It would be cool if there were a way to inform LINQ that this query should be cached until a notification is received from the database that the resultset has changed, since this can provide immense performance benefits.

On the plus side, LINQ will ship with a dev toolkit for writing data providers, which would if nothing else let me hack the default SQL behavior to support SQL Cache Invalidation. It’s been my experience that ORM tools do not care to consider caching of resultsets, and in this LINQ for SQL is no exception.

<!--EndFragment-->