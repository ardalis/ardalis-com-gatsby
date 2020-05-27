---
templateKey: blog-post
title: Outlook Data File PST Not Closed Properly
path: blog-post
date: 2007-05-14T14:16:51.966Z
description: A common problem with Outlook is the infamous data file issue that
  pops up when you launch Outlook and says it must check the data file for
  constency because it was not shut down properly.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Outlook
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

A common problem with Outlook is the infamous data file issue that pops up when you launch Outlook and says it must check the data file for constency because it was not shut down properly. In Outlook 2003 this is annoying because Outlook is unusable until the check completes, which can take a long time for large PST files. In Outlook 2007 this is a minor issue because the task occurs in the background and simply has a system tray bubble announcing its status. However, in both cases, the process of checking the file consistency is an annoying one that slows down one’s system and so if it can be avoided, it should be.

If you simply go into Task Manager and kill Outlook.exe, or if you just push the power button on your PC to turn it off, or if (I know, this never happens) windows just flat out crashes on you, then of course it makes sense for Outlook to tell you that it didn’t shut down properly. That’s acceptable, to me, that it should detect this improper shutdown and take the necessary steps to deal with it the next time I launch it.

But what if you’re a **Good Windows User(TM)**, and you always close all of your applications The Right Way, and then shut down your PC using the Start – Shutdown method? You wouldn’t think you would see these problems, but many people (even me, sometimes) do. Here’s a little secret: **The way to shut down Outlook properly when you’re shutting down Windows is not to shut it down at all.**

**That’s Right. Don’t shut down Outlook when you’re getting ready to shut down your machine.**

Why? Because when you shut down Outlook, the window goes away, but the process continues running for some time doing file system work on your PST files. That’s why you’ll see OUTLOOK.EXE sitting there in the Task Manager for some time after closing the window. However, when you tell Windows to Shut Down, it tell each OPEN WINDOW to shut itself down, and waits for all OPEN WINDOWS to close before it starts killing off processes. So, if Outlook is an open window, Windows will wait for it to close itself properly before shutting down. But if you the user have already killed the Outlook window, and all that remains is the OUTLOOK.EXE process, then if windows closes all of the other open windows (if any) before OUTLOOK.EXE is done doing its file stuff, windows will kill the OUTLOOK.EXE process (along with every other running process) as it shuts down.

Thus, windows itself will stop Outlook from properly shutting down if Outlook does not have an open window (i.e. visible UI on the screen) when you shut down your operating system. The “fix” for this behavior is to either:

1) Close Outlook a long time before you shut down your PC (or open task manager and make sure OUTLOOK.EXE is not there before shutting down).

or

2) Leave Outlook open when you perform your Start – Shutdown procedure, and let Windows worry about closing it.

If you follow either of these steps, you should not see the Outlook was not shut down properly message and you should avoid the data file / PST consistency check.

\[categories: Outlook]

<!--EndFragment-->