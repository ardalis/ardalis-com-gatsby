---
templateKey: blog-post
title: Avoid Regions for Interfaces in Visual Studio
path: blog-post
date: 2010-02-22T12:31:00.000Z
description: Another quick tip related to the use of regions in your C# code –
  you can turn off the default behavior of wrapping interfaced implementations
  in regions via the options dialog.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
Another quick tip related to [the use of regions](https://ardalis.com/prevent-resharper-from-adding-regions) in your C# code – you can turn off the default behavior of wrapping interfaced implementations in regions via the options dialog. Simply go to Tools –> Options –> Text Editor –> C# –> Advanced as shown in the screenshot below, and uncheck the “Surround generated code with #region” checkbox.

![](/img/interfraces-in-vs.png)