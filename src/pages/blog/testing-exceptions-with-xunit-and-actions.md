---
templateKey: blog-post
title: Testing Exceptions with xUnit and Actions
date: 2021-04-14
description: If a method you're writing throws exceptions under certain circumstances, such as through guard clauses or other expected conditions, be sure to write tests to verify this behavior. The xUnit test framework has great support for this, and using Actions helps make the tests cleaner.
path: blog-post
featuredpost: false
featuredimage: /img/testing-exceptions-xunit-actions.png
tags:
  - programming
  - testing
  - xunit
  - unit testing
category:
  - Software Development
comments: true
share: true
---

When you're writing unit tests for a method, it's a good idea to test various failure conditions ("sad paths") in addition to testing the expected, everything is working condition ("happy path"). In particular, if you have a method that may throw exceptions, especially if they're [custom domain exceptions](https://ardalis.com/prefer-custom-exceptions-to-framework-exceptions/), you should be sure you're testing this behavior. Another common source of exceptions is [guard clauses](https://deviq.com/design-patterns/guard-clause), which are used to keep your method clean while ensuring its inputs adhere to the method's expectations.

[Unlike NUnit, which mainly uses attributes for expected exceptions, and MSTest](https://xunit.net/docs/comparisons), which has little built-in support at all, xUnit provides an `Assert.Throws<T>` method that is used to test for expected exceptions ([NUnit 3 also has a similar method](https://docs.nunit.org/articles/nunit/writing-tests/assertions/classic-assertions/Assert.Throws.html)). A simple example looks like this:

```csharp
Customer customer = null;
Assert.Throws<NullReferenceException>(() => customer.LastName);
```

In addition to this simple usage, the method also returns the captured exception, so you can make additional assertions about the message or other properties of the exception:

```csharp
var customer = new Customer();

var caughtException = Assert.Throws<NameRequiredException>(() => customer.UpdateName("", ""));

Assert.Equal("A valid name must be supplied.", caughtException.Message);
```

## Arrange, Act, Assert and Exceptions

Many tests use the Arrange, Act, Assert, or AAA testing pattern. Using this approach, tests generally have this form:

```csharp
public class Customer_UpdateName
{
  [Fact]
  public void ThrowsExceptionGivenInvalidName
  {
    // Arrange

    // Act

    // Assert
  }
}
```

**Note:** Tests should be named to that when they fail, the combination of their class name and method name clearly indicates the expectation that was not met. [Read more about unit test naming conventions](https://ardalis.com/unit-test-naming-convention/).

Let's fill in the details from the `Customer.UpdateName()` test example, using the AAA template:

```csharp
public class Customer_UpdateName
{
  [Fact]
  public void ThrowsExceptionGivenInvalidName
  {
    // Arrange
    var customer = new Customer();

    // Act
    var caughtException = Assert.Throws<NameRequiredException>(() => customer.UpdateName("", ""));

    // Assert
    Assert.Equal("A valid name must be supplied.", caughtException.Message);
  }
}
```

Do you see the problem? The `Assert.Throws` line is both the **Act** step as well as one of the assertions. This makes the line both overly long and makes the test harder to read. We can fix this by using an `Action` to represent the operation that is expected to throw an exception.

## Using Actions with Assert.Throws

To help follow the AAA test pattern, represent the operation that is expected to throw an exception as a variable by using an `Action`:

```csharp
public class Customer_UpdateName
{
  [Fact]
  public void ThrowsExceptionGivenInvalidName
  {
    // Arrange
    var customer = new Customer();

    // Act
    Action action = () => customer.UpdateName("", "");

    // Assert
    var caughtException = Assert.Throws<NameRequiredException>(action);
    Assert.Equal("A valid name must be supplied.", caughtException.Message);
  }
}
```

Now in this example, the action that is the heart of the test stands alone within the **Act** section of the test, and the `Assert.Throws` line is much shorter and easier to follow.

## FluentAssertions

If you're using [FluentAssertions](https://fluentassertions.com/) instead of the built-in assertions of your testing library, you would do this:

```csharp
  [Fact]
  public void ThrowsExceptionGivenInvalidName
  {
    // Arrange
    var customer = new Customer();

    // Act
    Action action = () => customer.UpdateName("", "");

    // Assert
    action.Should()
      .Throw<NameRequiredException>()
      .WithMessage("A valid name must be supplied.");
  }
}
```

[Thanks to @volkmarrigo for this suggestion!](https://twitter.com/volkmarrigo/status/1382369414553669640)

I've been using the `Action` approach recently, since my friend [Shady Nagy](https://twitter.com/ShadyNagy_) (you should follow him on Twitter) pointed it out to me on a project we were working on together. This pattern is really simple to implement but I've found it makes tests for exceptions much cleaner.
