---
templateKey: blog-post
title: HttpModule Breaks Sub-Applications Problem Solved
path: blog-post
date: 2006-08-21T03:02:01.977Z
description: Recently I’ve been working on a number of HttpModule-based plug-in
  tools for ASP.NET applications, such as the [ASPAlliance CacheManager].
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Recently I’ve been working on a number of HttpModule-based plug-in tools for ASP.NET applications, such as the [ASPAlliance CacheManager](http://aspalliance.com/cachemanager). The idea being that these kinds of tools can provide added functionality to existing applications without the need for the application to be changed, recompiled, or migrated to some new architecture (as is required with heavier application frameworks like DNN, CS, etc.). However, one issue with this approach is that, once the HttpModule reference is added to the root application’s web.config file, any subfolder that has been set up as an application will fail if the HttpModule is not added to the GAC, or to every sub-application’s bin folder in addition to the root folder’s /bin.

Last week, I posted to the ASPInsiders to see if anybody knew of a fix for this, and Scott Forsyth let me know about this gem:

>
>
> There’s a good solution for this in ASP.NET v2.0 now. At least if you don’t need the assembly in the vdir. The <location> tag has a new property called inheritInChildApplications. All you need to do is wrap your modules and assemblies in that location tag and it won’t inherit in the vdirs.
>
> i.e.
>
> <location inheritInChildApplications=”false”>\
> <system.web>\
> <httpModules>\
> ….\
> </httpModules>\
> </system.web>\
> </location>

I haven’t had a chance to test this out yet (and there may be a typo or two in it since it’s not tested code), but it sounds like it will do the trick for me. Hopefully this will correct the problem, and once I verify it I will add it to the instructions for CacheManager and my other plug-in project that’s nearly ready, ASPAlliance SimpleCMS, which adds CMS capabilities to any existing ASP.NET application.

<!--EndFragment-->