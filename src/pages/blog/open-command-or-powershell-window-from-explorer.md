---
templateKey: blog-post
title: Open Command or Powershell Window From Explorer
date: 2016-12-07
path: /open-command-or-powershell-window-from-explorer
featuredpost: false
featuredimage: 
tags:
  - cmd
  - explorer
  - powershell
  - tip
category:
  - Productivity
  - Software Development
comments: true
share: true
---

Command line tools are becoming increasingly popular, so this tip may save you some time. On Windows, there are several ways to open up a command window. My typical method is to just hit the Start key and type 'cmd' and then enter. This will open a window in my user folder, which is exactly where I want to be precisely 0% of the time. From there, it's usually just a few dozen command to change folders and drives to get to where I actually need to be.

Fortunately, there's a (much) easier way. Most of the time, I either already have a Windows Explorer/File Explorer window open for the folder I'm working with, or I can quickly get one (my go-to tools Visual Studio and SourceTree both have quick menu options to open folder in explorer). From there, it's simple to get either a command window or a powershell window (and probably bash, but I haven't gone there, yet). Just click **in the whitespace** of the path as shown below, and type 'cmd' (or 'powershell'). You'll see a new instance of the appropriate window created, and **lo and behold**, it launches in the path from which you launched it!

[![explorer-shortcut](/img/explorer-shortcut.gif)](/img/explorer-shortcut.gif)

You can also shift-rightclick in a folder to choose "open command window here" but I find that to be slower and less intuitive than this approach (and it doesn't have a powershell option).

Another handy tip for command/powershell windows is alt-enter to toggle fullscreen. Especially handy for presenting or when you know you're going to be spending some time there.

If you have any related tips, please share them in the comments below.
