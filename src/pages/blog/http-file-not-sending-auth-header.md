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

The issue was the `UseHttpsRedirection` middleware. It was silently redirecting from the http endpoint to the https endpoint. The http endpoint was set up as a variable at the top of the .http file, so it wasn't even obvious far down into the file that a given request was using a particular URL/port:

```
POST {{BaseUrl}}/cart
```

Looking at the Request tab of the .http file output, it showed the URL of **https://localhost:7248/cart** but again, there was no reason for me to think this wasn't the correct URL. What it wasn't showing was the Authorization header.

**It might be a nice feature to include in the Request tab (or somewhere) that a redirect was followed, and that the final URL doesn't match the original URL that was requested.**

## Silent Redirection and Authorization Headers

The underlying behavior at work here was the means by which `UseHttpsRedirection` works and some assumptions about how that should behave. Specifically, it functions by sending a redirect response to the client, and if the client is configured to automatically follow redirects, it will do so without missing a beat. However, there is also a convention to not forward Authorization headers with redirects, as described [here](https://learn.microsoft.com/en-us/dotnet/api/system.net.http.httpclienthandler.allowautoredirect):

> The Authorization header is cleared on auto-redirects and the handler automatically tries to re-authenticate to the redirected location. No other headers are cleared. In practice, this means that an application can't put custom authentication information into the Authorization header if it is possible to encounter redirection. Instead, the application must implement and register a custom authentication module.

Note that this document literally says you shouldn't use custom auth headers "if it is possible to encounter redirection" which basically means **you should never combine `UseHttpsRedirection` with a token-secured API**.

Others have run into this problem before:

- [Beware of HTTP Redirects](https://mazeez.dev/posts/beware-of-http-redirects)

## Visual Studio / Template Feedback

I [submitted this feedback to Visual Studio](https://developercommunity.visualstudio.com/t/webapi-template-uses-HttpsRedirection-an/10576429?port=1025&fsid=e3c6a04d-024f-4953-9015-e38e269bd187). Please comment or vote on it if you think it will help.

## Summary

I'm hoping that this article will help save someone else some time (or who knows, maybe future me). If you're getting a 401 Unauthorized even though you are setting your Authorization header correctly, and you notice the Authorization header is missing, look for redirects as the culprit. They may not be obvious in your tooling, especially if things are configured to automatically follow redirects. Good luck and keep improving!

P.S. If you're looking to improve as a software developer, you may wish to join thousands of other developers who get my newsletter each week. [Sign up here](/tips)!
