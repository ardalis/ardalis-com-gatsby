---
templateKey: blog-post
title: Optimize ASP.NET HTTP Connection Limit
path: blog-post
date: 2007-05-30T13:58:37.210Z
description: "Mads has a nice post on [optimizing ASP.NET to utilize more than
  its default of 2 concurrent web connections]. Here’s the relevant config
  info:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - performance
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Mads has a nice post on [optimizing ASP.NET to utilize more than its default of 2 concurrent web connections](http://blog.madskristensen.dk/post/Optimize-HTTP-requests-and-web-service-calls.aspx). Here’s the relevant config info:

<system.net>\
<connectionManagement>\
<add address=”*” maxconnection=”8″/>\
</connectionManagement>\
</system.net>

\[categories: performance]

<!--EndFragment-->