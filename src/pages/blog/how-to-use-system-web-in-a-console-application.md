---
templateKey: blog-post
title: How to use System.Web in a Console Application
path: blog-post
date: 2012-03-16T03:36:00.000Z
description: "I’ve been bitten by this and have seen others run into it enough
  times that I thought I’d blog about it. Let’s say you’re creating a new
  Console, WPF, or Windows Forms application in .NET 4. You’re using Visual
  Studio 2010, and everything is going great until you get to the part where you
  wanted to make an HTTP request. "
featuredpost: false
featuredimage: /img/snaghtml59c784_thumb.png
tags:
  - .net
  - visual studio
category:
  - Software Development
comments: true
share: true
---
I’ve been bitten by this and have seen others run into it enough times that I thought I’d blog about it. Let’s say you’re creating a new Console, WPF, or Windows Forms application in .NET 4. You’re using Visual Studio 2010, and everything is going great until you get to the part where you wanted to make an HTTP request. You know you can do this, you’ve done it before, heck, you might even be copying code straight out of MSDN that does what you need. But it doesn’t compile. If you try and add a reference to System.Web, you’ll find it’s not there:

![](/img/snaghtml53c449_1.png)

If you look closely, though, you’ll see at the top of the dialog it says “Filtered to: .NET Framework 4 Client Profile”. That’s the issue. Now, if you really are doing HTTP requests in a console application in .NET 4, then I recommend you use the System.Net.HttpWebRequest type that \*is\* available in the Client profile. But for argument’s sake, if you really do need something in one of the filtered out assemblies, like System.Web, then you simply need to change your project type to use the full .NET 4 Framework. You can do that by going into project properties and changing the Target framework from .NET Framework 4 Client Profile to simply .NET Framework 4.

![](/img/image_3_console_app.png)

Having done that, you’ll then be able to reference System.Web again in your project. Hope that helps!

![](/img/snaghtml59c784_thumb.png)