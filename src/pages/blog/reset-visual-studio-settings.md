---
templateKey: blog-post
title: Reset Visual Studio Settings
path: blog-post
date: 2007-08-21T11:56:28.382Z
description: "If you're working with Visual Studio 2008 (Orcas) Beta builds, of
  which there are now two, you may have run into problems if you tried to
  install Beta 2 on the same machine on which you had installed Beta 1. While
  this is generally not advisable with any beta, I'm told it's working for a
  great many people. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Visual Studio 2008
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

If you're working with Visual Studio 2008 (Orcas) Beta builds, of which there are now two, you may have run into problems if you tried to install Beta 2 on the same machine on which you had installed Beta 1. While this is generally not advisable with any beta, I'm told it's working for a great many people. Nonetheless, one behavior you may see is that after installing Beta 2 certain portions of Visual Studio continue to reference the Beta 1 settings under Visual Studio Codename Orcas for instance. One thing you can do that will help with this issue is to run the following from the command line:

devenv.exe /resetsettings

This will clear out the Beta 1 settings for things like the toolbox and other areas. Hope this helps.

<!--EndFragment-->