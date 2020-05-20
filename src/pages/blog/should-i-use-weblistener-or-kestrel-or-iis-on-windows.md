---
templateKey: blog-post
title: Should I Use WebListener or Kestrel or IIS on Windows?
path: blog-post
date: 2017-05-24T02:28:00.000Z
description: "Someone recently asked this question on GitHub, and I thought it
  was worth spreading this information more widely:"
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - asp.net core
category:
  - Software Development
comments: true
share: true
---
Someone recently asked this question on [GitHub](https://github.com/aspnet/Docs/issues/3365), and I thought it was worth spreading this information more widely:

> I’ve been doing some research to figure out the best option to self host ASP.NET Web Api on Windows. Some articles recommend using WebListener for client facing services and other state that Kestrel is faster and can be used behind an IIS proxy.
>
> What is the better option?
>
> I understand that Kestrel has the benefit of being cross-platform but I am only deploying on Windows and mainly concerned about performance.

The recommendation comes in two parts. Currently in 1.1, Kestrel is not supported as an edge server (meaning, deployed directly facing the internet, as opposed to being configured behind a reverse proxy like IIS or nginx). Dan Roth (Microsoft) writes:

> We generally recommend using Kestrel behind IIS on Windows. However, Kestrel is not supported as an edge server in 1.1 (it will be in 2.0), so if you don’t want to use IIS then use WebListener. Kestrel by itself is generally faster than WebListener, but if you put Kestrel behind IIS it will be slower than plain WebListener as things currently stand.

**Update:** With the 2.0 release, Kestrel now supports edge deployments.

If you have any questions or your own experience to share with any of these approaches, feel free to leave them in the comments below.