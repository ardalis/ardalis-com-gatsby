---
templateKey: blog-post
title: Extract Control for ASP.NET in Visual Studio
path: blog-post
date: 2008-04-15T01:18:00.197Z
description: I’ve been posting about some feature requests for ASP.NET/Visual
  Studio, so here’s one more in that thread.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - silverlight
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve been posting about some [feature](http://aspadvice.com/blogs/ssmith/archive/2007/03/14/ASP.NET-Wish-List.aspx) requests for ASP.NET/ [Visual Studio](http://aspadvice.com/blogs/ssmith/archive/2008/03/16/Three-Requests-for-ASP.NET-4-and-VS-2010.aspx), so here’s one more in that thread.

One nice feature of Blend is the ability to select a chunk of XAML and choose to “Extract User Control”. The result works very nicely, creating the separate control and inserting the reference to that control into the original XAML document. It would be very cool if ASP.NET had this same notion, wherein one could select a chunk of ASPX markup and choose “Extract User Control” and have it create the .ascx file for you and insert the reference to that control into the original page.

Another nice addition to take this another step further would be the ability to convert an ASCX file into a compiled control. I wrote [an article and did some talks a few years ago about the evolution of controls from ASPX to ASCX to .CS (.VB)](http://msdn2.microsoft.com/en-us/library/aa478969.aspx). This is pretty much all a manual process and progression (it was then, and it is still today), but it would be nice if this were a bit easier via a VS tool or even a third party refactoring tool. Perhaps this already exists, in which case I’ll look for comments from the Resharper/RefactorPro guys shortly… (like [last time](http://aspadvice.com/blogs/ssmith/archive/2008/04/02/Refactor-Request.aspx))

<!--EndFragment-->