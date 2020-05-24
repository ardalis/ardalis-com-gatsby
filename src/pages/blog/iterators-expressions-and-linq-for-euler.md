---
templateKey: blog-post
title: Iterators, Expressions, and LINQ for Euler
path: blog-post
date: 2009-08-25T23:04:00.000Z
description: Recently I’ve been doing some Project Euler problems as exercises
  to help improve my coding skills. We do this internally at NimblePros
  periodically and also at last weeks Hudson Software Craftsmanship meeting,
  which I co-run.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - LINQ
category:
  - Uncategorized
comments: true
share: true
---
Recently I’ve been doing some [Project Euler](http://projecteuler.net/) problems as exercises to help improve my coding skills. We do this internally at [NimblePros](http://nimblepros.com/) periodically and also at last weeks [Hudson Software Craftsmanship](http://hudsonsc.com/) meeting, which I co-run. In doing these problems, I’ve been trying to approach them both from a traditional C# 1.0 standpoint as well as using newer constructs such as lambda expressions, LINQ, and iterators. It’s amazing how much more flexible a design can be through the use of these tools.

For example, the [first Euler problem](http://projecteuler.net/index.php?section=problems&id=1) simply asks that you add together all natural numbers that are multiples of either 3 or 5 and less than 1000. A simple design of this problem might be to write a for() loop that runs from 1 to 999 (< 1000) and checks if the current number MOD 3 or MOD 5 equals 0, and if so, add it to the sum. Pretty straightforward, but it comingles several concerns.

What are the moving parts in the problem?

* Generating a List of Numbers to Check
* Checking If A Number Is a Multiple of 3 or 5
* Summing Numbers Together

When you move on to the [second Euler problem](http://projecteuler.net/index.php?section=problems&id=2), which wants the sum of all even-valued terms in the Fibonacci sequence less than or equal to 4,000,000, you end up writing a lot more code if you didn’t separate out the initial concerns.

Let’s look at the first moving part, generating numbers. An iterator provides a useful solution here:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> IEnumerable&lt;<span style="color: #0000ff">long</span>&gt; Integers()
{
    <span style="color: #0000ff">long</span> currentValue = 1;
    <span style="color: #0000ff">while</span> (<span style="color: #0000ff">true</span>)
    {
        <span style="color: #0000ff">yield</span> <span style="color: #0000ff">return</span> currentValue++;
    }
}
```

Now you can use this with various LINQ expressions to generate sets of numbers. Here’s a simple test showing how to get 10 numbers with this iterator.

```
[Test]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> NumberGeneratorProvidesFirst10Integers()
{
    var myList = NumberGenerator.Integers().Take(10);
    Assert.AreEqual(1, myList.First());
    Assert.AreEqual(10, myList.Last());
}
```

Next you want to be able to check for various things. For example, the first problem wants only numbers that are multiples of 3 or 5, while the second problem wants numbers that are even (multiples of 2). Assuming you’ve pulled the modulo logic into a simple extension method like Is Multiple Of(x) you can use LINQ again to generate only numbers of a particular kind:

```
[Test]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> NumberGeneratorProvidesFirst10EvenIntegers()
{
    var myList = NumberGenerator.Integers().Where(x =&gt; x.IsMultipleOf(2)).Take(10);
    Assert.AreEqual(2, myList.First());
    Assert.AreEqual(20, myList.Last());
}
```

Of course, for common expressions like even numbers, you don’t want to repeat the logic throughout your code, so once you see that you’re using things like Is Multiple Of (2) in more than a few places, you can easily create a new Generator that only generates even numbers:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> IEnumerable&lt;<span style="color: #0000ff">long</span>&gt; Evens()
{
    <span style="color: #0000ff">return</span> Integers().Where(x =&gt; x.IsMultipleOf(2));
}
```

More complex expressions can be stored separately using Func, which can be an extremely powerful way to follow [OCP](http://en.wikipedia.org/wiki/Open/closed_principle) by allowing you to pass in criteria to an operation, rather than explicitly encoding it within a method. For example, here’s the Problem 1 criteria expressed as a Func<long,bool>:

```
var expression = <span style="color: #0000ff">new</span> Func&lt;<span style="color: #0000ff">long</span>, <span style="color: #0000ff">bool</span>&gt;(
    p =&gt; (p.IsMultipleOf(3) ||
          p.IsMultipleOf(5))
    );
```

Using this expression without LINQ (using standard loops and such), you can encapsulate the logic of summing numbers in its own class while keeping the criteria separate, like so:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> NumberSummer
{
    <span style="color: #0000ff">private</span> <span style="color: #0000ff">readonly</span> <span style="color: #0000ff">int</span> _upperBound;
    <span style="color: #0000ff">private</span> <span style="color: #0000ff">readonly</span> Func&lt;<span style="color: #0000ff">long</span>, <span style="color: #0000ff">bool</span>&gt; func;
&#160;
    <span style="color: #0000ff">public</span> NumberSummer(<span style="color: #0000ff">int</span> upperBound, Func&lt;<span style="color: #0000ff">long</span>, <span style="color: #0000ff">bool</span>&gt; func)
    {
        <span style="color: #0000ff">this</span>._upperBound = upperBound;
        <span style="color: #0000ff">this</span>.func = func;
    }
&#160;
    <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> Sum()
    {
        <span style="color: #0000ff">int</span> sum = 0;
        <span style="color: #0000ff">for</span> (<span style="color: #0000ff">int</span> i = 0; i &lt; _upperBound; ++i)
        {
            <span style="color: #0000ff">if</span> (func(i))
            {
                sum += i;
            }
        }
        <span style="color: #0000ff">return</span> sum;
    }
}
```

Alternately, with LINQ and the NumberGenerator already shown, the expression can be evaluated like this instead:

```
NumberGenerator.Integers().Take(999).Where(expression).Sum()
```

Since LINQ already supports a Sum() method, and it already supports criteria, there’s no need for the NumberSummer class above – it’s basically duplicating stuff that is already in the framework.

The real value of this as you move through one Euler problem and go to solve another one is that you can do so by building on what you’ve already written, but without cutting and pasting it. You get **real code reuse**, not cut-and-paste reuse. One of the fundamental principles of the Open-Closed Principle is that **new functionality is achieved by writing new code, not by changing existing code**.

Look at how easy it is to do problem 2 once the components have been well-factored using the techniques shown above:

```
var fibonacciChecker = <span style="color: #0000ff">new</span> FibonacciChecker();
expression = (
                 p =&gt; (fibonacciChecker.IsFib(p))
             );
<span style="color: #0000ff">const</span> <span style="color: #0000ff">int</span> upperBound = 4000000;
Console.WriteLine(<span style="color: #006080">&quot;The sum of all even Fib numbers below 4,000,000  is: &quot;</span>);
Console.WriteLine(NumberGenerator.Evens().Take(upperBound).Where(expression).Sum());
```

Since I’m not trying to spoil anyone’s fun solving these problems, I’ll leave actually writing the IsFib method to the reader, but my point is that using these techniques can really result in much less code which is far more expressive and reusable. And if you make IsFib() an extension method, you can rewrite problem 2 as just one line like this:

```
NumberGenerator.Evens().Take(4000000).Where(p =&gt; p.IsFib()).Sum()
```

I’m really digging LINQ and expressions these days! When you get to [Problem 3](http://projecteuler.net/index.php?section=problems&id=3), which deals with primes, all you need to do to get started is generate a series of primes like this:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> IEnumerable&lt;<span style="color: #0000ff">long</span>&gt; Primes()
{
    <span style="color: #0000ff">return</span> Integers().Where(x =&gt; x.IsPrime());
}
```

Then the only thing you have to write is an IsPrime() method and the problem is half-solved. Have fun!