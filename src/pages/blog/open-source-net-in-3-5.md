---
templateKey: blog-post
title: Open Source .NET in 3.5
path: blog-post
date: 2007-10-03T11:38:40.550Z
description: "ScottGu just made a very exciting announcement – as of Visual
  Studio 2008 and .NET 3.5, the base class libraries will ship with source and
  debug symbols! "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[ScottGu](http://weblogs.asp.net/scottgu) just made [a very exciting announcement – as of Visual Studio 2008 and .NET 3.5, the base class libraries will ship with source and debug symbols](http://weblogs.asp.net/scottgu/archive/2007/10/03/releasing-the-source-code-for-the-net-framework-libraries.aspx)! What this means to developers is we’ll no longer need to resort to tools like Reflector to see what is going on under the covers when we use framework libraries. These libraries are being released under the Microsoft Reference License (MS-RL), and can be browsed locally as well as being used within the Visual Studio debugger.

In addition to making it easier to see why a certain thing is failing or behaving unexpectedly, this will also make it much easier for developers to see real examples of the established patterns and practices for building classes within .NET. For instance, there are many ways to implement a collection, or a web control, but many of them are wrong (or at best, not consistent with how the rest of the framework operates). With the added transparency of being able to easily see how things are done in the framework, I think many developers will write better code by virtue of the fact that they’ll be more likely to follow the best practices embodied in the framework code.

Initially, the source for \*everything\* won’t be included, but most of the heavily used namespaces appear to be in the list, and I think we’ll see others coming in the future.

<!--EndFragment-->