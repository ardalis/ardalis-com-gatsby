---
templateKey: blog-post
title: Simple Systems and Gall's Law
date: 2021-05-04
description: When it's time to build that big new system to replace the aging old one, consider Gall's Law and the benefit of frequent feedback and evolutionary development.
path: blog-post
featuredpost: false
featuredimage: /img/simple-systems-galls-law.png
tags:
  - programming
  - architecture
  - laws
  - simplicity
category:
  - Software Development
comments: true
share: true
---

When it's time to build that big new system to replace the aging old one, consider [Gall's Law](https://en.wikipedia.org/wiki/John_Gall_(author)) and the benefit of frequent feedback and evolutionary development. Gall's Law states:

> A complex system that works is invariably found to have evolved from a simple system that worked. A complex system designed from scratch never works and cannot be patched up to make it work. You have to start over with a working simple system.

It's important to zero in on two parts of the first sentence before going any further. The complex system "works" and the simple system also "worked." We can ignore this law in any other case.

What kind of evidence is there for this "law"? It's fairly self-evident that small, simpler systems are easier to build and to get working. For one thing, it's easier to determine what "working" means for a small, simple system. A system that has minimal scope is pretty easy to diagnose even through rudimentary manual testing approaches.

Larger, more complicated systems often have difficult-to-diagnose behaviors, some by design, many not. Many successful systems we use every day in technology are built on stacks of smaller components that each can be tested independently. Consider the [OSI Network Model](https://en.wikipedia.org/wiki/OSI_model) and its layers. Think about fairly simple protocols like (the original) [HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) or [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol). Now think about what these would look like if they'd tried to design, explicitly and up front, all of the modern ways in which we build web-based technology on top of these foundational protocols and technologies.

## Big things have small beginnings

I've always loved this quote from [Prometheus](https://www.imdb.com/title/tt1446714/). And of course it's true. Often we can't see it until after the fact, but any big change can always be traced to smaller beginnings. Usually many of them - many choices and decisions and interactions with fate or luck or providence that led to the larger change. We can learn from this and keep it in mind while we design and attempt to deliver ambitious software systems. Build a small working system first before trying to deliver a working complex system.

## Extreme Programming

One of the key values of Extreme Programming (XP) is [Simplicity](https://deviq.com/values/simplicity), coupled with the practice of [Simple Design](https://deviq.com/practices/simple-design). At its heart, the practice of XP revolves around delivering working software, frequently, and changing it as needed to meet the latest needs of customers or users. Extreme Programming takes Gall's Law seriously and builds it into the process.

## Architecture, Monoliths, Microservices

We can try to apply Gall's Law to software architecture, especially for large and ambitious projects. Rather than trying to write a detailed specification for every part of a large system rewrite, frequently it's better to identify parts of the existing system that are working well and pull them into the new system piece by piece while keeping them working. Or if this is impractical, replace existing functionality with new functionality that wraps the old system, using patterns like the [strangler pattern](https://martinfowler.com/bliki/StranglerFigApplication.html) to eventually allow older parts to be removed or retired.

Which is simpler and quicker to build, a monolith or a set of microservices? The monolith, every time. So consider building a modular monolith first, and reach for microservices once you have a simple working system.

One of the key points of microservices is that they **are** simple working systems. So make sure you don't lose sight of this if and when you choose to build them. Keep them simple, keep them working, and ideally deploy them when they are stable and reliable. Until they are both reliable and relatively stable (at least in terms of their public interface), consider keeping them as modules or libraries in the system(s) that need their functionality. Keep things simple and working as long as you can, and when you need the architectural complexity of microservices make sure you're applying it to parts of your system that, individually, are simple and that work.
