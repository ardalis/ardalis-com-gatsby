---
templateKey: blog-post
title: Beyond Good Enough Is Waste
path: blog-post
date: 2007-06-27T13:34:29.131Z
description: I just finished reading Jon Galloway’s post, [The value of “good
  enough” technology], and it reminded me of something I repeat very often in my
  talks on improving performance and/or caching (which share some content as you
  may imagine).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Software Development
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I just finished reading Jon Galloway’s post, [The value of “good enough” technology](http://weblogs.asp.net/jgalloway/archive/2007/06/26/the-value-of-quot-good-enough-quot-technology.aspx), and it reminded me of something I repeat very often in my talks on improving performance and/or caching (which share some content as you may imagine). I wanted to emphasize one point a bit more succinctly than Jon did, and that is that in software development (and I imagine in any endeavor where resources are constrained): **Going beyond merely good enough is wasted effort.**

What does this mean? It means that if you architect the ultimate system with N layers and Z levels of object indirection for a problem that does not require arbitrary levels of flexibility and/or scalability, you’re wasting effort. You should have shipped sooner. If you’re tuning every last function or striving for 100% unit test coverage before the first real user has hit your application and found bugs and performance problems you hadn’t thought of yet, you’re wasting effort. You should have shipped sooner.

Rather than spend quite so much time on things that you may not need ([YAGNI](http://en.wikipedia.org/wiki/You_Ain't_Gonna_Need_It)), spend a bit of time building in processes to make it easy for your to react to user feedback once you ship. Then ship something. You’ll probably find that parts of it are sufficient, and some parts aren’t yet “good enough”. Ignore the pieces that are already sufficient and focus on what’s not good enough, then ship it again.

\[categories: Software Development]

<!--EndFragment-->