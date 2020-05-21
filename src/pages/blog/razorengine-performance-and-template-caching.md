---
templateKey: blog-post
title: RazorEngine Performance and Template Caching
path: blog-post
date: 2011-10-26T05:12:00.000Z
description: I’ve been using RazorEngine on a project and have been impressed
  with its simplicity and ease-of-use. However, the performance of the
  application isn’t quite where I need it to be, and I was pretty sure the issue
  was with how I was using RazorEngine.
featuredpost: false
featuredimage: /img/razor.jpeg
tags:
  - asp.net
  - razor
category:
  - Software Development
comments: true
share: true
---
I’ve been using [RazorEngine](http://razorengine.codeplex.com/) on a project and have been impressed with its simplicity and ease-of-use. However, the performance of the application isn’t quite where I need it to be, and I was pretty sure the issue was with how I was using RazorEngine, especially since I could anecdotally see that the processor consumption on the machine running the app was quite high, and looking at the running tasks it was clear that most of that was a result of csc.exe (C# compiler) activity.

A bit of searching found [this discussion thread on codeplex regarding the re-compiling of existing templates](http://razorengine.codeplex.com/discussions/244527). The issue is a known one with version 2.1, which is the current release and what I’m using. However, I talked to Matthew Abbott (aka Antaris) [via his blog where he recently discussed what’s coming in RazorEngine v3](http://www.fidelitydesign.net/?p=473), and that led me to go ahead and pull the latest pre-release [RazorEngine v3 code out of GitHub](https://github.com/Antaris/RazorEngine).

From there it was pretty trivial to get my code working with the new bits. Fortunately I’d created an interface ITemplateParser and implemented a RazorEngineTemplateParser, and this latter class was the only one I needed to change to use the new API. I created a couple of nearly identical unit tests, with the key difference being when they make the call to parse the template. The caching version provides the same name for the template with each call, while the non-caching one provides a new Guid string as the template name, ensuring a cache miss.

I don’t have any fancy graphs to show off, since all I did was run a 2-minute load test of each unit test with 5 users and no think time using Visual Studio 2010’s load test runner. The results were pretty significant, though, and corresponded with the performance I was seeing in my actual application (about 1 request per second on one thread):

## 5 Concurrent Users, Non-Cached

**5 Tests/Second**

## 5 Concurrent Users, Cached

**1600 Tests/Second**