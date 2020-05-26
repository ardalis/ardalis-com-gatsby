---
templateKey: blog-post
title: Accessing Session from an HttpHandler
path: blog-post
date: 2007-07-29T12:00:22.742Z
description: "I’ve run into this before but forgotten about it. I wrote an
  HttpHandler recently and was trying to access the Session object from the
  passed in HttpContext context object with "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - HttpHandler
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve run into this before but forgotten about it. I wrote an HttpHandler recently and was trying to access the Session object from the passed in HttpContext context object with

**context.Session\[“foo”] = “bar”;**

and I encountered a **NullReferenceException**. Some searching quickly yielded the answer, which is that in order to access Session from an HttpHandler you need to add a marker interface (meaning an interface with no implementation requirements) to your HttpHandler class. I had been looking for the solution in the web.config, wondering if perhaps I had disabled Session there, before I remembered this little gotcha.

There are in fact several options you can choose from, and it’s best for performance reasons if you limit your selection to only what is needed. The marker interfaces are found in the [System.Web.SessionState](http://msdn2.microsoft.com/en-us/library/system.web.sessionstate(vs.80).aspx) namespace, and include the following:

**[IRequiresSessionState](http://msdn2.microsoft.com/en-us/library/system.web.sessionstate.irequiressessionstate(VS.80).aspx)** – Specifies the HTTP handler requires both read and write access to session state values.

**[IReadOnlySessionState](http://msdn2.microsoft.com/en-us/library/system.web.sessionstate.ireadonlysessionstate(VS.80).aspx)** – Specifies the HTTP handler requires only read access to session state values.

<!--EndFragment-->