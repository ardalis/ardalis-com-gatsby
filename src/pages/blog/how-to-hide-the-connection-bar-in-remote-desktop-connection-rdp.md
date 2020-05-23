---
templateKey: blog-post
title: How to Hide the Connection Bar in Remote Desktop Connection (RDP)
date: 2019-02-03
path: /how-to-hide-the-connection-bar-in-remote-desktop-connection-rdp
featuredpost: false
featuredimage: /img/hide-connection-bar-in-remote-desktop-rdp.png
tags:
  - azure
  - rdp
  - remote desktop
category:
  - Software Development
comments: true
share: true
---

Sometimes, like when you're trying to record a full screen video from a (virtual) machine you've connected to using remote desktop, you'd like to hide the blue connection bar that display at the top of the screen. In my case, I was recording how something installs on a fresh Windows 10 virtual machine that I was connecting to over RDP since it was hosted in Azure. The blue bar at the top of the screen when I was remoted into the box in fullscreen mode was getting in the way of my recording, and of course none of the existing functionality of that bar will let you get rid of it. Pinning and unpinning don't help, and no amount of right-clicking or searching for shortcuts works, either.

The trick is to enable or disable this option before you even connect to the remove machine. You need to edit your remote desktop connection (which if you've saved it is a .rdp file - right click and Edit the file). When you have the connection details open, go to the Display tab and uncheck the box for 'Display the connection bar when I use the full screen':

![Hide connection bar in remote desktop RDP](images/hide-connection-bar-in-remote-desktop-rdp.png)

Hide the Connection Bar in Full Screen in RDP Remote Desktop

Once you've unchecked this item, you'll get the behavior you want. Of course, now it can be tough to get out of the full screen remote desktop session, so you may also want to know that you can use the CTRL-ALT-HOME shortcut to temporarily display the blue connection bar. Alternately, you can use CTRL-ALT-BREAK to jump out of the remote session and back into your host computer.

Hope this helps some of you - I'm sure it will also help future me when I need to know this again next time.
