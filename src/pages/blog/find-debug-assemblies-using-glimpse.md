---
templateKey: blog-post
title: Find Debug Assemblies using Glimpse
path: blog-post
date: 2014-11-03T15:34:00.000Z
description: "A new feature in Glimpse.AspNet 1.9.2 will display whether each
  assembly in your web site’s bin folder was compiled in Debug or Release mode.
  "
featuredpost: false
featuredimage: /img/glimpse_buildmode-300x96.png
tags:
  - asp.net
  - optimization
  - performance
category:
  - Software Development
comments: true
share: true
---
A new feature in[Glimpse.AspNet](http://www.nuget.org/packages/Glimpse.AspNet/)1.9.2 will display whether each assembly in your web site’s bin folder was compiled in Debug or Release mode. At development time, Debug mode is fine, but you want to avoid shipping Debug assemblies to production since there are performance costs associated with these assemblies. You can[determine for yourself whether a given assembly was compiled in debug mode using this code](http://ardalis.com/determine-whether-an-assembly-was-compiled-in-debug-mode), which also links to the performance issues.

![](/img/glimpse_buildmode-300x96.png)

Under the Environment tab in Glimpse, you can scroll down to view the Application Assemblies section. The new column, Build Mode, shows for each assembly how it was compiled. In your production deployments, you want to make sure (for aforementioned performance reasons) that all of the assemblies are built in Release mode.

Thanks to [Lohith for implementing this](https://github.com/Glimpse/Glimpse/commits/master) based on a conversation we had back in July!

![](/img/glimpse_commits-300x169.png)

One more thing I would probably add (and maybe I’ll create a PR for this) is to modify the style of the Release / Debug labels in the Build Mode column. Maybe make Debug bold and red, for instance, so it’s a bit more visible.

Check it out with your application – you may be surprised to find that you’re deploying Debug assemblies to production. Hope this helps!