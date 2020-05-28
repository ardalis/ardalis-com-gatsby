---
templateKey: blog-post
title: Team System Delete Project
path: blog-post
date: 2006-03-10T12:59:23.277Z
description: If you need to delete a Team System Project you need to do it
  through a command line utility that is installed with Team Explorer. In my
  case, I created a test project but wanted to also test project deletion.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - VS.NET
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

If you need to delete a Team System Project you need to do it through a command line utility that is installed with Team Explorer. In my case, I created a test project but wanted to also test project deletion. There is no way to delete a project from Team System except through the command line tool, TFSDeleteProject.exe. This utility is in the c:program filesMicrosoft Visual Studio 8Common7IDE folder by default. To delete a project, use the following syntax:

**TFSDeleteProject /server:ServerName ProjectName**

Optionally, you can use /force to force the removal even if some pieces are locked, but this is not recommended except as a last resort since any locked components would likely be left behind and unremovable.

In my case, running this command resulted in the following output:

**Are you sure (y/n)?\
Deleting from Build… Done\
Deleting from Work Item Tracking… Done\
Deleting from Version Control… Done\
Deleting Report Server files… Done\
Deleting SharePoint site… Done\
Deleting Team Foundation Core… Done**

<!--EndFragment-->