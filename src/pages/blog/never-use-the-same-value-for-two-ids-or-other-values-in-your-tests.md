---
templateKey: blog-post
title: Never use the same value for two IDs (or other values) in your tests
path: blog-post
date: 2020-05-13T01:29:00.000Z
description: When you're writing automated tests, whether you're following TDD
  or not, you want to avoid the possibility of testing the wrong thing. This is
  surprisingly easy to do if you're not careful, I can say from personal
  experience!
featuredpost: false
featuredimage: /img/tests.png
tags:
  - clean code
  - refactoring
  - tdd
  - tests
  - unit testing
category:
  - Software Development
comments: true
share: true
---
When you're writing automated tests, whether you're following TDD or not, you want to avoid the possibility of testing the wrong thing. This is surprisingly easy to do if you're not careful, I can say from personal experience! One way this can easily happen is if you're quickly writing a series of tests, and doing so using[copy-paste programming](https://deviq.com/copy-paste-programming/), like you might see here:

```csharp
[Fact]
public void ReducesNormalItemQualityBy1()
{
    var normalItem = new Item { Name = "Normal Item", Quality =      10, SellIn = 10 };

    var service = new GildedRose(new List&lt;Item> { normalItem });
    service.UpdateQuality();
    Assert.Equal(9, normalItem.Quality);
}
```

```csharp
[Fact]
public void ReducesNormalItemSellInBy1()
{
    var normalItem = new Item { Name = "Normal Item", Quality = 10, SellIn = 10 };

    var service = new GildedRose(new List&lt;Item> { normalItem });
    service.UpdateQuality();
    Assert.Equal(9, normalItem.Quality);
}
```

This is from one of my favorite refactoring [katas](https://github.com/ardalis/kata-catalog), the Gilded Rose. Do you see the problem?

Of course, there are actually a few problems in the above block of code, but one of them has to do with the fact that the test in the second case passes, even though it's not actually testing what its name says it is. That's because the assertion wasn't updated when it was copied from the previous test, and so it's not actually checking the SellIn property, but rather the Quality property (again).

This problem could still have happened even if we used different values for the two properties' starting values, but it would have been easier to pick out since the 9 should have been obviously the wrong thing to be checking for.

## What about IDs?

If you use integer IDs, this same problem frequently occurs. Let's say you have Customers and Orders each with IDs. If you just use 1 or 123 or something as your test ID value for both customers and orders, then you won't have as much confidence that there isn't a transposition error somewhere in your code (either test code or production code) when you're making assertions.

Consider this test code:

```csharp
[Fact]
public void ReturnsNewOrderForCustomer()
{
  int testOrderId = 123;
  int testCustomerId = 123;
  var service = new OrderService();
  var order = service.CreateOrderForCustomer(testOrderId,   testCustomerId);
Assert.Equal(testCustomerId, order.CustomerId);
Assert.Equal(testOrderId, order.Id);
}
```

Look carefully at the above code. It looks fine, right? Aside from the reuse of the magic number 123, it is fine. But it doesn't catch a bug in the system under test:

```csharp
public class OrderService
{
  public Order CreateOrderForCustomer(int newOrderId, int customerId)
  {
  return new Order { Id = customerId, CustomerId = customerId };
  }
}
```

Note in the return statement above, the new Order's Id is being set, presumably incorrectly, to the customerId argument, not the newOrderId argument. A unit test should easily have detected this problem, but reuse of test values let it slip by.

At this point most organizations have realized that automated testing is a worthwhile endeavor. This should be obvious since the alternative is some kind of repetitive manual testing, and technical workers are expensive and getting more expensive while computer time is cheap and getting cheaper. Computers are really good at executing repetitive tasks like unit tests, but we need to be careful to ensure we're writing good tests. I'll try to post more tips like these here, but if you're looking for more right now, check out [my module on Environment and Testing Code Smells in my (older) Refactoring Fundamentals course on Pluralsight](https://www.pluralsight.com/courses/refactoring-fundamentals). Thanks!
