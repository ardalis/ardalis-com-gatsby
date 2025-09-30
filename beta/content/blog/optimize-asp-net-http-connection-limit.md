---
title: Optimize ASP.NET HTTP Connection Limit
date: "2007-05-30T09:58:37.2100000-04:00"
description: "Mads has a nice post on optimizing ASP.NET to utilize more than its default of 2 concurrent web connections. Here's the relevant config info:"
featuredImage: img/optimize-asp-net-http-connection-limit-featured.png
---

Mads has a nice post on [optimizing ASP.NET to utilize more than its default of 2 concurrent web connections](http://blog.madskristensen.dk/post/Optimize-HTTP-requests-and-web-service-calls.aspx). Here's the relevant config info:

<system.net>\
<connectionManagement>\
<add address="*" maxconnection="8″/>\
</connectionManagement>\
</system.net>

\[categories: performance]

