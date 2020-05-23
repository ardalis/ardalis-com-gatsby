---
templateKey: blog-post
title: Disable Hibernation on Servers
path: blog-post
date: 2010-06-27T14:28:00.000Z
description: Here’s a quick tip if you should find several GB of your system
  drive taken up with hiberfil.sys on a production server machine (as I recently
  did with a virtual server with a very small C partition)
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Disable Hibernation
category:
  - Uncategorized
comments: true
share: true
---
Here’s a quick tip if you should find several GB of your system drive taken up with hiberfil.sys on a production server machine (as I recently did with a virtual server with a very small C partition) – Disable Hibernation.

**Disable Hibernation**

1. Open a command prompt as administrator

2. Run this command:

powercfg –h off

3. Done!

The hiberfil.sys file should immediately disappear. This also works on desktop computers that never use hibernate, of course. [Thanks to SpearMan](http://forums.techarena.in/tips-tweaks/1103838.htm)for the tip. I’ve only tested this on Windows Server 2008, but I’m pretty sure it will work on most modern versions of Windows (7, Vista, 2008 R2, etc.).