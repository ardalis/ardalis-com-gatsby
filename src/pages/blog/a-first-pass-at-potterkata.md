---
templateKey: blog-post
title: A First Pass at PotterKata
path: blog-post
date: 2009-10-20T20:00:00.000Z
description: Tonight at Hudson Software Craftsmanship, I paired with another
  group member and worked on the PotterKata for the first time. I’d seen Not
  Myself write about it a few days ago, which prompted me to suggest it for the
  group to work on summary of the meeting here.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - PotterKata
category:
  - Uncategorized
comments: true
share: true
---
Tonight at [Hudson Software Craftsmanship](http://hudsonsc.com/), I paired with another group member and worked on the [PotterKata](http://codingdojo.org/cgi-bin/wiki.pl?KataPotter) for the first time. I’d seen [NotMyself write about it](http://www.iamnotmyself.com/2009/10/20/UsingMSpecToSolveKataPotterPart1TheSpecifications.aspx) a few days ago, which prompted me to suggest it for the group to work on ([summary of the meeting here](http://hudsonsc.com/meetings/october-2009-meeting-recap)).

Briefly, this kata is a fairly real-world exercise in that it has to do with business rules for a shopping cart that are non-linear. In this case, the rules are:

> One copy of any of the five books costs 8 EUR. If, however, you buy two different books from the series, you get a 5% discount on those two books. If you buy 3 different books, you get a 10% discount. With 4 different books, you get a 20% discount. If you go the whole hog, and buy all 5, you get a huge 25% discount.
>
> Note that if you buy, say, four books, of which 3 are different titles, you get a 10% discount on the 3 that form part of a set, but the fourth book still costs 8 EUR.

Attentive readers will notice that there is no 15% discount – there’s a big jump from 3 different titles (10%) to 4 (20%). Because of this, it’s possible to calculate the discount incorrectly (that is, not optimized for the buyer), with a cart that includes 2 of each of 3 titles and 1 of each of the remaining 2. If you make it a set of 5 (25% off) and a set of 2 (5% off) your price will be higher than if you make it 2 sets of 4 (20% off all of them).

My partner and I set about TDDing this with these tests (the first 3 are easy so I left out the actual implementation):

```
[Test]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> EmptyCartShouldCostZero()
{
...
}
&#160;
[Test]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> CartWithOneBookShouldCostEightEuros()
{
...
}
&#160;
[Test]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> CartWithTwoOfSameBookShouldCost16Euros()
{
...
}
&#160;
[Test]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> CartWithTwoDifferentBooksShouldCost1520Euros()
{
&#160;
    <span style="color: #008000">// Arrange</span>
    var cart = <span style="color: #0000ff">new</span> Cart();
    var book = <span style="color: #0000ff">new</span> Book(<span style="color: #006080">&quot;One&quot;</span>);
    var book2 = <span style="color: #0000ff">new</span> Book(<span style="color: #006080">&quot;Two&quot;</span>);
    cart.AddBookToCart(book);
    cart.AddBookToCart(book2);
&#160;
    <span style="color: #008000">// Act</span>
    var totalPrice = cart.GetTotalPrice();
    <span style="color: #0000ff">const</span> <span style="color: #0000ff">decimal</span> expectedCost = 2 * 8.0m * .95m;
&#160;
    <span style="color: #008000">// Assert</span>
    Assert.AreEqual(expectedCost, totalPrice);
}
```

At this point it’s possible to do the calculation work simply based on the total number of distinct titles in the cart. However, the next test is much harder:

```
[Test]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> PriceCalculatorYields2320With2SameAnd1DifferentBooks()
{
&#160;
    <span style="color: #008000">// Arrange</span>
    var books = <span style="color: #0000ff">new</span> List&lt;CartItem&gt;()
                    {
                        <span style="color: #0000ff">new</span> CartItem(<span style="color: #0000ff">new</span> Book(<span style="color: #006080">&quot;A&quot;</span>), 2),
                        <span style="color: #0000ff">new</span> CartItem(<span style="color: #0000ff">new</span> Book(<span style="color: #006080">&quot;C&quot;</span>), 1)
&#160;
                    };
&#160;
    <span style="color: #008000">// Act</span>
    var totalPrice = <span style="color: #0000ff">new</span> PriceCalculator().CalculatePrice(books);
&#160;
    <span style="color: #008000">// Assert</span>
    Assert.AreEqual(23.20m, totalPrice);
}
```

Note that at this point we moved the logic of calculating discounts into its own class, which we pass into our Cart (but which we can test in isolation from the cart, as shown here). This test required substantial rework of the calculation bits, because it was no longer sufficient to just multiply the total book quantity times the discount based on distinct titles.

The last test is the hardest one, and represents the acceptance test given in the Kata itself:

```
[Test]
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> PriceCalculatorYields5120WithGivenCartLoadOfBooks()
{
&#160;
    <span style="color: #008000">// Arrange</span>
    var books = <span style="color: #0000ff">new</span> List&lt;CartItem&gt;()
                    {
                        <span style="color: #0000ff">new</span> CartItem(<span style="color: #0000ff">new</span> Book(<span style="color: #006080">&quot;A&quot;</span>), 2),
                        <span style="color: #0000ff">new</span> CartItem(<span style="color: #0000ff">new</span> Book(<span style="color: #006080">&quot;B&quot;</span>), 2),
                        <span style="color: #0000ff">new</span> CartItem(<span style="color: #0000ff">new</span> Book(<span style="color: #006080">&quot;C&quot;</span>), 2),
                        <span style="color: #0000ff">new</span> CartItem(<span style="color: #0000ff">new</span> Book(<span style="color: #006080">&quot;D&quot;</span>), 1),
                        <span style="color: #0000ff">new</span> CartItem(<span style="color: #0000ff">new</span> Book(<span style="color: #006080">&quot;E&quot;</span>), 1)
&#160;
                    };
&#160;
    <span style="color: #008000">// Act</span>
    var totalPrice = <span style="color: #0000ff">new</span> PriceCalculator().CalculatePrice(books);
&#160;
    <span style="color: #008000">// Assert</span>
    Assert.AreEqual(51.20m, totalPrice);
}
```

We were tight on time and one of the few pairs to get a working solution, so this code is still quite rough and would need additional tests and refactoring, but it works for this specific case. The main logic of the problem ended up all being in the PriceCalculator class shown below:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> PriceCalculator : IPriceCalculator
{
    <span style="color: #0000ff">public</span> <span style="color: #0000ff">const</span> <span style="color: #0000ff">decimal</span> BOOKPRICE = 8.0m;
    <span style="color: #0000ff">public</span> <span style="color: #0000ff">decimal</span> CalculatePrice(IEnumerable&lt;CartItem&gt; items)
    {
        List&lt;Book&gt; bookSet = <span style="color: #0000ff">new</span> List&lt;Book&gt;();
        var totalPrice = 0.0m;
        <span style="color: #0000ff">do</span>
        {
            bookSet = GetUniqueBookSet(items);
            totalPrice += CalculateUniqueSetPrice(bookSet);
        } <span style="color: #0000ff">while</span> (bookSet.Count &gt; 0);
&#160;
        <span style="color: #0000ff">return</span> totalPrice;
    }
&#160;
    <span style="color: #0000ff">private</span> List&lt;Book&gt; GetUniqueBookSet(IEnumerable&lt;CartItem&gt; items)
    {
        var bookSet = <span style="color: #0000ff">new</span> List&lt;Book&gt;();
&#160;
        var itemsOrderedByCount = items.OrderByDescending(x =&gt; x.Quantity).Where(x =&gt; x.Quantity &gt; 0);
&#160;
        <span style="color: #0000ff">foreach</span> (var item <span style="color: #0000ff">in</span> itemsOrderedByCount)
        {
            <span style="color: #0000ff">if</span> (items.ToList().Count &gt; 3)
            {
                <span style="color: #0000ff">if</span> (item.Quantity &gt; 1)
                {
                    AddBookToSet(item, bookSet);
                }
                <span style="color: #0000ff">if</span> (bookSet.Count == 3 && item.Quantity == 1)
                {
                    AddBookToSet(item, bookSet);
                }
            }
        }
        <span style="color: #0000ff">if</span> (bookSet.Count &gt; 0) {<span style="color: #0000ff">return</span> bookSet;}
&#160;
    
    
        <span style="color: #0000ff">foreach</span> (var item <span style="color: #0000ff">in</span> itemsOrderedByCount)
        {
            <span style="color: #0000ff">if</span> (item.Quantity &gt; 0)
            {
                AddBookToSet(item, bookSet);
            }
&#160;
        }
        <span style="color: #0000ff">return</span> bookSet;
&#160;
    }
&#160;
    <span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> AddBookToSet(CartItem item, List&lt;Book&gt; bookSet)
    {
        bookSet.Add(item.Book);
        item.Quantity--;
    }
&#160;
    <span style="color: #0000ff">public</span> <span style="color: #0000ff">decimal</span> CalculateUniqueSetPrice(IEnumerable&lt;Book&gt; books)
    {
        var count = books.Count();
        var discountMultiple = 1.0m;
        <span style="color: #0000ff">switch</span> (count)
        {
            <span style="color: #0000ff">case</span> 2:
                discountMultiple = 0.95m;
                <span style="color: #0000ff">break</span>;
            <span style="color: #0000ff">case</span> 3:
                discountMultiple = 0.90m;
                <span style="color: #0000ff">break</span>;
            <span style="color: #0000ff">case</span> 4:
                discountMultiple = 0.80m;
                <span style="color: #0000ff">break</span>;
            <span style="color: #0000ff">case</span> 5:
                discountMultiple = 0.75m;
                <span style="color: #0000ff">break</span>;
&#160;
        }
        <span style="color: #0000ff">return</span> count * discountMultiple * BOOKPRICE;
&#160;
    }
}
```

I’m pretty happy with the CalculateUniqueSetPrice() method; it’s clean and easy to follow. Likewise, CalculatePrice() is pretty easy to follow as well, though I’m not sure it’s as clear as it could be at expressing what it’s doing, which is pulling out sets of unique book titles and pricing each one. The actual logic for how it does the grouping of books into sets is in the big ugly GetUniqueBookSet method, which is full of magic numbers and inscrutable nested if statements. It’s nasty. If the discount schedule were to change such that the biggest jump in the discount schedule was not between 3 and 4 different titles, this method would break bigtime. But it works.

Note that we only ever group our collection of titles into sets once. This program has no intelligence or built-in optimization – that was all done by humans (we figured out that the magic number 3 was the threshold value). The more interesting problem to solve is one which works for any given discount schedule, by grouping the titles into sets in a variety of ways and seeing which resulted in the best price. One other pair did something close to this and completed the problem, and at least one other pair was working on a brute force approach that would literally try every possible set combination to see which resulted in the best price.

A simple way to discover the minimum optimal number of books to have per set (4 in this case), one could run through the discount schedule looking for the biggest gaps/differences. With the given schedule, the difference of 10% when going from 3 titles to 4 titles would be the largest (every other difference is only 5%). This calculation could be inserted to replace the magic number 3 in my implementation.

I’d also want to move from foreach() and nested ifs to LINQ and lamba expressions. I spent a little time trying this approach, but couldn’t get some of the syntax to work so ended up falling back to the familiarity of foreach() and if(). Still another option, not exclusive of this approach, would be to create a BookSet class which was capable of calculating its price, which would eliminate one of the responsibilities of PriceCalculator, which currently violates SRP because it is responsible for grouping books into sets as well as pricing such sets.

Anyway, it’s a fun kata if you want to give it a shot. If I have time to do it again on my own and to arrive at a more elegant solution, I’ll be sure to post it.