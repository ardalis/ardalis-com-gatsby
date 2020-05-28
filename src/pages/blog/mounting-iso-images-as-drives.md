---
templateKey: blog-post
title: Mounting ISO Images as Drives
path: blog-post
date: 2004-03-28T20:18:00.000Z
description: I tried using [Isobuster](http://www.smart-projects.net/isobuster)
  to extract the ISO of the VS2005 DVD image that I just downloaded off of MSDN
  but after burning it, I got a “Please insert VS Disk 1” midway through the
  install
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ISO Images
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

I tried using [Isobuster](http://www.smart-projects.net/isobuster) to extract the ISO of the VS2005 DVD image that I just downloaded off of MSDN but after burning it, I got a “Please insert VS Disk 1” midway through the install (I don’t know if that was user error, an Isobuster issue, or a DVD-burning issue — probly user error). So, that DVD is now a coaster. Did a quick search since I knew that it should be possible to mount an ISO as a drive letter directly and came across [this blog entry](http://weblogs.asp.net/pleloup/archive/2004/01/15/58918.aspx), which led me to this unsupported [“Virtual CD-ROM Control Panel for Windows XP”](http://download.microsoft.com/download/7/b/6/7b6abd84-7841-4978-96f5-bd58df02efa2/winxpvirtualcdcontrolpanel_21.exe). A short install and read of the README later, and I was in business. VS2005 is installing as I write this, and so far hasn’t asked me for the install CD (/me crosses fingers).

Anyway, this is a nifty utility even if VS bombs on me again, so I thought I’d blog about it so I can find it later.

<!--EndFragment-->