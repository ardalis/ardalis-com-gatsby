---
templateKey: blog-post
title: "Comparing Unit Testable Code with Maintainable Code"
date: 2024-06-12
description: "Writing maintainable code should be a goal in most software engineering projects. Although definitions and especially hard measurements of what maintainable means with regard to software may vary, it can be useful to compare maintainable code to the much more easily verified unit testability of that code."
path: blog-post
featuredpost: false
featuredimage: /img/comparing-unit-testable-code-with-maintainable-code.png
tags:
  - .NET
  - CSharp
  - dotnet
  - Maintainability
  - Testing
  - Unit Tests
  - Testability
  - Quality
  - Code Quality
category:
  - Software Development
comments: true
share: true
---

Writing maintainable code should be a goal in most software engineering projects. Although definitions and especially hard measurements of what maintainable means with regard to software may vary, it can be useful to compare maintainable code to the much more easily verified unit testability of that code.

## Introduction

When discussing software quality, two important concepts often arise: unit testable code and maintainable code. While these concepts are distinct, they share many characteristics. This article explores the overlap between unit testable code and maintainable code in C#, highlighting how striving for one often leads to achieving the other.

![venn diagram of unit testable code and maintainable code](/img/unit-testable-maintainable-code.png)

## Characteristics of Unit Testable Code

Unit testable code is designed to be easily and effectively tested in isolation. Key characteristics include:

- **Loose Coupling**: Dependencies are minimized and managed through interfaces or dependency injection.
- **Single Responsibility**: Each class or method has a single responsibility, making it easier to test.
- **Minimal External Dependencies**: Code avoids direct dependencies on external systems (e.g., databases, file systems) during tests.
- **Deterministic Behavior**: Code produces consistent results, which is crucial for repeatable tests.
- **Testable Design Patterns**: Use of design patterns like Dependency Injection (DI) and Inversion of Control (IoC) to facilitate testing.
- **Fast**: Unit tests are incredibly fast to run and typically should be capable of being run in parallel to optimize for speed of execution.

## Characteristics of Maintainable Code

Maintainable code is designed to be easily understood, modified, and extended. Key characteristics include:

- **Readability**: Code is easy to read and understand.
- **Modularity**: Code is divided into distinct, loosely-coupled modules, each with a clear purpose.
- **Consistency**: Code follows consistent naming conventions and coding standards.
- **Documentation**: Code is well-documented, making it easier for others to understand its purpose and functionality.
- **Test Coverage**: Code is well-tested, ensuring that changes do not introduce new bugs.

## Overlap Between Unit Testable Code and Maintainable Code

The overlap between unit testable code and maintainable code includes the following aspects:

1. **Loose Coupling and Single Responsibility**: Both characteristics enhance readability, maintainability, and testability.
2. **Minimal External Dependencies**: Reduces complexity and makes code more robust and easier to test and maintain.
3. **Deterministic Behavior**: Ensures reliability and predictability, essential for both quality and maintainability.
4. **Testable Design Patterns**: Encourage best practices that improve code quality and maintainability.

## Code Example

### Tightly Coupled Code (Difficult to Test and Maintain)

```csharp
public class FileLogger
{
    public void Log(string message)
    {
        System.IO.File.WriteAllText("log.txt", message);
    }
}

public class OrderProcessor
{
    private readonly FileLogger _logger = new FileLogger();

    public void ProcessOrder(Order order)
    {
        // Logic required to process the order

        _logger.Log("Order processed: " + order.Id);
    }
}
```

The above code example is difficult to unit test because of the direct dependency on the `FileLogger` type, resulting in tight coupling (remember, [New is Glue](/new-is-glue)). Any attempt to unit test the `ProcessOrder` method (running to its completion, and thus hitting the logger call) will fail if the test cannot access the log.txt file. Tests run in parallel are likely to result in file access errors, as well.

Aside from testing concerns, the above code cannot take advantage of alternative file stores, such as Azure Blob Storage or Amazon S3, not to mention redirecting log output to other locations, as may be desirable in various environments.

### Loosely Coupled Code (Easy to Test and Maintain)

```csharp
public interface ILogger
{
    void Log(string message);
}

public class FileLogger : ILogger
{
    public void Log(string message)
    {
        System.IO.File.WriteAllText("log.txt", message);
    }
}

public class OrderProcessor
{
    private readonly ILogger _logger;

    public OrderProcessor(ILogger logger)
    {
        _logger = logger;
    }

    public void ProcessOrder(Order order)
    {
        // Process the order
        _logger.Log("Order processed: " + order.Id);
    }
}
```

Notice that the above `OrderProcessor` version doesn't include any instance of the `new` keyword. Instead if follows the Explicit Dependencies Principle and clearly informs anyone calling or simply reading this class that it requires a logger of type `ILogger`, which is an incredibly simple abstraction.

As you'll see below, it's now trivial to test the `ProcessOrder` method, and also trivial to swap out the file logger implementation with any number of alternative loggers (or even several using a [Decorator](https://deviq.com/design-patterns/decorator-pattern) or [Chain of Responsibility pattern](https://deviq.com/design-patterns/chain-of-responsibility-pattern)). The resulting code is much more extensible with zero additional cyclomatic complexity and only one additional interface type.

### Unit Test for Loosely Coupled Code

```csharp
public class FakeLogger : ILogger
{
    public string LoggedMessage { get; private set; }

    public void Log(string message)
    {
        LoggedMessage = message;
    }
}

public class OrderProcessorTests
{
    [Fact]
    public void ProcessOrder_LogsOrderProcessedMessage()
    {
        // Arrange
        var fakeLogger = new FakeLogger();
        var processor = new OrderProcessor(fakeLogger);
        var order = new Order { Id = 123 };

        // Act
        processor.ProcessOrder(order);

        // Assert
        Assert.Equal("Order processed: 123", fakeLogger.LoggedMessage);
    }
}
```

## Conclusion

Striving for unit testable code often results in maintainable code. By focusing on loose coupling, single responsibility, minimal external dependencies, and deterministic behavior, developers can achieve code that is both easy to test and maintain. Incorporating testable design patterns further ensures code quality, making it more robust and scalable.

## References

- [Martin Fowler: Inversion of Control Containers and the Dependency Injection pattern](https://martinfowler.com/articles/injection.html)
- [Robert C. Martin: Clean Architecture: A Craftsman's Guide to Software Structure and Design](https://www.oreilly.com/library/view/clean-architecture-a/9780134494272/)
- [Microsoft Docs: Unit Testing in .NET](https://docs.microsoft.com/en-us/dotnet/core/testing/)


## Keep Up With Me

If you're looking for more content from me in your inbox [subscribe to my weekly tips newsletter](/tips) and be sure to follow me on [YouTube](https://www.youtube.com/ardalis?sub_confirmation=1).
