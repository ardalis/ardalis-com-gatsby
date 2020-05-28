---
templateKey: blog-post
title: BrowserHawk 11 Released
path: blog-post
date: 2007-10-26T11:22:18.114Z
description: "[CyScape] recently announced the latest version of their browser
  capabilities control, [BrowserHawk 11]. While I haven’t had a chance to review
  this new product yet, it touts some [new features] that at least appear to be
  pretty compelling."
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Cool Tools
  - reviews
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[CyScape](http://cyscape.com/) recently announced the latest version of their browser capabilities control, [BrowserHawk 11](http://cyscape.com/products/bhawk). While I haven’t had a chance to review this new product yet, it touts some [new features](http://www.cyscape.com/products/bhawk/new.aspx) that at least appear to be pretty compelling. I use BrowserHawk and [CountryHawk](http://cyscape.com/products/chawk) for [LakeQuincy’s advertising solution](http://lakequincy.com/), [AdSignia](http://lakequincy.com/adsignia), to quickly determine each ad request’s geographic location, allowing for certain ads to be targeted accordingly. We also pull some data from the user’s browser which we use primarily for statistical analysis (for example, what percentage of our users are running a particular screen size). It’s a rock solid and very fast set of products – **our ad engine is currently serving over 100M impressions per month** (an average of over 37 requests/sec – much more than that during peak usage)*, and these products **just work.**[**![BH RET Screenshot](<>)**](http://cyscape.com/)

The biggest new feature in BH11 is [Rules Enforcement Technology (RET)](http://www.cyscape.com/products/bhawk/ret.aspx) (shown above). Basically, this will allow you to easily ensure that users have the required features installed in their browsers, and take appropriate action if the user’s system is not properly configured. Another cool new addition is a set of video tutorials, including one dedicated to [introducing RET](http://www.cyscape.com/products/bhawk/tutorials/media/ret) (and using [Camtasia](http://techsmith.com/camtasia.asp), naturally). It also has a bunch of nice updates like Vista support, 64-bit support, etc. The other two features I think I will use immediately are [Silverlight Detection](http://www.cyscape.com/docs/showhelp.asp?topic=Plugin_Silverlight_Property_(.NET)) and [JavaScript Error Logging](http://www.cyscape.com/docs/showhelp.asp?topic=Monitoring_your_site_for_JavaScript_errors). Right now I have [ELMAH](http://code.google.com/p/elmah) and my own error logging routines to capture problems on the server, but nothing that will log client-side errors, so this sounds like it would be useful.



\* All of this is running on a [shared web farm](http://orcsweb.com/hosting/webfarmplan.aspx) at [Orcsweb](http://orcsweb.com/), which they only charge $399/mo for. Quite the steal for this kind of performance.

<!--EndFragment-->