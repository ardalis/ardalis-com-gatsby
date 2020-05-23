---
templateKey: blog-post
title: ASP.NET Whidbey Caching Features – Where's the Self-Renewing Feature?
path: blog-post
date: 2004-02-01T23:03:00.000Z
description: "One new feature Whidbey supports is custom CacheDependencies.
  Simply inherit from CacheDependency and NotifyDependencyChanged() whenever you
  want the cache to be invalidated — very simple. "
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - asp.net
  - Whidbey caching
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

One new feature Whidbey supports is custom CacheDependencies. Simply inherit from CacheDependency and NotifyDependencyChanged() whenever you want the cache to be invalidated — very simple. An old feature that has been around since 1.0 is the CacheItemRemovedCallback. For those unfamiliar, this (still sealed) callback is executed immediately after a cache entry is invalidated. Unfortunately, it is all but useless since the ideal purpose for such a callback would be to check and see if there is some new data available, grab it without the user having to wait for it, and re-enter it into the cache. This series of events fails because the item is removed from the cache before the callback executes, meaning that something is likely to come looking for the cached item, find that it has expired (it’s null), and go off to re-populate it (making a user wait for it).

One proposed feature I have discussed with the ASP.NET team is to add a new callback called CacheItemRemovingCallback, which would be executed before an item is removed from the cache (and the item would be guaranteed not to be removed until this callback finished executing). This would allow for things like caching the weather from a slow web service (takes 5 seconds to come back) for 5 minutes. After 5 minutes, the CacheItemRemovingCallback launches and in its associated function, there is code to call the web service, grab the latest weather, and insert it into the cache with a new expiration of 5 more minutes. This renewal would happen offline, behind the scenes, with no user waiting. Without this feature, 12 users per hour will have to suffer through page execution times in excess of 5 seconds while waiting for the web service to complete. With it, only the very first request will have to do so.

Unfortunately, it doesn’t sound like this feature is going to make it into Whidbey at this time. One reason I’ve been told is that this same functionality can be accomplished using the aforementioned CacheDependency which is now open to extension/derivation. While it is true that one could now write a WeatherServiceCacheDependency (for the previous scenario) to check every n seconds to see if the weather has changed, and if so, invalidate the cache, what I have not been able to do is update the cache with the new data directly. Unfortunately, the CacheDependency class has no knowledge of the key/value cache item that depends upon it, and thus it cannot update that entry. Which means such updates will have to be done in the space of a user’s request, resulting in slower request execution and lower overall performance.

For those of you who have the Whidbey bits today, please try and use the built-in Cache and CacheDependency classes to create a system where a cached item is renewed as it is about to expire without doing so in a user’s request. I’d be very interested to see if it can be done. In the meantime, I’m going to keep bugging the ASP.NET team in general and Rob Howard in particular to include this functionality, as well as perhaps writing a wrapper for the Cache object that will take care of it for my own uses.

<!--EndFragment-->