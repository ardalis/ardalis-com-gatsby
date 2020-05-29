---
templateKey: blog-post
title: How to Install Windows 7 from USB Drive
path: blog-post
date: 2009-10-13T20:32:00.000Z
description: I decided to reinstall Win7 on one of my laptops because it was
  acting up – turns out that’s not helping and I think at this point it’s a
  hardware problem (either memory or hard drive – I’m going to try memory next).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Windows7
category:
  - Uncategorized
comments: true
share: true
---
I decided to reinstall Win7 on one of my laptops because it was acting up – turns out that’s not helping and I think at this point it’s a hardware problem (either memory or hard drive – I’m going to try memory next). In the course of troubleshooting the problem, I decided to rule out a bad installer DVD for Windows 7 (the installer was failing, saying it couldn’t access certain required files). So I created a USB installer for Windows 7 x64. And since I’ve been meaning to install Win7 on my Dell mini10 for a while (which has no CD/DVD reader), I also created a separate USB installer for it for Win7 32-bit x86.

I found [this post to be helpful, but it has some problems in the original post that are corrected in the comments](http://www.blogsdna.com/2016/how-to-install-windows-7-from-usb-drive-without-windows-7-iso-dvd.htm). However, there are about a million comments so to save you the trouble of reading them all and trying to figure out which are correct, let me just post what worked for me here. I’m sure this is not the only way to create a USB thumb / flash drive installer for Windows 7, but it is one that I can confirm works.

**Requirements**

You need a 4GB or larger USB drive.

You also need the 32-bit ISO for Windows 7 no matter what, and you need the 64-bit ISO if you’re planning on making a 64-bit installer. (I’m assuming you need the 32-bit ISO in order to run the bootsect command correctly from a 32-bit machine based on a comment I read. I haven’t tried creating an installer from a 64-bit machine nor have I tried running the 64-bit ISO’s bootsect command, so I can’t say how or if those methods work).

I performed all of these steps on a 32-bit Windows Vista installation.



**Creating a Windows 7 USB Drive Installer**

1. Download [MBRWiz](http://mbrwizard.com/download.shtml) and unzip it to some folder.

2. Insert your USB drive, make sure there’s nothing on it you need (it’s about to all be destroyed), and Format it. If you’re in Vista you simply right-click on it and select Format, choosing NTFS as the file system.

3. Mount your Windows 7 32-bit ISO as a drive (using [MagicDisc](http://www.magiciso.com/tutorials/miso-magicdisc-overview.htm) or something similar).

4. Open up a cmd windows with administrator privileges. The easiest way to do this is to go to Start > Run and type ‘cmd’ and then press ctrl-shift-enter (instead of just enter).

5. Change to the folder where you unzipped MBRWiz and run the following commands:

> mbrwiz /list (note the disk number of your USB drive)
>
> mbrwiz /disk=X /active=1 (replace X with the number of your USB drive)

In my screenshot below you can see that my disk number for my USB drive is 1, so I used /disk=1 /active=1 for my command.

6. Now in the same cmd window, change to your ISO mounted drive (in my case the F drive). Type the following commands, replacing e: with the actual drive letter of your USB drive:

> cd boot
>
> bootsect /nt60 e:

Your command window should read more-or-less like the following screenshot (click for full size):

![image](/img/MBRWiz_exe.png)

7. Last, copy all of the files from your ISO mounted drive to your USB drive. **If you are creating a 64-bit installer, unmount the 32-bit ISO first, then mount the 64-bit ISO and copy the files from there.**

## Summary

I just followed these steps, twice, to create one 32-bit and one 64-bit Windows 7 USB thumb drive installers. I can confirm that these steps work for me doing all of the creation work from a 32-bit Vista machine. I can’t attest to any other configuration or process’s likelihood to work or not, but feel free to comment if you have suggestions, improvements, or success stories to share.