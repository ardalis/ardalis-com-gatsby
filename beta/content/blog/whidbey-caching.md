---
title: ASP.NET Whidbey Caching Overview
date: "2003-10-27T00:00:00.0000000"
description: An overview of the new features in the ASP.NET Caching engine coming in ASP.NET v2 (whidbey).
featuredImage: /img/whidbey-caching.png
---

## Caching in 1.x...

ASP.NET Caching in 1.x is very powerful and includes three pieces: output caching, fragment caching, and the cache API. The simplest form, output caching, simply caches the output of a page. Fragment caching is a bit more granular, and caches the output of a user control. Finally, the most powerful caching functionality is achieved using the cache API, and allows any serializable object to be cached. These cached items can then be invalidated based on a certain amount of time, a file or folder dependency, or another cached item. There's also a cached item removed callback function that lets you execute some code after something as been removed from the cache.

## ASP.NET 2.0 Caching Features

In ASP.NET 2.0, Caching has been improved in a couple of notable ways. Probably the most interesting is the introduction of database-triggered cache invalidation. There are several new cache dependencies, most notably the SqlCacheDependency object, which allows data to be cached until a change occurs in the database. There is also a new `<cache>` configuration section in the web.config which helps configure some of the details of this new functionality (such as how often to poll the database). Finally, there are some more options for caching of output to disk rather than memory, and to create your own custom cache dependency objects.

### SqlCacheDependency

In Sql Server 7 and Sql Server 2000, table level cache invalidation is supported using a polling system. Through this system, the ASP.NET process will poll the database (pull model) every so many seconds to check and see which tables have changed since it last checked. This means that instead of guessing at some arbitrary time period, like 60 seconds, and re-checking the database every 60 seconds, data can be cached indefinitely, and only flushed from the cache when the table changes.

In Sql Server Yukon, row level cache invalidation is supported. With this functionality, Yukon will actually notify ASP.NET (push model) whenever a particular row of data has been modified, so that cached items that relate to that particular row can then be flushed and re-populated from the database. This will have the best performance implications of any of these scenarios.

### CacheExpiringCallback

Although v1.x supported a CachedItemExpired callback, it was limited in usefulness because the callback was not called until **after** the item was removed from the cache. Thus, if the callback was used to repopulate the cache with the latest item, while it was doing that, other requests would hit the cache, find it empty, and error out or resort to repopulating the cache themselves. Thus, it is difficult to keep an entry in the cache and auto-updated it as needed without the user having to suffer the repopulation time.

In v2, a new callback will exist which will be called just **before** the item is removed from the cache, so that the entry in the cache could be updated based on the latest and greatest data. However, the cache would never by empty, so requests to the cache that are made while the update is going on will still get the original data, rather than an empty value.

### API Enhancements

CacheDependency in 1.x was *sealed*, meaning you couldn't inherit and extend it. In 2.x, this is no longer the case, so developers will be able to roll their own custom cache dependencies. This will allow, for instance, an OracleSqlCacheDependency to be written, or any other custom cache dependency required for a particular application or framework. This obviously opens up a whole field of possibilities, and may even result in some third-party components built around these dependencies, such as a standard StockPriceCacheDependency, for instance.

## Summary

In v2, the caching engine for ASP.NET will get improved to include some of the most frequently requested features for 1.x. Namely, support for database cache invalidation and custom cache dependencies will be added, allowing for much more powerful and intelligent caching scenarios to be set up.

Originally published on [ASPAlliance.com](http://aspalliance.com/246_ASPNET_Whidbey_Caching_Overview).

