---
templateKey: blog-post
title: VirtualPC Memory Limit — Nero InCD
path: blog-post
date: 2005-03-18T02:17:52.504Z
description: Chris Wille pointed me to Nero InCD as the culprit when my
  VirtualPC machine wouldn’t let me use more than 256mb of my 2GB of RAM. He
  says now that this [is fixed in the latest version].
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

[Chris Wille pointed me to Nero InCD as the culprit](http://chrison.net/ct.ashx?id=35a8b116-3855-496f-8471-9803351c1f4e&url=http%3a%2f%2fchrison.net%2fPermaLink%2cguid%2c99df6f99-52c8-4cbd-992a-2dbb8472e9ae.aspx) when my VirtualPC machine wouldn’t let me use more than 256mb of my 2GB of RAM. He says now that this [is fixed in the latest version](http://chrison.net/PermaLink,guid,35a8b116-3855-496f-8471-9803351c1f4e.aspx). Ben Armstrong also [covers the issue of Nero InCD and VirtualPC](http://blogs.msdn.com/virtual_pc_guy/archive/2005/01/18/355566.aspx), recommending uninstalling.

What I’ve found works for me is to simply open up Windows Task Manager, go to the Processes tab, sort by Image Name, select InCD.exe, and End Process. No need to uninstall (or install a new version of Nero). I can still use Nero when I want for burning or whatever, but when I’m doing VPC I just stop it. I’m pretty sure I don’t need InCD using up resources 24/7 anyway.

<!--EndFragment-->