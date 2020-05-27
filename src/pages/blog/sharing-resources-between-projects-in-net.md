---
templateKey: blog-post
title: Sharing Resources Between Projects in .NET
path: blog-post
date: 2007-10-17T11:28:00.463Z
description: "ASP.NET has some great support for Resources (for localization and
  internationalization, mainly), but unfortunately by default they’re limited to
  the same project because they’re generated with the internal keyword. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - Cool Tools
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

ASP.NET has some great support for Resources (for localization and internationalization, mainly), but unfortunately by default they’re limited to the same project because they’re generated with the internal keyword. I wanted to be able to share common strings for things like Exception messages, format strings, and default messages between members of my business objects and within my ASP.NET application, without duplicating the resources between these two separate projects. I did some searching and found [a great writeup by Rick](http://www.west-wind.com/WebLog/posts/9120.aspx), but it didn’t quite do the trick. However, fellow RD Guy pointed me to this [great tool on CodeProject](http://www.codeproject.com/dotnet/ResXFileCodeGeneratorEx.asp) that “just works”. It does two things that the standard resource generator does not:

* It generates a public class rather than an internal class
* It creates special Format() methods for any resource it determines is a format string which have exactly the expected number of arguments.

Getting this set up and working was pretty trivial and it’s working great. [Brendan has a bit more to say about it on his blog](http://aspadvice.com/blogs/name/archive/2007/10/16/Public-Strongly-Typed-Resource-Generator.aspx).

<!--EndFragment-->