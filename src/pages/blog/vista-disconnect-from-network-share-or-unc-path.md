---
templateKey: blog-post
title: Vista Disconnect From Network Share or UNC Path
path: blog-post
date: 2009-05-27T06:26:00.000Z
description: Occasionally I'll try to connect to a UNC share or network device
  and I'll forget my proper username and password for the device (NAS, router,
  another box, etc.). In the case of one of my NAS drives at home, it will let
  me guess three times what my credentials are
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - network
category:
  - Productivity
comments: true
share: true
---
Occasionally I'll try to connect to a UNC share or network device and I'll forget my proper username and password for the device (NAS, router, another box, etc.). In the case of one of my NAS drives at home, it will let me guess three times what my credentials are, and then it will just connect me as whatever my last guess was, but at that point I'm basically attached as guest. Once that happens, I can see the root of the drive in Windows Explorer, but I can't get to any of the subfolders due to lack of permissions.

![network drive folders](/img/network-drive-folders.png)

If I try to reconnect, it won't let me. If I try to map a new network drive, it tells me I can only have one connection open to this device. If I right-click on the IP/sharename in Windows Explorer, there is no option to disconnect. **Vista fail**.

In order to reconnect (with the correct credentials, once remembered), the only way I've found to disconnect without restarting (or at least logging out and back in) is via the command prompt, with the **net use** command. In this case, if you type net use you might see something like this:

![net use command](/img/net-use-command.png)

As you can see, I'm connected to a share via its IP address. If you have multiple connections open, you should see all of them listed here. To remove a connection, you simply specify its name and the /Delete flag along with the net use command:

```powershell
net use 192.168.0.109IPC$ /Delete
```

Following this with simply:

```powershell
net use
```

Should show that you no longer are connected to the resource, and you can try once more to attach to it (in Windows explorer, or via net use if you like – what I should do is script these so I don't have to remember them…).

![net use delete](/img/net-use-delete.png)
