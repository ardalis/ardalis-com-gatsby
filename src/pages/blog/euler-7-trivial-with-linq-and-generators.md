---
templateKey: blog-post
title: Euler 7 Trivial with LINQ and Generators
path: blog-post
date: 2009-09-04T22:37:00.000Z
description: "Euler problem 7 requires returning the 10001st prime number.  It
  notes that the 6th prime number is 13 in the problem description.  Having
  already done some work with iterators and various number generators, including
  a Primes generator for previous Euler problems, the base case given in the
  problem can be reduced to this NUnit test:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - LINQ
category:
  - Uncategorized
comments: true
share: true
---
[Euler problem 7 requires returning the 10001st prime number](http://projecteuler.net/index.php?section=problems&id=7). It notes that the 6th prime number is 13 in the problem description. Having already done [some work with iterators and various number generators](/iterators-expressions-and-linq-for-euler), including a Primes generator for previous Euler problems, the base case given in the problem can be reduced to this NUnit test:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> SixthPrimeIs13()
{
    Assert.AreEqual(13, NumberGenerator.Primes().Take(6).Last());
}
```

Replacing the 6 with 10001 takes care of the rest. I’m really starting to dig using LINQ for this stuff.