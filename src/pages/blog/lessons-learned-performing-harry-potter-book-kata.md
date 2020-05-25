---
templateKey: blog-post
title: Lessons Learned Performing Harry Potter Book Kata
path: blog-post
date: 2011-01-18T11:26:00.000Z
description: Last week at CodeMash I went through the Harry Potter Book Kata
  with [Steve (@underwhelmed)]. This is an interesting kata because it pretty
  much starts out very straightforward and things progress very quickly, and
  then you are faced with a brick wall in terms of how to proceed with the
  algorithm.
featuredpost: false
featuredimage: /img/code-geek-2680204_1280.png
tags:
  - design patterns
  - kata
  - practice
  - tdd
category:
  - Software Development
comments: true
share: true
---
Last week at [CodeMash](http://codemash.org/) I went through the Harry Potter Book Kata with [Steve (@underwhelmed)](http://twitter.com/underwhelmed). This is an interesting kata because it pretty much starts out very straightforward and things progress very quickly, and then you are faced with a brick wall in terms of how to proceed with the algorithm. I recommend you give the exercise a try yourself before reading my tips, since they may be something of a spoiler for you (if you enjoy the puzzle-solving aspect of these exercises more than the repetition of known good solutions).

**Lesson One – Test The Small Stuff**

This isn’t really a spoiler, so I’ll start with it. Steve and I tested all of the basic cases in the problem like 0 books, 1 book, 2 of the same book, 2 of different books, etc. We looked at the discount schedule and quickly came up with a simple function that produced the expected results in all of these cases. Here’s the discount schedule:

![image](<> "image")

Here’s our simple GetDiscount() function (v1):

```
<span style="color: #0000ff">private</span> <span style="color: #0000ff">decimal</span> GetDiscount(<span style="color: #0000ff">int</span> uniqueBooks)
{

    <span style="color: #0000ff">return</span> uniqueBooks * .05m;
}
```

Now, we didn’t specifically test this method – we only tested the larger function that calls this one, and until the end of the kata, we only tested the low numbers of books, and everything worked fine. However, if I were to do this kata again, I would certainly place the discount table implementation into its own class that I could easily test, and I would test the boundary conditions. At the very least, I would test the first and last numbers in the table to ensure that my algorithm was correct. In this case, our implementation failed for numbers of unique books greater than 4, because the discount amount makes a jump from 15% to 25% (skipping 20%) at that point. This is also the reason why the algorithm for selecting the best combination of books is non-trivial, because at a certain point it becomes better to group the books one way versus another.

Our incorrect implementation of GetDiscount early on in the kata cost us a few minutes of troubleshooting later on when we were trying to optimize the price calculator to deal with large numbers of books and sets.

**Lesson Two – Try To Test Incremental Operations (Spoiler)**

The other thing we sort of figured out as we went round and round trying to come up with a way to choose the best way to group a collection of books into numerous sets of unique book titles (maximizing discounts and thus overall cost for the whole sale) was to consider the addition of each book as a separate incremental operation, and strive for the lowest increase in overall cost. Our design had evolved to include a BookSet, which represented a set of unique books. Our price calculator took in the overall collection of books and arranged them into a collection of BookSets, creating new ones as required, and attempting to produce the optimal discount. This worked splendidly until we tried to do the example given in the kata, at which point our solution failed to yield the correct answer, because it was too eagerly filling one BookSet despite the fact that a larger net discount was to be had by adding a book to the other set.

The solution we came up with, which works but which of course may not be optimal in all situations, was to create a new method on BookSet that would let us know the marginal increase in price for the set given the addition of one more unique book. Thus we added GetNextBookMarginalPrice() to the set, which would calculate the price for a set of N+1 books, subtract the current set of N books price, and return the result. Now, given several existing BookSets in our current calculator instance, we can select the right one to add a new unique book to (assuming there are multiple sets that don’t already have that title in them) by ordering by the marginal cost. This is easily done using LINQ like so:

```
var candidateSets = bookSets.Where(d =&gt; !d.Exists(book));
<span style="color: #0000ff">if</span> (candidateSets.Any())
{
    var setToUse = candidateSets.OrderBy(

        s =&gt; s.GetNextBookMarginalPrice()).First();

    setToUse.Add(book);

}
```

**Summary**

The whole purpose of running through coding exercises and/or katas is to learn new techniques and improve your skills – to get outside of your comfort zone. I’m certain that I could stand to run through the Harry Potter kata a few more times to really nail the things that tripped me up this time. I think I’d only done it once before at a [Hudson Software Craftsmanship](http://hudsonsc.com/) meeting probably back in 2009, and I’m pretty sure I just added a special case to get the thing to work, which wasn’t nearly as elegant as sorting by the marginal increase in cost that adding to a given set would represent. I thought that was a fairly elegant solution to the problem, and it’s a technique I want to try and remember in the future, since the path we were going down of trying to deal with O(n^2) possible combination of unique books into sets was stymying us.