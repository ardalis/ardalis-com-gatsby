---
templateKey: blog-post
title: JungleDisk as Service on Windows Server 2003
path: blog-post
date: 2008-07-15T08:47:00.000Z
description: I'm a big fan of JungleDisk, a $20 utility that makes using
  Amazon's S3 storage solution easy and backups cheap. I'm also a big fan of Red
  Gate's tools, and in particular SQL Backup, which makes backing up SQL Server
  databases much easier and compresses them down to almost nothing.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - JungleDisk
category:
  - Uncategorized
comments: true
share: true
---
I'm a big fan of [JungleDisk](http://jungledisk.com/), a $20 utility that makes using [Amazon's S3 storage solution](http://www.amazon.com/S3-AWS-home-page-Money/b?ie=UTF8&node=16427261) easy and backups cheap. I'm also a big fan of [Red Gate's tools, and in particular SQL Backup, which makes backing up SQL Server databases much easier and compresses them down to almost nothing](http://www.red-gate.com/products/SQL_Backup/index.htm). I've been manually backing up my one server that isn't hosted with [ORCS Web](http://orcsweb.com/)(who take care of such things for me quite well for the servers there) for way too long. And it has only been backed up to a separate drive in the same box, so there wasn't any offsite backup happening. Circumstances finally conspired to drive me to prioritize getting off-site backups set up.

![Mangiamo](/img/mangiamo_3.png)You see, not long ago (end of May) the [building next door to my office burned down](http://www.recordpub.com/news/article/3975011) (it was a [nice restaurant – the web site survived](http://www.mangiamotwinlakes.com/)), and we were lucky that our leased office space didn't burn down with it. Had that happened, it is likely that my SQL files that were **so religiously backed up to the other hard drive in the same box** would not have fared any better than the system drive, and would in fact have been toast. I've always been aware of the possibility of natural disaster affecting my data, but mainly in the abstract “hurricanes and earthquakes don't happen in Ohio” sense. The fire next door made this seem quite a bit more real (enough that a mere 6 weeks later I'm doing something about it!).

Which brings me back to JungleDisk. JungleDisk provides a simple and easy interface into Amazon S3, which in turn provides very very very affordable storage and bandwidth. To use JungleDisk for your personal machine, just download it, go through the very straightforward wizard, and it will map a network drive on your machine when you're logged in. Drag files there, and they go “into the cloud”. Configure backups with a wide variety of options, and they do the same. For a little bit extra, JungleDisk Plus is an add-on service that optimizes your file transfers so when large files change only the changed chunks get pushed up to S3, not the whole file. I signed up for it today since I want to start backing up some PST files while they're in use (be sure to run JD as administrator to do so) but I don't know how well it works yet to report on that.

This all works fabulous – as long as you're logged in. However, on Windows Server platforms (and in my case, Windows Server 2003), as soon as you log out, JungleDisk is no more. It doesn't run as a service by default. For all of its many options, that is not one of them. However, with a bit of searching I was able to trace the steps required to make JungleDisk run as a service on Windows Server 2003. Before I share those steps, let me share my sources:

[Forum Thread – Start jungledisk as windows service?](http://forum.jungledisk.com/viewtopic.php?t=264)(key takeaway: use ***instsrv*** and ***srvany***)

[Another Thread](http://forum.jungledisk.com/viewtopic.php?t=4340&highlight=)

[Running FolderShare as a Service](http://mswhs.com/2008/05/27/synchronize-files-on-a-remote-network-with-whs)(same steps required for JungleDisk as for FolderShare!)

[Windows Server 2003 Resource Kit Tools](http://www.microsoft.com/downloads/details.aspx?FamilyID=9D467A69-57FF-4AE7-96EE-B18C4790CFFD&displaylang=en)(which contains instsrv and srvany)

## Run JungleDisk as a Service

Thanks to [Philip Churchill](http://mswhs.com/2008/05/27/synchronize-files-on-a-remote-network-with-whs) for the steps. Here's a screenshot:

![Configure JungleDisk as Service](/img/jungledisk-1.png)

1. Get a copy of instsrv.exe and srvany.exe from the[Windows Server 2003 Resource Kit Tools](http://www.microsoft.com/downloads/details.aspx?FamilyID=9D467A69-57FF-4AE7-96EE-B18C4790CFFD&displaylang=en).
2. Copy both files to your c:program filesJungleDisk folder.
3. Run “c:program filesjunglediskinstsrv.exe” JungleDisk “c:program filesjungledisksrvany.exe”
4. Run reg ADD HKLMSYSTEMCurrentControlSetServicesJungleDiskParameters /v Application /d “c:program filesjunglediskjunglediskmonitor.exe”
5. execute c:reg ADD HKLMSYSTEMCurrentControlSetServicesFolderShareParameters /v AppDirectory /d “c:documents and settings{USERNAME}application datajungledisk”**change {USERNAME} to your username!**

Once this is done, you can run:

## net start JungleDisk

and it should fire up. You should also be able to configure it from the Services dialog, where you'll want to set it to run as the correct user rather than local system.

![Services list](/img/jungledisk-2.png)

Finally, to confirm that the service is working, simply set up a backup and watch task monitor to see what kind of CPU and bandwidth your server start using at that time. In my case, JungleDisk tends to use 0% of the cpu unless it's doing a backup, and then it might use 1%, but the outbound bandwidth graph is quite telling (at night when nobody else is using the box – this is not a public-facing web server).

Lastly, don't forget to remove Jungle Disk Monitor from your account's StartUp Folder (under Start-Programs-StartUp). If you try to run the EXE locally while the service is running, you may see this (at least, that's what I see):

![Jungle Disk is already running, dummy!](/img/jungledisk-3.png)
