---
templateKey: blog-post
title: Attempt was made to load an assembly from a network location
path: blog-post
date: 2011-01-05T11:23:00.000Z
description: If you see this bug while running an application that is
  referencing some third-party DLLs that you recently downloaded, your first
  thought should be “I need to Unblock the assembly I’m referencing!”
featuredpost: false
featuredimage: /img/computer-311339_1280-760x360.png
tags:
  - .net
  - error
  - troubleshooting
category:
  - Software Development
comments: true
share: true
---
If you see this bug while running an application that is referencing some third-party DLLs that you recently downloaded, your first thought should be “I need to Unblock the assembly I’m referencing!”

> *…an attempt was made to load an assembly from a network location…*

Windows, while trying to be helpful, will block downloaded files, causing .NET to fail when trying to load such DLLs. The best way to fix this problem when you are downloading a package with many assemblies in it (e.g. [NUnit](http://nunit.org/), [NServiceBus](http://nservicebus.com/), etc.) is to Unblock the entire zip file before you unzip it. Otherwise, every file will need to be Unblocked, which is a major inconvenience.

To Unblock either the zip file or any individual files within it, just right-click on the file in Windows Explorer, and click the Unblock button:

![SNAGHTML275c280](<> "SNAGHTML275c280")



Many of these projects actually are nice enough to include these instructions on their download page, but if you aren’t reading everything carefully (you DO read the entire EULA for everything you download, right?), you could easily miss it and then be faced with the wonderful error message described here.