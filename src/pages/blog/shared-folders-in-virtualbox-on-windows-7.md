---
templateKey: blog-post
title: Shared Folders in VirtualBox on Windows 7
path: blog-post
date: 2010-05-04T05:59:00.000Z
description: In my [adventures with
  VirtualBox](/clone-a-virtualbox-machine), my
  latest victory was in figuring out how to share folders between my host OS
  (Windows 7) and my virtual OS (Windows Server 2008). I'm familiar with
  VirtualPC and other such products
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - windows7
  - virtualbox
category:
  - Productivity
comments: true
share: true
---
In my [adventures with VirtualBox](/clone-a-virtualbox-machine), my latest victory was in figuring out how to share folders between my host OS (Windows 7) and my virtual OS (Windows Server 2008). I'm familiar with VirtualPC and other such products, which allow you to share local folders with the VM. When you do, they just show up in Windows Explorer and all is good. However, after configuring shared folders in VirtualBox like so:

![virtualbox shared folders](/img/virtualbox-shared-folders.png)

I couldn't see them anywhere within the machine.

## Where are Shared Folders in a VirtualBox VM?

Fortunately a bit of searching yielded [this article](http://news.softpedia.com/news/How-to-Fix-Windows-7-Sharing-in-VirtualBox-123021.shtml), which describes the problem nicely. It turns out that there is a magic word you have to know, and that is the share name for the host OS:

**vboxsrv**

Once you know this, mapping shared folders is straightforward. From Windows Explorer, click on the Map network drive option, and then map a drive to `\\vboxsrv\YOURSHAREDFOLDER`

Like so:

![virtualbox map network drive](/img/virtualbox-map-network-drive.png)

With that, it's easy to share folders between the client and host OS using VirtualBox. The reason I didn't simply use a standard network share to my host OS' machine name is that both guest and host are in a VPN, and the VPN is over the Internet and in a different country, so when I went that route my files were (apparently) traveling from host to guest by way of the remote VPN network, rather than locally. Using the Shared Folders feature dramatically sped up my ability to transfer files between Host and Guest machines.

**Update**: Most [Lenovo desktop](http://shop.lenovo.com/us/desktops) computers ship with Windows 7, and of course you can install any other OS you like on them using VirtualBox.
