---
templateKey: blog-post
title: Using Custom Middleware to Record and Fix 404s in ASPNET Core Apps
path: blog-post
date: 2016-06-14T06:39:00.000Z
description: >+
  ASP.NET – Use Custom Middle Middleware to Detect and Fix 404s in ASP.NET Core
  Apps, the article was written in the ASP.NET 5 RC1 timeframe, but the sample
  code has been updated to RC2 and is available on GitHub.

featuredpost: false
featuredimage: /img/ic854853.png
tags:
  - asp.net core
  - middleware
  - msdn
category:
  - Software Development
comments: true
share: true
---
My most recent article in MSDN Magazine is now available online:

[ASP.NET – Use Custom Middle Middleware to Detect and Fix 404s in ASP.NET Core Apps](https://msdn.microsoft.com/en-us/magazine/mt707525.aspx)

The article was written in the ASP.NET 5 RC1 timeframe, but the sample code has been updated to RC2 and is [available on GitHub](https://github.com/ardalis/NotFoundMiddlewareSample).

From the introduction:

> If you’ve ever lost something at a school or an amusement park, you may have had the good fortune of getting it back by checking the location’s Lost and Found. In Web applications, users frequently make requests for paths that aren’t handled by the server, resulting in 404 Not Found response codes (and occasionally humorous pages explaining the problem to the user). Typically, it’s up to the user to find what they’re looking for on their own, either through repeated guesses or perhaps using a search engine. However, with a bit of middleware, you can add a “lost and found” to your ASP.NET Core app that will help users find the resources they’re looking for.

And here’s a screenshot of what the article builds:

![](/img/ic853846.png)

If you have questions or comments, you can add them here or [in the article’s MSDN forum](https://social.msdn.microsoft.com/forums/en-us/be9534bb-e886-4a40-b5d3-1d6a499721f7/aspnet-use-custom-middleware-to-detect-and-fix-404s-in-aspnet-core-apps?forum=msdnmagazine).