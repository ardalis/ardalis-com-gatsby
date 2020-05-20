---
templateKey: blog-post
title: Speed Up Visual Studio Build Times
path: blog-post
date: 2016-02-04T13:15:00.000Z
description: "Although compiling is still the #1 programmer excuse for slacking
  off, you still probably don’t want to spend more time on it than you
  absolutely have to."
featuredpost: false
featuredimage: /img/task-manager.png
tags:
  - optimization
  - tip
  - visual studio
category:
  - Software Development
comments: true
share: true
---
[](https://xkcd.com/303/)Although compiling is still the #1 programmer excuse for slacking off, you still probably don’t want to spend more time on it than you absolutely have to.

If your Visual Studio builds take longer than you would like, there are a couple of things you can do. First, if you’re still using a spinning-metal disk drive, upgrade to an SSD. You can get [a 250GB SSD for under $100 these days on Amazon](http://amzn.to/1ULddYj), and this will improve your overall software development productivity more than any other upgrade to your hardware. Seriously, stop reading this now and go get an SSD, then come back and read the rest if that doesn’t make your performance 100% better.

![](/img/compiling.png)

Ok, now that we’re all using an SSD, check and see if your antivirus software is slowing down your builds. If you’re using the default Windows software, you’re going to be looking for Windows Defender. Open up Task Manager and watch it while you go into your Visual Studio solution and choose “Rebuild All”. Do you see something like this?

![](/img/task-manager.png)

Notice that Windows Defender, also known as Antimalware Service Executable, is taking up almost as much CPU time as Visual Studio, and quite a bit more than MSBuild.exe or the VB/C# compiler service (VBCSCompiler.exe). Assuming your build takes more than a second or two, note how long it takes to run under these conditions.

**Exclude Visual Studio from Windows Defender**

As a quick check, run a scan to make sure you don’t have anything currently infecting your system, and then go to Windows Defender -> Settings and disable Real-time protection:

![](/img/real-time-protection.png)

Rebuild your solution in Visual Studio, noting the total time it takes and observing in Task Manager to see if the Antimalware Service Executable appears to be consuming significant processor time. Assuming your build is faster and your CPU less busy, congratulations, you’ve identified one cause of your performance problems. The next step is to responsibly tell Windows Defender to leave Visual Studio alone without turning it off completely.

First, turn Real-time protection back on. Then, scroll down to Exclusions and choose Add an exclusion.

![](/img/add-exclusion.png)

We’re going to exclude the devenv.exe process and your projects folder(s). First, click Exclude a folder and choose the folder(s) where your development projects reside. Next, choose Exclude a .exe process and add devenv.exe. When you’re finished, the Add An Exclusion menu should look something like this:

![](/img/add-exclusion-finished.png)

Close the window and return to Visual Studio. Rebuild your solution and confirm that the build times are similar to when Real-time protection was off, and that you’re no longer seeing the Antimalware Service Executable process consuming processor time during your build.

If you’re using another antivirus tool, it should provide you with similar steps for excluding certain files and programs.

Now share this with your team – they should love you for it.