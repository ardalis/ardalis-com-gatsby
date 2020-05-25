---
templateKey: blog-post
title: Sort Generic List of T
path: blog-post
date: 2007-06-17T13:37:48.241Z
description: Plenty of others have written about this so I'll keep it brief. I
  needed to sort some objects based on a string property. Some quick searching
  led me to [this post] which got me close to what I wanted.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - sort
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Plenty of others have written about this so I'll keep it brief. I needed to sort some objects based on a string property. Some quick searching led me to [this post](http://echerng.net/blog/2006/07/23/anonymous-methods-sorting-a-generic-list) which got me close to what I wanted.

My final code was this:

<!--EndFragment-->

```
myThings.Sort(<span class="kwrd">delegate</span>(Thing x, Thing y) { <span class="kwrd">return</span> String.Compare(x.Name,y.Name); });
```

<!--StartFragment-->

myThings is a List<Thing> collection. String.Compare done in this fashion will sort them alphabetically – reverse its parameters to sort in reverse.

<!--EndFragment-->