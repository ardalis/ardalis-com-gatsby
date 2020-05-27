---
templateKey: blog-post
title: AspAlliance Simple CMS Plugin
path: blog-post
date: 2006-07-19T03:45:25.219Z
description: I’ve been interested in plug-in applications for ASP.NET for a
  while now. I think it can be a very powerful way to quickly add new
  functionality to an existing site without significant rework of the site being
  extended
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Cool Tools
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve been interested in plug-in applications for ASP.NET for a while now. I think it can be a very powerful way to quickly add new functionality to an existing site without significant rework of the site being extended. The architecture that makes this possible is the HttpHandler and HttpModule combination that, in fact, is what makes ASP.NET work in the first place. One simple example of such an application, which is built into ASP.NET, is the application trace viewer, commonly known as trace.axd. Trace.axd is simply an HttpHandler that is mapped in the server’s configuration file (machine.config or the server’s web.config, in C:WINDOWSMicrosoft.NETFramework\[version]CONFIG). You’ll find trace.axd defined here:



<httpHandlers>

<addpath=“trace.axd“verb=“*“type=“System.Web.Handlers.TraceHandler“validate=“True“/>

…

</httpHandlers>

What’s powerful about this kind of application is that it can be easily configured, added to some sites, removed from others, etc. Let’s say you consider trace.axd a security risk. You can remove it from all sites or from any one site. Or you can rename it to “securetrace.axd” and add some security by making it much harder for someone to guess the file’s location. And of course you can lock it down using .NET security, like so:



<locationpath=“trace.axd“>

<system.web>

<authorization>

<allowroles=“Admins“/>

<denyusers=“*“/>

</authorization>

</system.web>

</location>

Anyway, you can see why this kind of plug-in can be very powerful. One of the best sample applications out there which demonstrates many best practices for this kind of application development is [ELMAH, or Error Logging Modules and Handlers](http://msdn.microsoft.com/library/en-us/dnaspp/html/elmah.asp)[[gotdotnet](http://www.gotdotnet.com/workspaces/workspace.aspx?id=f18bab11-162c-4267-a46e-72438c38df6f)] [[author home](http://www.raboof.com/Projects/Elmah/Elmah.aspx)]. Read that article if you’re considering writing your own plugin.

Using this approach, I created a Cache Manager plugin last year. This was my first foray into a real world application using these techniques. The result is a very simple plugin that provides cache management functionality to any ASP.NET web site (1.x or 2.0). You can [download AspAlliance.CacheManager](http://aspalliance.com/cachemanager)for free.

Enough background though – this post is about a CMS tool.

**AspAlliance.SimpleCms – A Simple CMS Application Plugin (NOT a CMS Application!)**

Earlier this year while I was updating [AspAlliance.com](http://aspalliance.com/)I found myself wishing there were an easy way for me to simply edit certain pages with my site’s look and feel without having to migrate my site over to some mammoth CMS application (of which there are many) or portal/community application with CMS as a feature. I asked around to see if anybody I knew had something like this – nobody did, but several were wishing for the same thing. I talked to some component vendors and CMS application builders, and none of them had anything that fit what I wanted, either. So in the end I decided to build it. I talked with [Dave Wanta](http://weblogs.asp.net/dwanta), who was also interested in such a tool, and came up with some specs, and about a month ago I started [Brendan](http://aspadvice.com/blogs/name/default.aspx), one of my interns, (with 0 ASP.NET knowledge when he began in May) on the task.

Brendan blogged about [the tool](http://aspadvice.com/blogs/name/archive/2006/06/29/19109.aspx)a [couple of times](http://aspadvice.com/blogs/name/archive/2006/07/12/19518.aspx). It’s now very close to complete. Hopefully in the next day or two I’ll have a live version running on AspAlliance.com. The basic idea for the application is that it should be a plugin that requires no code changes in the host application, just some configuration to set things up (wiring up the modules and handlers, and adding the CMS config section). With just that, it should then allow the administrator to list all pages, edit individual pages, enable/disable pages under the CMS’s control. It allows any arbitrary path to be used for the content under its control, and this is configured within the web.config. For instance, SimpleCMS might be set up to manage \*.cmsx or /cms/\*.aspx. Each page will simply be a blog of HTML that is placed within a content region which is in turn wrapped by a user-configured Master page (or header and footer ASCX controls), allowing for a common look and feel. The system will also define the page’s filename, keywords, description, title, etc, allowing for a search engine optimized final result.

We still have a few more bugs to work out before we release a public beta, but I’ll be dogfooding it on some new areas of AspAlliance.com very soon. If you have a wish list of features, please add your comments and I’ll see what I can do.

<!--EndFragment-->