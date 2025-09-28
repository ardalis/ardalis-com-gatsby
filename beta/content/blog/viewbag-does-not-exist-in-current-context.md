---
title: ViewBag does not exist in current context
date: "2011-01-30T06:10:00.0000000-05:00"
description: "If you're working with the ASP.NET MVC 3 MvcMusicStore demo and you run into the error message:"
featuredImage: /img/error-261887_1280.jpg
---

If you're working with the ASP.NET MVC 3 MvcMusicStore demo and you run into the error message:

> **The name 'ViewBag' does not exist in the current context**

It's probably a sign that you are running on an older version of ASP.NET MVC (or a pre-release of MVC 3). You can [download the latest version of ASP.NET MVC 3 here](http://www.asp.net/mvc/mvc3). This will install the Web Platform Installer (version 3) and will install ASP.NET MVC 3:

Once MVC 3 (released version) is installed, recompile the [MVC Music Store demo](http://mvcmusicstore.codeplex.com/) and your "ViewBag does not exist in current context" errors should disappear.

**Update**: You may still see this error if you have an application that you built using the pre-release versions of MVC 3. In that case, the fix that worked for me is to update the web.config in the /Views folder to use the one from the RTM version of MVC 3 (you can find one such as part of the [mvc music store source code, here](http://mvcmusicstore.codeplex.com/SourceControl/changeset/view/b783a1bfa56c#MvcMusicStore%2fViews%2fWeb.config)).

**Update 2**: There's also an upgrade tool that, if used, should prevent all of the above problems:

<http://blogs.msdn.com/b/marcinon/archive/2011/01/13/mvc-3-project-upgrade-tool.aspx>

