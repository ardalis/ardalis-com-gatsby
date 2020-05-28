---
templateKey: blog-post
title: TFS Beta 2 VPCs Expire November First
path: blog-post
date: 2007-10-29T12:21:20.500Z
description: "In case you haven’t seen this news from last Friday, the TFS Beta
  2 Virtual PC images have an operating system timebomb in them that is set to
  expire on 1 November 2007. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - Team System
  - TFS
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

In case you haven’t seen this news from last Friday, the[TFS Beta 2 Virtual PC images have an operating system timebomb in them that is set to expire on 1 November 2007](http://blogs.msdn.com/jeffbe/archive/2007/10/25/vs2008-beta2-vpcs-expiring-prematurely.aspx). This is not, however, the end of the world if you have been using these builds for demo or test purposes, though if you’ve got them in anything close to a production mode you’ll have problems.[Jeff Beehler’s follow-up post describes exactly what will happen when the date is reached/passed, and some workarounds for it](http://blogs.msdn.com/jeffbe/archive/2007/10/27/update-on-expiring-vs2008-beta2-vpcs.aspx). From the sounds of things, you’ll have about two hours per reboot of the machine before it forces a reboot due to the timebomb. That means you should be able to use it for most demo purposes, assuming you start it up at the beginning of your talk (and you’re not talking for more than 2 hours). You can also upgrade to a fully licensed version, which most MSDN customers should be able to do easily. Finally, any time now there should be updated VPC images with VS2008/TFS2008 Beta 2 on them (like, today, I expect) and you can[move your data to this new TFS server](http://msdn2.microsoft.com/en-us/library/ms404879(VS.90).aspx)if you need to do so.

<!--EndFragment-->