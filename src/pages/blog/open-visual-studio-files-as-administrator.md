---
templateKey: blog-post
title: Open Visual Studio Files As Administrator
path: blog-post
date: 2010-03-03T11:51:00.000Z
description: "Working with IIS as your web server, or working with Azure
  projects, are two examples of situations in which Visual Studio (2008+) needs
  to be running as Administrator (on Windows Vista or Windows 7). "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - visual studio
category:
  - Software Development
comments: true
share: true
---
Working with IIS as your web server, or working with Azure projects, are two examples of situations in which Visual Studio (2008+) needs to be running as Administrator (on Windows Vista or Windows 7). If you don't run it as such, you may be faced with a dialog like this one (for Azure):

![azure tools for visual studio](/img/azure-tools-visual-studio.png)

Now of course if you have Visual Studio pinned to your taskbar or start menu, you can launch it as admin by right-clicking and [selecting Run As Administrator, as Jeff Blankenburg shows here](http://jeffblankenburg.com/2010/02/19th-of-diduary-did-you-know-that-you.aspx). That's great for one-off things, but in my scenario I really want to be able to double-click on a .sln file and have it open with Visual Studio as an administrator:

![cloud project solution](/img/the-cloud-project.png)

The solution as suggested by <http://twitter.com/JeremySkinner>is to go and update VSLauncher.exe so that it always runs as administrator. You'll find VSLauncher here:

**C:Program Files (x86)Common Filesmicrosoft sharedMSEnv**

Right click on it, select Properties, and then the Compatibility tab. From here you can check the box for **Run this program as an administrator:**

![vslauncher properties](/img/vslauncher-properties.png)

With that done, you can now go right into your project structure in Windows Explorer and open whichever solution or project files you want, and they will open in an Administrator privileged instance of Visual Studio, with the elevated privileges Azure and IIS require.
