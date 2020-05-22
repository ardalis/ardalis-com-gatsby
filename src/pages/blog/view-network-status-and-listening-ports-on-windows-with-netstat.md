---
templateKey: blog-post
title: View Network Status and Listening Ports on Windows with Netstat
path: blog-post
date: 2012-06-06T01:59:00.000Z
description: >
  There are plenty of times when you may need to know which applications are
  running on which ports on your machine. Some examples of questions this might
  answer include:
featuredpost: false
featuredimage: /img/network-6.png
tags:
  - netstat
  - networking
  - ports
  - windows
category:
  - Software Development
comments: true
share: true
---
There are plenty of times when you may need to know which applications are running on which ports on your machine. Some examples of questions this might answer include:

* How can I see which port my application is running on, so I can forward or open that port in my firewall?
* How can I see which applications are actively using my network connection?
* How can I see where applications on my machine are connecting to, whether on my network or on the Internet?

If you’re running a Windows system, the netstat command, run from an elevated (Run As Administrator) command prompt can provide a lot of the answers to these kinds of questions. Like most command line utilities, you can get a lot of information about netstat by simply running it with the /? extension, like so:

![](/img/network-1.png)

If you just run it with –a, it will show all active connections and their ports, and their state and destination, but nothing else. You can leave netstat running, and will continue to update with additional information. You break out of its execution with **ctrl-c**. Here’s example output of netstat –a (click to enlarge):

![](/img/network-2.png)

When you add –b to netstat, it will show the process responsible for the port in question. Here you can see Apple, iTunes, DropBox, and Firefox and which ports they’re using:

![](/img/network-3.png)

Of course, you can combine these two to see which processes are simply listening on ports even if they’re not actively using the connection. Running netstat –a –b for me looks like this:

![](/img/network-4.png)

Finally, adding –o can give you the Process ID, which you can use along with Task Manager (or other tools) to find (and kill, if necessary) the process involved in each connection.

![](/img/network-5.png)

In this case, PID 4 says “Can not obtain ownership information”. Looking in Task Manager, I can see that this process is System:

![](/img/network-6.png)

If you don’t see the PID column in Task Manager, you can turn it on under View – Select Columns:

![](/img/network-7.png)

There are a few more features to netstat, but these are the ones I’ve found most useful. Hope this helps, and if you have any particular tricks you’d like to share that relate to these tools or scenarios, please share them or a link to them in the comments.