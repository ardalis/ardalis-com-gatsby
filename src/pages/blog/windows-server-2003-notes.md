---
templateKey: blog-post
title: Windows Server 2003 Notes
path: blog-post
date: 2003-04-09T00:09:00.000Z
description: I set up Win2K3 Server on a box at home a few days ago and here are
  some of the things I’ve learned. The first thing I’d like to point out is that
  there is a pretty good [Unofficial FAQ] maintained by Windows XP MVP Larry
  Samuels.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - windows
  - windows server
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

I set up Win2K3 Server on a box at home a few days ago and here are some of the things I’ve learned. The first thing I’d like to point out is that there is a pretty good [Unofficial FAQ](http://home.triad.rr.com/faq/WNS2003%20FAQ.htm) maintained by Windows XP MVP Larry Samuels.

The machine I installed on is a Dell Dimension 4100, P3-1GHz with 512MB ram. It has a DVD player that was flaking out under XP Pro for some reason (no sound during movies, otherwise fine). I was at the brink of requesting a new DVD player from Dell, but I managed to get it to work after the Win2k3 install. Here’s what I had to do:

1. Enable graphics acceleration. This is under an Advanced button in the Display properties box. You can get to it either from Control Panel or by right-clicking on the desktop.
2. Enable the Windows Audio service. Gotta have this for sound. This is in the Sounds section of the Control panel.
3. Install a DVD decoder. You can buy one from MS if need be for like $20. For some reason Win2k3 doesn’t come with one despite its huge price tag and WinXP does (and you can get WinXP for like $49). In my case, I was in luck — I installed the Dell Intervideo WinDVD software that came with the machine and it worked fine under Win2k3.
4. **Games:** To get most games to work, follow these same steps, but then enable DirectX, which is disabled by default. Go to a command prompt or the Start-Run prompt and type “dxdiag”. Click OK. Click on the Display tab, then click on the Enable button for DirectDraw and Direct3d.

Once this was done, I was able to watch DVDs using either WinDVD or WMP on the machine, which is good news because my wife wants to be able to use it to entertain [Ilyana](http://ilyanasmith.com/)while she’s working on her computer. I was also able to get Ghost Recon to work as a test to see if the OS would support games. The PC has an old GeForce2 card that seemed to work just fine without any need to download drivers.

The next thing I did was try and install Exchange. The end goal is to be able to share my schedule with my family, something that Outlook Express and Outlook do not support without a Server product (insane overkill for a family’s needs). I got IIS set up and played with ASP.NET 1.1 a bit, and once I’d finally gotten all of its prerequisites installed, I tried to install Exchange 2000 only to learn that it was not supported. So I’m now downloading the Exchange 2003 Beta 2 and I’ll probably install that tomorrow.

<!--EndFragment-->