---
templateKey: blog-post
title: "Mastering Unit Tests in .NET: Best Practices and Naming Conventions"
date: 2023-08-24
description: "Dive into the world of .NET unit tests with this comprehensive guide. Understand the qualities of effective unit tests, and explore the best naming conventions that make your test code readable and maintainable." 
path: blog-post
featuredpost: false
featuredimage: /img/mastering-unit-tests-dotnet-best-practices-naming-conventions.png
tags:
  - .NET
  - dotnet
  - unit testing
  - naming conventions
  - software development
  - test automation 
  - best practices
  - quality assurance
  - software testing
  - code maintainability
  - xUnit
  - NUnit
category:
  - Software Development
comments: true
share: true
---

Unit testing is a crucial part of modern software development. It ensures that code is working as intended and can be a lifesaver when refactoring or adding new features. It's like having a friendly guard dog that barks if anything suspicious is going on in your code! In the context of .NET, there are some unique considerations and tools that can help make your unit tests even more effective. In this article, we'll explore the essential qualities of good unit tests and delve into the naming conventions that make your test code clear and expressive.

## Essential Qualities of Good Unit Tests

Below is my list of essential qualities of good unit tests. Check out this thread for more from folks on Xitter:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Name one quality all unit tests should have. Reply or QT.<a href="https://twitter.com/hashtag/tdd?src=hash&amp;ref_src=twsrc%5Etfw">#tdd</a> <a href="https://twitter.com/hashtag/testing?src=hash&amp;ref_src=twsrc%5Etfw">#testing</a> <a href="https://twitter.com/hashtag/dev?src=hash&amp;ref_src=twsrc%5Etfw">#dev</a> <a href="https://twitter.com/hashtag/agile?src=hash&amp;ref_src=twsrc%5Etfw">#agile</a></p>&mdash; Steve &quot;ardalis&quot; Smith (@ardalis) <a href="https://twitter.com/ardalis/status/1692207963912421628?ref_src=twsrc%5Etfw">August 17, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### Clarity and Readability

Clarity is the key to any good relationship, including the one between developers and their code. Write expressive test names, follow the Arrange, Act, and Assert (AAA) pattern, and use frameworks like xUnit (my preference) or NUnit that integrate well with .NET. Your future self will thank you when they're not scratching their head trying to figure out what the test does.

### Simplicity

As mentioned above, unit tests should follow the AAA pattern. This pattern helps keep your tests simple and focused. It also makes it easier to identify the cause of a failure. When following this pattern, ideally your test should have a very small Arrange section, a single Act, and a single Assert. If you find yourself writing a lot of code in your test, consider refactoring it into a separate method or class. This will help keep your tests simple and focused.

Your tests should be simple in terms of complexity as well. The cyclomatic complexity of a unit test should always be 1. This means that there should be no branching logic in your test. If you find yourself writing a lot of if/else statements in your test, consider refactoring it into a separate method or class. This will help keep your tests simple and focused.

Complexity in your software is the main thing unit tests verify is correct. If you have branching logic in your tests, you should probably write unit tests to verify its correctness, and you **really* don't want to be writing tests that require tests (that require tests...).

### Isolation

Unit tests should run independently. They shouldn't depend on other tests, and they shouldn't depend on external dependencies. They should only depend on the code they're testing, in process. Tests that rely on external dependencies are more likely to fail, and they're also slower to run. They're also often much harder to run in parallel, which can be a big deal if you have a lot of tests.

