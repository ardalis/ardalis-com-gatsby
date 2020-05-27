---
templateKey: blog-post
title: Updating Hosts In and Out of Office
path: blog-post
date: 2008-11-09T13:19:00.000Z
description: We have a machine in the office that we use for source control, and
  it’s set up in DNS with a fully qualified name that points to the office’s
  external IP address. Of course, if you try and use that fully qualified name
  while you’re in the office, you can’t connect – you have to use the local
  192.168.X.X address to get to it.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - HOSTS
category:
  - Uncategorized
comments: true
share: true
---
We have a machine in the office that we use for source control, and it’s set up in DNS with a fully qualified name that points to the office’s external IP address. Of course, if you try and use that fully qualified name while you’re in the office, you can’t connect – you have to use the local 192.168.X.X address to get to it. Thus, the machine has different addresses depending on whether you’re trying to reach it from within or outside of the office LAN.

Short of requiring everyone VPN into the LAN when outside the office, the simplest solution (not having a domain controller or DNS server inside the LAN) we’ve found thus far is to update the HOSTS file (C:WindowsSystem32DriversEtcHosts) of computers when they are outside of the office. To achieve this, we simply created two hosts files:

> **hosts.office.txt**– includes mapping of foo.bar.com –> 192.168.x.x
>
> **hosts.home.txt**– includes mapping of foo.bar.com –> xxx.xxx.xxx.xxx internet address

“Home” really means “Anywhere but the office” but usually that’s home. It also starts with a different letter (as opposed to “out of office”) which we’ll see matters slightly.

The next step is to create an office.bat and home.bat which each consist of one line and say:

**office.bat:**\
xcopy /Y hosts.office.txt hosts

**home.bat:**xcopy /Y hosts.home.txt hosts

The /Y tells it to overwrite without asking.

Now all that remains is to make it easy to call these two batch files. This is where [Slickrun](http://www.bayden.com/SlickRun) comes in handy. By creating magic words for “office” and “home” that map to these two files, switching from one profile to another is just a matter of typing:

**Win-Q, h o ENTER**(for home)

or

**Win-Q o f ENTER**(for office)



Now, what I’d really like is for Windows to automatically notice when its network status changes (basically, my machine’s IP address, or perhaps the name of the LAN/Wireless network), and determine from that which hosts file to use. If someone has a script that does something like this, let me know. In the meantime, this approach has worked for the last couple of years with minimal friction/annoyance, so I’ll keep using it until something simpler presents itself (or until we move our source control to the cloud/internet).