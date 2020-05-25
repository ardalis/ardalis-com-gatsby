---
templateKey: blog-post
title: "Fix: Cant Change or Remove Visual Studio 2008 from DVD"
path: blog-post
date: 2010-03-08T11:39:00.000Z
description: If you installed Visual Studio 2008 on a 64-bit operating system,
  you may have trouble when you try ad add or remove functionality by inserting
  the disk (or remounting the ISO image). I believe this is because of the path
  used to install the 32-bit Visual Studio program.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
If you installed Visual Studio 2008 on a 64-bit operating system, you may have trouble when you try ad add or remove functionality by inserting the disk (or remounting the ISO image). I believe this is because of the path used to install the 32-bit Visual Studio program. When you run the setup.exe off of the disk, you get this:

![](/img/change-or-remove.png)

Clicking on Change or Remove Visual Studio 2008 brings up this dialog:

![](/img/change-or-remove2.png)

But not long after it appears, it disappears to be replaced with:

![](/img/change-or-remove3.png)

**Microsoft Visual Studio 2008 Setup**

> *A problem has been encountered while loading the setup components. Canceling setup.*

**FIX: Use Add or Remove Programs**

Launch the Add or Remove Programs dialog in Windows, and find **Microsoft Visual Studio Team System 2008 Team Suite – ENU**(or whichever SKU you installed). Click Uninstall/Change. From here you should be able to change your installed components of Visual Studio successfully:

![](/img/change-or-remove4.png)

Thanks to [Brendan](http://brendan.enrick.com/) for the tip!

If you’re still having trouble, or encounter additional problems like “a selected drive is no longer valid. please review your installation path settings” then check out Heath Stewart’s posts:

[Adding features to Visual Studio 2008 may fail to load setup components](http://blogs.msdn.com/heaths/archive/2008/10/06/adding-features-to-visual-studio-2008-may-fail-to-load-setup-components.aspx)

[Do Not Repair VS 2008 SP1 from Installation Media](http://blogs.msdn.com/heaths/archive/2008/08/20/do-not-repair-vs-2008-sp1-from-installation-media.aspx)