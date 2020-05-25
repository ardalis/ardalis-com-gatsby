---
templateKey: blog-post
title: Visual Studio Silent Crash with Designer
path: blog-post
date: 2009-03-03T10:19:00.000Z
description: If you’re encountered an issue where Visual Studio 2008 SP1 crashes
  silently whenever you try to open a web form or master page (which by default
  will open the design view), there is a hotfix that will likely solve the
  problem.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - VisualStudio
category:
  - Uncategorized
comments: true
share: true
---
If you’re encountered an issue where Visual Studio 2008 SP1 crashes silently whenever you try to open a web form or master page (which by default will open the design view), there is a hotfix that will likely solve the problem. I ran into this recently while working on the [Azure MVC templates](http://blogs.msdn.com/jnak/archive/2008/11/10/asp-net-mvc-on-windows-azure-with-providers.aspx) that [Jim Nakashima](http://blogs.msdn.com/jnak) posted in November. I brought this to his attention (as I’m sure others did as well) and last week [he published the details](http://blogs.msdn.com/jnak/archive/2009/02/26/fix-available-asp-net-mvc-rc-crash-in-a-windows-azure-cloud-service-project.aspx) of a [hotfix](https://connect.microsoft.com/VisualStudio/Downloads/DownloadDetails.aspx?DownloadID=16827&wa=wsignin1.0) that takes care of this (and other) issues. [Eric Hexter](http://www.lostechies.com/blogs/hex/archive/2009/03/02/hot-fix-available-for-visual-studio-2008-sp1-crashing-when-opening-up-aspx-files-views-on-vista-sp1-x64.aspx) and [Jeffrey Palermo](http://jeffreypalermo.com/blog/kb963676-fixes-visual-studio-2008-sp1-crash-on-vista-x64) have also confirmed that this fix has resolved issues they were seeing as well.