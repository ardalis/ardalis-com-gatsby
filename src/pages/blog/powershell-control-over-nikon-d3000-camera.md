---
templateKey: blog-post
title: PowerShell Control over Nikon D3000 Camera
path: blog-post
date: 2010-04-24T07:12:00.000Z
description: "My wife got me a Nikon D3000 camera for Christmas last year, and
  I'm loving it but still trying to wrap my head around some of its features.
  For instance, when you plug it into a computer via USB, it doesn't show up as
  a drive like most cameras I've used to, but rather it shows up as Computer
  D3000. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Camera
category:
  - Productivity
comments: true
share: true
---
My wife got me a Nikon D3000 camera for Christmas last year, and I'm loving it but still trying to wrap my head around some of its features. For instance, when you plug it into a computer via USB, it doesn't show up as a drive like most cameras I've used to, but rather it shows up as Computer D3000. After a bit of research, I've learned that this is because it implements the MTP/PTP protocol, and thus doesn't actually let Windows mount the camera's storage as a drive letter. [Nikon describes the use of the MTP and PTP protocols in their cameras here](http://support.nikontech.com/app/answers/detail/a_id/4613).

What I'm really trying to do is gain access to the camera's file system via PowerShell. I've been using a very handy [PowerShell script to pull pictures off of my cameras and organize them into folders by date](/copy-pictures-to-folders-by-date-taken-with-powershell). I'd love to be able to do the same thing with my Nikon D3000, but so far I haven't been able to figure out how to get access to the files in PowerShell. If you know, I'd appreciate any links/tips you can provide. All I could find is a shareware product called [PTPdrive](http://www.xentrik.net/software/ptpdrive.html), which I'm not prepared to shell out money for (yet). (and yes you can do much the same thing with Windows 7's Import Pictures and Videos wizard, which is pretty good too)

However, in my searching, I did find some really cool stuff you **can** do with PowerShell and one of these cameras, like actually taking pictures via PowerShell commands. Credit for this goes to [James O'Neill](http://blogs.technet.com/jamesone/archive/2009/09/23/on-scanners-cameras-and-their-usb-modes-and-lifting-the-lid-on-how-they-can-be-scripted.aspx) and [Mark Wilson](http://www.markwilson.co.uk/blog/2009/09/shooting-tethered-on-my-nikon-d700-using-powershell.htm). Here's what I was able to do:

**Taking Pictures via PowerShell with D3000**

First, connect your camera, turn it on, and launch PowerShell. Execute the following commands to see what commands your device supports.

```powershell
$dialog = New-Object -ComObject <span class="str">&quot;WIA.CommonDialog&quot;</span>

$device = $dialog.ShowSelectDevice()

$device.Commands
```

You should see something like this:

![nikon d3000 powershell](/img/nikon-d3000-powershell.png)

Now, to take a picture, simply point your camera at something and then execute this command:

```powershell
$device.ExecuteCommand(<span class="str">&quot;{AF933CAC-ACAD-11D2-A093-00C04F72DC3C}&quot;</span>)
```

![nikon d3000 powershell](/img/nikon-d3000-powershell-2.png)

Imagine my surprise when this actually took a picture (with auto-focus):

![nikon d3000 powershell selfie](/img/nikon-d3000-powershell-3.jpg)

Imagine what you could do with a camera completely under the control of your computer… Time-lapse photography would be pretty simple, for instance, with a very simple loop that takes a picture and then sleeps for a minute (or whatever time period). Hooked up to a laptop for portability (and an A/C power supply), this would be pretty trivial to implement. I may have to give it a shot and report back.
