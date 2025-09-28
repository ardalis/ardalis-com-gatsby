---
title: Extract Control for ASP.NET in Visual Studio
date: "2008-04-14T21:18:00.1970000-04:00"
description: I've been posting about some feature requests for ASP.NET/Visual
featuredImage: img/extract-control-for-asp-net-in-visual-studio-featured.png
---

I've been posting about some [feature](http://aspadvice.com/blogs/ssmith/archive/2007/03/14/ASP.NET-Wish-List.aspx) requests for ASP.NET/ [Visual Studio](http://aspadvice.com/blogs/ssmith/archive/2008/03/16/Three-Requests-for-ASP.NET-4-and-VS-2010.aspx), so here's one more in that thread.

One nice feature of Blend is the ability to select a chunk of XAML and choose to "Extract User Control". The result works very nicely, creating the separate control and inserting the reference to that control into the original XAML document. It would be very cool if ASP.NET had this same notion, wherein one could select a chunk of ASPX markup and choose"Extract User Control" and have it create the.ascx file for you and insert the reference to that control into the original page.

Another nice addition to take this another step further would be the ability to convert an ASCX file into a compiled control. I wrote [an article and did some talks a few years ago about the evolution of controls from ASPX to ASCX to.CS (.VB)](http://msdn2.microsoft.com/en-us/library/aa478969.aspx). This is pretty much all a manual process and progression (it was then, and it is still today), but it would be nice if this were a bit easier via a VS tool or even a third party refactoring tool. Perhaps this already exists, in which case I'll look for comments from the Resharper/RefactorPro guys shortly… (like [last time](http://aspadvice.com/blogs/ssmith/archive/2008/04/02/Refactor-Request.aspx))

