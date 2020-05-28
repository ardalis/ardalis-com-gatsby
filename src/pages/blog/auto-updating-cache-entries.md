---
templateKey: blog-post
title: Auto-Updating Cache Entries
path: blog-post
date: 2004-02-14T22:25:00.000Z
description: I’m interested in a feature of the ASP.NET Cache engine that isn’t
  there today, and it sounds like won’t be there in Whidbey. To wit, I’d like to
  be able to throw something in the cache and have it periodically update itself
  in an offline process, rather than simply expire and force a user request to
  sit and wait while the data is retrieved.
featuredpost: false
featuredimage: /img/aspnetcore-1.png
tags:
  - asp.net
  - auto updating cache entries
  - CacheConfig
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

As I posted [here](http://aspadvice.com/blogs/ssmith/archive/2004/02/02/1766.aspx), I’m interested in a feature of the ASP.NET Cache engine that isn’t there today, and it sounds like won’t be there in Whidbey. To wit, I’d like to be able to throw something in the cache and have it periodically update itself in an offline process, rather than simply expire and force a user request to sit and wait while the data is retrieved. I’ve come up with a workaround/hack that I think will let me accomplish this using the 1.x engine, and I intend to work it out in the next couple of weeks and post an article on it. I’ll probably build on my CacheConfig helper class, which I detail in [this MSDN article](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnaspp/html/aspnet-createcacheconfigobject.asp).

You’d think this would be simple. For example, my first thought was to just add a second item to the cache with a related name (e.g. if I’ve just added some weather data to the cache for zip code 44240, I might have a key of ‘weather44240’. My second item’s key might be ‘weather44240_repopulate’), and use a CacheItemRemoved callback off of the second cached item to do the repopulation. By setting the expiration datetime of the second item to a minute or so less than the expiration datetime of the actual cached data, this should ensure that the callback complete before the data cache item expires. Then, in the callback, repopulate the data, re-insert it into the cache, and also re-insert the second key with an expire date of 1 minute less than the actual data.

The problem with this solution is that, unfortunately, items in the cache are not removed when their time expires. They’re removed when something tries to access them and they have expired at that time. Thus, the only way the above technique would work would be if the ‘weather44240_repopulate’ item were being retrieved by something fairly frequently (at least a few times per minute), which would be pretty inefficient.

More likely, I’ll build a timer into CacheConfig to get this working, but for now I’m overdue on some articles for magazines, so I have to get those done. More on this in a week or so.

<!--EndFragment-->