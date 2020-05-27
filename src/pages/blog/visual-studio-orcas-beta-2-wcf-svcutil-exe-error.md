---
templateKey: blog-post
title: Visual Studio Orcas Beta 2 WCF svcutil.exe Error
path: blog-post
date: 2007-07-28T12:01:34.771Z
description: >
  If you run into trouble using svcutil.exe with the Beta 2 release of Visual
  Studio / .NET FX, try this:
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

If you run into trouble using svcutil.exe with the Beta 2 release of Visual Studio / .NET FX, try this:

sn-exe -Vr svcutil.exe

It wasn't signed in this drop (it will surely be at RTM). Alternately I've been told you can copy the svcutil.exe file from the previous beta.

<!--EndFragment-->