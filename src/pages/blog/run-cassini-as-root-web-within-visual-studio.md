---
templateKey: blog-post
title: Run Cassini as Root Web within Visual Studio
path: blog-post
date: 2006-07-26T03:23:19.792Z
description: "I’ve been fighting with differences in folder paths between
  production and dev (via Cassini / WebDevServer) for a while now and stumbled
  upon this forum topic today and gave it a shot. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve been fighting with differences in folder paths between production and dev (via Cassini / WebDevServer) for a while now and stumbled upon [this forum topic](http://www.velocityreviews.com/forums/t115876-can-cassini-be-configured-to-run-in-the-root.html) today and gave it a shot. The forum didn’t provide full details but here’s what I managed to figure out. Yes, Cassini supports root pathed sites, but it’s not how Visual Studio (or, presently, Expression Web Designer) are configured to use it by default. If you want to make it work, you can, using these steps:

1. In your Solution Explorer, right click on your website and go to its Property Pages (or Start Options).\
2. Change Start action: to “Start external program:“ and specify this path:\
C:WINDOWSMicrosoft.NETFrameworkv2.0.50727WebDev.WebServer.EXE\
3. Set Command line arguments as such (change /path to be the path of your current website):\
/port:8080 /path:”C:WebsitesMyWeb”\
4. Set Working directory to be your .NET Framework Version Root:\
C:WINDOWSMicrosoft.NETFrameworkv2.0.50727\
5. Change the Server option from “Use default Web server” to “Use custom server”\
6. Set the Base URL to\
<http://localhost:8080/> or whatever port you care to use.

Now to use a page, you need to:\
1. Run the site by pressing F5, Ctrl-F5, or clicking the “Run” icon in VS. This will open up a black window hosting the WebDev.WebServer.EXE process which will hang around on your screen as long as the web server is running. I’m sure there’s an easy way to have it start without this window (because, hey, it doesn’t do that when VS launches Cassini), but I haven’t figured it out yet.

2. Right click on a page you want to view and click “View in Browser” from within Solution Explorer or the edit window for any ASP.NET page. Or open up a browser yourself and type in the URL yourself.

That works for me – hopefully it does for you as well. I’d like to figure out a way to get the webdev window to not show up and figure out a way to make Right-Click View In Browser automatically launch the webserver if it hasn’t already been launched (as VS does now) but apart from that inconvenience, this is a working solution. Below is a screenshot showing my Property Page.

**WebSite Property Page Settings**

**Update**: [ScottGu Apparently also covered this last November](http://weblogs.asp.net/scottgu/archive/2005/11/21/431138.aspx)… Guess I missed that. His technique is even a bit better since it lets you keep the Start action as Use Current Page.

<!--EndFragment-->