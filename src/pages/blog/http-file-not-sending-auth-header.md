---
templateKey: blog-post
title: "Solved! Visual Studio .http File Not Sending Authorization Header"
date: 2024-02-01
description: "I ran into a weird problem with how Visual Studio was sending API requests. I was trying to use a bearer token, and it worked fine in Swagger, but from an .http file the Authorization header was simply being ignored, resulting in a 401 Unauthorized."
path: blog-post
featuredpost: false
featuredimage: /img/http-file-not-sending-auth-header.png
tags:
  - dotnet
  - .NET
  - ASP.NET Core
  - Visual Studio
  - Visual Studio 2022
category:
  - Software Development
comments: true
share: true
---

I ran into a weird problem with how Visual Studio was sending API requests. I was trying to use a bearer token, and it worked fine in Swagger, but from an .http file the Authorization header was simply being ignored, resulting in a 401 Unauthorized.

## The Problem

I'd built a simple ASP.NET Core webapi project using the default template. I was using the built-in support for .http files to execute requests against the project. I could register and log in successfully, but when it came time to hit an endpoint that required authentication, it would always result in a 401. The same token added to the same `Authorization` header worked just fine using Swagger/Swashbuckle in the browser.

## Diagnosing the Problem

I tried a bunch of things to attempt to diagnose the problem. I checked to see if anyone else had reported similar issues. I posted on my company Discord and on Twitter to see if anyone else knew what was going on. Since the Request info tab in the .http file wasn't even showing the Authorization header (but would show a made-up `Authorization2` header that I added that was identical in all respects but the name) I figured maybe it was by design for some reason.

Since the issue seemed to revolve around missing headers, I wanted to verify if what was showing up in the Request tab was correct, so [I wrote some custom LogHeadersMiddleware](/log-request-headers-middleware) to show me **every** header that ASP.NET Core was seeing.

That's when I noticed something odd. See if you can pick it out in this image, which shows a request (a single request) from the .http file:

![Request from .http file showing logged headers](/img/http-file-request-with-headers.png)

Notice that halfway through, the first request to **http://localhost:5206/cart** ends, and a new request to **https://localhost:7248/cart** begins.

The issue was the `UseHttpsRedirection` middleware. It was silently redirecting from the http endpoint to the https endpoint.


## Summary
