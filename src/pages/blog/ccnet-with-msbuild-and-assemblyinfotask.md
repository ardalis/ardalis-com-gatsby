---
templateKey: blog-post
title: CCNET with MSBuild and AssemblyInfoTask
path: blog-post
date: 2007-01-17T17:45:20.305Z
description: This afternoon I embarked on a quick (hah!) task to fix a problem
  with my CC.NET implementation. I’m using CC.NET running on my Team Foundation
  Server machine.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - CC.NET
  - TFS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

This afternoon I embarked on a quick (hah!) task to fix a problem with my [CC.NET](http://confluence.public.thoughtworks.org/display/CCNET/Welcome+to+CruiseControl.NET)implementation. I’m using CC.NET running on my Team Foundation Server machine. It checks my TFS source control to see when anything in my project has changed, and if it has, it kicks off a build using an MSBuild <exec> task pointing at a solution (.sln) file which it grabs from source control. The problem I’m encountering is that one of the folders in this Workspace is a website. Not a Web Application Project, just a plain old VS2005 website. It has a /bin folder with a bunch of assemblies in it, but as it is not a Web Application Project it has no project file and thus no references stored in said file.

So the root of my problem is that when I do a build, updated versions of my Business and Data assemblies (also projects in the same solution, with project references that are stored in the .sln file) are not getting copied into the /bin folder. I was thinking this \*might\* be because the version numbers were hardcoded to 1.0.0.0, so I took a look at the [AssemblyInfoTask](http://www.gotdotnet.com/codegallery/codegallery.aspx?id=93d23e13-c653-4815-9e79-16107919f93e)MSBuild task and quickly got that working ([note that it has Y2K7 issues](http://blogs.msdn.com/msbuild/archive/2007/01/03/fixing-invalid-version-number-problems-with-the-assemblyinfotask.aspx?CommentPosted=true#commentmessage)). However, I eventually ran into the problem of how to update my AssemblyInfo.cs files on the build machine since these are kept in my source control. Right now, it’s failing because they’re read-only, so it’s unable to open them for writing. There are solutions on the web to modify AssemblyInfoTask and have it twiddle the readonly bit. There are also options to [try and do a checkout/checkin on the files](http://blogs.msdn.com/msbuild/archive/2006/01/05/how-to-use-the-assemblyinfotask-with-source-code-control.aspx), but this can lead to [an infinite loop with the checked-in files triggering a fresh CC.NET build](http://blogs.msdn.com/msbuild/archive/2006/03/28/how-to-remove-the-up-to-date-check-from-the-assemblyinfotask.aspx), which updates the AssemblyInfo.cs files, which triggers a new build…

So, a few hours later, I don’t have a good solution for how to integrate CC.NET and AssemblyInfoTask that I’m happy with. However, I do have a bunch of links that others may find useful, and that I’ll probably want to refer to later.

[MSBuild and CC.NET Configuration Article](http://brennan.offwhite.net/blog/2006/11/29/msbuild-configurations-4of7) – not really related but came up a few times in my search efforts.

[AssemblyInfoTask checking out all projects](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=997185&SiteID=1) – the exclude and cloak stuff might be useful to hide AssemblyInfo.cs files from CC.NET

[Real World CC.NET Article with Great Detail](http://blogs.conchango.com/johnrayner/archive/2006/11/17/WiX_3A00_-Integrating-into-the-continuous-build.aspx) – This is a great post with a ton of good reference material.

At the end of all this, I’m wondering if the original problem with the files not being copied has to do with how they’re set up in source control, so it may be that this was all a dead-end path. However, at some point it would be cool to be able to use AssemblyInfoTask to update my assembly build numbers correctly on the build server.

\[categories: CC.NET, MSBuild, .NET, TFS]

<!--EndFragment-->