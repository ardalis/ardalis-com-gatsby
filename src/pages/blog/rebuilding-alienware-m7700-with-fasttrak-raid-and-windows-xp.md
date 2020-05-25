---
templateKey: blog-post
title: Rebuilding Alienware M7700 with FastTrak RAID and Windows XP
path: blog-post
date: 2005-05-17T04:40:26.261Z
description: This is a note for myself and anybody else who finds themselves
  frustrated when it comes time to reinstall Windows XP on their Alienware
  laptop with RAID (this advice applies to more than just the M7700).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - win xp
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

This is a note for myself and anybody else who finds themselves frustrated when it comes time to reinstall Windows XP on their Alienware laptop with RAID (this advice applies to more than just the M7700). Basically, the behavior I ran into was that I would boot to the Windows XP CD and it would ask me if I had any drivers, press F6. I did so and installed the FastTrak drivers using a USB Floppy drive I had to purchase six months ago the last time I had to rebuild the system (apparently the only way to specify these drivers is with a floppy). Anyway, it founds the drivers fine, found the hard drive, asked me to format, etc. I said yes, NTFS, go for it and it did its thing, copying a bunch of windows files to the disk before finally saying it was time to reboot (with a countdown and automatic reboot).

When it rebooted, however, it would then come back up and say Windows could not read something on the hard drive. I repeated this process about 4 times, ensuring that I specified the drivers correctly, it could see the partitions, etc but whenever it rebooted it would fail to find it. So I went to Google on another machine and found this:

>
>
> *I had exactly the same problem. The PC would not recognise the hard drive when it restarts. I eventually discovered that the bios recognised the hard drive if the PC was completely powered down rather the just restarted.**\
> During windows XP installation the installer does a software restart resulting in the bios not recognising the hard drive. When the PC needs to restart try pressing the power off button, then pressing it again to restart once the system is completely shut down.*



On [Tech-Recipes Forums](http://www.techspot.com/vb/topic46839.html).

Turns out, that works. Instead of letting it reboot, I simply powered the laptop down completely. Then when I powered it back up, it went into Windows XP and continued installing just fine. Having blogged it, hopefully I’ll remember this in six months when it’s time to change my OS again (kind of like regular maintenance on car).

<!--EndFragment-->