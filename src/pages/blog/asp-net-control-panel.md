---
templateKey: blog-post
title: ASP.NET Control Panel
path: blog-post
date: 2009-03-03T07:31:00.000Z
description: Something I think would be a nice addition to ASP.NET (ideally
  shipping in 4.0 or N.0, but a community effort would also work) is a control
  panel that can be plugged into any application. A control panel would provide
  some or all of the following capabilities to a web site administrator
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
Something I think would be a nice addition to ASP.NET (ideally shipping in 4.0 or N.0, but a community effort would also work) is a control panel that can be plugged into any application. A control panel would provide some or all of the following capabilities to a web site administrator:

* View Page Trace output
* View Recent Exceptions
* View Cache Contents and Clear Cache
* Other tasks as plugins (manage membership, db connections, whatever)

With ASP.NET 1.0, support shipped out of the box for viewing a site’s trace output using an HttpHandler, by default called trace.axd. This can provide valuable diagnostic information, and of course can be locked down using standard authentication techniques (e.g. setting up a <location /> element in web.config). It also has some built-in security, such as a setting that locks it down only to localhost, if desired. You can learn more about ASP.NET Tracing [here](http://msdn.microsoft.com/en-us/library/wwh16c6c.aspx) if you’re unfamiliar with it. I’m always surprised when I give my tips-and-tricks talk how many people in the audience are unfamiliar with this feature, but in the defense it doesn’t get much press time these days.

For logging exceptions and viewing them online,[ELMAH](http://www.raboof.com/projects/Elmah) is one of the oldest and best choices available (others include more general logging frameworks like log4net). ELMAH stands for Error Logging Modules and Handlers and is an open source project, [originally introduced by Atif Aziz and Scott Mitchell on MSDN](http://msdn2.microsoft.com/en-us/library/aa479332.aspx). ELMAH provides, among other things, the ability to set up a handler that will allow you to view your site’s unhandled exceptions online. The exceptions may be persisted in memory or a database or sent by email or any number of other configurable options, but the key aspect that relates to an online control panel is the web viewable piece, accomplished via an HttpHandler.

For cache viewing and management, the [ASPAlliance CacheManager](http://www.aspalliance.com/CacheManager/Default.aspx) is the existing plugin that fills this need. It is modeled after ELMAH and provides the ability to view and remove individual items in the cache, clear the whole cache, and to remove individual pages’ output caches.

Today, if you want all of these capabilities, you need to configure tracing, download and configure ELMAH, and download and configure CacheManager. There is no integrated solution that bundles these (and potentially other) features together. Further, none of these applications know about the others, so there are no navigation links between them and their locations can be whatever you want, so if you’re not consistent it can be difficult to remember what URL you set up for each of these.

A control panel would basically incorporate all three of these projects into a unified plugin with centralized configuration and a single assembly and config deployment model. Additional plugins could be added as well, such that they were accessible from the control panel. I suppose the \*simplest\* version of such a control panel would just be a UI that knew the locations of the other pieces and provided the navigation to them, but obviously the ideal solution would be one that updated the UI of all three systems into something cleaner, prettier, and easier to use.

So, what do you think? Should Microsoft invest in something like this? Is it a worthwhile community project? Do you think many ASP.NET developers and site administrators would find this helpful?