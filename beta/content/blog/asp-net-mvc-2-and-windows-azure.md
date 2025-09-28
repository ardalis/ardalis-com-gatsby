---
title: ASP.NET MVC 2 and Windows Azure
date: "2010-04-17T05:08:00.0000000-04:00"
description: If you upgrade an Azure web instance to use ASP.NET MVC 2, make
featuredImage: img/asp-net-mvc-2-and-windows-azure-featured.png
---

If you upgrade an Azure web instance to use ASP.NET MVC 2, make sure you mark the System.Web.Mvc reference as Copy Local = true. Otherwise, your deployment will fail. And you won't get any good feedback from Windows Azure as to the cause of the problem. So you'll start searching the web for help, and perhaps you'll stumble on this post, and you'll realize that you didn't set Copy Local = true on your System.Web.Mvc assembly reference in your ASP.NET MVC 2 web instance. And you'll leave happy (or at least slightly happier) than when you came.

That is all.

![](/img/mvc2.png)

