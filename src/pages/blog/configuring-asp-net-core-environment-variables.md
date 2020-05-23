---
templateKey: blog-post
title: Configuring ASP.NET Core Environment Variables
path: blog-post
date: 2015-05-20T14:21:00.000Z
description: "Whether you’re developing on Windows or a Mac/Linux machine, you
  can control the behavior of your ASP.NET 5 application by setting environment
  variables. "
featuredpost: false
featuredimage: /img/mac-terminal-environment-e1432142361365.png
tags:
  - asp.net core
category:
  - Software Development
comments: true
share: true
---
Whether you’re developing on Windows or a Mac/Linux machine, you can control the behavior of your ASP.NET 5 application by setting environment variables. Learn more about how this works in the official docs on [working with multiple environments in ASP.NET 5](http://docs.asp.net/en/latest/fundamentals/environments.html). The environment variable used to determine the application environment of an ASP.NET 5 application is `ASPNET_ENV`.

If you’re developing your application in Visual Studio 2015, you can specify the environment in the debug profile for your web project. However, if you’re working from a command line interface, it’s useful to know how to list and set environment variables.

## Viewing and Setting Environment Variables on Windows

On Windows, you can use `set` to view current environment variables, and `set ASPNET_ENV=Development` to set the current environment to development. You can filter the list by piping (using the `|` character) the result to `findstr`. The following screenshot shows how to view the current `ASPNET_ENV` setting (if any), how to set it, and then how to run a sample ASP.NET 5 application from the command prompt:

![](/img/windows-command-environment.png)

## Viewing and Setting Environment Variables on Mac OS X

On a Mac, you can also manage environment variables from a command prompt, using a slightly different set of commands. Open a Terminal window, and use `export` to see a list of currently configured environment variables. You can filter the result by piping it to `grep`. Use `export ASPNET_ENV=Development` to set the variable, as shown:

![](/img/mac-terminal-environment-e1432142361365.png)

Learn more about [developing ASP.NET Applications on a Mac](http://docs.asp.net/en/latest/tutorials/your-first-mac-aspnet.html).