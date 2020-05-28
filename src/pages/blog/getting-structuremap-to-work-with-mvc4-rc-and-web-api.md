---
templateKey: blog-post
title: Getting StructureMap to Work with MVC4 RC and Web API
path: blog-post
date: 2012-07-17T22:48:00.000Z
description: At the moment (18 July 2012) if you install the NuGet package
  structuremap.MVC4, it will not compile due to breaking changes in the ASP.NET
  MVC4 RC distribution.
featuredpost: false
featuredimage: /img/webdesign-3411373_1280.jpg
tags:
  - asp.net
  - mvc
  - structuremap
category:
  - Software Development
comments: true
share: true
---
At the moment (18 July 2012) if you install the NuGet package structuremap.MVC4, it will not compile due to breaking changes in the ASP.NET MVC4 RC distribution. You have to jump through some extra hoops to get this working. Here are two posts that help:

* [Configuring MVC4 with StructureMap](http://biasecurities.com/2012/06/configuring-mvc-4-with-structuremap)
* [Using the Web API Dependency Resolver](http://www.asp.net/web-api/overview/extensibility/using-the-web-api-dependency-resolver)

However, even with both of these getting things working wasn’t quite as easy as I would have liked. Here are two full files with namespaces showing what I used to get things working ([Gist 3135943](https://gist.github.com/3135943)). I assume the NuGet package will be updated to be correct once MVC4 ships.

<script src="https://gist.github.com/3135943.js?file=StructureMapMvc.cs"></script><script src="https://gist.github.com/3135943.js?file=HomeController.cs"></script>