---
templateKey: blog-post
title: Testing Logging in ASPNET Core
path: blog-post
date: 2017-08-08T21:51:00.000Z
description: "When it’s important, logging should be considered a “real”
  requirement, not just a developer or operations afterthought. In many cases,
  especially diagnosis of production problems, logging has real business value.
  "
featuredpost: false
featuredimage: /img/testing-logging-in-aspnet-core.png
tags:
  - asp.net core
  - refactoring
  - testing
category:
  - Software Development
comments: true
share: true
---
When it’s important, [logging should be considered a “real” requirement](https://ardalis.com/logging-and-monitoring-are-requirements), not just a developer or operations afterthought. In many cases, especially diagnosis of production problems, logging has real business value. Thus, there are times when you’ll want to test that your logging works. Consider the following function:

```
public void DoSomething(int input)
{
    _logger.LogInformation("Doing something...");
 
    try
    {
        // do something that might result in an exception
        var result = 10 / input;
 
    }
    catch (Exception ex)
    {
        // swallow but log the exception
        _logger.LogError(ex, "An error occurred doing something.", input);
    }
}
```

Let’s assume for a moment that when this exception occurs, it’s potentially costing the company substantial money. Thus, it would be good to know about it so that the issue can be resolved somehow. From the developer’s point of view, unlike the first log method call in the function, the LogError method has Business Importance. To be very sure that it’s working correctly, there should be automated tests proving this is the case (and ensuring it’s not inadvertently broken by some future revision to the code). Now, let’s look at how to test this code when the _logger instance in question is an ASP.NET Core ILogger<T> type, injected like so:

```
public class SomeService
{
    private readonly ILogger<SomeService> _logger;
 
    public SomeService(ILogger<SomeService> logger)
    {
        _logger = logger;
    }
 
    // methods
}
```

Now let’s take a moment to consider how we can test this scenario. We can’t call the method and then observe SomeService’s state to see if it worked. We can use the return value from the method (there isn’t one in this case, it’s void). The only way to confirm this behavior in a unit test (that is, without using a*real*logger implementation and then checking log files, console output, etc.) is to pass in our own implementation of ILogger<SomeService> into SomeService, and then check to see whether this instance was called by the DoSomething method. One way to pass in our own implementation is to use a mocking library like Moq, which we can use to verify that a particular method call was made:

```
[Fact]
public void LogsErrorWhenInputIsZero()
{
    var mockLogger = new Mock<ILogger<SomeService>>();
    var someService = new SomeService(mockLogger.Object);
 
    someService.DoSomething(0);
 
    // Option 1: Try to verify the actual code that was called.
    // Doesn't work.
    mockLogger.Verify(l => l.LogError(It.IsAny<Exception>(), It.IsAny<string>(), 0));
}
```

Unfortunately, this approach fails, because there is no LogError method on ILogger<T>. LogError is an extension method. This is the root of what makes [unit testing logging difficult in ASP.NET Core](https://github.com/aspnet/Logging/issues/611).

An approach that does work is to [crack open the code for the LoggerExtensions and look to see what non-extension method is ultimately executed on ILogger](https://github.com/aspnet/Logging/blob/dev/src/Microsoft.Extensions.Logging.Abstractions/LoggerExtensions.cs#L342). This leads to a test like this one:

```
[Fact]
public void LogsErrorWhenInputIsZeroTake2()
{
    var mockLogger = new Mock<ILogger<SomeService>>();
    var someService = new SomeService(mockLogger.Object);
 
    someService.DoSomething(0);
 
    // Option 2: Look up what instance method the extension method actually calls:
    // https://github.com/aspnet/Logging/blob/dev/src/Microsoft.Extensions.Logging.Abstractions/LoggerExtensions.cs#L342
    // Mock the underlying call instead.
    // Works but is ugly and brittle
    mockLogger.Verify(l => l.Log(LogLevel.Error, 0, It.IsAny<FormattedLogValues>(), It.IsAny<Exception>(),
        It.IsAny<Func<object, Exception, string>>()));
}
```

Yuck. Now we’re having to mock calls that don’t even exist in the method we’re testing. That’s not very discoverable, and someone else coming along and reading this test, and then looking at our code, may have a hard time figuring out where this call to Log() is coming from, since there’s no such method call in the DoSomething function.

In discussing this online, I had someone suggest a novel approach. Create our own version of ILogger<T> and provide it with its own implementation of the method we want to check. Since instance methods are always used before extensions methods, this would provide a way of overriding the extension method in our test code. The implementation would look something like this:

```
[Fact]
public void LogsErrorWhenInputIsZeroTake3()
{
    var fakeLogger = new FakeLogger();
    var someService = new SomeService(fakeLogger);
 
    someService.DoSomething(0);
 
    // Option 3: Create your own instance of ILogger<T> that has a non-extension version of the method
    // Doesn't work, unless you change system under test to take in a FakeLogger (which is useless)
    Assert.NotNull(FakeLogger.ProvidedException);
    Assert.NotNull(FakeLogger.ProvidedMessage);
}
 
private class FakeLogger : ILogger<SomeService>
{
    public static Exception ProvidedException { get; set; }
    public static string ProvidedMessage { get; set; }
    public static object[] ProvidedArgs { get; set; }
    public IDisposable BeginScope<TState>(TState state)
    {
        return null;
    }
 
    public bool IsEnabled(LogLevel logLevel)
    {
        return true;
    }
 
    public void Log<TState>(LogLevel logLevel, EventId eventId, TState state, Exception exception, Func<TState, Exception, string> formatter)
    {
    }
 
    public void LogError(Exception ex, string message, params object[] args)
    {
        ProvidedException = ex;
        ProvidedMessage = message;
        ProvidedArgs = args;
    }
}
```

As you can read in the comments above, this approach doesn’t actually work. Assuming DoSomething is still calling the method LogError on ILogger<T>, the extension method will still be used because ILogger<T> doesn’t have an instance method that matches (the fact that FakeLogger does is irrelevant in the context of the DoSomething method). The only way to make this work would be to change the SomeService method to accept a FakeLogger, instead of an ILogger<T>, but obviously that doesn’t help since we don’t want to tightly couple our real implementation code to some fake test code.

So now what?

The real problem here is that we are depending on types that are outside of our control, and these types are using static methods that are difficult to decouple in our tests. To achieve loose coupling in our applications, we want to encapsulate dependencies on specific implementations by working with interfaces we control. This is part of the [Interface Segregation Principle (ISP)](http://deviq.com/interface-segregation-principle/). Now, many developers will counter that it’s perfectly acceptable to directly use ILogger<T> anywhere we want, because (a) it’s not an implementation and (b) it’s part of the framework that we’re already depending on. Unfortunately, while it’s true that ILogger<T> itself isn’t an implementation, its use of extension methods as the primary way to work with it makes it difficult to test. It is this interface implementation detail that is the source of the problem, and the thing we should thus try to keep at arm’s length through the use of abstraction. The simplest way to address the issue is through the use of an adapter.

In keeping with ISP, we can begin with the minimal interface that our client code requires. We don’t have to create one-adapter-to-rule-them-all with every variation of method found on LoggerExtensions. Most applications won’t need all of those. Just include the ones you need.

```
public interface ILoggerAdapter<T>
{
    // add just the logger methods your app uses
    void LogInformation(string message);
    void LogError(Exception ex, string message, params object[] args);
}
```

You can implement the adapter easily by passing in the implementation type it’s using. In this case, the ILogger<T> type and its extension methods:

```
public class LoggerAdapter<T> : ILoggerAdapter<T>
{
    private readonly ILogger<T> _logger;
 
    public LoggerAdapter(ILogger<T> logger)
    {
        _logger = logger;
    }
 
    public void LogError(Exception ex, string message, params object[] args)
    {
        _logger.LogError(ex, message, args);
    }
 
    public void LogInformation(string message)
    {
        _logger.LogInformation(message);
    }
}
```

At this point, you [refactor](https://www.pluralsight.com/courses/refactoring-fundamentals) your service to swap out the ILogger<T> dependency and instead use an ILoggerAdapter<T>. Writing a test to verify that the error is logged properly then becomes trivial:

```
[Fact]
public void LogsErrorWhenInputIsZero()
{
    var mockLogger = new Mock<ILoggerAdapter<SomeOtherService>>();
    var someOtherService = new SomeOtherService(mockLogger.Object);
 
    someOtherService.DoSomething(0);
 
    mockLogger.Verify(l => l.LogError(It.IsAny<Exception>(), It.IsAny<string>(), 0));
}
```

All of the code for this example is available in [my TestingLogging repository on GitHub](https://github.com/ardalis/TestingLogging). Feel free to play around with it there to see that it works.

**Update: November 2019**

This post is about 2 years old now and while I still prefer to keep dependencies like framework logging behind an interface or type I control, there are other options that are great especially if you’re trying to test legacy code that maybe didn’t follow this approach. Commenter Ashish Jain recently shared with me some utilities written by Christian Knaap that provide extension methods to use in your tests that make mocking the underlying Logger.Log method less painful. [Check out his static LoggerUtils class here](https://gist.github.com/cknaap/6919df54820853f7a3ef054303cebfc3). While investigating this I also found a nuget package, [MockLoggerExtensions](https://www.nuget.org/packages/MockLoggerExtensions/), that looks like it could be helpful as well, but which I haven’t yet had a chance to play with. If someone has a chance to demonstrate its use in a blog post or GitHub repo/gist please leave me a link to it in the comments.

## Summary

Depending on types you don’t control throughout your application adds coupling and frequently becomes a source of problems and technical debt. Think carefully before you decide to depend directly on a particular implementation, or even an abstraction/interface, that you don’t directly control. Logging is just one example, but I know many developers who fall into the trap of depending on Entity Framework throughout their code, having bought into the “I don’t need a repository interface because EF is a repository” nonsense which completely misses the point. You don’t use your own interfaces to magically add behavior to the third party library (i.e. repository behavior for EF). You add your own interfaces so that you isolate your dependence on the third party library to one part of your code, so that if that dependency changes for any reason, you only need to deal with the change in one place, not everywhere.