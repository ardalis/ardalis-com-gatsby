---
title: ASPNET Core Razor Pages – Worth Checking Out?
date: "2017-08-31T17:12:00.0000000-04:00"
description: You may have heard that in ASP.NET Core MVC 2.0, there is a new
featuredImage: /img/aspnetcore-logo.png
---

You may have heard that in ASP.NET Core MVC 2.0, there is a new feature called Razor Pages. This feature allows you to create pages that don't need to have a controller or action, and which can optionally have an associated PageModel class instead of a ViewModel. If you've been programming for a while, especially in the ASP.NET space, this may trigger some immediate reactions.

* Oh no! The return of web forms!
* Won't this just lead to [spaghetti code](http://deviq.com/spaghetti-code/)?
* How does this not violate [Separation of Concerns](http://deviq.com/separation-of-concerns/)?
* Oh, right, that's that thing for newbie coders and incoming PHP programmers – I can ignore it.

My recommendation is that you should **not** just ignore Razor Pages, and instead you should consider how they can be used in concert with regular View-based endpoints in your MVC applications, and can even be used to help organize large projects in much the same way that [feature folders](https://ardalis.com/msdn-feature-slices-for-aspnet-core-mvc) are used.

This month, my feature article in MSDN magazine on [Simpler ASP.NET Core MVC Apps with Razor Pages](https://msdn.microsoft.com/en-us/magazine/mt842512) goes to print (and is of course available online, too). Check it out, play with the sample on GitHub, and let me know what you think.

