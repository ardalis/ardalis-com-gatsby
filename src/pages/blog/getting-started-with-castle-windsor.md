---
templateKey: blog-post
title: Getting Started with Castle Windsor
path: blog-post
date: 2014-07-31T14:55:00.000Z
description: My preferred IoC container is StructureMap, but I’m going to be
  working with a client who uses Castle Windsor as their standard container, so
  I decided to learn a bit about it this week.
featuredpost: false
featuredimage: /img/windsorcastle_760x360-760x359.jpg
tags:
  - clean code
  - dependency injection
  - ioc
  - windsor
category:
  - Software Development
comments: true
share: true
---
My preferred IoC container is [StructureMap](http://structuremap.net/), but I’m going to be working with a client who uses Castle Windsor as their standard container, so I decided to learn a bit about it this week. I created a simple console application and included some interfaces and implementations to see how things work. Registering individual interfaces and wiring them up to their implementations is pretty straightforward:

Simple Registration with Castle Windsor

```
var container = new WindsorContainer(); 
// register interfaces and their implementation
container.Register(Component.For<IGreeting>()
    .ImplementedBy<HelloGreeting>());
container.Register(Component.For<IWriter>()
    .ImplementedBy<ConsoleWriter>());
```

Getting resolved types out of the container is also imple. Greeter requires an IGreeting and an IWriter in its construction:

Resolving Types with Windsor

```
var greeter = container.Resolve<Greeter>(); greeter.Name = "Bob the Greeter";
greeter.Execute("Steve");
```

Especially while you’re learning how to work with the container, it can be useful to see a list of everything that is currently registered. I’m not aware of a built-in method that does this directly, but this code will suffice:

Show Contents of Windsor Container

```
foreach(var handler in container.Kernel     
.GetAssignableHandlers(typeof(object)))
{
    Console.WriteLine("{0} {1}",
        handler.ComponentModel.Services,
        handler.ComponentModel.Implementation);
}
```

The one tricky part I ran into is the fact that [Castle Windsor does not automatically resolve concrete types](http://stackoverflow.com/questions/1955579/can-castle-windsor-do-automatic-resolution-of-concrete-types), so you have to register them all yourself. You can do this one by one, like this:

Register One Type at a Time

```
container.Register(Component.For<Greeter>());
```

But that doesn’t necessarily scale in a large project that’s going to have hundreds of classes. Fortunately, you can also register many types at once using a variety of predicates to filter the list. For instance, all classes that inherit from a particular base class, or belong to a certain namespace, or end with a certain string. One of my favorite StructureMap features automatically maps concrete types to interfaces with similar names, e.g. IFoo gets mapped to class Foo with no code required. In StructureMap this is achieved using .WithDefaultConventions(). You can do the same thing in Castle.Windsor by using .WithServiceDefaultInterfaces(), which seems to go beyond StructureMap in terms of the naming conventions it supports.

Here’s an example showing how to register a bunch of types at once using this feature:

Register Many Types Automatically

```
container.Register(Classes.FromThisAssembly()     
  .InNamespace("CastleWindsorConsole")
    .WithServiceDefaultInterfaces());
```

If you’re familiar with StructureMap, the .WithServiceDefaultInterfaces() call above is similar to StructureMap’s WithDefaultConventions() method. Not that you can’t just say container.Register(Classes.FromThisAssembly()) by itself – you must provide some kind of predicate, even if it’s just a Where() that always returns true.

You can view and download the code for this [CastleWindsorSample application from GitHub](https://github.com/ardalis/CastleWindsorSample/).