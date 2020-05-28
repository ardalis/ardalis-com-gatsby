---
templateKey: blog-post
title: Logging and Using Services in Startup in ASPNET Core Apps
path: blog-post
date: 2016-07-25T06:08:00.000Z
description: >
  When you set up an ASP.NET Core app, most of the time you begin with the
  Startup.cs file, which provides essentially three places where you can add
  code:
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - asp.net core
  - debugging
  - diagnostic
  - diagnostics
  - logging
  - startup
category:
  - Software Development
comments: true
share: true
---
When you set up an ASP.NET Core app, most of the time you begin with the Startup.cs file, which provides essentially three places where you can add code:

* Constructor
* ConfigureServices
* Configure

Naturally, the constructor fires first. Then, ConfigureServices is run, and finally the Configure method. You can learn more about this process in my[Application Startup Fundamentals article on docs.asp.net](https://docs.asp.net/en/latest/fundamentals/startup.html).

One of the cool features about how ASP.NET loads a Startup class, is that the class doesn’t adhere to a strongly typed contract or interface. It’s a POCO, with no particular base type. Its constructor is optional, as is ConfigureServices. The only thing you really have to include is the Configure method, because this sets up your app’s request pipeline. But, as I showed in [my recent article on the minimal ASP.NET Core app](http://ardalis.com/the-minimal-aspnet-core-app), you don’t even need a Startup class at all. You can configure the request pipeline directly from the WebHostBuilder that creates the host in which the app will run. That said, assuming you are using a Startup class, the other really cool feature of this lack of strong typing is that the class’s methods support [dependency injection](http://deviq.com/dependency-injection/). The constructor and Configure methods each can request whatever services they may require, and the host will provide them if they’ve previously been configured. There are numerous examples like this one showing how to request an interface that provides access to the current environment, so that different code can be run in Development versus in Production:

`public Startup(IHostingEnvironment env) {
  var builder = new ConfigurationBuilder()
      .SetBasePath(env.ContentRootPath)
      .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true)
      .AddJsonFile($"appsettings.{env.EnvironmentName}.json", optional: true);

      if (env.IsDevelopment())
      {
         // For more details on using the user secret store see http://go.microsoft.com/fwlink/?LinkID=532709
         builder.AddUserSecrets();
      }
      builder.AddEnvironmentVariables();
      Configuration = builder.Build();
}
 public void Configure(IApplicationBuilder app, 
                       IHostingEnvironment env,
                       ILoggerFactory loggerFactory)
{
  loggerFactory.AddConsole(Configuration.GetSection("Logging"));
  loggerFactory.AddDebug();

  if (env.IsDevelopment())
  {
    app.UseDeveloperExceptionPage();
    app.UseDatabaseErrorPage();
    app.UseBrowserLink();
  }
  else
  {
    app.UseExceptionHandler("/Home/Error");
  }
// more removed
}`

One frequently asked question from developers new to ASP.NET Core is, “which services are available from Startup methods, and where do they come from?”. I cover the first part of the question [here](https://docs.asp.net/en/latest/fundamentals/startup.html#services-available-in-startup) – let’s talk about the second part. You can configure your own services, including logging, and make them available within Startup from WebHostBuilder.

Imagine you have a fairly complex app, and you want to have some insight into what it’s doing when it starts up. By default, there are no loggers configured when your Startup constructor runs, and even if you were to create one by requesting ILoggerFactory, you would have to configure it before you could use it (and by convention this is done in the Configure method, which fires after your constructor). Now, did you know that the WebHostBuilder that you’re most likely running in Program.cs includes methods for ConfigureLogging and ConfigureServices? Using these, you can configure logging before Startup is even run, and make loggers and other services available to your Startup and Configure methods (ConfigureServices doesn’t support dependency injection directly, but its IServiceCollection parameter gives it access to all configured services, anyway). Configure the host in Program.cs as follows:

`var host = new WebHostBuilder()             .UseKestrel()
            .ConfigureServices(s => {
                s.AddSingleton<IFormatter, LowercaseFormatter>();
            })
            .ConfigureLogging(f => f.AddConsole(LogLevel.Debug))
            .UseStartup<Startup>()
            .Build();

host.Run();`

With this in place, you can request whatever services you need, including the standard ILogger<T> (in this case, ILogger<Startup>), and you’ll get an appropriate logger instance, configured according to whatever specifications you made via WebHostBuilder. For example:

`public class Startup {
    ILogger _logger;
    IFormatter _formatter;
    public Startup(ILoggerFactory loggerFactory, IFormatter formatter)
    {
        _logger = loggerFactory.CreateLogger<Startup>();
        _formatter = formatter;
    }

    public void ConfigureServices(IServiceCollection services)
    {
        _logger.LogDebug($"Total Services Initially: {services.Count}");

        // register services
        //services.AddSingleton<IFoo, Foo>();
    }

    public void Configure(IApplicationBuilder app, IFormatter formatter)
    {
        // note: can request IFormatter here as well as via constructor
        _logger.LogDebug("Configure() started...");
        app.Run(async (context) => await context.Response.WriteAsync(_formatter.Format("Hi!")));
        _logger.LogDebug("Configure() complete.");
    }
}

public interface IFormatter
{
    string Format(string input);
}

public class LowercaseFormatter : IFormatter
{
    public string Format(string input)
    {
        return input.ToLower();
    }
}`



## Where Should You Configure Logging and Services?

It’s up to you where you want to configure your app’s services, including logging. However, if there are services beyond those the framework provides that you want to have access to during Startup’s execution, the simplest way to ensure they’re available is to configure them at the host level, as shown in this article. Aside from those services that you expect to use during Startup, I recommend configuring the rest of your app in Startup, since this is the conventional location for doing so and will be the first place ASP.NET Core developers will look to see how the app is configured.