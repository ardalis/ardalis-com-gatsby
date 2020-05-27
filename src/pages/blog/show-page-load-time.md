---
templateKey: blog-post
title: Show Page Load Time
path: blog-post
date: 2008-07-07T02:32:45.544Z
description: "When testing performance for an individual ASP.NET page, it’s
  often useful to be able to see how long the page took to render. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - load time
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

When testing performance for an individual ASP.NET page, it’s often useful to be able to see how long the page took to render. The bar-none easiest way to achieve this is to simply add Trace=”true” to the <%@ Page %> directive, which will yield results like this:

[![Trace Output](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/ShowPageLoadTime_A79B/image_2.png)

However, often times this won’t play nicely with CSS on the page, so you can achieve similar results on a separate URL by adding <trace enabled=”true” pageOutput=”false” /> to your web.config’s <system.web /> section. Then, simply navigate to your web application folder path and add /trace.axd to the request and you’ll be able to choose from a list of requests.

In addition to the timings, the trace output also shows a ton of other stuff, which sometimes is more than you need and can be distracting if all you really care about is how fast the page loaded. To achieve something “good enough” for most purposes, you can add something like the following to your [base page class](http://aspadvice.com/blogs/ssmith/archive/2006/09/14/Ultimate-ASP.NET-Base-Page-Class.aspx) or master page:

<!--EndFragment-->

```
DateTime startTime = DateTime.Now;

<span style="color: #0000ff">protected</span> <span style="color: #0000ff">override</span> <span style="color: #0000ff">void</span> OnPreRender(EventArgs e)
{

   <span style="color: #0000ff">base</span>.OnPreRender(e);
   <span style="color: #0000ff">this</span>.LoadTime.Text = (DateTime.Now - startTime).TotalMilliseconds.ToString();
   <span style="color: #0000ff">this</span>.ServerTime.Text = DateTime.Now.ToString();

}
```

This example is from a master page that includes the following in its markup:

```
<span style="color: #0000ff">&lt;</span><span style="color: #800000">div</span> <span style="color: #ff0000">id</span><span style="color: #0000ff">="footer"</span><span style="color: #0000ff">&gt;</span>Load Time: <span style="color: #0000ff">&lt;</span><span style="color: #800000">asp:Literal</span> <span style="color: #ff0000">runat</span><span style="color: #0000ff">="server"</span> <span style="color: #ff0000">ID</span><span style="color: #0000ff">="LoadTime"</span> <span style="color: #0000ff">/&gt;</span> ms<span style="color: #0000ff">&lt;</span><span style="color: #800000">br</span> <span style="color: #0000ff">/&gt;</span>
Server Time:  <span style="color: #0000ff">&lt;</span><span style="color: #800000">asp:Literal</span> <span style="color: #ff0000">runat</span><span style="color: #0000ff">="server"</span> <span style="color: #ff0000">ID</span><span style="color: #0000ff">="ServerTime"</span> <span style="color: #0000ff">/&gt;&lt;</span><span style="color: #800000">br</span> <span style="color: #0000ff">/&gt;</span>
```

<!--StartFragment-->

This approach doesn’t include some of the time spent on rendering logic, but does include everything else the page is doing, such as expensive calls to web services, the file system, or the database, and so it does a good job of showing whether or not changes to such access are improving the overall page load time (or not).

Phil Haack has an alternative approach that [uses an HttpModule to insert the page load time into the page’s HTML](http://haacked.com/archive/2008/07/02/httpmodule-for-timing-requests.aspx). The code as written can have some issues with JSON callbacks from UpdatePanels, but some of the comments on the post describe techniques to avoid this. The nice thing about an HttpModule is that you don’t need to duplicate the code in other projects or pages. Once you have your own HttpModule for doing page timing, you can add it to any projects you like, and it’s easily included in developer builds and not in production builds through the use of separate web.config files in each environment (which in all likelihood is already in place).

It’s also worth noting that Phil’s example uses the [System.Diagnostics.Stopwatch](http://msdn.microsoft.com/en-us/library/system.diagnostics.stopwatch.aspx) class, which provides greater accuracy than simply comparing DateTimes directly. For something like this, where we’re looking at full page load times, the extra accuracy is typically not needed, but it’s an important class to know about for when you’re timing small bits of code to try and determine which is faster down to a few milliseconds (or less). On some systems the Stopwatch may not be any faster – you can check if the currently running environment supports higher resolution timing by using the **IsHighResolution** property.

<!--EndFragment-->