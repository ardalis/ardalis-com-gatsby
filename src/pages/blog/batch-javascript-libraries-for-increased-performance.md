---
templateKey: blog-post
title: Batch JavaScript Libraries for Increased Performance
path: blog-post
date: 2008-07-28T03:21:00.000Z
description: "I’ve been meaning to set up batched loading of the JavaScript
  libraries used by Lake Quincy Media’s administration application for some
  time, and finally had a chance this past weekend. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - JavaScript
category:
  - Uncategorized
comments: true
share: true
---
I’ve been meaning to set up batched loading of the JavaScript libraries used by [Lake Quincy Media’s](http://lakequincy.com/) administration application for some time, and finally had a chance this past weekend. The site uses a variety of third-party tools such as [DevExpress](http://devexpress.com/),[ComponentArt](http://componentart.com/),[AJAX Control Toolkit](http://www.codeplex.com/AjaxControlToolkit),[Overlib](http://www.bosrup.com/web/overlib),[PeterBlum](http://peterblum.com/),[Dundas Charts](http://dundas.com/), and probably a couple of others I’m forgetting at the moment. As a result, the site’s initial load tended to be pretty sluggish. JavaScript libraries are loaded and executed serially by the browser, resulting in a pretty significant bottleneck to page load time, as shown here

![](/img/java-script1.png)

Once loaded the first time, most of these scripts are cached in the client, so performance doesn’t remain dreadful (and usually the individual files don’t take as long as they are above). However, you can see how this has a seriously detrimental effect on the site’s perceived performance, and this has nothing to do with any kind of server or database processing time (which is typically the first place folks go looking for performance issues within ASP.NET applications).

While researching this problem I found a couple of helpful links:

* [Combine Multiple JavaScript and CSS Files and Remove Overhead](http://geekswithblogs.net/rashid/archive/2007/07/25/Combine-Multiple-JavaScript-and-CSS-Files-and-Remove-Overheads.aspx)
* [Client-side caching for script methods access in ASP.NET AJAX](http://www.codeproject.com/KB/ajax/ScriptMethodClientCache.aspx)

More importantly, though, I discovered that the [AJAX Control Toolkit](http://www.codeplex.com/AjaxControlToolkit) project added a new ScriptManager object over a year ago that I’d overlooked. [David Anson blogged about the new ToolkitScriptManager](http://blogs.msdn.com/delay/archive/2007/06/11/script-combining-made-easy-overview-of-the-ajax-control-toolkit-s-toolkitscriptmanager.aspx) class last June, explaining its script combining features. Replacing my ScriptManager with this one resulted in an immediate and significant reduction in the number of ScriptResource.axd calls required. The ToolkitScriptManager inherits from ScriptManager, so you simply need to replace <asp:ScriptManager /> with <ajaxToolkit:ToolkitScriptManager /> assuming your prefix for the AJAX Control Toolkit is ajaxToolkit.

It’s a good idea to use a separate domain for static files like images, CSS, and common scripts, because browsers typically will open 2 concurrent connections*per domain*to retrieve such things. However, in the case of scripts like these, the browser only loads them one at a time, and further since they’re dynamic (at least, the *.axd ones), there’s no simple way to use a separate domain anyway.

After switching to ToolkitScriptManager, I still had a bunch of dynamic script calls, which I determined were being loaded by ComponentArt controls. I figured they probably had a similar batch load mechanism, and they did not disappoint. Milos wrote about [Optimizing Web.UI Client Script Deployment](http://www.componentart.com/BLOGS/milos/archive/2007/10/29/optimizing-web-ui-client-script-deployment.aspx), which has the necessary steps. It requires setting up a handler and adding a key to <appSettings /> ([something which I think is a bad idea for components to use](https://ardalis.com/avoid-appsettings-usage-in-controls-or-shared-libraries)), but otherwise it was quite painless.

Finally, I determined that the Overlib scripts we’re using were only needed by one custom control we’d created for displaying Help dialogs, but the scripts were being included in the Master page. Many pages show the help dialogs, but many do not, and there were 4 separate scripts being loaded. I could have written my own handler or updated the custom control to automatically emit the required script references, but since I was going for the simplest thing that worked I opted to wrap the 4 <script /> tags in an ASP.NET Panel control and set its visibility to a property on the common base page. I then set this property to true from my Help control’s Page property, after casting it to our base page class using the as keyword to ensure type safety.

The end result is shown here

![](/img/java-script2.png)

The scripts are still loaded serially, but there are far fewer of them, so the overall page load time is dramatically reduced. In this case I had to look at three different approaches for three different sets of scripts that I was using. However, it’s possible to use an HttpModule to look at all of the resources on the page and batch them up into fewer requests. The links I listed above show some of this, but if you want an off-the-shelf solution, check out the [Runtime Page Optimizer from ActionThis](http://runtimepageoptimizer.com/), which will do this and more. The product is still in beta, but it offers 9 different page load optimizations that take script, css, and even images and batch them up on the server and request them as fewer, larger chunks on the client. I’ve tested it and it’s not quite 100% ready to go for my needs, but that’s mainly because of some conflicts with the many different third-party tools I’m using. On simpler pages, **it just works**, so check it out if you want a simple solution to batching up scripts and other files to improve performance of your web application.