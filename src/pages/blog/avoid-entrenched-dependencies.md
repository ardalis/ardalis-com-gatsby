---
templateKey: blog-post
title: Avoid Entrenched Dependencies
path: blog-post
date: 2009-10-11T20:35:00.000Z
description: Last year I wrote about Avoiding Dependencies and described some
  Insidious Dependencies (with help from many commenters) that many developers
  might not immediately recognize as dependencies.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - entrenched
category:
  - Uncategorized
comments: true
share: true
---
Last year I wrote about [Avoiding Dependencies](/avoiding-dependencies) and described some [Insidious Dependencies](/insidious-dependencies) (with help from many commenters) that many developers might not immediately recognize as dependencies. It occurred to me today that I should point out that dependencies themselves are not intrinsically bad design – all software has dependencies. The important distinction here that I think is a best practice is that one should make efforts to avoid ***entrenched dependencies*** on things that are ***likely to change***.

As an example, I write most of my software using Microsoft .NET. I’m inherently taking a dependency on the CLR. If at some point the customer’s needs dictate that I need to move to Java or Ruby, that is most likely going to be a painful thing. However, I don’t foresee such a change being required, so I’m happy to have tight coupling to .NET for most of my applications.

When you perform a code review, whether for your own software or for someone else’s, one of the things you should analyze are the dependencies the code has, and whether these are implicit or explicit and whether they are entrenched or flexible. If the software simply instantiates classes directly wherever it might need them, and makes no use of Dependency Injection, it’s likely to be riddled with *implicit*and *entrenched* dependencies. On the other hand, if classes identify their dependencies in their constructor via interfaces, and an IoC container is in place to allow easy management of the actual implementation classes that are used at runtime (that conform to these interfaces), then the dependencies are *explicit*and *flexible*. (and on the other hand, if *everything* is an interface, the application is likely to be more difficult to understand than necessary – see below)

There are costs associated with abstracting dependencies. In the extreme, every “new” in your code is a dependency on a particular implementation, and thus could be replaced with an interface and injected in. In practice, the main things you want to worry about abstracting are the ones that are *most likely to change*, and over which you have the least control. **Things that need to change in order to test your code count as things that are likely to change,**and thus should always be abstracted if you plan on writing good unit tests! Otherwise, don’t go overboard. Wait until your dependence on a particular implementation causes pain before you start extracting interfaces and DI-ing them into all of your classes. All things in moderation.