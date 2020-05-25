---
templateKey: blog-post
title: "Stir Trek 2: Iron Man Edition"
path: blog-post
date: 2014-06-12T15:56:00.000Z
description: Next month (7 May 2010) I’ll be presenting at the second annual
  Stir Trek event in Columbus, Ohio. Stir Trek (so named because last year its
  themes mixed MIX and the opening of the Star Trek movie) is a very cool local
  event.
featuredpost: false
featuredimage: /img/stirtrek_thumb.png
tags:
  - asp.net
  - speaking
  - stir trek
category:
  - Software Development
comments: true
share: true
---
Next month (7 May 2010) I’ll be presenting at the second annual [Stir Trek event in Columbus, Ohio](http://www.stirtrek.com/default.aspx). Stir Trek (so named because last year its themes mixed MIX and the opening of the Star Trek movie) is a very cool local event. It’s a lot of fun to present at and to attend, because of its unique venue: a movie theater. And what’s more, the cost of admission includes a private showing of a new movie (this year: Iron Man 2). The [sessions](http://www.stirtrek.com/Sessions.aspx) cover a variety of topics (not just Microsoft), similar to [CodeMash](http://codemash.org/). The event recently sold out, so I’m not telling you all of this so that you can go and sign up (though I believe you can get on the waitlist still). Rather, this is pretty much just an excuse for me to talk about my session as a way to organize my thoughts

![](/img/iron-man-2_thumb.jpg)

I’m actually speaking on the same topic as I did last year, but the key difference is that last year the subject of my session was nowhere close to being released, and this year, it’s RTM (as of last week). That’s right, the topic is “What’s New in ASP.NET 4” – how did you guess?

**What’s New in ASP.NET 4**

So, just what \*is\* new in ASP.NET 4? Hasn’t Microsoft been spending all of their time on Silverlight and MVC the last few years? Well, actually, no. There are some pretty cool things that are now available out of the box in ASP.NET 4. There’s a [nice summary of the new features on MSDN](http://msdn.microsoft.com/en-us/library/s57a598e.aspx). Here is my super-brief summary:

* Extensible Output Caching – use providers like distributed cache or file system cache
* Preload Web Applications – IIS 7.5 only; avoid the startup tax for your site by preloading it.
* Permanent (301) Redirects – are finally supported by the framework in one line of code, not two.
* Session State Compression – Can speed up session access in a web farm environment. Test it to see.
* Web Forms Features – several of which mirror ASP.NET MVC advantages (viewstate, control ids)
* * Set Meta Keywords and Description easily
  * Granular and inheritable control over ViewState
  * Support for more recent browsers and devices
  * Routing (introduced in 3.5 SP1) – some new features and zero web.config changes required
  * Client ID control – makes client manipulation of DOM elements much simpler.
  * Row Selection in Data Controls fixed (id based, not row index based)
  * FormView and ListView enhancements (less markup, more CSS compliant)
  * New QueryExtender control – makes filtering data from other Data Source Controls easy
  * More CSS and Accessibility support
  * Reduction of Tables and more control over output for other template controls
  * Dynamic Data enhancements
  * * More control templates
    * Support for inheritance in the Data Model
    * New Attributes
  * ASP.NET Chart Control ([learn more](http://msdn.microsoft.com/en-us/library/ee410579.aspx))
* Lots of IDE enhancements
* Web Deploy tool

My session will cover many but not all of these features. There’s only an hour (3pm-4pm), and it’s right before the prize giveaway and movie showing, so I’ll be moving quickly and most likely answering questions off-line via email after the talk.

Hope to see you there!