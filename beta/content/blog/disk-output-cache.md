---
title: Disk Output Cache
date: "2005-12-14T08:57:35.7600000-05:00"
description: DmitryR writes about an implementation of using Output Cache to Disk (instead of memory) via an HttpModule.
featuredImage: img/disk-output-cache-featured.png
---

DmitryR writes about an implementation of using [Output Cache to Disk (instead of memory) via an HttpModule](http://blogs.msdn.com/dmitryr/archive/2005/12/13/503411.aspx). Definitely an interesting topic (and a similar feature was in v2 through beta2 but ended up getting cut) and one that could be useful in certain scenarios, especially to avoid the dreaded "application-restarting-and-maxing-out-resources-filling-data-caches" effect that happens when many large applications that make heavy use of the in-memory cache reset.

