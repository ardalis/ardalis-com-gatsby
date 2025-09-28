---
title: Sort Generic List of T
date: "2007-06-17T09:37:48.2410000-04:00"
description: Plenty of others have written about this so I'll keep it brief. I
featuredImage: img/sort-generic-list-of-t-featured.png
---

Plenty of others have written about this so I'll keep it brief. I needed to sort some objects based on a string property. Some quick searching led me to [this post](http://echerng.net/blog/2006/07/23/anonymous-methods-sorting-a-generic-list) which got me close to what I wanted.

My final code was this:


```
myThings.Sort(<span class="kwrd">delegate</span>(Thing x, Thing y) { <span class="kwrd">return</span> String.Compare(x.Name,y.Name); });
```


myThings is a List<Thing> collection. String.Compare done in this fashion will sort them alphabetically – reverse its parameters to sort in reverse.

