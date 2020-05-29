---
templateKey: blog-post
title: Cannot Connect to Windows Home Server Solution
path: blog-post
date: 2009-03-28T07:14:00.000Z
description: "I have an HP MediaSmart 470 Home Server (previous post) that I
  like very much for its ease-of-use and simple ability to back up my home
  network’s computers and act as a streaming media server. However, one of my
  computers stopped being able to connect to it. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Windows WHS
category:
  - Uncategorized
comments: true
share: true
---
I have an [HP MediaSmart 470 Home Server](http://www.amazon.com/gp/product/B000UY1WSK?ie=UTF8&tag=aspalliancecom&linkCode=as2&camp=1789&creative=390957&creativeASIN=B000UY1WSK)([previous post](/installing-windows-home-server)) that I like very much for its ease-of-use and simple ability to back up my home network’s computers and act as a streaming media server. However, one of my computers stopped being able to connect to it. Since it was my laptop, and I have another WHS at my office that is also backing up the same machine, I didn’t worry too much about it, but eventually it bothered me enough to investigate and ultimately fix. The primary culprit, it turns out, is [OpenDNS](http://www.opendns.com/).

**OpenDNS**

OpenDNS is a DNS provider that offers some additional services, such as web content filtering and anti-phishing protection. Since our daughter is old enough to be into things like [Webkinz](http://www.webkinz.com/us_en) and other online activities, OpenDNS is a pretty nice way to easily provide “net-nanny” like functionality to the entire household internet, without having to install anything on individual computers. I’ve been using it for probably six months now and overall I’ve been pretty happy with it.

Unfortunately, OpenDNS does some “creative” things in order to achieve its functionality, that don’t apparently follow RFCs for standard Internet protocols like DNS. Thus, problems with Windows Home Server (and other LAN connectivity) can arise. Searching for something like “cannot connect to windows home server” yields quite a few results, and eventually I was able to narrow down some that were helpful. By far the best one for resolving the OpenDNS issue was [here](http://social.microsoft.com/Forums/en-US/whshardware/thread/0b0c89d4-82eb-4733-bf92-e72ec2c4b65b).

With OpenDNS configured in my router’s DNS, if I attempt to ping some non-existent machine on my network, I’ll get back something like this:

> *Pinging foo.MyNetwork \[208.69.36.132] with 32 bytes of data:\
> …*

If I ping my windows home server, I would get the same thing. However, its actual IP address is 192.168.0.100. The problem is that OpenDNS doesn’t simply fail when it doesn’t have an entry for an item (allowing another lookup like NetBIOS to take over at the LAN level), but instead it **always returns an IP address**.

In order to correct this behavior for specific, known machines on your LAN (assuming you don’t want to just abandon OpenDNS), you can follow the instructions in [this KB article](http://www.opendns.com/support/article/164):

> ***Typo Exceptions** provides a simple solution.*
>
> 1. *Create a [free account](https://www.opendns.com/dashboard/create) or sign in to your account.*
> 2. *Add a network, if you haven’t already.*
> 3. *Go to the[ Settings](https://www.opendns.com/dashboard/settings) tab.*
> 4. *Click Advanced Settings.*
> 5. *Click**Manage**under Manage VPN Exceptions in the Domain Typos section.*
> 6. *Add your internal domain(s) to this list.*
> 7. *Wait 3 minutes (worst case) and all should be well.*

Note that if your router has a domain set, then you can’t just add your machine “foo” to this exception list. You must include it as “foo.MyNetwork” for the exception to work.

Another workaround if you can’t change your OpenDNS settings is to [modify your Hosts file, as described here](http://mswhs.freeforums.org/whs-console-cannot-connect-t270.html).

**Other Fixes**

This turned out not to be my only issue with Windows Home Server, but it was the main one. I also had trouble connecting to the WHS using the connector software until I reinstalled it. Assuming you can get to your server via Windows Explorer, you should try reinstalling the software from

SERVERNAMESoftwareHome Server Connector SoftwareWHSConnector.msi

Note that by default your server’s name is probably “Server” – in any event, replace SERVERNAME with the actual name or IP address of your server. Here’s [a forum thread](http://social.microsoft.com/Forums/en-US/whssoftware/thread/2c8a0e0e-5cd3-45b3-9d1d-3b3ca9063629)(one of many online) with a bit more on reinstalling WHSConnector.

Of course, restarting your WHS, or your router, or your PC, is always worth a shot. I’ve even heard of some people reporting success with restarting their cable modem.

[Others have reported that various addins, such as McAfee, can be responsible for problems connecting to your WHS](http://www.mediasmarthome.com/forum/thread/10667/can-t-log-into-windows-home-server-console). So far, that hasn’t been my issue. It may be that such addins strain the resources of the machine, which only ships with 512mb of RAM. Upgrading your HP MediaSmart WHS to 2GB of RAM is [very inexpensive ($25 or less)](http://www.newegg.com/product/product.aspx?Item=N82E16820231119&ATT=20-231-119&CMP=AFC-C8Junction&nm_mc=&cm_mmc=AFC-C8Junction-_-Memory+(Desktop+Memory)-_-G.SKILL-_-20231119)and is no longer something that will void your warranty. Here’s a [guide to upgrading the memory in your HP EX470 or EX475](http://www.homeserverhacks.com/2007/12/upgrade-memory-in-your-hp-ex470.html). I haven’t upgraded mine yet, but plan to do so soon after seeing how much the machine is using its pagefile (typically over 650MB of RAM allocated).

Finally, remember that you likely can use Remote Desktop to connect to your WHS, even when the connector software doesn’t work. This can sometimes help in gathering diagnostic information, such as the load on the server and its IP address. You’ll find the Remote Desktop software on most windows installations under Start-Programs-Accessories (sometimes under Communications). In Vista just type Remote Desktop in the Start dialog.

If you’ve had any issues with your WHS or HP MediaSmart, and have a fix to report, please add it in the comments below.