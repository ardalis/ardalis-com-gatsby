---
templateKey: blog-post
title: Encapsulation in Objects and Applications
path: blog-post
date: 2017-11-01T20:48:00.000Z
description: Encapsulation is a key principle of software development in
  general, and object-oriented design in particular. It refers to the ability
  for constructs (objects, functions, other things) to expose a public interface
  with which clients can interact, while keeping their internal implementation
  hidden.
featuredpost: false
featuredimage: /img/encapsulation-in-objects-and-applications.png
tags:
  - ddd
  - oop
  - quality
category:
  - Software Development
comments: true
share: true
---
[Encapsulation](http://deviq.com/encapsulation/) is a key principle of software development in general, and object-oriented design in particular. It refers to the ability for constructs (objects, functions, other things) to expose a public interface with which clients can interact, while keeping their internal implementation hidden. Encapsulation offers a host of benefits, most important being to allow the construct in question to change its inner implementation details without fear of breaking dependent client code, provided the exposed public contract remains fulfilled. Most software developers (in my experience) are comfortable with this concept and make use of private vs. public members of objects in their software.

The extreme opposite of encapsulation is global variables. Most developers recognize that global variables should be avoided when possible, since they are a huge source of bugs and quality problems.

However, most of the software I see being maintained and built today still fails to consider encapsulation as a beneficial principle to apply at the *application* level. When I’m teaching a class on [Domain-Driven Design](http://bit.ly/ddd-fundamentals) to a group of developers, I almost always ask how many of them have to use a database that is shared by other applications. Virtually every hand goes up. Probably the few that don’t just weren’t paying attention or were busy with something in that moment.

But using a shared database between two applications as a means of integration completely goes against the idea of encapsulation. That shared database represents global state that any application with access to that database can manipulate at any time. Imagine trying to reason about the behavior of your classes in your OO program if other classes frequently just altered the values of your object’s private fields and variables. Not appealing? So why do we tolerate it for our applications?

**Shared databases between applications are global variables, but with even more global scope than any application-specific global variable.**

In DDD, the concept of a [bounded context](http://deviq.com/bounded-context/) is all about encapsulation. A given model of the problem space exists within a bounded context, and interacts with other contexts and apps through programmatic interfaces. If a given bounded context needs to store its state, it does so to a data store that lives within the bounded context, and which is protected from direct access from outside of this context. If you’re sold on the value of encapsulation *within* your application, hopefully this goes a little way toward convincing you that encapsulation is also an important quality for your application, itself.

### A Quick Story

I know another consultant (who will remain nameless) who, when working at a client, was faced with a problem. The application he was building had its own database. The application was evolving rapidly and the database needed to change to accommodate the application as its design evolved. However, other teams wanted access to the data in the application’s database, and unfortunately it was hosted somewhere that they had the necessary credentials to access. The consultant’s solution to this “problem” was simple – he wrote a script that would rename the database every morning using an algorithm that his own application could use to retain uninterrupted access. This made it difficult enough for other teams to directly access the database that they were forced to come to him and work out how to get the data they needed through an API his app exposed.

You may not be in a position to use this technique exactly, but it does demonstrate the value of retaining control of your application’s private state storage, and forcing would-be collaborators to work through your application, not around it.