---
templateKey: blog-post
title: Configuring ASPNET Core Apps with WebHostBuilder
path: blog-post
date: 2016-09-09T05:13:00.000Z
description: "In ASP.NET Core apps, you typically configure the application in
  Startup. However, the application itself runs inside of a host, which is
  configured separately using a WebHostBuilder. "
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - asp.net core
  - builder
  - design patterns
  - pattern
  - startup
category:
  - Software Development
comments: true
share: true
---
In ASP.NET Core apps, you typically configure the [application in Startup](https://docs.asp.net/en/latest/fundamentals/startup.html). However, the application itself runs inside of a [host](https://docs.asp.net/en/latest/fundamentals/hosting.html), which is configured separately using a WebHostBuilder. Although it’s not the default, recommended case (and thus isn’t shown in [the official docs](https://docs.asp.net/en/latest/index.html)), you can actually configure the application directly from WebHostBuilder and avoid using a Startup class entirely (or augment what Startup is able to do). These techniques can come in handy in certain scenarios, including integration tests, which I’ll use in this post to demonstrate different kinds of WebHostBuilder configurations. [View all of the tests and run them yourself from this repo](https://github.com/ardalis/ConfigureWithWebHostBuilder).

When using Startup, you must implement the Configure method (to set up the app’s request pipeline) and optionally the ConfigureServices method (to configure any dependencies the app needs to have registered). You can do either or both of these things directly within WebHostBuilder via its Configure() and ConfigureServices() extension methods. For example:

`[Fact] public async void TestNoStartup() 
{
    _server = new TestServer(
        new WebHostBuilder()
    .Configure(app => 
    {
        app.Run(async (context) =>
        {
            await context.Response.WriteAsync("Hi");
        });
    }));
    _client = _server.CreateClient();

    var response = await _client.GetAsync("/");
    response.EnsureSuccessStatusCode();
    var result = await response.Content.ReadAsStringAsync();

    Assert.Equal("Hi",result);
}`

This [integration test](https://docs.asp.net/en/latest/testing/integration-testing.html) configures a host to return “Hi” to all requests, and then confirms that “Hi” is returned when a request is made to the root of the application.

Within Startup, you can leverage dependency injection in the constructor and in the Configure method. Normally, only a few known framework types are available to you, such as IApplicationBuilder or IHostingEnvironment. However, using WebHostBuilder you can configure services before Startup is instantiated, making additional services available to be injected into Startup’s constructor and/or Configure method (ConfigureServices can access these services directly from its IServiceCollection parameter).

This Startup class requests an instance of IGreeting in its Configure method:

`public class StartupWithGreeting {
    public void Configure(IApplicationBuilder app, IGreeting greeting)
    {
        app.Run(async (context) =>
        {
            await context.Response.WriteAsync(greeting.Greet("Steve"));
        });
    } 
}

public interface IGreeting
{
    string Greet(string name);
}

public class MorningGreeting : IGreeting
{
    public string Greet(string name)
    {
        return $"Good morning, {name}!";
    }
}`

Normally, this would fail, but you can provide the required service using WebHostBuilder, as this test demonstrates:

`[Fact] public async void TestAddingServices() 
{
    _server = new TestServer(
        new WebHostBuilder()
        .ConfigureServices(services => 
        {
            services.AddSingleton<IGreeting,MorningGreeting>();
        })
        .UseStartup<StartupWithGreeting>()
    );
    _client = _server.CreateClient();

    var response = await _client.GetAsync("/");
    response.EnsureSuccessStatusCode();
    var result = await response.Content.ReadAsStringAsync();

    Assert.Equal("Good morning, Steve!",result);
}`

Finally, debugging problems that occur in your app’s Startup method can be difficult, since usually at that point error pages and logging are not yet configured. One approach that can be helpful is to configure logging from the WebHostBuilder, so that you can log what’s happening in Startup. For example, this Startup class requests an ILogger<T> in its constructor:

`public class StartupWithLogging {
    private readonly ILogger<StartupWithLogging> _logger;
    public StartupWithLogging(ILogger<StartupWithLogging> logger)
    {
       _logger = logger;
    }

    public void ConfigureServices(IServiceCollection services)
    {
        _logger.LogInformation("Starting ConfigureServices");
        // do stuff here
        _logger.LogInformation("Exiting ConfigureServices");        
    }
    public void Configure(IApplicationBuilder app)
    {
        _logger.LogWarning("Entering Configure");
        app.Run(async (context) =>
        {
            await context.Response.WriteAsync("Logging");
        });
    } 
}`

Its logger is configured in WebHostBuilder to use a ConsoleLogger:

`[Fact] public async void TestAddingLogging() 
{
    _server = new TestServer(
        new WebHostBuilder()
        .ConfigureLogging(factory =>
        {
            factory.AddConsole();
        })
        .UseStartup<StartupWithLogging>()
    );
    _client = _server.CreateClient();

    var response = await _client.GetAsync("/");
    response.EnsureSuccessStatusCode();
    var result = await response.Content.ReadAsStringAsync();

    Assert.Equal("Logging",result);
}`

You can view the log output when you run dotnet test from the console.

Similarly, you can pass the logger into the Configure method directly, rather than the constructor:

`public class StartupWithLoggingPassedIntoMethod {
        public void Configure(IApplicationBuilder app, ILogger<StartupWithLoggingPassedIntoMethod> logger)
    {
        logger.LogWarning("Entering Configure");
        app.Run(async (context) =>
        {
            await context.Response.WriteAsync("Logging via method injection");
        });
    } 
}`

And it works the same. Note that passing in loggers like this, which will use the ILoggerFactory service behind the scenes, is supported without any special configuration via WebHostBuilder. All I’m doing here is making sure a Console logger is wired up in WebHostBuilder so that when Startup executes I’m able to view the log output in the console.

`[Fact] public async void TestAddingLoggingViaMethod() 
{
    _server = new TestServer(
        new WebHostBuilder()
        .ConfigureLogging(factory =>
        {
            factory.AddConsole();
        })
        .UseStartup<StartupWithLoggingPassedIntoMethod>()
    );
    _client = _server.CreateClient();

    var response = await _client.GetAsync("/");
    response.EnsureSuccessStatusCode();
    var result = await response.Content.ReadAsStringAsync();

    Assert.Equal("Logging via method injection",result);
}`

Having logging configured and available to Startup can be a big help to diagnosing issues that occur there. Normally, [application logging isn’t configured until the Configure method is called](https://docs.asp.net/en/latest/fundamentals/logging.html), which is after the constructor and ConfigureServices have already run, so there’s no opportunity to log what goes on in those earlier methods. Using WebHostBuilder, logging (and other services) can be configured prior to Startup running at all, making these services available to all three of Startup’s main methods (constructor, Configure, and ConfigureServices).