---
title: Euler 7 Trivial with LINQ and Generators
date: "2009-09-04T18:37:00.0000000-04:00"
description: "Euler problem 7 requires returning the 10001st prime number. It notes that the 6th prime number is 13 in the problem description. Having already done some work with iterators and various number generators, including a Primes generator for previous Euler problems, the base case given in the problem can be reduced to this NUnit test:"
featuredImage: img/euler-7-trivial-with-linq-and-generators-featured.png
---

[Euler problem 7 requires returning the 10001st prime number](http://projecteuler.net/index.php?section=problems&id=7). It notes that the 6th prime number is 13 in the problem description. Having already done [some work with iterators and various number generators](/iterators-expressions-and-linq-for-euler), including a Primes generator for previous Euler problems, the base case given in the problem can be reduced to this NUnit test:

```csharp
public void SixthPrimeIs13()
{
 Assert.AreEqual(13, NumberGenerator.Primes().Take(6).Last());
}
```

Replacing the 6 with 10001 takes care of the rest. I'm really starting to dig using LINQ for this stuff.

