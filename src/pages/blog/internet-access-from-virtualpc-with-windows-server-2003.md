---
templateKey: blog-post
title: Internet Access from VirtualPC with Windows Server 2003
path: blog-post
date: 2005-03-18T02:19:29.641Z
description: Decided to install a fresh VPC for development, which is why I
  justified getting so much RAM in my latest laptop (the graphics card, on the
  other hand, was purely for CounterStrike / HalfLife 2).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - VirtualPC
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Decided to install a fresh VPC for development, which is why I justified getting so much RAM in my latest laptop (the graphics card, on the other hand, was purely for CounterStrike / HalfLife 2). Got it up and running in short order, but it didn’t want to talk to the Internet. I knew I’d seen this before but it took me about half an hour of googling to find the quick fix here: <http://blogs.msdn.com/virtual_pc_guy/archive/2005/01/06/347965.aspx>. The solution:

*Windows Server 2003 looks at the DNS packet, sees that it is coming from a source other than the DNS server it requested the information from, and rejects it. A simple fix for this is to manually assign the DNS server inside the virtual machine to 192.168.131.254 – then everything will work just fine.*

Now I’m much happier, and on to my next issue…

<!--EndFragment-->