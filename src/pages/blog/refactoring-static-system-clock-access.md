---
templateKey: blog-post
title: Refactoring Static System Clock Access
path: blog-post
date: 2016-08-10T05:32:00.000Z
description: "If you have logic that depends on dates and/or times, it can be
  difficult to test if it’s directly accessing the system clock (via
  DateTime.Now in .NET, for example). "
featuredpost: false
featuredimage: /img/refactoring-static-system-clock-access-760x360.png
tags:
  - dependencies
  - refactoring
  - solid
  - static cling
  - testing
  - unit testing
category:
  - Software Development
comments: true
share: true
---
If you have logic that depends on dates and/or times, it can be difficult to test if it’s directly accessing the system clock (via DateTime.Now in .NET, for example). This is an example of an [insidious dependency](http://ardalis.com/insidious-dependencies) that can add unnecessary coupling to an application, making it harder to maintain. Fortunately, it’s pretty easy to refactor your code to address this issue.

First, realize that **you don’t need to do this** anywhere you’re simply displaying or persisting a datetime value. In that case, your code’s *behavior* isn’t a function of the value of the datetime.

Now, consider some simple logic like this ASP.NET Core middleware for displaying a greeting:

`public void Configure(IApplicationBuilder app) {
    app.Run(async (context) => 
    {
        var greeting = "Good morning!";
        if(DateTime.Now.Hour > 12)
        {
            greeting = "Good afternoon!";
        }
        if(DateTime.Now.Hour > 16)
        {
            greeting = "Good evening!";
        }
        await context.Response.WriteAsync(greeting);
    });
}`

Let’s say you want to be able to test this logic, since perhaps it’s critical to your application (in this case, it’s the entire application). The first thing I would do is move the logic of generating greetings out into its own class:

`public class GreetingService {
    public string GenerateGreeting()
    {
        var greeting = "Good morning!";
        if(DateTime.Now.Hour > 12)
        {
            greeting = "Good afternoon!";
        }
        if(DateTime.Now.Hour > 16)
        {
            greeting = "Good evening!";
        }
        return greeting;
    }
}`

This class can simply be instantiated from the original location to retain the original behavior:

`public void Configure(IApplicationBuilder app) {
    app.Run(async (context) => 
    {
        var greetingService = new GreetingService();
        await context.Response.WriteAsync(greetingService.GenerateGreeting());
    });
}`

Since the GreetingService class is a simple POCO, it seems like it should be easy enough to test. Unfortunately, it’s not following the [Explicit Dependencies Principle](http://deviq.com/explicit-dependencies-principle/), since it has a hidden dependency on the system clock, making testing hard. I would want to write tests like these:

* GenerateGreetingShouldReturnGoodMorningAt0800
* GenerateGreetingShouldReturnGoodAfternoonAt1230
* GenerateGreetingShouldReturnGoodEveningAt1700

Or alternately I might want a single test method that I could pass in some test cases:

`[Test] [TestCase(8, "Good morning!")]
[TestCase(13, "Good afternoon!")]
[TestCase(17, "Good evening!")]
public void ReturnCorrectGreetingForHour(int hour, string expectedGreeting)
{
}`

What I don’t want is to have to write tests that include their own datetime logic, essentially mirroring the system under test, or to write tests that only execute properly at certain times of day, but otherwise are skipped.

The key to fixing this hidden dependency problem is to pull the dependency out into an abstraction and then pass it into the service’s constructor. We can create a simple abstraction and implement that abstraction like so:

`public interface IDateTime {
    DateTime Now { get;}
}

public class SystemDateTime : IDateTime
{
    public DateTime Now
    {
        get
        {
            return DateTime.Now;
        }
    }
}`

The service has the dependency provided to it via its constructor:

`public class GreetingService {
    private readonly IDateTime _dateTime;
    public GreetingService(IDateTime dateTime)
    {
        _dateTime = dateTime;
    }
    public string GenerateGreeting()
    {
        var greeting = "Good morning!";
        if(_dateTime.Now.Hour > 12)
        {
            greeting = "Good afternoon!";
        }
        if(_dateTime.Now.Hour > 16)
        {
            greeting = "Good evening!";
        }
        return greeting;
    }
}`

At this point, the middleware code complains because our instantiation of GreetingService doesn’t pass anything to its constructor. We need to take care to do that. We could simply new up a SystemDateTime and pass it in, but this just exacerbates the problem whose root cause is that we are directly instantiating implementations instead of taking them in as dependencies. Remember, “[new is glue](/new-is-glue)“. Instead, we can just get a Greeting Service from ASP.NET Core’s [dependency injection](https://docs.asp.net/en/latest/fundamentals/dependency-injection.html) support as a parameter to the Configure method:

`public void Configure(IApplicationBuilder app, GreetingService greetingService) {
    app.Run(async (context) => 
    {
        await context.Response.WriteAsync(greetingService.GenerateGreeting());
    });
}`

Then, we just have to be sure we’ve registered the service and the IDateTime implementation in ConfigureServices:

`public void ConfigureServices(IServiceCollection services) {
    // register services
    services.AddSingleton<IDateTime, SystemDateTime>();
    services.AddSingleton<GreetingService>();
}`

Now, the application continues to run just as it did before, but it’s been factored out so that the classes follow the [Single Responsibility Principle](http://deviq.com/single-responsibility-principle/) and are more easily tested in isolation. For testing, we can provide a mock implementation of IDateTime, or use a fake class like this one:

`public class FakeDateTime : IDateTime {
    private DateTime _theDateTime;
    public FakeDateTime(int hour)
    {
        _theDateTime = new DateTime(2016,1,1,hour,0,0);
    }
    public DateTime Now
    {
        get
        {
            return _theDateTime;
        }
    }
}`

Since for these tests we only care about the hour, this fake class can easily be used to produce times for any desired hour.

**What About a Method Parameter?**

Another simple approach is to simply pass in the DateTime value as a parameter to the method that depends on it. This can work in many cases, including this one, and is especially worth considering if only one method in a class with several methods needs the value. In this case, GenerateGreeting would simply take in a DateTime parameter, and just like that it would be quite simple to test, without the need for any mocks or fakes or interfaces or the rest. This is a simple refactoring that you can use a lot of the time, but one that doesn’t lend itself to automatic wire-up via dependency injection. You’ll still need to get the current time from somewhere in your application in order to pass it into the method, and wherever you do that, you may be introducing the static dependency. In this example, though, it would work fine since the behavior of the middleware would be unaffected by the time, and it could simply pass the current time to the GreetingService’s GenerateGreeting method.

Related to this approach, you could pass the service a DateTime, rather than an IDateTime, to its constructor. Again, this makes using DI slightly more complicated, but it would work and would obviate the need for the interface and its implementation.

**Summary**

Note that this example uses ASP.NET Core but all of the code applies equally to any C# (or Java for that matter) application that includes a [static dependency](http://deviq.com/static-cling/) on the system clock.

Learn more about other code smells and how to refactor them in my [Refactoring Fundamentals course](https://www.pluralsight.com/courses/refactoring-fundamentals).