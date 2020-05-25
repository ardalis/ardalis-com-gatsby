---
templateKey: blog-post
title: Configure NLog with StructureMap
path: blog-post
date: 2016-02-22T12:53:00.000Z
description: "In a couple of recent posts, I demonstrated how to set up
  StructureMap 4 in a simple .NET console application, and how to configure NLog
  to capture and record some app-specific fields with each logged entry (well,
  to be able to do so if desired, anyway). "
featuredpost: false
featuredimage: /img/subscribe-3534409_1280.jpg
tags:
  - logging
  - nlog
  - structuremap
category:
  - Software Development
comments: true
share: true
---
In a couple of recent posts, I demonstrated[how to set up StructureMap 4 in a simple .NET console application](http://ardalis.com/using-structuremap-4-in-a-console-app), and [how to configure NLog to capture and record some app-specific fields](http://ardalis.com/configure-nlog-to-log-application-specific-data) with each logged entry (well, to be able to do so if desired, anyway). If you’re using StructureMap already in your application, you may want to leverage it for your logging as well. Let’s consider that, and then show a couple of ways to do it that keep your code [DRY](http://deviq.com/don-t-repeat-yourself/).

## Logging as an Abstraction

There is some debate about where logging logic belongs in your application, especially if you are following [Domain-Driven Design](http://bit.ly/PS-DDD). Logging is a cross-cutting concern, and not necessarily one that the core domain should worry about. However, it’s quite likely that you will want to perform some logging in your core domain. Assuming you’ve separated your application’s infrastructure from its core ([learn more](https://www.pluralsight.com/courses/n-tier-apps-part1)), this means either you need to put implementation details about your logging in your core project, or you need some kind of ILogger abstraction that is implemented in your infrastructure. Usually I lean toward the latter, since I try to follow the [Dependency Inversion Principle](http://deviq.com/dependency-inversion-principle/), which suggests that high level modules (i.e. domain model) should not depend on low level modules (i.e. a logger implementation). However, there are also those who [argue against using dependency injection with loggers](https://jamesmckay.net/2014/09/how-not-to-do-logging-unnecessary-abstractions/), and they make some good points. Most importantly, that the typical ILogger facade is going to leave out a lot of the best features of your logger, and in any case logging code shouldn’t impact your ability to run tests (if it does, you’ve configured your logger wrong in your test project).

I’m going to take a middle road for this article, which is that we can work with a concrete Logger class (and thus have full access to its goodness), but still use dependency injection to make the logger available to our classes (thus eliminating some boiler-plate code in every class that might require a logger). In order to inject the logger into classes that need it, we need to decide whether we should use constructor or property injection. In the former case, we have no choice but to include it in the list of constructor arguments, which helps us to follow the [Explicit Dependencies Principle](http://deviq.com/explicit-dependencies-principle), but adds a little bit more code we need to write. The second case, property injection, would allow us to place the Logger property in a base class. Once in place, any child of this base class would “just work” without additional code.

In both cases, one of the nice features of NLog is its ability to use named loggers, which typically correspond to the fully qualified class name of the class they’re associated with. The techniques below will not require us to sacrifice this functionality.

## Inject Logger as Property

In order to inject the logger as a property, we first need a base class that exposes the property. One disadvantage of this approach is that this property, which should only ever be called from within the class itself, is exposed (at least partially) as part of the class’s interface.

`public abstract class LoggedClass {
    public CustomLogger Logger { protected get; set; }
}`

Classes that inherit from LoggedClass can use the logger as expected:

`public class Greeting : LoggedClass {
    public string SayHello(string name)
    {
        Logger.Info("{0} started.", nameof(SayHello));
        return $"Hello {name}";
    }
}`

The property is populated automatically by StructureMap using a custom policy. This policy checks to see if there is a property called Logger, and if there is, it creates a logger instance and sets the property to this instance. Otherwise, it does nothing. The reason we’re using a custom policy is to give us access to the pluginType so that the logger is properly named for the type it is being injected into (and not, for instance, ConsoleRegistry where StructureMap is creating it).

```
public class AddLoggerPolicy : ConfiguredInstancePolicy {
    protected override void apply(Type pluginType, IConfiguredInstance instance)
    {
        var property = instance.SettableProperties()
                       .FirstOrDefault(p => p.Name == "Logger");
        if (property != null)
        {
            var logger = (CustomLogger)LogManager
                .GetLogger(pluginType.ToString(), typeof(CustomLogger));
            instance.Dependencies.AddForProperty(property, logger);
        }
    }
}
```

The policy is then added to StructureMap in the registry class that is used to set it up:

`Policies.Add<AddLoggerPolicy>();`

## Inject Logger via Constructor

Unfortunately, we can’t just create a base class, give it a constructor that accepts an instance of Logger, and be done with it. Nor will an interface help us achieve any reuse in this case – the logger isn’t something we want as part of our public interface. Thus, we’ll need to request an instance of the logger anywhere we want to perform some logging. But this is what we do anyway if we’re writing SOLID, DDD-style code. Here’s what a type requiring logging looks like:

```
public class Greeting {
    private readonly CustomLogger _logger;

    public Greeting(CustomLogger logger)
    {
        _logger = logger;
    }

    public string SayHello(string name)
    {
        _logger.Info("{0} started.", nameof(SayHello));
        return $"Hello {name}";
    }
}
```

As above, we could at this point use a standard StructureMap rule to provide an instance of a Logger to the class, but it wouldn’t get the name of the class properly. Instead, we use a similar policy-based approach, targeting constructor parameters rather than properties:

```
public class AddLoggerPolicy : ConfiguredInstancePolicy {
    protected override void apply(Type pluginType, IConfiguredInstance instance)
    {
        var parameter =
            instance.Constructor.GetParameters()
            .FirstOrDefault(p => p.ParameterType == typeof (CustomLogger));
        if (parameter != null)
        {
            var logger = (CustomLogger)LogManager
                .GetLogger(pluginType.ToString(), typeof(CustomLogger));
            instance.Dependencies.AddForConstructorParameter(parameter, logger);
        } 
    }
}
```

With this in place, the ConsoleRegistry can add it to its Policies collection:

```
public class ConsoleRegistry : Registry {
    public ConsoleRegistry()
    {
        Scan(scan =>
        {
            scan.TheCallingAssembly();
            scan.WithDefaultConventions();
        });
        Policies.Add<AddLoggerPolicy>();
    }
}
```

## Summary

Which approach do you prefer? There are plenty of opinions on this subject that you’ll find [with a quick search](https://www.google.com/webhp?sourceid=chrome-instant&rlz=1C1CHWA_enUS614US614&ion=1&espv=2&ie=UTF-8#q=logging%20dependency%20injection). My current preference is with the constructor injection approach, but using NLog instances directly rather than a custom ILogger facade. I’ve demonstrated that I can test the code that includes the loggers without any problem, and if I need to actually test that some logging is performed correctly, I have a way to inject my own custom logger implementation or mock that would let me detect this.