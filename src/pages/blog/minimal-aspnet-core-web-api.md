---
templateKey: blog-post
title: Minimal ASPNET Core Web API
path: blog-post
date: 2017-07-12T22:04:00.000Z
description: Inspired by a StackOverflow question, I’ve created a minimal
  ASP.NET Core Web API app as a learning exercise and aid to troubleshooting web
  API development.
featuredpost: false
featuredimage: /img/minimal-aspnet-core-web-api.png
tags:
  - asp.net core
category:
  - Software Development
comments: true
share: true
---
Inspired by a[StackOverflow question](https://stackoverflow.com/questions/44356052/minimal-footprint-bare-bones-asp-net-core-webapi), I’ve created a minimal ASP.NET Core Web API app as a learning exercise and aid to troubleshooting web API development. The goal of this app is to demonstrate how little code and how few files are required to build simple web apps and APIs using ASP.NET Core. You can also quickly[clone and run the minimal ASP.NET Core Web API app](https://github.com/ardalis/minimalwebapi)to verify that your installation of ASP.NET Core is working correctly. To create this app, I started with an empty ASP.NET Core Web Application. It turns out you don’t really need a Startup.cs if you’re making a minimal app, so I deleted that and the reference to it from Program.cs. In fact, the only two lines I needed in my WebHostBuilder were one to specify Kestrel as the host and another to wire up a single request delegate:

```
public static void Main(string[] args)
{
    var host = new WebHostBuilder()
        .UseKestrel()
        .Configure(app => app.Map("/echo", EchoHandler))
        .Build();
 
    host.Run();
}
```

When you run this app, it will initially tell you there’s nothing running. That’s because there isn’t a default app.Run to handle the root URL. You need to navigate to “/echo” to see the echo behavior. You can do this in your browser, but it’s more interesting using a tool like Postman:

![](/img/postman-echo-api.png)

Notice that this isn’t a simple GET request like your browser would send, but a PUT request complete with a raw JSON payload as its body. The whole request, including the ContentType of the response, is echoed back in the response. The code to achieve this is pretty simple:

```
private static void EchoHandler(IApplicationBuilder app)
{
    app.Run(async context =>
    {
        context.Response.ContentType = context.Request.ContentType;
        await context.Response.WriteAsync(
            JsonConvert.SerializeObject(new
            {
                StatusCode = context.Response.StatusCode.ToString(),
                PathBase = context.Request.PathBase.Value.Trim('/'),
                Path = context.Request.Path.Value.Trim('/'),
                Method = context.Request.Method,
                Scheme = context.Request.Scheme,
                ContentType = context.Request.ContentType,
                ContentLength = (long?)context.Request.ContentLength,
                Content = new StreamReader(context.Request.Body).ReadToEnd(),
                QueryString = context.Request.QueryString.ToString(),
                Query = context.Request.Query
                    .ToDictionary(
                        item => item.Key,
                        item => item.Value,
                        StringComparer.OrdinalIgnoreCase)
            })
        );
    });
}
```

In the past I’ve written about [the minimal ASP.NET Core app](http://ardalis.com/the-minimal-aspnet-1-1-app), but that was just a Hello World app. This app is similar, but offers slightly more functionality, such that it might be useful to keep handy if you’re troubleshooting a client communicating with a .NET core API and you want to make sure it’s receiving what you think you’re sending. If you have any suggestions or feedback, please leave them in the comments or on [the GitHub repo](https://github.com/ardalis/minimalwebapi).

By the way, if you’re looking to get up to speed with ASP.NET Core quickly, check out my [ASP.NET Core Quick Start web course](http://aspnetcorequickstart.com/). Try the chapter on Startup for free!