---
templateKey: blog-post
title: Cruise Control Bug Fix
path: blog-post
date: 2005-12-30T13:47:55.036Z
description: "I’ve been using Cruise Control for a few weeks now and noticed a
  recurring problem where it would just error out and not recover periodically.
  "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - Cool Tools
  - Test Driven Development
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve been using [Cruise Control](http://confluence.public.thoughtworks.org/display/CCNET/Welcome+to+CruiseControl.NET) for a few weeks now and noticed a recurring problem where it would just error out and not recover periodically. The issue was a timeout checking my source control server, which is running[Vault](http://sourcegear.com/vault/index.html)and hosted remotely. Anyway, [Jonathan Cogley](http://weblogs.asp.net/JCogley) at [Thycotic](http://thycotic.com/) pointed me to a fix they’d come up with when they encountered the same problem. Specifically, [John Morales](http://cs.thycotic.net/blogs/john_morales) created a simple workaround patch that retries N times if the first attempt fails, and posted the [Cruise Control Bug Fix on his blog.](http://cs.thycotic.net/blogs/john_morales/archive/2005/12/15/48.aspx)

<!--EndFragment-->