---
templateKey: blog-post
title: SuperCache – Extending and Wrapping System.Web.Caching.Cache
path: blog-post
date: 2005-10-03T13:57:31.151Z
description: I’m nearly finished with my cache wrapper object, which I’ve named
  SuperCache for lack of a better name (Cache being taken, naturally).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - asp.net
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’m nearly finished with my cache wrapper object, which I’ve named SuperCache for lack of a better name (Cache being taken, naturally). I’ll be releasing it with source and a small article describing how to use it, most likely on [ASPAlliance.com](http://aspalliance.com/), but before I call it done I want to solicit some feedback and see if there are any features people are interested in that I could add in.

Currently it wraps pretty much all of the interesting methods of the existing System.Web.Caching.Cache object, as well as adding the following:

* Clear() – removes all entries from the cache
* RemoveByPattern() – removes all entries whose keys match a given [regular expression](http://regexadvice.com/)
* InsertRenewable() – inserts an item and specifies a callback method to use to update the item periodically using a background thread. The user always gets a cached value (fast access), but that value is never stale (at least, no more stale than the interval specified).
* Insert() and Add() – I support the use of both sliding and absolute expirations concurrently. This allows for scenarios like “keep cached as long as the item has been requested in the last minute, but not any longer than one hour” which are not supported (easily) using the standard Cache object.

The main reason why you would use this object is to abstract your dependency on a framework object so that if/when you need to extend it or swap it out, you can easily do so. That is why this will be released with source, and you will be encouraged to add it to your own class library as something like **MyCompany.Framework.Caching.SuperCache**. Additionally, I hope the extra functionality I’m exposing will be useful in some situations.

<!--EndFragment-->