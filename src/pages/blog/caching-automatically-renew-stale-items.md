---
templateKey: blog-post
title: "Caching: Automatically Renew Stale Items"
path: blog-post
date: 2005-06-16T20:47:32.542Z
description: I’m working on a new library for Caching that has been an interest
  of mine for some time, but which I only took the time to implement last week
  (on the plane home from Charleston).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Caching
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’m working on a new library for Caching that has been an interest of mine for some time, but which I only took the time to implement last week (on the plane home from Charleston). Basically the problem is that for many of the things that are ideal candidates for caching, it would be nice if there were an easy way to keep these in the cache forever while still ensuring the cached values are relatively current. Consider this scenario:

*A web application requires data from another system, which is accessed via the Internet, operated by another organization, and not entirely reliable. For performance reasons, data from this system is cached; however accessing this data takes approximately 1-3 seconds, and the data is only valuable for 10 minutes at a time.*

Using standard caching features in ASP.NET, the easy way to implement this would be to Output Cache the page or user control that is responsible for displaying this data. Slightly less easy would be to pull the data via a data access library, and implement caching using the Cache object within that library. Add an absolute time expiration of 10 minutes and voila, done. However, the downside to this solution is that every 10 minutes, some user is going to have the dubious honor of being the ‘lucky’ one who gets to sit and wait for 1-3 seconds for their data, when they’re used to otherwise snappy performance. Worse, if the distant application is unavailable when the cache has expired, the user will have to wait even longer while the call times out, and then they won’t even be presented with any data at all! In some scenarios, old data is better than no data, provided the user is aware of how old the data is, so in this latter case, it may be preferable to fall back to the last data retrieved rather than losing the data entirely. But even if this is done, the standard behavior would require the user to wait while the service timed out before they would be presented with the old data.

The solution to this issue is to create a Renewing Cache. A Renewing Cache is one which is populated initially with not only the key and value used by a standard Cache, but also with the information necessary to repopulate the data, and an interval on which to do so. Then, behind the scenes, this object will attempt to renew the cached data with data from the original source. If it fails, the old data will remain (or not, depending on business rules). The key feature here is that these renewal attempts are resolved in a separate thread from any user’s request, so except for the very first time (usually just after the application is started), no user will have to wait for the data to be repopulated.

I’ve gotten this to work in a simple case. I’m working on making the class more flexible and I’ll eventually (hopefully this month) publish an article on this topic on [AspAlliance.com](http://aspalliance.com/).

<!--EndFragment-->