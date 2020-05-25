---
templateKey: blog-post
title: Nuget Package Source Update Important
path: blog-post
date: 2016-09-07T05:21:00.000Z
description: "Today a client reported an issue with their build server, which
  was failing to locate version 4.4 of StructureMap. The build worked fine,
  locally, on more than one machine. "
featuredpost: false
featuredimage: /img/older-code.jpg
tags:
  - nuget
  - structuremap
category:
  - Software Development
comments: true
share: true
---
Today a client reported an issue with their build server, which was failing to locate version 4.4 of StructureMap. The build worked fine, locally, on more than one machine. After some investigation, we discovered that the build server’s Nuget task was configured to use several sources, including an internal feed the client uses, and this one:

**https://www.nuget.org/api/v2/**

This is obviously a slightly *older feed, but it checks out…*

![](/img/older-code.jpg)

In fact, it’s been working without issues forever (and in fact it still works fine for every other project and package this client is using). I’m not sure why it blows up with a “Cannot find package <name>” error for StructureMap 4.4, but updating the feed to the v3 feed fixed the problem on the build server:

**https://api.nuget.org/v3/index.json**

One possible cause is that the solution is also using an older version of StructureMap in another project – no other solution the build server is working with has more than one version of StructureMap in it. In any case, if you see weird “Cannot find package <name>” errors in your nuget restore logs, consider updating your package source to the latest version.