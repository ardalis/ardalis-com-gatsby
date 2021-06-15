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
public void EmptyCartShouldCostZero()
{
...
}

[Test]
public void CartWithOneBookShouldCostEightEuros()
{
...
}

[Test]
public void CartWithTwoOfSameBookShouldCost16Euros()
{
...
}

[Test]
public void CartWithTwoDifferentBooksShouldCost1520Euros()
{
    // Arrange
    var cart =new Cart();
    var book = new Book("One");
    var book2 = new Book("Two");
    cart.AddBookToCart(book);
    cart.AddBookToCart(book2);

    // Act
    var totalPrice = cart.GetTotalPrice();
    const decimal expectedCost = 2 * 8.0m * .95m;

    // Assert
    Assert.AreEqual(expectedCost, totalPrice);
}
```

At this point it’s possible to do the calculation work simply based on the total number of distinct titles in the cart. However, the next test is much harder:

```
[Test]
public void PriceCalculatorYields2320With2SameAnd1DifferentBooks()
{
    // Arrange
    var books = new List<CartItem>()
                    {
                        new CartItem(new Book("A"), 2),
                        new CartItem(new Book("C"), 1)
                    };

   // Act
    var totalPrice = new PriceCalculator().CalculatePrice(books);

    // Assert
    Assert.AreEqual(23.20m, totalPrice);
}
```

Note that at this point we moved the logic of calculating discounts into its own class, which we pass into our Cart (but which we can test in isolation from the cart, as shown here). This test required substantial rework of the calculation bits, because it was no longer sufficient to just multiply the total book quantity times the discount based on distinct titles.

The last test is the hardest one, and represents the acceptance test given in the Kata itself:

```
[Test]
public void PriceCalculatorYields5120WithGivenCartLoadOfBooks()
{
    // Arrange
    var books = new List<CartItem>()
                    {
                        new CartItem(new Book("A"), 2),
                        new CartItem(new Book("B"), 2),
                        new CartItem(new Book("C"), 2),
                        new CartItem(new Book("D"), 1),
                        new CartItem(new Book("E"), 1)
                    };

    // Act
    var totalPrice = new PriceCalculator().CalculatePrice(books);

    // Assert
    Assert.AreEqual(51.20m, totalPrice);
}
```

We were tight on time and one of the few pairs to get a working solution, so this code is still quite rough and would need additional tests and refactoring, but it works for this specific case. The main logic of the problem ended up all being in the PriceCalculator class shown below:

```
public class PriceCalculator : IPriceCalculator
{
    public const decimal BOOKPRICE = 8.0m;
    
    public decimal CalculatePrice(IEnumerable&lt;CartItem&gt; items)
    {
        List<Book> bookSet = new List<Book>();
        var totalPrice = 0.0m;
        do
        {
            bookSet = GetUniqueBookSet(items);
            totalPrice += CalculateUniqueSetPrice(bookSet);
        } while (bookSet.Count > 0);

        return totalPrice;
    }

    private List<Book> GetUniqueBookSet(IEnumerable<CartItem> items)
    {
        var bookSet = new List<Book>();

        var itemsOrderedByCount = items.OrderByDescending(x => x.Quantity).Where(x => x.Quantity > 0);

        foreach (var item in itemsOrderedByCount)
        {
            if (items.ToList().Count > 3)
            {
                if (item.Quantity> 1)
                {
                    AddBookToSet(item, bookSet);
                }
                if (bookSet.Count == 3 && item.Quantity == 1)
                {
                    AddBookToSet(item, bookSet);
                }
            }
        }
        if (bookSet.Count > 0) {return bookSet;}    
    
        foreach (var item in itemsOrderedByCount)
        {
            if (item.Quantity > 0)
            {
                AddBookToSet(item, bookSet);
            }
        }
        return bookSet;
    }

    private void AddBookToSet(CartItem item, List<Book> bookSet)
    {
        bookSet.Add(item.Book);
        item.Quantity--;
    }

    public decimal CalculateUniqueSetPrice(IEnumerable<Book> books)
    {
        var count = books.Count();
        var discountMultiple = 1.0m;
        switch (count)
        {
            case 2:
                discountMultiple = 0.95m;
                break;
            case 3:
                discountMultiple = 0.90m;
                break;
            case 4:
                discountMultiple = 0.80m;
                break;
            case 5:
                discountMultiple = 0.75m;
                break;
        }
        return count * discountMultiple * BOOKPRICE;
    }
}
```

I’m pretty happy with the CalculateUniqueSetPrice() method; it’s clean and easy to follow. Likewise, CalculatePrice() is pretty easy to follow as well, though I’m not sure it’s as clear as it could be at expressing what it’s doing, which is pulling out sets of unique book titles and pricing each one. The actual logic for how it does the grouping of books into sets is in the big ugly GetUniqueBookSet method, which is full of magic numbers and inscrutable nested if statements. It’s nasty. If the discount schedule were to change such that the biggest jump in the discount schedule was not between 3 and 4 different titles, this method would break bigtime. But it works.

Note that we only ever group our collection of titles into sets once. This program has no intelligence or built-in optimization – that was all done by humans (we figured out that the magic number 3 was the threshold value). The more interesting problem to solve is one which works for any given discount schedule, by grouping the titles into sets in a variety of ways and seeing which resulted in the best price. One other pair did something close to this and completed the problem, and at least one other pair was working on a brute force approach that would literally try every possible set combination to see which resulted in the best price.

A simple way to discover the minimum optimal number of books to have per set (4 in this case), one could run through the discount schedule looking for the biggest gaps/differences. With the given schedule, the difference of 10% when going from 3 titles to 4 titles would be the largest (every other difference is only 5%). This calculation could be inserted to replace the magic number 3 in my implementation.

I’d also want to move from foreach() and nested ifs to LINQ and lamba expressions. I spent a little time trying this approach, but couldn’t get some of the syntax to work so ended up falling back to the familiarity of foreach() and if(). Still another option, not exclusive of this approach, would be to create a BookSet class which was capable of calculating its price, which would eliminate one of the responsibilities of PriceCalculator, which currently violates SRP because it is responsible for grouping books into sets as well as pricing such sets.

Anyway, it’s a fun kata if you want to give it a shot. If I have time to do it again on my own and to arrive at a more elegant solution, I’ll be sure to post it.
