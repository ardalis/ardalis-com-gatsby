---
templateKey: blog-post
title: Microsoft Version Number Integer Type
path: blog-post
date: 2014-06-11T16:04:00.000Z
description: "Microsoft made some headlines a few years ago when they decided to
  skip Office 13 and jump straight from Office 12 to Office 14. "
featuredpost: false
featuredimage: /img/vslogo-760x360.png
tags:
  - C#
  - microsoft
  - parody
category:
  - Software Development
comments: true
share: true
---
Microsoft made some headlines a few years ago when they decided to [skip Office 13](http://msftkitchen.com/why-did-microsoft-skip-office-13) and jump straight from Office 12 to Office 14. Recently, they’ve announced Visual Studio “14” CTP, which appears to be doing the same thing:

**Current Version (Visual Studio 2013):**

![](/img/vs12021005.png)

**Next Version:**

![](/img/vs14021730.png)

I actually wrote about [Microsoft’s apparent triskaidekaphobia](http://ardalis.com/triskaidecaphobia) back in 2008 with the Office naming, and suggested that they consider updating their software frameworks to follow suit (since if 13 is unlucky, it should be worthwhile to keep it out of our computer programs, right?). They haven’t taken this logical next step yet, so **today I’m announcing an open source project you can use to implement Microsoft versioning numbers in your own systems**.

You can [view and fork MicrosoftVersioning.VersionInt here](https://github.com/ardalis/VersionInt).

Currently, the VersionInt type supports the following features:

* VersionInt types can be used interchangeably with integer types
* Attempting to set a VersionInt to 13 will raise an exception
* Incrementing a VersionInt from 12 will yield 14 as expected

Of course the whole thing is unit tested to ensure the maximum “luckiness.” Enjoy!