---
templateKey: blog-post
title: Visual Studio 2005 Web Deployment Projects
path: blog-post
date: 2005-10-05T13:36:41.221Z
description: The ASPInsiders were just introduced to an upcoming and
  as-yet-unannounced addin for Visual Studio 2005 that should ship with or close
  to RTM.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Cool Tools
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

The ASPInsiders were just introduced to an upcoming and as-yet-unannounced addin for Visual Studio 2005 that should ship with or close to RTM. The feature is called Web Deployment Projects, and will extend VS 2005’s capabilities for building and deploying ASP.NET web projects. VS 2005 did away with web project files, and there has been some pushback in the community on this because there are many enterprise scenarios where project files make sense (they were removed because they cause a lot of pain in VS 2002/2003).

The Web Deployment Projects feature works like this. It’s an addin, so it builds on top of VS 2005 but doesn’t touch any of the actual bits there (it’s separate). So, it’s optional if you want to install it, but most enterprise users will likely want to do so. To create one, right click on a website in VS2005 solution explorer and select the new menu item, Add Web Deployment Project. This will add a new project to the solution which will manage the build and deploy options for the website.

The Web Deployment Project is literally just an MSBuild file, with some UI to help set it up. You can always drop down and hand edit the MSBuild file if you need to. The UI covers most of the usual scenarios, though, and supports separate configurations for deployment for each different build config in Visual Studio. Some scenarios it enables out of the box are:

* Precompiling websites
* Merging precompiled outputs into single assembly
* Swapping out config sections per-configuration option
* Swapping out entire config files per configuration option
* Include/Exclude different folders/files per configuration option

At RTM there will be 2 white papers published detailing how this was built and how to use it in a variety of scenarios. This is not RTM so you should expect to see some other blogs talking about it today and in the near future. There were a lot of things that VS2005 couldn’t easily do because of its omission of web project files, so this is a great addition that covers most (all?) of these scenarios.

<!--EndFragment-->