Utilize Dependency Injection and mocking frameworks like [NSubstitute](https://nsubstitute.github.io/) (when needed) to keep your tests independent and focused.

### Repeatability

If your tests are giving you different results every time you run them, then they're dancing to their own tune. Tests should provide the same result each time, avoiding reliance on real-time data that can change. Consistency is key; it's the secret sauce to reliable tests. We'll talk about consistency *between* tests below, but here we mean consistent, deterministic behavior over time for a given test. Don't write tests that run differently depending on the time of day, the phase of the moon, or the weather outside. Ideally, they should also run the same on any machine, but that's not always possible.

### Fast Execution

Slow tests are like waiting for your toast to pop; it's frustrating and makes you late for work. Minimize I/O operations, and run tests in parallel where possible. Your *unit* tests, especially, should be incredibly quick to run. Integration tests, functional tests, end to end tests, etc may take longer. But unit tests should be fast. If they're not, you're probably doing something wrong.

### Maintainability

A well-maintained garden is a joy to behold, and the same applies to your unit tests. Keep them pruned and tidy. Use descriptive names, maintain consistency across your test suite, and refactor when necessary. Remember, chaos in your tests can lead to chaos in your code.

One key thing to remember is that you should minimize duplication of interactions with the System-Under-Test (SUT) in your tests. The biggest one to watch for is `new` for the SUT, since it's very common to add additional dependencies later, which will require you to update all of your tests. Instead, use a factory method to create the SUT, and then update that in one place when you need to add a dependency.

### Coverage

A test that doesn't cover anything is like an umbrella full of holes on a rainy day. Yes, it is possible to write tests that don't actually test anything in the SUT (especially if you're mocking lots of things). First, ensure your tests are doing what you think, and that you can verify they fail when you expect them to. Then worry about test coverage.

 Ensure that you have good test coverage but don't waste time trying to get to 100%. The most complicated parts of your code are the places that gain the most from automated test coverage. Auto properties and one-line methods with no conditional logic are very unlikely to fail, so the ROI on writing tests is much lower. Focus on critical paths and business logic.

 If you are looking into test coverage, [consider whether you're measuring line coverage or branch coverage](https://ardalis.com/which-is-more-important-line-coverage-or-branch-coverage/), and look at using a tool to combine coverage between kinds of tests (unit, integration, etc.). If your unit tests cover 20% of your code and your integration tests cover 20% of your code, what can you say about your total test coverage? You can't add them together, but you can use a tool like [ReportGenerator](https://www.nuget.org/packages/ReportGenerator) to combine them and get a more accurate picture of your total coverage.

## Naming Conventions for Unit Tests in .NET

Naming conventions in unit tests help ensure consistency and should let you know immediately what is broken when a test fails. Here are some styling tips for your .NET unit test names:

### ClassNameMethodName.DoesXGivenY

My current favorite, this convention yields one test *class* per SUT *method*. In many cases this will be combined with a folder per SUT class, in which case you can drop the SUT class name from the test fixture name.

Examples:
```csharp
// no folders for classes
CalculatorAdd.cs
CalculatorDivide.cs
// etc.

// folders for classes
CalculatorTests\Add.cs
CalculatorTests\Divide.cs
// etc.
```

**NOTE:** Do not name your test fixtures `CalculatorTests.cs` since this name doesn't really provide much value. The reason to use it as a folder name is so that the resulting namespace (if you use the common convention of matching namespaces to folders) will not conflict with the SUT class name.

Here are some example method names for the `CalculatorTests\Add.cs` class:

```csharp
ReturnsPositiveSumGivenTwoPositiveNumbers()
ReturnsNegativeSumGivenTwoNegativeNumbers()
ReturnsZeroGivenTwoZeroes()
ThrowsArgumentExceptionGivenInvalidValues()
// etc.
```

If you prefer underscores you can use them to separate sections of the name. Example: `Add_WhenTwoPositiveNumbers_ResultIsPositive`.

### Given_Precondition_When_Action_Then_ExpectedResult

A perfect choice for the Behavior-Driven Development (BDD) aficionados. Example: `Given_TwoPositiveNumbers_When_Adding_Then_ReturnPositiveSum`. Note that Given/When/Then maps pretty much 1:1 with Arrange/Act/Assert, so you can use either of these conventions with the other.

### Consistency and Clarity

Whether you're attending a black-tie event or a backyard barbecue, consistency in your naming conventions is key. Collaborate with your team, pick a style, and stick with it. And remember, cryptic test names are like a mystery novel without a plot; they leave everyone confused.

## Conclusion

Whether you're a seasoned .NET developer or just starting, these guidelines can help you write unit tests that are clear, efficient, and maintainable. Remember, a well-written test is like a good joke; it gets to the point and makes everyone's life a little better.

### References

- Beck, K. (2002). *[Test-Driven Development: By Example](https://amzn.to/44kPAz3)*. Addison-Wesley Professional. Affiliate link.
- Fowler, M. (2019). ["Unit Test," *martinfowler.com*](https://martinfowler.com/bliki/UnitTest.html).
- xUnit.net. (n.d.). ["Getting started with xUnit.net (.NET Core / ASP.NET Core)"](https://xunit.net/docs/getting-started/netcore/cmdline).
- NUnit Documentation. (n.d.). ["NUnit Documentation"](https://docs.nunit.org/).
- Osherove, R. (2009). *[The Art of Unit Testing: with Examples in .NET](https://amzn.to/3Pd1Q0v)*. Manning Publications. Affiliate link.
- Microsoft. (n.d.). ["Unit Test Basics," *Microsoft Docs*](https://docs.microsoft.com/en-us/visualstudio/test/unit-test-basics).

### Further Reading

- [Naming Conventions in Unit Testing](https://ardalis.com/unit-test-naming-convention/)

### Share

**Found value in these insights?** Share this article with fellow developers and quality assurance pros! Let's help improve the state of automated testing in .NET and the industry overall!
