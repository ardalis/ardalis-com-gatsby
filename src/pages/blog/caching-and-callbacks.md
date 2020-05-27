---
templateKey: blog-post
title: Caching and Callbacks
path: blog-post
date: 2003-04-24T00:18:00.000Z
description: I gave my second presentation to a user group for INETA this
  evening (well, last evening – it’s late). I spoke to about 70 members of the
  Philadelphia .NET user group, Philly .NET, about ASP.NET Performance Tips and
  Tricks
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Caching
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

I gave my second presentation to a user group for [INETA](http://www.ineta.org/) this evening (well, last evening – it’s late). I spoke to about 70 members of the Philadelphia .NET user group, [Philly .NET](http://www.phillydotnet.org/), about ASP.NET Performance Tips and Tricks and the Caching support in ASP.NET. While I was discussing callbacks and the CacheItemRemovedCallback delegate that can be specified when an object is inserted into the cache, one of the users asked me a question that I wasn’t sure of the answer to. In my example, I was doing something like this:

<!--EndFragment-->

```
//create an instance of the callback delegate

CacheItemRemovedCallback callBack =
new CacheItemRemovedCallback(onRemove);

Cache.Insert(cacheKey,System.DateTime.Now.ToString(),null, 

System.DateTime.Now.AddSeconds(5),
System.Web.Caching.Cache.NoSlidingExpiration,
System.Web.Caching.CacheItemPriority.Default,
callBack);
…

private void onRemove(string key, 

object val, 

CacheItemRemovedReason reason)
{
//create an instance of the callback delegate

CacheItemRemovedCallback callBack =
new CacheItemRemovedCallback(onRemove);

Cache.Insert(key,val.ToString() + suffix,null,System.DateTime.Now.AddSeconds(5),Cache.NoSlidingExpiration,

System.Web.Caching.CacheItemPriority.Default, callBack);
}
```

<!--StartFragment-->

The question then was, since I wasn’t using a static method for my callback, would the .NET runtime keep an instance of this page around in memory so that it was available for this instance method I was calling. I thought that that couldn’t be right, since it seemed like it would potentially be quite a bit of overhead to keep around, since there was no telling how big and complex my page instance might be. The right answer, I said, was to use a static method for the callback in this case, since it did not depend on the state of the page. However, I didn’t have a good answer to the question.

So after modifying my example slightly to depend on some stateful instance data in the page, I found that yes, indeed, the caching API does keep a copy of the page instance available so that it can call the instance method I specified as the callback. This is good to know, since that could have implications on scalability as well as potentially cause some strange behavior if theinstance data of the page were somehow to cause the callback to behave differently in different situations, unintentionally.

Thanks for the good question!

<!--EndFragment-->