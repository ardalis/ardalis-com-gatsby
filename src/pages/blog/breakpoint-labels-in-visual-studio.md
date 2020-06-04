---
templateKey: blog-post
title: Breakpoint Labels in Visual Studio
path: blog-post
date: 2017-08-29T21:31:00.000Z
description: >
  Breakpoints offer a great way to debug our software, letting us literally stop
  time during code execution and inspect what's going on at that moment.
featuredpost: false
featuredimage: /img/breakpoint-labels-in-visual-studio.png
tags:
  - tip
  - visual studio
category:
  - Software Development
comments: true
share: true
---
Breakpoints offer a great way to debug our software, letting us literally stop time during code execution and inspect what's going on at that moment. It's a bit like being a speedster like Quicksilver, who can almost stop time and manipulate the environment between moments in time:

<iframe width="560" height="315" src="https://www.youtube.com/embed/4LIcOFvWqjk" frameborder="0" allowfullscreen="allowfullscreen"></iframe>

Unfortunately, in larger applications, we may find that we have quite a few places where we might want to stop and inspect the code. We may have a dozen or more breakpoints, and some of them may be hit multiple times within a given user interaction with the application. There are a number of features that can help with this, but today the one I want to discuss is breakpoint labels.

Within Visual Studio, once you've created a breakpoint, you can add one or more labels to it by simply right-clicking and choosing Edit Labels:

![edit label](/img/edit-breakpoint-label.png)

The Breakpoints window is useful for quickly navigating to certain breakpoints, as well as quickly enabling or disabling breakpoints (or setting conditions – more on that in another post).

<img src="/img/breakpoints.gif" alt="animated breakpoint image" />

Visual Studio will persist your breakpoints, so when you close and reopen your solution, your breakpoints (and their labels and whether or not they are enabled) will remain. In some cases it may make sense for you to keep some breakpoints around as just a part of your codebase and how you navigate around in it. Of course, since they're stored in .suo files that typically aren't checked into source control, you probably won't be sharing your breakpoints with other members of your team. But that doesn't mean they're not useful for you.

If you present code at conferences, user groups, etc., you may find labeled breakpoints useful during demos. You can add a label like "Demo1" to some breakpoints, and "Demo2" to others. Toggle which breakpoints are enabled when you run your application in order to demonstrate different topics.

This feature has been around for quite a while, though I believe in the earliest versions it was limited to certain versions of Visual Studio. I think today in Visual Studio 2017 you can access this feature from all versions (please leave a comment if this isn't the case and let me know).
