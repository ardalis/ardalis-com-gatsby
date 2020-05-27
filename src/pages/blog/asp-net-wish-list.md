---
templateKey: blog-post
title: ASP.NET Wish List
path: blog-post
date: 2007-03-14T16:30:48.229Z
description: "I’m at the MVP Summit this week in Seattle and one of the things
  this provides an opportunity for is providing feedback to the product teams. "
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

I’m at the MVP Summit this week in Seattle and one of the things this provides an opportunity for is providing feedback to the product teams. I certainly have plenty of ideas of my own for new features I’ve been longing to see in ASP.NET, as well as fixes for some annoyances. If you have ASP.NET feature requests of your own, please add them as comments. I’m going to make sure the ASP.NET team reads this post.

My short list of ASP.NET feature requests follows:

**Recursive FindControl**\
A very common issue with ASP.NET today is locating references to controls that are not referenced directly from the page. For instance, if you want to refer to a button called Button1 within a LoginView control, you can’t use Button1 on the page directly in your code. You have to get a reference to it by using the LoginView.Controls collection, or by using LoginView.FindControl(id). However, if it’s further nexted within a Template then it won’t even be found by using this process, and the easiest way to locate it becomes using a [recursive findcontrol like this one](http://aspadvice.com/blogs/ssmith/archive/2006/08/23/Add-Profile-Items-in-CreateUserWizard-and-Recursive-FindControl.aspx). This should be added into the framework, or a better system of having references to controls on the page should be added so that it is easier to refer to unique controls by ID on the page. There are [many](http://www.google.com/search?hl=en&q=recursive+findcontrol)[people](http://search.live.com/results.aspx?q=recursive%20findcontrol) looking for this.

**Cache Invalidation Options**\
When a cached item comes up for invalidation, there should be an option whereby the application can hook into the invalidation process and abort the invalidation. The reason for this is so that the application can update the cache if necessary (or just keep it in the cache if desired, based on some business logic), so that at a higher level, things that are looking for the item in the cache don’t find it to be null and go regen it on the customer’s dime. The way it stands today, the CacheRemovedCallback is worthless in this case because it fires after the cached data has been nulled, so while the callback is executing, other requests are finding the null in the cache and are kicking off their logic to fetch the data from its source – meanwhile the user is waiting for this request. Allowing the cache to be updated offline without making the user’s request wait for it would be a great improvement. Some third party tools like [ScaleOut StateServer](http://www.scaleoutsoftware.com/products/stateServer/index.html) provide this feature today, but it would be great it if were included in the built-in cache.

**Distributed Cache**\
Building on the caching theme, it would be great if there were support for a distributed cache. A distributed cache would ensure that all servers in a web farm have the same data in cache at any given time, so requests made to any server will have the same data. One of the biggest disadvantages of the ASP.NET Cache is that it has application affinity. Sql Invalidation can help this to a degree, but this imposes additional overhead on the database and does not scale well to dozens of servers and very large scenarios.

**Cache Provider Model**\
Between ASP.NET 1.x and 2.x, session state was improved to support a provider model. It would be great if the cache worked as a provider as well, so that it could be customized easily or replaced with a third party tool if desired (such as [Cache Application Block](http://msdn2.microsoft.com/en-us/library/aa480456.aspx), [ScaleOut](http://www.scaleoutsoftware.com/products/stateServer/index.html), [NCache](http://www.alachisoft.com/ncache/index.html), etc.).

**Cache To Disk**\
Bring it back from the Whidbey cut list.

**Cache Management**\
Add something like trace.axd for cache management. Heck, use [my cache manager](http://aspalliance.com/cachemanager). It provides a way to view the cache, clear the cache, or remove individual cache entries or page’s output caches.

**Last caching request I promise.**

**[LINQ Support for SQL Cache Invalidation via SQL 2005 Notifications](http://aspadvice.com/blogs/ssmith/archive/2006/12/06/C_2300_-3.0-Feature-Notes.aspx)**\
LINQ as it stands today is a black box. Under the covers it uses ADO.NET to talk to the database but there are no hooks I’m aware of to reach into this process and add, for example, a SqlCacheDependency using the new SQL Cache Invalidation features in SQL 2005 and ASP.NET 2.0. Certainly above LINQ you can use the Cache API, but the SQL 2005 notification based cache invalidation is dependent on the actual SQL (and SqlCommand) used, so there is no way to tack that on above the ADO.NET level.

**ViewState Provider Model (or configuration options)**\
A common optimization that helps many sites is to move ViewState from the wire/page to server memory/session. Having some built-in ways to tweak the ViewState behavior, or better yet a plug-and-play provider system with a couple of default providers, would be great.

**Anti-Spam or CAPTCHA Validator Control**\
Spam sucks, and it’s getting worse. There are some things coming in the [AJAX Control Toolkit](http://ajax.asp.net/ajaxtoolkit/NoBot/NoBot.aspx) that help this, but it would be great if there were something like the [InvisibleCaptcha](http://haacked.com/archive/2006/09/26/Lightweight_Invisible_CAPTCHA_Validator_Control.aspx) built in as a validator.

**Control Improvements**\
The built-in Calendar control has a lot of issues. Improving it at least to the point where one can navigate to arbitrary years and months rather than just going forward and back one month at a time would be great. So would a cleaner design. Making it work as a datepicker would be cool, too.

**Factor Out Common User Errors (if possible)**There are a few areas where developers, especially novice developers, repeatedly make mistakes because the API does not make it obvious how things should be done. The two I’m thinking of right now is working with DataReader objects and not closing them correctly, especially when these are passed back as return types from functions. A great pattern to follow (apart from just **not passing DataReaders between methods**) is to [use a delegate](http://aspalliance.com/526), ([see my post](http://aspadvice.com/blogs/ssmith/archive/2004/09/17/1821.aspx)cache ) but this is not at all intuitive. Another area of very frequent mistakes is cache access. I have a [cache access pattern](http://aspadvice.com/blogs/ssmith/archive/2004/04/02/1803.aspx) that demonstrates the safe way to access the cache, but if the API could be refactored somehow to make this process require less code and still be safe, that would be great.

**AJAX File Upload Control**\
I’d love to be able upload files without a postback. Or to pop-up a modal dialog and in the dialog, upload a file and have that file show up on the host page (again, no postback).

**SSL / HTTPS Support in Cassini / WebDev.WebServer**\
I like having a non-IIS web server to test on. I don’t like that I can’t test SSL on it. This requires me to write special “am I running in dev/test” code in my SSL required pages, which is annoying. If we’re expected to all use IIS7 going forward, then that’s cool (especially since you can launch it from the command prompt now), but if WebDev.WebServer will exist in future VS drops, please give it full SSL support.

**ASP.NET Page Metrics, Static Analysis, Rules, Code Quality Checks**I want to see something like FxCop for ASP.NET which would have some pieces that would apply staticly and some pieces that would provide some checks on a live application (either in test or even in production). For instance, here are some checks I’d like to see (and I’m sure you can come up with more):\
– ViewState Size / Does it exceed threshold?\
– Page Size (total) / Does it exceed threshold?\
– Render/Response Time / Threshold\
– Trace Enabled?\
– Debug Enabled?\
– Session Enabled?\
– ValidateRequest Enabled?\
etc.

So that’s my short list of requests – please add yours!

Tags: [ASP.NET](http://technorati.com/tag/ASP.NET)

<!--EndFragment-->