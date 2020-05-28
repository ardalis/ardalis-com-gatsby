---
templateKey: blog-post
title: Disk Output Cache
path: blog-post
date: 2005-12-14T13:57:35.760Z
description: "DmitryR writes about an implementation of using Output Cache to
  Disk (instead of memory) via an HttpModule. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - asp.net
  - Caching
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

DmitryR writes about an implementation of using [Output Cache to Disk (instead of memory) via an HttpModule](http://blogs.msdn.com/dmitryr/archive/2005/12/13/503411.aspx). Definitely an interesting topic (and a similar feature was in v2 through beta2 but ended up getting cut) and one that could be useful in certain scenarios, especially to avoid the dreaded “application-restarting-and-maxing-out-resources-filling-data-caches” effect that happens when many large applications that make heavy use of the in-memory cache reset.

<!--EndFragment-->