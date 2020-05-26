---
templateKey: blog-post
title: Latitude D830 Vista BlueScreen
path: blog-post
date: 2009-01-07T09:46:00.000Z
description: I’m rebuilding one or our laptops and it’s had a few bluescreens
  immediately upon Vista launching for the first time (it had Vista on it before
  I decided to pave it). Going into safe mode, I was able to identify that the
  last thing it tries to do is load crcdisk.sys.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - D830 Vista
category:
  - Uncategorized
comments: true
share: true
---
I’m rebuilding one or our laptops and it’s had a few bluescreens immediately upon Vista launching for the first time (it had Vista on it before I decided to pave it). Going into safe mode, I was able to identify that the last thing it tries to do is load crcdisk.sys. Searching online, I was able to find two possible solutions:

* The laptop has 4GB of RAM (2x2GB). Remove one of the DIMMs and try again. ([source](http://social.technet.microsoft.com/forums/en-US/itprovistasetup/thread/a2ed1ff1-3c60-4cfd-ac4e-72f22b180093/#page:2)) ([source](http://www.tomshardware.com/forum/245556-30-vista-blue-screen-p5n32-geil-4x1gb-6400-black-dragon)) ([MS Update](http://support.microsoft.com/kb/929777))
* The laptop has a bios setting of Onboard Devices -> SATA Operation: AHCI. Switch it to ATA. ([source](http://cc.msnscache.com/cache.aspx?q=latitude+d830+vista+blue+screen+%22crcdisk+sys%22&d=74491797570472&mkt=en-US&setlang=en-US&w=764c4b61,8a67f255))

I tried the first one and this let it reboot the first time, but then it started BSODing again once I started doing Windows Updates. Further searching after this led me to the second option, which did the trick. I haven’t switched it back to AHCI yet to see if it will still run OK now that it’s done installing (recall that it had Vista on it before, with AHCI, so theoretically it can do it).

If you’ve run into this issue, hopefully this will help. And if you’re looking to put more than 4GB of RAM into your D830, I also found [this info](http://forum.notebookreview.com/showthread.php?s=13ad27922175cecfa61bd87b788686f1&t=267038) which looks helpful. Sounds like 6GB is the most anybody has managed, but I’d love to be able to put 8GB into this thing. Can anyone confirm if that works, and if there’s a particular BIOS needed? If you have 8GB working, what RAM are you using? Thanks in advance.