---
templateKey: blog-post
title: UseStatusCodePages Middleware Problem Resolved
path: blog-post
date: 2016-12-01T04:55:00.000Z
description: If you’re trying to get the ASP.NET Core Status Code Pages
  middleware to work, but it just is ignored no matter what, one thing to check
  is the rest of your middleware pipeline.
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - asp.net
  - asp.net core
  - middleware
category:
  - Software Development
comments: true
share: true
---
If you’re trying to get the [ASP.NET Core Status Code Pages middleware](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/error-handling#configuring-status-code-pages) to work, but it just is ignored no matter what, one thing to check is the rest of your middleware pipeline. If you have middleware that is writing anything to the response, it will cause the status code pages middleware to be ignored. For example, the following middleware:

`app.Use(async (context, next) =>  {   
    context.Response.ContentType="text/html";
    await next();
});`

I had this set up in front of some other middleware to reduce duplication. I wanted to add support for 404 pages, so I added

`app.UseStatusCodePages();`

which I expected to provide me with a simple 404 status code for any paths that weren’t mapped to middleware. However, it was never being triggered. Once I removed the common middleware that was setting the ContentType, the statuscodepages middleware started working as expected.

The reason for this is [pointed out in the comments below](https://github.com/aspnet/Diagnostics/blob/ea27a4e56c12a08423d3b2b296b73cbbfa2063ab/src/Microsoft.AspNetCore.Diagnostics/StatusCodePage/StatusCodePagesMiddleware.cs#L46). The StatusCodePages middleware checks to see if Response.ContentType is null or empty, and does nothing if ContentType has a value.