---
templateKey: blog-post
title: Use HttpApplication.CompleteRequest Instead of Response.End
path: blog-post
date: 2009-04-06T07:34:00.000Z
description: HttpApplication.CompleteRequest is preferable to use for aborting a
  request in an ASP.NET application over Response.End, because it has better
  performance characteristics. If you’re using Response.End, you’ve probably at
  one time or another encountered
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - HttpApplication
category:
  - Uncategorized
comments: true
share: true
---
[HttpApplication.CompleteRequest](http://msdn.microsoft.com/en-us/library/system.web.httpapplication.completerequest.aspx) is preferable to use for aborting a request in an ASP.NET application over Response.End, because it has better performance characteristics. If you’re using Response.End, you’ve probably at one time or another encountered the [ThreadAbortException that goes along with it](http://support.microsoft.com/kb/312629).

The [behavior of CompleteRequest changed with 2.0, as Rick describes here](http://www.west-wind.com/WebLog/posts/5491.aspx). However, the reason why you’ll most likely want to call CompleteRequest rather than Response.End is that, while it still short-circuits the ASP.NET pipeline (jumping immediately to the EndRequest event), it does so without throwing a ThreadAbortException.

*(thanks to Stefan Schackow for this tip)*