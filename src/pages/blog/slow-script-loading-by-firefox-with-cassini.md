---
templateKey: blog-post
title: Slow Script Loading by FireFox with Cassini
path: blog-post
date: 2008-12-30T10:08:00.000Z
description: Bertrand just posted about a bug I’d encountered before but never
  tracked down wherein FireFox (and in particular, FireBug) is extremely slow in
  loading scripts for a local web site running on Cassini (Dev Web Server).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - FireFox
category:
  - Uncategorized
comments: true
share: true
---
[Bertrand](http://devmavens.com/BertrandLeRoy) just posted about a bug I’d encountered before but never tracked down wherein [FireFox (and in particular, FireBug) is extremely slow in loading scripts for a local web site running on Cassini](http://weblogs.asp.net/bleroy/archive/2008/12/29/why-are-scripts-slow-to-load-in-firefox-when-using-visual-studio-s-built-in-development-web-server-a-k-a-cassini.aspx) (Dev Web Server). It turns out that the issue has to do with an FF bug trying resolve “localhost” using IPv6. [Dan Wahlin follows up with the fix, describing how to disable IPv6 in FireFox](http://weblogs.asp.net/dwahlin/archive/2007/06/17/fixing-firefox-slowness-with-localhost-on-vista.aspx). Since the issue has to do with name resolution, another workaround is to simply change the URL from using localhost to using 127.0.0.1.

With the bug in place, individual requests typically take over a second. Using 127.0.0.1 or disabling IPv6 in FireFox results in the expected 5-25ms response times for static local resources.