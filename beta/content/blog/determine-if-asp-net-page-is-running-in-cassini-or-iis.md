---
title: Determine if ASP.NET Page is running in Cassini or IIS
date: "2006-01-05T08:43:46.1140000-05:00"
description: Sometimes you'd really like to know whether your web application is
featuredImage: img/determine-if-asp-net-page-is-running-in-cassini-or-iis-featured.png
---

Sometimes you'd really like to know whether your web application is running in IIS or Cassini (ASP.NET Developer Server or whatever it's called now). For example, I've heard there are certain scenarios that do not work under the latter and therefore must run under the former, so during automated test suites using Cassini you might want to avoid executing some blocks of code that you know will fail except under IIS. Regardless of \*why\* you might care, here is some code you can use to accomplish the task:

*System.Diagnostics.Process.GetCurrentProcess().MainModule.ModuleName*

Looking at this property you will see different values for IIS and for Cassini. For the VS web host, it will say something like "WebDev.WebServer.EXE". For IIS it will be something like"aspnet_wp.exe" or"w3wp.exe". In any event, you can use the differing values to determine which server environment your application is running in (including MONO for that matter, though I don't know what the string is for that), should you need to do so.

