---
templateKey: blog-post
title: Avoid Using C# Events in ASP.NET Core Applications
path: /avoid-using-csharp-events-in-aspnetcore-apps
date: 2024-12-15
featuredpost: false
description: C# events are a convenient way to implement publish-subscribe patterns, but they can lead to significant issues in ASP.NET Core applications, such as memory leaks, thread-safety problems, and tight coupling between components. These issues arise when event handlers are not properly managed or when shared state is accessed concurrently. Using alternatives discussed in this article can provide better scalability, testability, and maintainability for modern applications.
featuredimage: /avoid-using-csharp-events-in-aspnet-core-apps.png
tags:
  - C#
  - ASP.NET Core
  - Events
  - Memory Leaks
  - Thread Safety
  - Publish-Subscribe Pattern
  - Mediator Pattern
  - Event Aggregator
  - Software Architecture
  - Best Practices
category:
  - Software Development
comments: true
share: true
---

*This post is part of the [C# Advent Calendar 2024 - check out all of the C# articles from this year!](https://csadvent.christmas/)*

C# events are a powerful feature of the language, providing a simple mechanism for building publish-subscribe communication patterns. However, when used in ASP.NET Core applications, events can lead to subtle, hard-to-diagnose issues that can harm the reliability and scalability of your application. In this article, I'll highlight the main issues with using C# events in ASP.NET Core and share better alternatives.

The associated code samples can be found in this [GitHub repository: AvoidCSharpEventsAspNetCore](https://github.com/ardalis/AvoidCSharpEventsAspNetCore)

## The Appeal of C# Events

At first glance, C# events seem like a natural choice for situations where you want to notify other parts of the application about something that has happened. Here's a simple example of an event-based system in a hypothetical alarm service:

```csharp
public class AlarmService
{
    public event EventHandler<Alarm>? AlarmAdded;

    public void AddAlarm(Alarm alarm)
    {
        // Business logic for adding an alarm
        AlarmAdded?.Invoke(this, alarm); // Notify subscribers
    }
}

public class AlarmSubscriber
{
    public AlarmSubscriber(AlarmService service)
    {
        service.AlarmAdded += OnAlarmAdded; // C# event subscription
    }

    private void OnAlarmAdded(object? sender, Alarm alarm)
    {
        Console.WriteLine($"Alarm received: {alarm.Code}");
    }
}
```

In this example, the `AlarmService` notifies subscribers whenever a new alarm is added. While this works well for small, simple applications, it introduces problems when used in larger or more complex systems, like ASP.NET Core applications.

## The Problems with Events in ASP.NET Core

There are several issues with using C# events in ASP.NET Core applications. Let's look at a few of them just so you have some concrete reasons to avoid them and understand it's not just because I said so.

### Memory Leaks

One of the most common issues with events is that they can lead to memory leaks if you forget to unsubscribe (or you remember but **bad things happen** and the code that would have cleaned them up doesn't end up running). In .NET, the event publisher holds a strong reference to the event handler. If a subscriber is not unsubscribed, it cannot be garbage-collected even if it is no longer in use. This is particularly problematic in ASP.NET Core, where transient objects are common. As you may know, in .NET the garbage collector is the thing that makes sure unused memory is reclaimed for the application. If your application continues to create objects that cannot be garbage collected, you will eventually run out of memory and your application will crash.

Example of a Memory Leak:

```csharp
public class LeakyAlarmSubscriber
{
    public LeakyAlarmSubscriber(AlarmService service)
    {
        // Subscribing to the event but never unsubscribing
        service.AlarmAdded += OnAlarmAdded;
    }

    private void OnAlarmAdded(object? sender, Alarm alarm)
    {
        Console.WriteLine($"Alarm received: {alarm.Code}");
    }
}
```

Every time a new `LeakyAlarmSubscriber` is created, it stays in memory indefinitely because the `AlarmService` holds a reference to its event handler. You can see this in the following memory snapshots taken with the Visual Studio debugger:

![Memory Leak in Visual Studio Debugger](/img/memory-snapshots-csharp-events.png)

You can also demonstrate the issue using BenchmarkDotNet to measure the memory usage of your application over time. Set up the benchmark:

```csharp
using BenchmarkDotNet.Attributes;

[MemoryDiagnoser]
public class MemoryLeakBenchmark
{
    private EventPublisher _publisher;

    [GlobalSetup]
    public void Setup()
    {
        _publisher = new EventPublisher();
    }

    [Benchmark]
    public void CauseLeak()
    {
        var subscriber = new EventSubscriber(_publisher);
        _publisher.RaiseEvent();
    }
}

// run it from Main()
BenchmarkRunner.Run<MemoryLeakBenchmark>();
```

Then add a FixedSubscriber that uses IDisposable to unsubscribe from the event:

```csharp
public class FixedSubscriber : IDisposable
{
    private readonly EventPublisher _publisher;

    public FixedSubscriber(EventPublisher publisher)
    {
        _publisher = publisher;
        _publisher.SomethingHappened += OnSomethingHappened;
    }

    private void OnSomethingHappened(object? sender, EventArgs e)
    {
        //Console.WriteLine("Event received.");
    }

    public void Dispose()
    {
        _publisher.SomethingHappened -= OnSomethingHappened;
    }
}
// and another benchmark method
[Benchmark]
public void ProperlyDisposeSubscriber()
{
    using var subscriber = new FixedSubscriber(_publisher);
    _publisher.RaiseEvent();
}

```

It will take a few minutes (be sure to comment out the `Console.WriteLine` call, too), and then you'll see the results:

![](/img/benchmarkdotnet-comparison.png)

The allocated memory is the same in both cases, but notice that garbage collection is happening in the second case. This is because the `FixedSubscriber` is properly unsubscribing from the event, allowing the garbage collector to reclaim the memory.

But even if you're always diligent about unsubscribing from events, there are other issues to consider.

### Where's the increase in RAM over time?

To see the increase in memory usage over time, you can put the leaky code into a big loop like this one:

```csharp
for (int i = 0; i < 1_000_000; i++)
{
    // Create a new leaking subscriber
    var subscriber = new LeakySubscriber(publisher);

    // Optionally raise an event to simulate activity
    publisher.RaiseEvent();

    // Periodically log memory usage
    if (i % 10_000 == 0)
    {
        Console.WriteLine($"Iteration: {i}, Memory: {GC.GetTotalMemory(false):N0} bytes");
    }
}
```

Running that yields something like this:

```plaintext
Iteration: 0, Memory: 64,168 bytes
Iteration: 10000, Memory: 1,860,584 bytes
Iteration: 20000, Memory: 3,646,528 bytes
Iteration: 30000, Memory: 5,170,200 bytes
Iteration: 40000, Memory: 7,218,032 bytes
Iteration: 50000, Memory: 8,741,808 bytes
Iteration: 60000, Memory: 6,668,840 bytes
Iteration: 70000, Memory: 9,247,104 bytes
Iteration: 80000, Memory: 10,768,544 bytes
Iteration: 90000, Memory: 12,297,072 bytes
Iteration: 100000, Memory: 13,820,848 bytes
Iteration: 110000, Memory: 11,798,080 bytes
Iteration: 120000, Memory: 13,327,744 bytes
Iteration: 130000, Memory: 14,849,184 bytes
Iteration: 140000, Memory: 18,469,752 bytes
Iteration: 150000, Memory: 19,993,272 bytes
Iteration: 160000, Memory: 21,517,048 bytes
Iteration: 170000, Memory: 17,547,392 bytes
Iteration: 180000, Memory: 19,068,832 bytes
Iteration: 190000, Memory: 20,590,272 bytes
Iteration: 200000, Memory: 22,118,816 bytes
Iteration: 210000, Memory: 23,642,336 bytes
Iteration: 220000, Memory: 21,500,744 bytes
Iteration: 230000, Memory: 23,024,520 bytes
Iteration: 240000, Memory: 24,548,296 bytes
Iteration: 250000, Memory: 26,071,720 bytes
Iteration: 260000, Memory: 27,595,496 bytes
Iteration: 270000, Memory: 33,321,824 bytes
Iteration: 280000, Memory: 29,327,472 bytes
```

### Thread-Safety Issues

C# events are not thread-safe by default. If multiple threads raise or subscribe to an event at the same time, it can lead to race conditions or even `NullReferenceException`.

Example of a Potential Race Condition:

```csharp
public class AlarmService
{
    public event EventHandler<Alarm>? AlarmAdded;

    public void AddAlarm(Alarm alarm)
    {
        // A race condition can occur if AlarmAdded is modified on another thread
        AlarmAdded?.Invoke(this, alarm);
    }
}
```

To avoid these issues, you would need to introduce thread-safety mechanisms, such as copying the event delegate to a local variable before invoking it.

### Tight Coupling

C# events create tight coupling between the publisher and the subscribers. The publisher directly depends on the existence of the subscribers, making it harder to maintain and test the system. Other patterns can be more flexible because subscribers (handlers) can be instantiated as needed.

Why This Is Problematic:

- The `AlarmService` has no control over what the subscribers do.
- Subscribers may unintentionally introduce performance issues or exceptions that impact the entire system.

## Better Alternatives

To avoid these issues, consider the following alternatives to C# events:

### Use a Mediator Pattern

The Mediator pattern decouples the publisher and subscribers, making the system more scalable and testable. Libraries like [MediatR](https://github.com/jbogard/MediatR) are great for implementing this pattern in ASP.NET Core. Here's how you could rewrite the alarm example using MediatR:

```csharp
public class AlarmAdded : INotification
{
    public Alarm Alarm { get; }

    public AlarmAdded(Alarm alarm)
    {
        Alarm = alarm;
    }
}

public class AlarmService
{
    private readonly IMediator _mediator;

    public AlarmService(IMediator mediator)
    {
        _mediator = mediator;
    }

    public void AddAlarm(Alarm alarm)
    {
        // Business logic for adding an alarm
        _mediator.Publish(new AlarmAdded(alarm));
    }
}

public class AlarmHandler : INotificationHandler<AlarmAdded>
{
    public Task Handle(AlarmAdded notification, CancellationToken cancellationToken)
    {
        Console.WriteLine($"Alarm received: {notification.Alarm.Code}");
        return Task.CompletedTask;
    }
}
```

In this example, the `AlarmService` publishes an `AlarmAdded` notification using MediatR, and the `AlarmHandler` subscribes to it. This approach decouples the publisher and subscribers, making the system more maintainable and testable. There's no direct dependency between the components, so there's no risk of memory leaks or tight coupling.

### Use an Event Aggregator

An Event Aggregator is a centralized hub for managing events and subscribers. This pattern is particularly useful in applications with complex communication requirements.

An example of an Event Aggregator in ASP.NET Core:

```csharp
public class EventAggregator
{
    private readonly Dictionary<Type, List<Action<object>>> _subscribers = new();

    public void Subscribe<T>(Action<T> handler)
    {
        if (!_subscribers.TryGetValue(typeof(T), out var handlers))
        {
            handlers = new List<Action<object>>();
            _subscribers[typeof(T)] = handlers;
        }

        handlers.Add(obj => handler((T)obj));
    }

    public void Publish<T>(T message)
    {
        if (_subscribers.TryGetValue(typeof(T), out var handlers))
        {
            foreach (var handler in handlers)
            {
                handler(message);
            }
        }
    }
}

public class AlarmService
{
    private readonly EventAggregator _eventAggregator;

    public AlarmService(EventAggregator eventAggregator)
    {
        _eventAggregator = eventAggregator;
    }

    public void AddAlarm(Alarm alarm)
    {
        // Business logic for adding an alarm
        _eventAggregator.Publish(alarm);
    }
}

public class AlarmSubscriber
{
    public AlarmSubscriber(EventAggregator eventAggregator)
    {
        eventAggregator.Subscribe<Alarm>(OnAlarmAdded);
    }

    private void OnAlarmAdded(Alarm alarm)
    {
        Console.WriteLine($"Alarm received: {alarm.Code}");
    }
}
```

In this example, the `EventAggregator` acts as a central hub for managing events and subscribers. The `AlarmService` publishes an `Alarm` message, and the `AlarmSubscriber` subscribes to it. This pattern provides a flexible and scalable way to manage communication between components, without the issues associated with C# events or dependency on third-party libraries.

### Conclusion

C# events can be a useful tool in small, isolated systems, but they often cause more problems than they solve in modern ASP.NET Core applications. By understanding their limitations and considering alternative approaches, you can build more robust, maintainable systems.

## References

- [C# Events](https://learn.microsoft.com/dotnet/csharp/programming-guide/events/)
- [Handle and Raise Events](https://learn.microsoft.com/en-us/dotnet/standard/events/)
- [Reddit: Events and delegates in ASP.NET Core](https://www.reddit.com/r/dotnet/comments/lrby7j/events_and_delegates_in_an_aspnet_core/)
- [C# Advent Calendar](https://csadvent.christmas/)
- [Follow Me on YouTube](https://www.youtube.com/@Ardalis)
