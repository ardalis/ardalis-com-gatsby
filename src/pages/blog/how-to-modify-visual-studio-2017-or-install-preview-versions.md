---
templateKey: blog-post
title: How to Modify Visual Studio 2017 or Install Preview Versions
date: 2018-03-09
path: blog-post
featuredpost: false
featuredimage: /img/vs-notifications.png
tags:
  - visual studio
category:
  - Software Development
comments: true
share: true
---

When Visual Studio has updates available, you'll see a notification flag change color at the top of the screen:

![vs-notifications](/img/vs-notifications.png)

When you run the update, the installer will also show you if there are other versions available, such as previews.

![vs-installer](/img/vs-installer.png)

However, if you close the installer dialog it can be difficult to get back to it short of waiting for another update. The trick to finding it is to use **Tools - Get Tools and Features**.

![Tools - Get Tools and Features](/img/vs-tools-gettoolsandfeatures.png)

This will also let you modify the Workloads you have installed, as shown here:

[![vs-install-workloads](/img/vs-install-workloads-1024x572.png)](/img/vs-install-workloads.png)

Hopefully this will help some of you when you're trying to figure out how to update Visual Studio's version, install a preview, or modify which workloads you have installed. It can be difficult to find if you don't know what you're looking for, especially since most apps would put it under Help - About or as an option as part of Check for updates.
