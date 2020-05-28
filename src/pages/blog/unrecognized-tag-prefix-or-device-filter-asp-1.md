---
templateKey: blog-post
title: Unrecognized tag prefix or device filter 'asp'
path: blog-post
date: 2006-08-29T02:44:11.660Z
description: "This error was bugging me today so I finally went searching for an answer. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

This error was bugging me today so I finally went searching for an answer. I found it [here](http://groups.google.com/group/microsoft.public.vsnet.ide/browse_thread/thread/15c6061bf89e23a4/23c2760f3b78cb74?q=unrecognized+asp+prefix&rnum=1#23c2760f3b78cb74).

The short version – if you’re using nested master pages and you’re seeing all of your <asp: … /> tags underlined and complaining with “Unrecognized tag prefix or device filter ‘asp’.” the solution is to keep your nested master page open in Visual Studio. That’s right – it sounds stupid – but that’s the fix.

So, if you have a Page that references a master page called ChildMaster.master which references ParentMaster.master, you should open ChildMaster.master (even if you don’t plan to make any changes to it) and leave it open in the IDE while you work on pages that refer to it.

Hopefully this will be fixed in a later update.

<!--EndFragment-->