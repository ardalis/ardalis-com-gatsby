---
templateKey: blog-post
title: A Gentle Introduction to StructureMap
path: blog-post
date: 2012-09-11T22:09:00.000Z
description: I found myself explaining inversion of control containers and their
  benefits to someone today, and so I created a very simple console application
  that makes use of StructureMap (my favorite such container). You can view the
  whole file in this Gist. Here I’ll just briefly explain what’s going on.
featuredpost: false
featuredimage: /img/background-2462434_1280.jpg
tags:
  - dependencies
  - ioc
  - structuremap
category:
  - Software Development
comments: true
share: true
---
I found myself explaining inversion of control containers and their benefits to someone today, and so I created a very simple console application that makes use of StructureMap (my favorite such container). You can view the whole file in [this Gist](https://gist.github.com/3703492). Here I’ll just briefly explain what’s going on.

The main benefit of a tool like StructureMap is to decouple your classes from their collaborators. Rather than classes knowing exactly which implementations they’re working with, they publish their needs for collaborators in their constructors, providing [explicit dependencies](http://deviq.com/explicit-dependencies-principle) (see [my other posts on dependencies](http://www.google.com/#q=dependencies+site:ardalis.com)). The IoC container then is used to provide these classes with the collaborating instances they require. How it does this is via a (generally) one-time configuration at app startup, that maps types to their implementations (usually but not always interface types to instance types).

For example, to tell StructureMap to use the SimplePersonFormatter whenever an IPersonFormatter is required, this line is used:

**config.For<IPersonFormatter>().Use<SimplePersonFormatter>();**

One of the cool features of StructureMap that I take advantage of frequently is its default convention, specified like so:

**config.Scan(scan =>\
{\
scan.TheCallingAssembly();\
scan.WithDefaultConventions();\
 });**

This will automatically register classes named Foo for interfaces named IFoo. That is, for any interface starting with I, if there is a class with a name matching the interface name without the leading “I”, it will be used. In this way you can quickly set up interfaces and their default implementations without having to change the StructureMap initialization code.

The other very nice use for StructureMap and similar tools is object lifetime management. If you’re using an ORM tool like OpenAccess or EntityFramework, it’s often important to fetch, change, and ultimately save changes to entities using the same data context. However, in many applications the data context might be created in one class and used in others and ultimately committed in yet other classes. Trying to track down where the original data context was in order to call its SaveChanges() method can be complicated. StructureMap can eliminate this by managing the lifetime of your data context and/or repository instances. Simply specify that their lifetime is Singleton() or HybridHttpOrThreadLocalScoped() depending on your needs, and then instead of directly instantiating your objects, pull them from StructureMap as needed. You’ll be sure to always have the same instance you started with ([read more](http://stackoverflow.com/questions/3014061/what-is-the-difference-between-hybridhttporthreadlocalscoped-httpcontextscoped)).

There are some who feel, dogmatically I think, that “IOC containers are overkill for all but the most complex applications.” Hopefully you can see from this very simple example how easy it is to get started using an IOC container – there’s little to fear here. Yes, dependency inversion does require a new way of thinking if you’ve never used it before, but the benefit of looser coupling in your applications is definitely worth it in my experience. Remember, “[New is Glue](http://ardalis.com/new-is-glue)”, and providing explicit dependencies and keeping your decisions about which implementations to use in your application in one place helps you to keep your code DRY and your concerns separated.

**See Also**

[Gist Showing Console App Implementation](https://gist.github.com/3703492)

[New is Glue article](http://ardalis.com/new-is-glue)

[Explicit Dependencies Principle (EDP)](http://deviq.com/explicit-dependencies-principle)