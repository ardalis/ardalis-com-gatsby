---
templateKey: blog-post
title: Wiring Up TimeAgo and ASPNET MVC
path: blog-post
date: 2013-08-20T16:46:00.000Z
description: Imagine you want to display something on a page so that instead of
  raw dates, the user is shown something more relative to the current time.
featuredpost: false
featuredimage: /img/timeago.png
tags:
  - asp.net
  - javascript
  - jquery
  - mvc
category:
  - Software Development
comments: true
share: true
---
Imagine you want to display something on a page so that instead of raw dates, the user is shown something more relative to the current time. You’ve probably seen this in some of the applications you use. “Last Updated: A moment ago” or “about an hour ago”. There are a variety of ways you can implement this, and it’s been done in[many](http://stackoverflow.com/questions/11/how-do-i-calculate-relative-time)[different](http://stackoverflow.com/questions/195740/how-do-you-do-relative-time-in-rails)[languages](http://www.devnetwork.net/viewtopic.php?f=50&t=113253). In my case, which is an ASP.NET MVC C# application, I considered doing it on the server and simply passing the result as a string to the view for display. However, in searching for the best way to do this, I stumbled upon the[Timeago plugin for jQuery](http://timeago.yarp.com/).

![](/img/timeago.png)

One of the key benefits of this plugin is that, unlike embedding the strings directly in the HTML, if the user leaves the page open for a while, the relative times remain accurate. A nice side effect of this is that your pages can still using caching, since they just send the actual datetime of the event’s occurrence, and let Timeago format it into a relative string. Without this, if you want accurate relative times to be reported, you would need to avoid caching or use [micro-caching](http://ardalis.com/1811), since the strings representing the times would rapidly change from “a few seconds ago” to “a minute ago” etc.

Getting set up with Timeago proved to be very simple. Their home page lists the necessary steps on the client side. On the server side, all you need to do is send a date in the proper format, which is [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601). This proved to be slightly challenging to figure out, but once I found the right format setting, it was simple.

The trick is to use a UtcNow and the “o” parameter of .ToString(). For example:

LastActivityDateString=DateTime.UtcNow.ToString(“o”)

Then, in your view, you can simply output the <abbr> tag like so:

<abbr class=”timeago” title=”#:LastActivityDateString #”>#:LastActivityDateString #</abbr>

(in this case I’m using a [Kendo UI Template](http://docs.kendoui.com/getting-started/framework/templates/overview))

In Razor syntax:

<abbr class=”timeago” title=”@Model.LastActivityDateString”>@Model.LastActivityDateString</abbr>

When you’re done, you’ll be able to display relative times, like these, that update in realtime even after the user has left the web page open for a while.

![](/img/13minagp.png)