---
templateKey: blog-post
title: VS2005 Data Pro Dies on Compile Fix
path: blog-post
date: 2007-03-22T15:58:33.114Z
description: I had an issue with VS2005 For DB Pros (the Data Dude SKU) where
  every time I would build my solution (or that project), VS2005 would simply
  die.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - sql2005
  - VS.NET
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I had an issue with VS2005 For DB Pros (the Data Dude SKU) where every time I would build my solution (or that project), VS2005 would simply die. This was on Vista. After looking for the answer, I contacted [Gert Drapers](http://blogs.msdn.com/gertd) who informed me of the fix — [install the RTM of SQL 2005 SP2](http://blogs.msdn.com/gertd/archive/2007/02/19/sql-server-2005-sp2.aspx) (or just the XMO redist) and the problem’s solved.

Thanks, Gert – I hope this helps some others who had a CTP of SP2 installed.

Tags: [vs2005](http://technorati.com/tag/vs2005), [dbpro](http://technorati.com/tag/dbpro), [data+dude](http://technorati.com/tag/data+dude)

<!--EndFragment-->