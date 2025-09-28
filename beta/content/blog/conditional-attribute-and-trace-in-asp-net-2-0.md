---
title: Conditional Attribute and TRACE in ASP.NET 2.0
date: "2006-09-15T22:15:40.0810000-04:00"
description: "In ASP.NET 1.x I had created some helper classes that wrapped the ASP.NET Trace class. These included methods like this one:"
featuredImage: img/conditional-attribute-and-trace-in-asp-net-2-0-featured.png
---

In ASP.NET 1.x I had created some helper classes that wrapped the ASP.NET Trace class. These included methods like this one:

\[Conditional("TRACE")]\
public static void Write(string category, string message, Exception myException)\
{\
context = HttpContext.Current;

if (context!= null)\
context.Trace.Write(category, message, myException);\
}



In VS2003, I would simply mark my project as having the TRACE conditional compilation flag, and this would work fine. In production, I could turn it on or off as desired, and all overhead from the tracing would disappear when it was turned off (and recompiled).

In VS 2005, using basic Websites (folders – not [Web Application Projects](http://msdn.microsoft.com/asp.net/reference/infrastructure/wap)), there doesn't seem to be any way to tell the server to use conditional compilation constants when it builds the site. The best I've found thus far is to use #define TRACE (in C#) inside my BasePage class, but unfortunately changing this requires a change to my BasePage class, not simply to my build process, so it's less than ideal.

Apart from using WAP to build websites, has anyone come up with a simpler solution to this issue? I'm not prepared to switch to WAP just yet.

