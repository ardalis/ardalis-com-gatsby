---
templateKey: blog-post
title: "Extending the ASP.NET Cache Object: Cache.Clear()"
path: blog-post
date: 2005-11-14T14:10:01.317Z
description: The built-in Cache object in ASP.NET does not support a Clear()
  method. This method would be useful if you ever just wanted to invalidate all
  cache entries and start fresh.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - asp.net
  - C#
  - Caching
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

The built-in Cache object in ASP.NET does not support a Clear() method. This method would be useful if you ever just wanted to invalidate all cache entries and start fresh. In a utility object I’m working on, tentatively called SuperCache, I’ve implemented a Clear method using the following code:

```
/// <summary>\
/// Removes all items from the Cache\
/// Note – should not remove from cache in while loop since enumerator is only valid while collection remaind intact:\
///<http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpref/html/frlrfsystemcollectionsidictionaryenumeratorclasstopic.asp>\
/// </summary>\
public void Clear()\
{\
List<string> keyList = new List<string>();\
IDictionaryEnumerator CacheEnum = _cache.GetEnumerator();\
while (CacheEnum.MoveNext())\
{\
keyList.Add(CacheEnum.Key.ToString());\
}\
foreach (string key in keyList)\
{\
Remove(key);\
}\
}
```

This is interesting mainly because of the reference to the [IDictionaryEnumerator documentation](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpref/html/frlrfsystemcollectionsidictionaryenumeratorclasstopic.asp), which states

**An enumerator remains valid as long as the collection remains unchanged. If changes are made to the collection, such as adding, modifying or deleting elements, the enumerator is irrecoverably invalidated and the next call to MoveNext or Reset throws an [InvalidOperationException](http://msdn.microsoft.com/library/en-us/cpref/html/frlrfsysteminvalidoperationexceptionclasstopic.asp). If the collection is modified between MoveNext and Current, Current will return the element that it is set to, even if the enumerator is already invalidated.**

Since my original code, borrowed from others who will remain nameless, called Remove() inside the while loop, I thought I’d post this since I’m sure others are probably making the same mistake. I never encountered any errors and I have a bunch of unit tests that all pass using my old way of doing things, but I figure it’s probably safest to go with what the docs say and do the removal after I’m finished with the enumerator.

<!--EndFragment-->