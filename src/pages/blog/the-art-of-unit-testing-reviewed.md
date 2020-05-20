---
templateKey: blog-post
title: The Art of Unit Testing Reviewed
path: blog-post
date: 2012-09-30T21:54:00.000Z
description: I recently finished reading Roy Osherove’s The Art of Unit Testing.
  I was kind of splitting my time reading it and Growing Object Oriented
  Software Guided by Tests, which I just recently reviewed as well. One nice
  thing about this book is that it comes with an eBook once you register it with
  Manning.
featuredpost: false
featuredimage: /img/test-13394.jpg
tags:
  - book
  - review
  - tdd
category:
  - Software Development
comments: true
share: true
---
[](http://amzn.to/PHbXUU)I recently finished reading Roy Osherove’s [The Art of Unit Testing](http://amzn.to/PHbXUU). I was kind of splitting my time reading it and [Growing Object Oriented Software Guided by Tests, which I just recently reviewed](http://ardalis.com/growing-object-oriented-software-guided-by-tests-book-review) as well. One nice thing about this book is that it comes with an eBook once you register it with Manning.

![](/img/unit-testing.jpg)

Overall, I think this is a great book on unit testing. Roy is certainly well-qualified to write on this topic, and he does an excellent job of describing how to get started with unit testing, how to get the necessary tools, and how to write your first test. As the book proceeds, he goes into more detail on how to break dependencies and use mock objects, how to organize tests, and what separates good tests from bad.

Part 3, chapter 7, starts with “we’ll look at the three basic pillars of good unit tests – readability, maintainability, and trustworthiness… if you only read one chapter in the book, this should be it.” I’m not sure how anybody intent on reading just one chapter is supposed to know to jump to page 139, read this sentence, and then start reading chapter 7 (which starts on page 171). If the author really feels the most important content is what’s in chapter 7, there’s probably a case to be made for re-organizing the table of contents.

That said, I do think Roy’s three pillars provide a great set of guidelines for writing good unit tests. I also agree that the first-order organization for tests should be “fast tests” and “slow tests,” which usually correlates to unit tests and integration (or other) tests.

When writing the book, Roy was working at TypeMock, and so there are numerous locations in the book wherein he points out certain features of TypeMock’s Isolator product. I think this was done well and that he generally did a good job of pointing out his relationship to the product, though I admit by the end of the book I was feeling like “yes, Roy, I know, you work there…” TypeMock Isolator and Telerik (where I now work, while we’re talking about full disclosure…) JustMock both provide features for mocking out tightly coupled code, like static method calls or in-method instantiated classes. Some even argue that having such tools available make it unnecessary to spend additional effort trying to write “testable” code, and Roy covers this discussion in chapter 8, along with other issues you may grapple with as you try to bring testing into an organization that hasn’t done much of it before.

There’s a great table in chapter 8 that shows some actual data on how writing unit tests affected the time spent on a feature. It’s a rare look at comparing apples-to-apples because the two features written were nearly the same size and the teams were roughly at the same skill and experience level. The simple result of the experiment showed that without tests, the feature was implemented in 7 days, while with tests it took 14 days. However, the no-tests feature took 7 days to integrate and required 12 more days of QA-bugfix time, while the with-tests feature took just 2 days to integrate and 8 more days of QA-bugfix time. Finally, after release, the no-tests feature had 71 bugs reported from production; the with-tests feature had 11. So the idea that writing tests takes longer is true, but the ROI on that investment comes pretty quickly (at least in this case, based on real data).

Roy also mentions his tool, [Depender](http://osherove.com/blog/2008/7/5/introducing-depender-testability-problem-finder.html), in the book at the end (in the tools section, no less). I haven’t used this tool before, but it’s on my list to try out now.

Finally, I’m not sure if Roy still follows his test naming convention he lays out in the book (p210), but that’s one area where I would disagree. His convention is basically METHODNAME_SCENARIO_BEHAVIOREXPECTED. He doesn’t really take a stance on what a test’s containing class should be named. Personally, I prefer a more BDD-style of naming, and one that takes advantage of the class name, as well as some Single Responsibility Principle for the test class. I’ve detailed my [unit test naming convention](http://ardalis.com/unit-test-naming-convention) elsewhere, but essentially I set up the scenario in the class name and end the class name with “should” and then have each test finish the sentence with the expected behavior. For example, a pricing calculator that yields a special discount for preferred customers might have a test class called “PricingCalculatorGivenPreferredCustomerShould” and a method “ReturnZeroGivenQuantityZero”. Whether or not the various parameters (“Givens”) belong in the class or the method is mainly a matter of taste. In this case, testing behavior of the system for preferred customers vs. regular customers makes more sense to me in terms of business rules than exception cases for out-of-range quantities.

Have you read The Art of Unit Testing? What did you think of it? Let us know in the comments below.