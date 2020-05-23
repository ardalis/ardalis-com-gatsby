---
templateKey: blog-post
title: xUnit Test Discovery Error with ASPNET Core 1.1
path: blog-post
date: 2017-01-17T04:21:00.000Z
description: If you run into an error with test discovery using xUnit and
  ASP.NET Core 1.1 where there is a **FileNotFoundException** looking for
  Microsoft.DotNet.Internal.Abstractions version 1.0.0.0, there is a fairly
  simple fix.
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - asp.net core
  - xunit
category:
  - Software Development
comments: true
share: true
---
If you run into an error with test discovery using xUnit and ASP.NET Core 1.1 where there is a **FileNotFoundException** looking for Microsoft.DotNet.Internal.Abstractions version 1.0.0.0, there is a fairly simple fix. The problem is that one of the dependent packages in ASP.NET Core requires this package but for some reason it’s not being pulled in. You can get around the issue by explicitly including the package in your test project’s dependencies. Assuming you’re using the new XML-based project file, you would add a line like this one:

`<PackageReference Include="Microsoft.DotNet.InternalAbstractions"  Version="1.0.0" />`

Once you add this package reference explicitly, it will be pulled into the test project and everything should work. This approach can also work if you find warnings related to incompatible package versions (when you don’t have either version referenced by your project explicitly). Include a specific version of the package and the warning should disappear.