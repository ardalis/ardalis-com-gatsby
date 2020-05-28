---
templateKey: blog-post
title: How Do I Shutdown Windows 8
date: 2013-06-12
path: /how-do-i-shutdown-windows-8
featuredpost: false
featuredimage: /img/win-8.jpg
tags:
  - tip
  - windows
  - windows 8
category:
  - Productivity
comments: true
share: true
---

With the new Windows 8 operating system, Microsoft has made it harder than ever to figure out how to actually shut down your computer. I think this is due to a major emphasis on the tablet form factor, which one will typically not shut down, or will shut down via a hardware button. In any event, many desktop and laptop users with Windows 8 installed must figure out how to actually shut down the system from time to time. Here are some tips that may help, courtesy of my [Regional Director](http://en.wikipedia.org/wiki/Microsoft_Regional_Director) friends.

## The Windows 8 Way

You can swipe in from the right, choose the settings gear icon, then the power icon, and then click restart (or shutdown). It’s a bit convoluted, but that’s the preferred way in the OS to shut down Windows 8. It’s not quite as quick or keyboard friendly as Windows 7, where you could simply hit the Windows key, then right-arrow, then enter to shut down.

**Windows 7**

[**![Win7](/img/win-7.png "Win7")**](/img/chrome.png)

**Windows 8**

![windows 8 settings](/img/win-8.png "windows 8 settings")

![shutdown windows 8](/img/sleep.png "shutdown windows 8")

The way to do this is rather convoluted, enough so that [several](http://www.pcworld.com/article/2012202/how-to-shut-down-windows-8.html) [articles](http://lifehacker.com/create-the-shutdown-tile-thats-missing-from-windows-8-505599879) have been written on the topic already.

## Start8

One option that will return the beloved Start button to Windows 8 is [Start8 fro StarDock](http://www.stardock.com/products/start8). With Start8 installed, just as you would expect, the Start button is back in Windows 8, complete with easy access to shutdown, restart, etc. options:

![Start8](/img/start8.png "Start8")

## Alt-F4

Keyboard shortcut gurus will appreciate that Alt-F4 has meant “close” in Windows for many years. In Windows 7, from the desktop, alt-F4 will bring up this dialog:

![Shut Down Windows](/img/win-pre.png "Shut Down Windows")

In Windows 8, Alt-F4 continues to work to close applications, but from the Start menu, it won’t bring up the Shut Down Windows dialog. However, in the desktop, it will still work as it did in previous versions of Windows. So, to return quickly to the desktop, use the Win-D keyboard shortcut, followed by alt-F4, and you’ll be greeted with a similar dialog.

\[include win8 screenshot\]

## Script and Tile or Task Bar Shortcut

If you prefer the command line, you can also shut down windows by using the shutdown command in a console window or from the Run… menu:

[![shutdown command](/img/SNAGHTML24c8264_thumb.png "shutdown command")](/img/SNAGHTML24c8264_thumb.png)

To shut down the computer:

shutdown /s

To log off:

shutdown /l

To restart:

shutdown /r

By default, these will use a delay of 30 seconds (you’ll see a dialog like this one):

![Windows will shut down](/img/SNAGHTML24fcdc5_1.png "Windows will shut down")

You can cancel this shutdown by typing:

shutdown /a

Which should yield this notification in the task bar:

![logoff cancelled](/img/SNAGHTML2507e6e_1.png "logoff cancelled")

If you don’t want to have any delay, you can specify the timeout using /t switch. Use this to restart immediately:

shutdown /r /t 00

Once you have the command you want to use, you can map it to a shortcut. Just go to your desktop, the Start menu, or the task bar and choose to create a new Shortcut. Then fill in the command like so:

![create shortcut](/img/SNAGHTML7ee7e3d7_1.png "create shortcut")

You can name the short cut ‘Restart’ for instance and add it to your task bar, like so:

[![image](/img/image_thumb.png "image")](/img/image_thumb.png)

(note, as written, this will not ask “are you sure”

so if you accidentally hit it, it will start the process of restarting windows immediately)

You can of course add this to your Windows 8 start menu as a tile as well. Just create the shortcut on your desktop as above, then choose Pin to Start:

![Pin to Start](/img/pin-start.png "Pin to Start")

With that, you’ll find a new tile with the command, which you can move wherever is convenient for you.

![windows 8 shutdown tile](/img/shutdown.png "windows 8 shutdown tile")

## Summary

Windows 8 introduced a number of new UI features that many users are still trying to get used to (and some of which are likely to change with the upcoming update to Windows 8). One of the more confusing changes the new OS introduced was the reorganization of many options that previously were tied to the start button/menu in the bottom left of the screen. In some cases, like shutting down, the new approach may be difficult to discover or may simply require more effort to perform than the user would like. In this article, I’ve outlined several options for improving this situation – please comment with any that you’ve found that I missed.
