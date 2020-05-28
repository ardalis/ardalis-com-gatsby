---
templateKey: blog-post
title: Strange Issue with HttpContext.Current with WebDevServer
path: blog-post
date: 2006-09-16T02:17:03.274Z
description: "I’m working with a Trace class that I wrote back in .NET 1.1 that
  wraps System. Diagnostics and System.Web tracing. The class looks like this:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’m working with a Trace class that I wrote back in .NET 1.1 that wraps System.Diagnostics and System.Web tracing. The class looks like this:

<!--EndFragment--><!--StartFragment-->

publicstaticclassTrace

{

privatestaticHttpContextcontext =null;

staticTrace()

{

context = HttpContext.Current;

}

This worked fine in 1.x, but testing it with Cassini / Test Web Server I was seeing unusual behavior. The first load of a page, the trace statements would work just fine (using ASP.NET tracing), but on subsequent loads, no trace output was shown. Replacing my calls with standard Trace.Write() calls on the page showed that tracing was working fine, it was just my library that wasn’t working.

What I did to fix the problem was move the context = HttpContext.Current out of the static constructor and into each method that uses it. The effect of this was that the current context would be detected on every method call, not just once when the type is first used. Strangely, this worked. The only thing I can think is that the Cassini web server creates a new context for each web request, whereas IIS retains the same context between requests.

I’m not 100% sure this is what’s going on, but that seems to make sense of the behavior I’m seeing.

<!--EndFragment-->