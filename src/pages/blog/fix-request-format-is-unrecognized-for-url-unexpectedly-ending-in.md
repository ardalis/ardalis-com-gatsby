---
templateKey: blog-post
title: FIX Request format is unrecognized for URL unexpectedly ending in
path: blog-post
date: 2007-09-04T11:54:05.517Z
description: "Adding a new web service to an application today so that I can
  delay loading some web user controls and ran into this 500 Error when calling
  the web service:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Atlas and Ajax
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Adding a new web service to an application today so that I can delay loading some web user controls and ran into this 500 Error when calling the web service:

Request format is unrecognized for URL unexpectedly ending in /GetHtml

Found this [KB article](http://support.microsoft.com/default.aspx?scid=kb;en-us;819267) with the fix:

Add the following to web.config since GET and POST are disabled by default in ASP.NET 2.0 and greater:

<!--EndFragment-->

```
&lt;configuration&gt;

    &lt;system.web&gt;

    &lt;webServices&gt;

        &lt;protocols&gt;

            &lt;add name=<span class="str">&quot;HttpGet&quot;</span>/&gt;

            &lt;add name=<span class="str">&quot;HttpPost&quot;</span>/&gt;

        &lt;/protocols&gt;

    &lt;/webServices&gt;

    &lt;/system.web&gt;

&lt;/configuration&gt;
```

<!--StartFragment-->

I'd forgotten this little detail…

<!--EndFragment-->