---
templateKey: blog-post
title: Perform Rolling Upgrade of Web Farm using Windows Network Load Balancer
path: blog-post
date: 2010-09-07T12:44:00.000Z
description: Once you’ve set up a web farm / cluster using Windows Network Load
  Balancing, one of the benefits you have is the ability to perform a rolling
  upgrade.
featuredpost: false
featuredimage: /img/computer-311339_1280-760x360.png
tags:
  - windows
  - network loader
category:
  - Software Development
comments: true
share: true
---
Once you’ve set up a web farm / cluster using Windows Network Load Balancing, one of the benefits you have is the ability to perform a rolling upgrade. A rolling upgrade is a process by which you perform updates to individual servers within the cluster while they are not actively serving requests. This process is repeated so that eventually all servers have been updated, but users have not experienced any downtime.

Assume for a moment that you already have 3 servers set up identically to serve web requests, and that you have configured them into a cluster using Windows Network Load Balancing. You can open Network Load Balancing Manager from Administrative Tools on one of these servers and you should see something like this (after a moment while it loads the cluster into the menu):

![image](<> "image")

In my scenario there’s a reason why the numbers progress 1,2,4 but for the purpose of this article we’ll talk about nodes 1, 2, and 3 to avoid any confusion. I’m in the process of upgrading an application from .NET 2 to .NET 4. I’d like to be able to do so without any downtime for my users. A rolling upgrade makes sense in this scenario. I’ve already installed .NET 4 on all 3 nodes and I’ve tested a stage application that has been upgraded to .NET 4 on each node as well. All that remains is to perform the actual upgrade, which I’d like to be able to do while knowing users aren’t actively hitting the site, so I’ll pull the node I’m upgrading out of the cluster during the actual upgrade.

**Process**

![image](<> "image")1) Remove one node from the cluster

> a) In NLB Manager, right click on the cluster member and click on Control Host –> Drainstop. This will stop incoming connections and then issue a Stop. It should turn Yellow, then Red/Green and then eventually Red. You may have to hit F5 or right click and select Refresh in order to see its status update.
>
> b) (optional) Remote into that box and confirm its requests drop off to zero since any requests in progress will still complete.



2) Perform the updates on the node that was just removed. Test it from localhost to ensure all is working correctly.



![image](<> "image") 3) Add the node back into the cluster

> a) In NLB Manager, right click on the cluster member and click on Control Host –> Start. It should turn Green.
>
> b) (optional) Remote into that box and confirm its requests resume.

If the Drainstop doesn’t work, you can always do a Suspend/Resume+Start, or a Stop/Start to take the node out of the cluster. In my case, for some reason, Drainstop didn’t work after several minutes, so I simply issued a Stop command and that immediately took the node out of the cluster. You might wonder, too, What’s the difference between Stop and Suspend in Windows Network Load Balancing? The answer can be found [here](http://technet.microsoft.com/en-us/library/cc782460(WS.10).aspx), which reads:

* * *The **suspend** command suspends all cluster operations until the **resume** and **start** commands are issued.\
    The purpose of the **suspend** command is to override any remote control commands that might be issued. All subsequent cluster-control commands except **resume**and **query** are ignored.*
  * *This command can be performed on the whole cluster or remotely to a single host.*
  * *The **stop** command differs from the **suspend** command in that **suspend** stops Network Load Balancing on the host and also suspends all Network Load Balancing cluster-control commands on the host, except for the **resume** and **query** commands. **Stop** only stops Network Load Balancing on the host, but does not affect the other Network Load Balancing cluster-control commands. For more information on the **stop** command, see "Immediately stop handling all Network Load Balancing cluster traffic" in Related Topics.*

If you’re not concerned about other network admins issuing commands to your cluster while you’re doing your work, there’s little difference between **suspend** and **stop**. Note that after a **resume**, you must also issue a **start** command to return a node to the cluster.

**Command Line**

Naturally you can also perform these tasks from the command line. In this case it’s probably easiest to do everything from the machine you’re about to update. You simply issue this command from the current machine to suspend it:

**nlb.exe suspend**

Note that you need to run nlb.exe as an administrator. To resume your local machine, simply issue:

**nlb.exe resume**

There’s a detailed listing of the commands supported by nlb.exe if you type

**nlb.exe /?**

[![Click to View](<> "Click to View")](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/PerformRollingUpgradeofWebFarmusingWindo_AF75/image_11.png)

You can read more about NLB settings and commands from these resources:

* [How to Perform Basic Network Load Balancing Procedures in Windows Server 2003](http://support.microsoft.com/kb/816111)
* [Network Load Balancing – Concepts and Notes](http://support.microsoft.com/kb/556067)

Thanks to Vince for teaching me the basics of using Windows NLB!