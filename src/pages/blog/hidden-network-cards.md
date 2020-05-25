---
templateKey: blog-post
title: Hidden Network Cards
path: blog-post
date: 2005-08-20T14:53:10.174Z
description: I just moved a server and switched it from using a wireless card to
  a 10/100 Ethernet port and I kept getting this kind of message when I set it
  back up with its IP addresses.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - wireless
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I just moved a server and switched it from using a wireless card to a 10/100

Ethernet port and I kept getting this kind of message when I set it back up with

its IP addresses:

The IP address `XXX.XXX.XXX.XXX`

you have entered for this network adapter is already assigned to another adapter

`Name of adapter`. `Name of adapter` is hidden from the

network and Dial-up Connections folder because it is not physically in the

computer or is a legacy adapter that is not working. If the same address is

assigned to both adapters and they become active, only one of them will use this

address. This may result in incorrect system configuration. Do you want to enter

a different IP address for this adapter in the list of IP addresses in the

advanced dialog box?

Unfortunately, I couldn’t figure out a way to remove the IPs

from the wireless card since it was (a) hidden and (b) not around to plug

in. I found this KB article which quickly showed me the light:

# [Error Message When You Try to Set](http://support.microsoft.com/kb/269155)

[an IP Address on a Network Adapter](http://support.microsoft.com/kb/269155)

In case Microsoft decides to break that link (it’s been known to

happen), here’s the resolution:

To resolve this problem, uninstall the ghosted network adapter

from the registry:

| 1.  | Click **Start**, click **Run**, type cmd.exe, and then press ENTER. |
| --- | ------------------------------------------------------------------- |
| 2.  | Type set                                                            |
| 3.  | Type Start DEVMGMT.MSC, and                                         |
| 4.  | Click **View**, and then click **Show Hidden**                      |
| 5.  | Expand the Network Adapters tree.                                   |
| 6.  | Right-click the dimmed network adapter, and then click              |

<!--EndFragment-->