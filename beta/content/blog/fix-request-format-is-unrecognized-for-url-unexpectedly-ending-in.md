---
title: FIX Request format is unrecognized for URL unexpectedly ending in
date: "2007-09-04T07:54:05.5170000-04:00"
description: "Adding a new web service to an application today so that I can delay loading some web user controls and ran into this 500 Error when calling the web service:"
featuredImage: img/fix-request-format-is-unrecognized-for-url-unexpectedly-ending-in-featured.png
---

Adding a new web service to an application today so that I can delay loading some web user controls and ran into this 500 Error when calling the web service:

Request format is unrecognized for URL unexpectedly ending in /GetHtml

Found this [KB article](http://support.microsoft.com/default.aspx?scid=kb;en-us;819267) with the fix:

Add the following to web.config since GET and POST are disabled by default in ASP.NET 2.0 and greater:

```html
<configuration>

 <system.web>

 <webServices>

 <protocols>

 <add name= "HttpGet&quot">

 <add name="HttpPost">

 </protocols>

 </webServices>

 </system.web>
</configuration>

