---
templateKey: blog-post
title: ASP.NET 2.0 MVP Hacks and Tips
path: blog-post
date: 2006-08-18T03:03:12.686Z
description: I got a copy of WROX’s [ASP.NET 2.0 MVP Hacks and Tips] yesterday
  and skimmed the TOC and read a few chapters. I have to say that this is a very
  good book from my first impression of it, based on the fact that I learned a
  few new techniques in just the brief amount of time I’ve spent on it so far.
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

I got a copy of WROX’s [ASP.NET 2.0 MVP Hacks and Tips](http://www.amazon.com/exec/obidos/ASIN/0764597663/aspalliancecom) yesterday and skimmed the TOC and read a few chapters. I have to say that this is a very good book from my first impression of it, based on the fact that I learned a few new techniques in just the brief amount of time I’ve spent on it so far. Since I haven’t read the whole thing yet, I can’t write up a good formal review, but let me give you the quick notes I took away from it already:

* In 2.0 configuration you can specify external files for configuration sections. I knew this. What I didn’t know, and what is very cool for team scenarios, is that those files can be in a parent folder, so that they are not deployed by automatic deployment scripts and are not placed into source control. I’ll use this immediately.
* Save as Template – In VS2005 if you tire of setting up a base page for every ASPX file, or you don’t like the default Title of “Untitled Page” you can easily create a template laid out how you want, save it, and use it going forward. Haven’t tried it yet but sounds promising.
* Cache Hack – View System Files in Cache. Through some cool reflection trickery, a cache viewer that shows files stored by ASP.NET itself in the Cache is demonstrated. This is something I’ll definitely add to my [ASPAlliance CacheManager plugin](http://aspalliance.com/cachemanager) for its next release.
* Roles – Enabled=”true”. This one I just smiled at because I ran into an issue where authorization wasn’t working earlier this week that had me stumped for longer than I’d like to admit. I had <roles> set up in my web.config from long ago when I’d initially upgraded to 2.0, but apparently I’d neglected Enabled=”true”. You’d think that would be the default, but it’s not, and this tip was also called out in this book (I should have read the book earlier this week!).
* CustomConfig – 2.0 makes it easier to do custom configuration sections, which I’ve done, but what I haven’t played with is using attributes to apply validation to the settings. This looks cool and I’ll have to play with more.

So far I’ve only looked at about 5 of the 17 chapters and I’ve picked up a bunch of little things that will help me write better ASP.NET applications. Based on that, I’m definitely going to bump this book up to the top of my reading list (it’s a quicker read than many of the comprehensive tomes out there – less than 400 pages), and perhaps write a formal review on ASPAlliance when I’ve completed it.

<!--EndFragment-->