---
title: How to List All Services Available to an ASP.NET Core App
date: "2016-07-25T02:03:00.0000000-04:00"
description: In a recent article, I showed how to configure logging for your Startup class in ASP.NET Core. With this configured, it's easy to log all of the services that have been configured in ASP.NET Core services container.
featuredImage: /img/aspnetcore-logo.png
---

In a [recent article](http://ardalis.com/logging-and-using-services-in-startup-in-aspnet-core-apps), I showed how to configure logging for your Startup class in ASP.NET Core. With this configured, it's easy to log all of the services that have been configured in ASP.NET Core services container. This can be very useful when diagnosing issues with [ASP.NET Core's support for dependency injection](https://docs.asp.net/en/latest/fundamentals/dependency-injection.html). Grab the code from the other post to get access to the logger in your ConfigureServices method, then add this:

```csharp
 _logger.LogDebug($"Total Services Registered: {services.Count}");
 foreach(var service in services)
 {
 _logger.LogDebug($"Service: {service.ServiceType.FullName}
 \nLifetime: {service.Lifetime}
 \nInstance: {service.ImplementationType?.FullName}");
 }
}
```

This will produce output like this, when you run the application:

![console output of services](/img/startup-services.png)

Of course, if you'd rather see the services in your browser than just in your logging, you can create some simple middleware that will display them. First, in your Startup class, create a field `_services` of type IServiceCollection. Then, at the end of ConfigureServices, assign the services parameter to the `_services` field.

Then, in configure, set up the middleware to map a particular URL to list out the contents of _services. I recommend you only do this for the Development environment. Below there are two options – use the app.Map call if you just want to add this functionality to an existing app. Otherwise use app.Run (which will respond to all request paths with the list of services).

```csharp
using Microsoft.AspNetCore.Builder; using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Http;
using System.Text;

namespace WebApplication
{
 public class Startup
 {
 private IServiceCollection _services;

 public IConfigurationRoot Configuration { get; }

 // This method gets called by the runtime. Use this method to add services to the container.
 public void ConfigureServices(IServiceCollection services)
 {
 _services = services;
 }

 // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
 public void Configure(IApplicationBuilder app, IHostingEnvironment env, ILoggerFactory loggerFactory)
 {
 // add this if you want to add this for a particular path in an existing app
 app.Map("/allservices", builder => builder.Run(async context =>
 {
 var sb = new StringBuilder();
 sb.Append("<h1>All Services</h1>");
 sb.Append("<table><thead>");
 sb.Append("<tr><th>Type</th><th>Lifetime</th><th>Instance</th></tr>");
 sb.Append("</thead><tbody>");
 foreach(var svc in _services)
 {
 sb.Append("<tr>");
 sb.Append($"<td>{svc.ServiceType.FullName}</td>");
 sb.Append($"<td>{svc.Lifetime}</td>");
 sb.Append($"<td>{svc.ImplementationType?.FullName}</td>");
 sb.Append("</tr>");
 }
 sb.Append("</tbody></table>");
 await context.Response.WriteAsync(sb.ToString());
 }));

 // otherwise just add this
 app.Run(async context =>
 {
 var sb = new StringBuilder();
 sb.Append("<h1>All Services</h1>");
 sb.Append("<table><thead>");
 sb.Append("<tr><th>Type</th><th>Lifetime</th><th>Instance</th></tr>");
 sb.Append("</thead><tbody>");
 foreach(var svc in _services)
 {
 sb.Append("<tr>");
 sb.Append($"<td>{svc.ServiceType.FullName}</td>");
 sb.Append($"<td>{svc.Lifetime}</td>");
 sb.Append($"<td>{svc.ImplementationType?.FullName}</td>");
 sb.Append("</tr>");
 }
 sb.Append("</tbody></table>");
 await context.Response.WriteAsync(sb.ToString());
 });
 }
 }
}
```

You'll probably want to add some CSS so this looks decent, but here's the basic output:

![browser showing html services output](/img/startup-services-middleware.png)

The code is [available on GitHub here](https://github.com/ardalis/AspNetCoreStartupServices).

You can also [grab a Nuget package](https://www.nuget.org/packages/Ardalis.ListStartupServices/) to easily add this to your own project without copy/pasting the code.

Now you have two easy ways to quickly see what's in your services container in your ASP.NET Core app, so that you can better understand how ASP.NET Core works under the covers and manage your app's dependencies. The dependency injection support in ASP.NET Core is much nicer than in previous versions of ASP.NET, and can really help you to produce more loosely-coupled, testable, more maintainable apps. Your classes will be better able to follow important principles like [SOLID](http://deviq.com/solid/) and the [Explicit Dependencies Principle](http://deviq.com/explicit-dependencies-principle/).

Let me know what you think in the comments or on twitter, where I'm [@ardalis](https://twitter.com/ardalis). Thanks!

