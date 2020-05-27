---
templateKey: blog-post
title: Seamless Multi-Computer CPU Sharing
path: blog-post
date: 2015-06-29T14:08:00.000Z
description: "Something I’d love to see in a future version of Windows is a
  seamless way to use some of the extra computers I always tend to have on my
  network, whether at home or at the office. "
featuredpost: false
featuredimage: /img/computer-311339_1280-760x360.png
tags:
  - grid computing
  - networking
  - windows
category:
  - Software Development
comments: true
share: true
---
[](/img/computer-311339_1280.png) Something I’d love to see in a future version of Windows is a seamless way to use some of the extra computers I always tend to have on my network, whether at home or at the office. For CPU-intensive activities like video rendering, whether it’s video I’m producing for [Pluralsight](https://ardalis.com/ps-stevesmith) or something similar, or ripping my DVD collection to Plex, these activities take significant time on a single machine, even with 8-cores and the latest processors. Wouldn’t it be cool if you could add a computer to a workgroup (or similar) and check a box to say “Share CPU cycles when idle” and perhaps limit it to x%. Then, when a machine is pegged at over 90% CPU for more than a few seconds, it could send out work packets across the LAN and get help from other machines that have spare cycles. Does this already exist? I don’t want to have to install and run specialized software on every machine to achieve this – I really want it to be something the OS takes care of for me in the background, and all I see is that my render times drop by some factor.

Let me know what you think. I’m sure there are a bunch of technological hurdles to overcome here (disk I/O, network I/O, security of the data being processed (and therefore encryption overhead), etc.) but given that most of the applications that need to perform these CPU-intensive tasks have already solved the parallelism problem introduced by multi-core processors, I see this as the next logical step. In many development environments, just building the application can take over a minute, but at any given moment, most team members’ machines are idle. Being able to drop build (and test) times (at least in cases where CPU is the bottleneck, which is more and more the case with fast SSDs, etc) by a factor of 2 or more could be a huge productivity boost. Graphic-intensive applications like CAD or 3D game or animation development would be similar ideal candidates for this kind of feature.