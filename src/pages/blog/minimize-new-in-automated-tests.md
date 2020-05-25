---
templateKey: blog-post
title: Minimize new in Automated Tests
date: 2019-08-07
path: /minimize-new-in-automated-tests
featuredpost: false
featuredimage: /img/minimize-new-in-automated-tests.png
tags:
  - quality
  - refactoring
  - tdd
  - testing
category:
  - Software Development
comments: true
share: true
---

Automated tests have gained a lot of acceptance in recent years. Not long ago, many organizations bristled at the notion of having their expensive developers spend time writing code that wasn't actually going to ship to production, but instead would just verify that the "real" code worked. Today, the idea that testing in many instances is something computers can do very effectively - and cost effectively - relative to human testers (or, \*cough\* users) has gained general acceptance. And so, a lot more tests are being written. Which means a lot more teams are running into common testing quality problems. One of these is overuse of the 'new' keyword in your tests.

## new is Glue

If you haven't seen it before, I encourage you to quickly read my article, [New is Glue](https://ardalis.com/new-is-glue), which covers why using new in your application code is something you should do with care. Not that you shouldn't ever use it, obviously. Just that you should have some awareness of its impact on coupling when you do. This impact extends to your tests, and if you're going to write a lot of tests you want them to be maintainable, and that correlates with being loosely coupled.

## new in Tests

A very common pattern I typically follow when writing tests is Arrange-Act-Assert, or AAA. You'll often see test template that include comments for these different parts of each test, like so:

```
public void TestMethod()
{
    // Arrange

    // Act

    // Assert
}
```

Once you know the pattern, you can delete the comments - they're not adding any value. The benefit of this is that your tests all get 3 lines shorter, which should be a big % drop since they should be very short already. But I digress.

The instantiation of the classes that are to be tested - the "System Under Test" or SUT - should happen in the Arrange step, typically. However, some "arranging" can also happen during a common test setup stage, either using the \[SetUp\] attribute in NUnit or (preferably) using the constructor in xUnit. **Typically, you want to start out with the simplest thing that can work - create an instance as a local variable - and then refactor when you see duplication.**

One way to get better a writing unit tests is through deliberate practice. [I have a small collection of katas that can be used for this purpose](https://github.com/ardalis/kata-catalog). One of my favorites is [Roy Osherove's String Calculator kata](https://github.com/ardalis/kata-catalog/blob/master/katas/String%20Calculator.md). After writing tests for the first few requirements you might have code like this:

```
public class CalculatorAdd
{
    [Fact]
    public void Returns0GivenEmptyString()
    {
        var calculator = new Calculator();

        var result = calculator.Add("");

        Assert.Equal(0, result);
    }

    [Fact]
    public void Returns0GivenSingle0String()
    {
        var calculator = new Calculator();

        var result = calculator.Add("0");

        Assert.Equal(0, result);
    }

    [Fact]
    public void Returns1GivenSingle1String()
    {
        var calculator = new Calculator();

        var result = calculator.Add("1");

        Assert.Equal(1, result);
    }
}
```

There's quite a bit of structural repetition here, and there are other techniques I'll get into to address some of that, but for now let's just focus on the 100% duplicated lines of code:

```
var calculator = new Calculator();
```

Is this a problem? Some would argue that each test is more clear because it contains all of the code required. You don't need to go looking elsewhere to see where the SUT is created or configured. There's some truth to this, and it's why you should be consistent in your approach to creating and configuring the SUT in your test suite. As long as you always do things the same way in a given codebase, it should be pretty easy for developers to figure out what's going on. Also, in terms of ease of understanding, you should refactor to the next closest location to centralize the information rather than jumping to something farther away. What I mean by this is, if you have a bunch of local variables, the next closest place to put them is in a class field or a local helper method, not a separate class (a base class or a static class, for instance). Let's look at that in a moment.

Back to the question, is it a problem, I argue it is. Why is it a problem? Because it needlessly increases the cost of making changes to your SUT. If you need to add an argument to the constructor of the SUT, you must now change N different tests as part of that change. The cost of that change just increased dramatically. As a result, you will either spend more time on that change, or you will spend time researching things you could do instead of making the change because you don't want to have to change all of those tests, and possibly you'll end up making a less optimal change as a result because it's less work than the ideal change would have been.

**Having new sprinkled all over your test suite is technical debt in your tests.**

## Refactor to Centralize Creation

There are two typical ways to centralize creation of the objects you need in your tests - constructor/setup method and helper method. I generally prefer the former unless I need to pass parameters to the object's constructor that vary within the tests, in which case I'll go with the latter (or [use the builder pattern](https://ardalis.com/improve-tests-with-the-builder-pattern-for-test-data), which I'm now fond of for this scenario).

Here's the same test suite refactored to create the SUT in its constructor.

```
public class CalculatorAdd
{
    private Calculator _calculator;

    public CalculatorAdd()
    {
        _calculator = new Calculator();
    }

    [Fact]
    public void Returns0GivenEmptyString()
    {
        var result = _calculator.Add("");

        Assert.Equal(0, result);
    }

    [Fact]
    public void Returns0GivenSingle0String()
    {
        var result = _calculator.Add("0");

        Assert.Equal(0, result);
    }

    [Fact]
    public void Returns1GivenSingle1String()
    {
        var result = _calculator.Add("1");

        Assert.Equal(1, result);
    }
}
```

Of course we don't actually need a separate constructor method in this case. Instead we can just initialize the \_calculator instance inline:

```
public class CalculatorAdd
{
    private Calculator _calculator = new Calculator();

    [Fact]
    public void Returns0GivenEmptyString()
    {
        var result = _calculator.Add("");

        Assert.Equal(0, result);
    }

    [Fact]
    public void Returns0GivenSingle0String()
    {
        var result = _calculator.Add("0");

        Assert.Equal(0, result);
    }

    [Fact]
    public void Returns1GivenSingle1String()
    {
        var result = _calculator.Add("1");

        Assert.Equal(1, result);
    }
}
```

Notice that now all of our tests are 2 lines instead of 3 - a 33% reduction! And yes, real tests in real business applications can be very short like this if you build your applications using [SOLID principles](https://www.pluralsight.com/courses/csharp-solid-principles) and you [refactor to improve the design of your system](https://www.pluralsight.com/courses/refactoring-fundamentals) as you build it. And as I mentioned, this isn't the end of how I would refactor these tests, but it is the end of this article so additional steps will be covered in another article.

You can [grab the source for the kata implementation shown here from this GitHub repo](https://github.com/ardalis/StringCalculatorKata2019). If you want to see how the tests evolve, you can use [GitHistory using this url](https://github.githistory.xyz/ardalis/StringCalculatorKata2019/blob/master/CalculatorAdd.cs). It will let you step through each change.

## Challenge

Do a search in your codebase for how many places you use `new Foo(` where Foo is some heavily used (and hopefully heavily tested) class in your application. Now think about how hard (or easy!) it would be for you to modify that class's constructor to accept a new required parameter. How many places would you need to provide this new parameter? Is there any way you could reduce this number without negatively impacting your code?
