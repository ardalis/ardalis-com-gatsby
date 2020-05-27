---
templateKey: blog-post
title: Caching Application Block Released
path: blog-post
date: 2003-06-17T23:47:00.000Z
description: "News if you haven’t heard, another application block has been
  released (actually a couple):"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - application block
  - Caching
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

News if you haven’t heard, another application block has been released (actually a couple):

[Caching Application Block](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnpag/html/Cachingblock.asp) (the other one is [Aggregation](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnpag/html/ServiceAgg.asp))

I’ve read over the docs for the Caching block and at first glance it looks like it doesn’t offer anything to ASP.NET developers that the built-in Cache API doesn’t have, unless you’re looking to store your cached data in a database (and suffer big perf penalties).

It’s missing features that the intrinsic Cache object supports, such as providing access to the just-expired object in a CacheItemRemovedCallback (the app block only passes in the key, not the value), and it doesn’t go further with than the intrinsic Cache object where the Cache object falls short (for instance, CacheItemRemovedCallback would be 1000 times more useful if it were guaranteed to complete execution BEFORE the item was actually removed from the cache. The app block might have implemented this but it doesn’t appear to have).

In short, this looks like an AWESOME addition to the .NET framework for non-web developers, but it doesn’t look like anything ASP.NET developers are going to be anything but underwhelmed by. By all means, tell me if I’m wrong – caching is of particular interest to me and I’d love to hear that this app block will give me things the intrinsic Cache object cannot. And perhaps, some day, when I have time, I might extend the app block to have it handle database table cache dependencies or ItemExpiredButNotYetRemovedCallbacks. But probably not; I’ll just hope to see those in a future version of ASP.NET.

\[Listening To: Redshift – Infamy]

<!--EndFragment-->