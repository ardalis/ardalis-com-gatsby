---
templateKey: blog-post
title: The Minimal ASPNET Core App
path: blog-post
date: 2016-07-21T06:12:00.000Z
description: There’s no upper limit on how large an ASP.NET Core app can get,
  but what about how small you can make it? With the new .NET Core framework,
  the answer is pretty small. Let’s see just how small.
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - asp.net core
  - startup
category:
  - Software Development
comments: true
share: true
---
Now [updated for ASP.NET Core 1.1 here](http://ardalis.com/the-minimal-aspnet-1-1-app).

There’s no upper limit on how large an [ASP.NET Core](http://docs.asp.net/) app can get, but what about how small you can make it? With the new .NET Core framework, the answer is pretty small. Let’s see just how small.

First, make sure you have the dotnet CLI tools installed. You can get them from [dot.net](http://dot.net/). This sample will work on Windows as well as Mac and Unix.

Next, open a command prompt, create a new folder (e.g. ‘min’) and run ‘dotnet new’ to create a simple console application. This will produce two files:

* Program.cs
* project.json

Now, at this point you can run the application by running ‘dotnet restore’ and ‘dotnet run’ and you’ll get the standard Hello World output. But that’s not an ASP.NET Core app (yet).

To make this console application an ASP.NET Core app, you need to add “Microsoft.AspNetCore.Server.Kestrel”:”1.0.0″ to the “dependencies” property in project.json. When you’re done, it should look like this:

`{   "version": "1.0.0-*",
  "buildOptions": {
    "debugType": "portable",
    "emitEntryPoint": true
  },
  "dependencies": {},
  "frameworks": {
    "netcoreapp1.0": {
      "dependencies": {
        "Microsoft.NETCore.App": {
          "type": "platform",
          "version": "1.0.0"
        },
        "Microsoft.AspNetCore.Server.Kestrel":"1.0.0"
      },
      "imports": "dnxcore50"
    }
  }
}`

Now, open Program.cs. Normally your ASP.NET apps will have separate files for Startup.cs, Program.cs, and probably MVC-related folders and files for controllers, views, etc. For this example, though, let’s show how you can set it all up in just Program.cs. Program.cs is the entry point for the application. Instead of having it print “Hello World” we’re going to configure a web host (using a WebHostBuilder), tell it to use the Kestrel server, and set it up to respond to all requests by simply writing a reponse of “Hi!”. Here’s the end result:

`using Microsoft.AspNetCore.Hosting; using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
public class Program
{
    public static void Main()
    {
        new WebHostBuilder()
            .UseKestrel()
            .Configure(a => a.Run(c => c.Response.WriteAsync("Hi!")))
            .Build()
            .Run();
    }
}`

From your command prompt, type ‘dotnet run’ and you should see the app start up on localhost:5000 by default. Browse to that URL and you should see “Hi!”. That’s about as small as I can get a working ASP.NET Core app while still making it readable.