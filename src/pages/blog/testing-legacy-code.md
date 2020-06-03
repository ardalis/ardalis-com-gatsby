---
templateKey: blog-post
title: Testing Legacy Code
path: blog-post
date: 2008-08-27T03:00:00.000Z
description: Oren wrote today about a fun problem he’d run into with trying to
  TDD some changes to some code about which many of his assumptions were proving
  incorrect. The problem is that each test he wrote that verified one of his
  assumptions needed to later be fixed when he found the underlying assumption
  wasn’t true.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - testing
category:
  - Uncategorized
comments: true
share: true
---
[![vice](/img/vice.jpg)](http://www.overstock.com/Auto-Parts/5-inch-Multi-Purpose-Vise/2653972/product.html) 

Oren wrote today about [a fun problem he’d run into with trying to TDD some changes to some code](http://ayende.com/Blog/archive/2008/08/27/Legacy-Driven-Development.aspx) about which many of his assumptions were proving incorrect. The problem is that each test he wrote that verified one of his assumptions needed to later be fixed when he found the underlying assumption wasn’t true. The result was a lot of thrashing and not a lot of productivity. The solution in this case for him was to worry first about just **verifying that the code does what it does**.

This caught my eye because yesterday I was talking about this very thing with Brendan and the name used by Feathers in [Working Effectively with Legacy Code](http://www.amazon.com/exec/obidos/ASIN/0131177052/aspalliancecom) (my[review](http://aspadvice.com/blogs/ssmith/archive/2008/05/13/Book_3A00_-Working-Effectively-With-Legacy-Code.aspx)) eluded me. And of course, that’s been bugging me ever since but I lent my copy to another developer. So Oren’s post finally forced me to look it up – the Software Vise.

## Software Vise

*When we have tests that detect change, it is like having a vise around our code. The behavior of the code is fixed in place. When we make changes, we can know that we are changing only one piece of behavior at a time. In short, we’re in control of our work.*

In short, when you have no tests and you’re working with legacy code that you don’t fully understand, a good place to start is to write tests that simply confirm that whatever the code does, it keeps on doing. These are often referred to as **characterization tests**, and [I discuss them further in my Pluralsight courses on Refactoring](https://app.pluralsight.com/profile/author/steve-smith).

