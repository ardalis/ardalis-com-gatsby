---
templateKey: blog-post
title: Clone a VirtualBox Machine
path: blog-post
date: 2010-04-23T07:18:00.000Z
description: I just installed which I want to try out based on recommendations
  from peers for running a server from within my Windows 7 x64 OS. I’ve never
  used VirtualBox, so I’m certainly no expert at it, but I did want to share my
  experience with it thus far. Specifically, my intention is to create a couple
  of virtual machines.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - clone
category:
  - Uncategorized
comments: true
share: true
---
I just installed [VirtualBox](http://www.virtualbox.org/), which I want to try out based on recommendations from peers for running a server from within my Windows 7 x64 OS. I’ve never used VirtualBox, so I’m certainly no expert at it, but I did want to share my experience with it thus far. Specifically, my intention is to create a couple of virtual machines. One I intend to use as a build server, for which a virtual machine makes sense because I can easily move it around as needed if there are hardware issues (it’s worth noting my need for setting up a build server at the moment is a result of a disk failure on the old build server). The other VM I want to set up will act as a proxy server for the issue tracking system we’re using at Code Project, Axosoft OnTime. They have a Remote Server application for this purpose, and since the OnTime install is 300 miles away from my location, the Remote Server should speed up my use of the OnTime client by limiting the chattiness with the database (at least, that’s the hope).

So, I need two VMs, and I’m lazy. I don’t want to have to install the OS and such twice. No problem, it should be simple to clone a virtualbox machine, or clone a virtualbox hard drive, right? Well unfortunately, if you look at the UI for VirtualBox, there’s no such command. You’re left wondering “How do I clone a VirtualBox machine?” or the slightly related “How do I clone a VirtualBox hard drive?”

If you’ve used VirtualPC, then you know that it’s actually pretty easy to copy and move around those VMs. Not quite so easy with VirtualBox. Finding the files is easy, they’re located in your user folder within the .VirtualBox folder (possibly within a HardDisks folder). The disks have a .vdi extension and will be pretty large if you’ve installed anything. The one shown here has just Windows Server 2008 R2 installed on it – nothing else.

![](/img/clone-a-virtualbox.png)

If you copy the .vdi file and rename it, you can use the Virtual Media Manager to view it and you can create a new machine and choose the new drive to attach to. Unfortunately, if you simply make a copy of the drive, this won’t work and you’ll get an error that says something to the effect of:

***Cannot register the hard disk ‘PATH’ with UUID {id goes here} because a hard disk ‘PATH2’ with UUID {same id goes here} already exists in the media registry (‘PATH to XML file’).***

There are command line tools you can use to do this in a way that avoids this error. Specifically, the c:Program FileSunVirtualBoxVBoxManage.exe program is used for all command line access to VirtualBox, and to copy a virtual disk (.vdi file) you would call something like this:

**VBoxManage clonehd “Disk1.vdi” “Disk1_Copy.vdi”**

However, in my case this didn’t work. I got basically the same error I showed above, along with some debug information for line 628 of VBoxManageDisk.cpp. As my main task was not to debug the C++ code used to write VirtualBox, I continued looking for a simple way to clone a virtual drive. I found it in[this blog post](http://www.modhul.com/2009/06/17/how-to-clone-or-copy-a-virtualbox-virtual-disk).

**The Secret setvdiuuid Command**

VBoxManage has a whole bunch of commands you can use with it – just pass it /? to see the list. However, it also has a special command called*internalcommands*that opens up access to**even more commands**. The one that’s interesting for us here is the**setvdiuuid**command. By calling this command and passing in the file path to your vdi file, it will reset the UUID to a new (random, apparently) UUID. This then allows the virtual media manager to cope with the file, and lets you set up new machines that reference the newly UUID’d virtual drive. The full command line would be:

**VBoxManage internalcommands setvdiuuid “MyCopy.vdi”**

The following screenshot shows the error when trying clonehd as well as the successful use of setvdiuuid.

![](/img/clone-a-virtualbox1-.png)

**Summary**

Now that I can clone machines easily, it’s a simple matter to set up base builds of any OS I might need, and then fork from there as needed. Hopefully the GUI for VirtualBox will be improved to include better support for copying machines/disks, as this is I’m sure a very common scenario.