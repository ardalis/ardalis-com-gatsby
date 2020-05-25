---
templateKey: blog-post
title: Installing TFS RC
path: blog-post
date: 2006-03-09T13:06:07.105Z
description: I had to buy a new box to install Team Foundation Server —
  apparently it just won’t work on my old Dell Inspiron laptop from around 2001
  (P3, 866Mhz).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - VS.NET
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I had to buy a new box to install Team Foundation Server — apparently it just won’t work on my old Dell Inspiron laptop from around 2001 (P3, 866Mhz). Seems it requires at least a P4 2.2GHz. The complete system requirements can be found in the latest [Visual Studio 2005 Team Foundation Installation Guide](http://www.microsoft.com/downloads/details.aspx?familyid=E54BF6FF-026B-43A4-ADE4-A690388F310E&displaylang=en). I also found this [TFS success story](http://blogs.claritycon.com/blogs/tim_erickson/archive/2006/02/13/207.aspx), which I hope to duplicate myself (though I’m installing on a real machine, not a Virtual PC). I’m planning on keeping a log of my activities (and time spent) as I build this machine, which I’ll post once the install is complete.

Finally, let me just take this opportunity to express my extreme disapointment over the news that [TFS basically is broken over the Internet](http://blogs.msdn.com/robcaron/archive/2006/02/22/537485.aspx). According to Rob Caron:



> *Integrated Windows Authentication is an ideal choice for most deployment scenarios in a corporate environment, but it is not an optimal choice in Internet scenarios due to limitations resulting from proxy servers, firewalls, and trusted connections. For this reason, we originally planned to support Basic and Digest authentication as well. For more information, see [Integrated Windows Authentication (IIS 6.0)](http://www.microsoft.com/technet/prodtechnol/WindowsServer2003/Library/IIS/523ae943-5e6a-4200-9103-9808baa00157.mspx "http\://www.microsoft.com/technet/prodtechnol/WindowsServer2003/Library/IIS/523ae943-5e6a-4200-9103-9808baa00157.mspx").*
>
> *Unfortunately, we were not able to complete this implementation in time to ship with the initial RTM release of Team Foundation Server. We are continuing to work on adding this support in the near future, which should be available sometime soon after the release of Team Foundation Server. However, this means that Team Foundation Server does not immediately support some scenarios, such as accessing Team Foundation Server through a proxy that does not maintain a connection between the client and server.*

So… basically forget about this “Internet” thing; TFS is basically just useful in a client-server environment. What happened to “web services” ? Weren’t they supposed to be this cool new thing that would let systems communicate through firewalls using standard Internet protocols? I’m sorry, but it’s very sad that this premium product cannot, without the use of a VPN, work over the Internet. I know this is something Microsoft is aware of and I really hope they quickly release something to fix this shortfall. If I’m mis-understanding the issue in some way, please, set me straight with a comment and/or link. I really \*hope\* that’s the case.

<!--EndFragment-->