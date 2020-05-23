---
templateKey: blog-post
title: Run MSTest Without Breaking on Exceptions in VS2010
path: blog-post
date: 2010-04-19T08:48:00.000Z
description: Quick tip I just figured out (no R# installed yet) when using
  VS2010’s test runner. If you want to just use the keyboard, then you can use
  ctrl-R T to Run Tests in Current Context.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - MS test
category:
  - Uncategorized
comments: true
share: true
---
Quick tip I just figured out (no R# installed yet) when using VS2010’s test runner. If you want to just use the keyboard, then you can use ctrl-R T to Run Tests in Current Context. But if like me you tend to just leave ctrl held down when you hit the T, your test run will stop at any/every exception. Why? Because

**ctrl-R T**

is not the same as

**ctrl-R ctrl-T**

which is the shortcut for Debug Tests in Current Context.

Note to self, don’t be lazy and pick up your finger from the ctrl key when running tests…