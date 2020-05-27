---
templateKey: blog-post
title: VSTS TFS Install Notes
path: blog-post
date: 2006-03-10T13:00:53.792Z
description: As I wrote yesterday, I’ve just gone through my first real install
  of VSTS Team Foundation Server.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - VS.NET
  - VSTS
  - windows
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

As I wrote yesterday, I’ve just gone through my first real install of [VSTS Team Foundation Server](http://ardalis.com/blogs/ssmith/archive/2006/03/09/Installing_TFS_RC.aspx). For the most part it went without a hitch. A big part of that was due to the excellent documentation, which really must be followed step by step. Even trying to do so, I ran into a couple of minor hitches, but I was able to get back on track in each case. Here’s a basic log of what I did.

I’m installing on a Dell Dimension E510 with a P4 630 w/HT 3.0GHz 800FSB processor and 3GB of RAM. This exceeds the required 2.2 GHz P4 w/1GB RAM for a single server configuration. Incidentally, these machines are dirt cheap. The box came with Windows XP Media Center 2005 (and a ton of preinstalled junk) which was sad since my first step was to format the machine and install Windows Server 2003 Standard w/SP1. I’ll detail my steps and the time involved below:

1. Install Windows Server 2003 Standard w/SP1 (from DVD). 1.5 hours, mostly unattended.
2. Install all updates from Microsoft Update. 15 minutes, unattended.
3. Install IIS 6.0 (from Win2k3 DVD). 5 minutes.
4. Install SQL Server 2005 Standard Edition. about 50 minutes, not counting time to get the install files.

   * Had to download this from MSDN which took 2 hours (900mb)
   * For some reason IE on the Win2k3 machine would not let me install the MS File Transfer Manager so I spent 10 minutes fighting with its security settings before I finally found a way to install it from an MSI.
   * Be sure to follow the Team System Single Server Deployment Checklist, and to install the hotfixes required.
   * I accidentally forgot to check the checkbox to install the database the first time (doh!) so I had to go back and redo that, which only took an extra 5 minutes (discovered during the Verify Your SQL Server 2005 installation step).
   * Checked for updates (none) and rebooted for good measure.
5. Install Windows SharePoint Services with SP2. 2 minutes, not counting time to download 40mb file.

   * Note that you need to use the Server Farm option when installing
   * 40mb download took me about 10 minutes.
   * Checked for updates (none) and rebooted for good measure.
6. Actually install Team Foundation Server (RC), about half an hour, due to one error I had to resolve.

   * Install ran for about 12 minutes then bombed with Reports Server not configured. It had specifically said \*not\* to configure this in the steps earlier, so I hadn’t done anything with it.
   * I found the Reports Server Config option under Sql Server 2005, create vdirs and such using the defaults.
   * Resumed TFS install and it worked!
7. Install Team Explorer, 3 minutes.
8. Install Build Server, 4 minutes.

Total time (if my math is right): about 200 minutes = 3 hrs, 10 minutes. Half of that was installing Windows, and most of it was installing Windows plus SQL Server. In real time this took me from just after lunch until just after dinner, intermittently working on other stuff while things downloaded/ran.

Don’t forget you also need to install Team Explorer on your dev machine(s) from the TFS disk. I had thought that Visual Studio Team Suite would come with this automatically, but apparently not. [Rob Caron](http://blogs.msdn.com/robcaron)(Team System guru) noted this last summer during the beta period: [Install Team Explorer for Team Foundation Functionality.](http://blogs.msdn.com/robcaron/archive/2005/06/17/430232.aspx)

Anyway, hopefully this will help some folks who have been unsure about the pain involved with installing TFS. It went quite smoothly, I thought. Much easier than, say, Microsoft CRM 3, which one of my coworkers has been fighting with for the last week.

<!--EndFragment-->