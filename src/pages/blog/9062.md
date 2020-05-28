---
templateKey: blog-post
title: The Caching Pattern
path: blog-post
date: 2003-06-20T23:58:00.000Z
description: "Here’s a little something that I term “the caching pattern” for
  using the ASP.NET cache object:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Caching
  - design patterns
  - patterns
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

Here’s a little something that I term “the caching pattern” for using the ASP.NET cache object:

<!--EndFragment-->

```
Object cacheItem = Cache[key]
as DataTable;
if(cacheItem == null)
{
  cacheItem = GetData();
  Cache.Insert(key, cacheItem, null, DateTime.Now.AddHours(1), TimeSpan.Zero);
}
return (DataTable)cacheItem;
```

<!--StartFragment-->

The as keyword will try to cast Cache\[key] to DataTable and if unsuccessful it will return null. If it is null, it will return null. The rest of it is pretty straightforward. This is the best practice way to get something from the cache, but look at it! It’s huge! I’m trying to come up with a helper class that will encapsulate this logic in a reusable fashion so that reading something from cache would take only a line or two of code. I’ll post more when I’m done – I think I’m close to having it.

\[Listening to: Queens of the Stone Age – No One Knows]

<!--EndFragment-->