---
templateKey: blog-post
title: Use LINQ Aggregate to Multiply a Series of Digits
path: blog-post
date: 2009-09-05T22:34:00.000Z
description: "The LINQ Aggregate() extension method uses a Func<int, int, int>
  to operate on items in a series. If you want to use it, for example, to return
  the product of each value with its successor, you can do something like this:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - LINQ
category:
  - Uncategorized
comments: true
share: true
---
The LINQ Aggregate() extension method uses a Func<int, int, int> to operate on items in a series. If you want to use it, for example, to return the product of each value with its successor, you can do something like this:

```
Func&lt;<span style="color: #0000ff">int</span>, <span style="color: #0000ff">int</span>, <span style="color: #0000ff">int</span>&gt; producter = (one, two) =&gt; one * two;
var result = subString.ToCharArray().ToDigits().Aggregate(producter);
```

Of course, you don’t need the intermediate value. You can simply use a lambda directly for the Aggregate()’s parameter:

```
<span style="color: #008000">//Func&lt;int, int, int&gt; producter = (one, two) =&gt; one * two;</span>
var result = subString.ToCharArray().ToDigits().Aggregate((p1,p2) =&gt; p1 * p2);
```

With a loop to keep track of the largest result returned for a substring of length 5, you can easily use this technique to [solve Euler 8](http://projecteuler.net/index.php?section=problems&id=8).