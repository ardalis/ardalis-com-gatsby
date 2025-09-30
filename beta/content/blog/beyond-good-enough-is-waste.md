---
title: Beyond Good Enough Is Waste
date: "2007-06-27T09:34:29.1310000-04:00"
description: I just finished reading Jon Galloway's post, [The value of " good
featuredImage: /img/beyond-good-enough-is-waste.jpg
---

I just finished reading Jon Galloway's post, [The value of "good enough" technology](http://weblogs.asp.net/jgalloway/archive/2007/06/26/the-value-of-quot-good-enough-quot-technology.aspx), and it reminded me of something I repeat very often in my talks on improving performance and/or caching (which share some content as you may imagine). I wanted to emphasize one point a bit more succinctly than Jon did, and that is that in software development (and I imagine in any endeavor where resources are constrained): **Going beyond merely good enough is wasted effort.**

What does this mean? It means that if you architect the ultimate system with N layers and Z levels of object indirection for a problem that does not require arbitrary levels of flexibility and/or scalability, you're wasting effort. You should have shipped sooner. If you're tuning every last function or striving for 100% unit test coverage before the first real user has hit your application and found bugs and performance problems you hadn't thought of yet, you're wasting effort. You should have shipped sooner. If your pages load and your APIs return in 500ms and your users and stakeholders have said anything under a second is fine, spending a week to cut that down by 10% is probably not the most important thing to be doing.

Rather than spend quite so much time on things that you may not need ([YAGNI](https://deviq.com/principles/yagni)), spend a bit of time building in processes to make it easy for your to react to user feedback once you ship. Then ship something. You'll probably find that parts of it are sufficient, and some parts aren't yet"good enough". Ignore the pieces that are already sufficient and focus on what's not good enough, then ship it again.

This applies to process as much as to the code itself. If you have a [bloated process](https://ardalis.com/process-bloat-silent-killer-developer-productivity/) that slows down your cycle time, and a leaner"good enough" process would let you ship faster and more often, then go with the simpler process if you possibly can. A key reason startups outmaneuver larger established players is because they have simpler processes and systems, not more resources. They almost always have far fewer resources, but they're able to apply them better because they're so much leaner.

