---
templateKey: blog-post
title: Cache Manager Almost Ready
path: blog-post
date: 2005-12-03T14:03:31.867Z
description: "I’m almost done with my Cache Manager application, which is
  modeled after ELMAH and uses an HttpHandler model to add cache management
  functionality to any ASP.NET application. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Caching
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’m almost done with my Cache Manager application, which is modeled after [ELMAH](http://workspaces.gotdotnet/elmah)and uses an HttpHandler model to add cache management functionality to any ASP.NET application. At the moment it’s built using VS 2005 and v2 of the framework, but doesn’t really use any 2.0 functionality (except for .resx files, which are AWESOME for managing string resources within a project!). Here’s a screenshot:

![screenshot](<>)

[http://aspadvice.com/photos/ssmith/picture14144.aspx](http://ardalis.com/photos/ssmith/picture14144.aspx)

Current Features:

* Clear Application Cache
* View Cache API contents

  * View values of most simple types
* Remove specific page’s output cache entries
* View Cache/Server stats
* * Server Name
  * Server Cache Maximum Memory (mb)
  * Server Free Memory (mb)
  * Application Path
  * Application Cache Entries



I’m hoping to add some support for guessing at the memory footprint of the total cache and/or individual items, but this is not an easy problem, it seems. I borrowed a bit from [this article](http://www.codeproject.com/aspnet/exploresessionandcache.asp), which describes a method of getting object sizes that, unfortunately, is not recommended because it isn’t accurate. I’m hoping to hear something from the ASP.NET team that will let me implement a somewhat accurate memory estimate algorithm soon, though.

The initial feedback I’ve received is that the UI is pretty ugly. To be honest I think it looks great compared to what it started out as. If you have any recommendations for the UI, or have some design skills and want to take a pass at the HTML+CSS, let me know.

<!--EndFragment-->