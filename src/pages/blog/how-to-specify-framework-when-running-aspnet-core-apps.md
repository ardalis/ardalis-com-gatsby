---
templateKey: blog-post
title: How To Specify Framework When Running ASPNET Core Apps
path: blog-post
date: 2016-05-23T06:47:00.000Z
description: "In .NET Core, you can target multiple frameworks from the same
  application. Where there are incompatibilities, you can use precompiler
  directives, like so:"
featuredpost: false
featuredimage: /img/frameworkselectorvisualstudio.png
tags:
  - asp.net core
category:
  - Software Development
comments: true
share: true
---
In .NET Core, you can target multiple frameworks from the same application. Where there are incompatibilities, you can use precompiler directives, like so:

`#if NET461   // access something that requires full .NET framework
  // like the Windows event log
#endif`

However, if you have this in an application that also runs “netcoreapp1.0” it will probably run with that by default. To force it to run using .NET Framework 4.6.1 (or whatever version you’re using), you can switch it in Visual Studio using the dropdown menu next to IIS Express, as shown here:

![](/img/frameworkselectorvisualstudio.png)

If you’re running the application from the command line interface (dotnet run), you can specify the framework by using the -f directive:

`dotnet run -f NET461`

With that, you should be able to test out your framework specific code blocks!