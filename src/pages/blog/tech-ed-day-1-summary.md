---
templateKey: blog-post
title: Tech Ed Day 1 (summary)
path: blog-post
date: 2005-06-07T16:26:15.335Z
description: "Got up early, which was an accomplishment considering how late I
  was out with Doug, Stephen, Scott, and Amy Sunday night, and made it to the
  keynote at 0900. "
featuredpost: false
featuredimage: /img/background-2462434_1280.jpg
tags:
  - asp.net
  - Events
  - Personal
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Got up early, which was an accomplishment considering how late I was out with Doug, Stephen, Scott, and Amy Sunday night, and made it to the keynote at 0900. Steve Ballmer was presenting, assisted by Samantha Bee (from the Daily Show, I think) and a few MS employees. The keynote was definitely entertaining with some pretty cool demos. The main focus of the demos was on mobile technology and server administration technology which is coming down the pipeline. They also showed off Microsoft’s VirtualEarth, which looks very cool, and very similar to [Google Maps](http://maps.google.com/). The URL they were using was a local one, though, so I guess it’s not public yet since virtualearth.com doesn’t show anything.

I spent most of the day at the Web Cabana answering user questions. There were a few good ones which I’ll summarize here. One architect from a major job website wanted to know more about caching, my favorite topic. Unfortunately his questions centered on the algorithms used under the covers to scavenge memory as the cache fills up, and those APIs are closed, so I had to rely on an ASP.NET team member for the answer. However, the three of us had a good conversation about how the cache works and what changes might be coming for the cache in the future (not many beyond what’s in Whidbey, from the sounds of it). One specific question raised was whether the actual number of entries in the cache affected the memory pressure algorithm or if it depended only on the actual amount of memory used (e.g. is there a difference in memory pressure from 10 1000kb things or 1000 10kb things) and the answer was no, but with the caveat that there is some memory overhead for each entry since it is wrapped in a couple of objects which store additional information about the cached data. So that was good to know.

Later in the day someone wanted to know if they should upgrade their ASP 3.0 application to ASP.NET 1.1 or just skip it and jump straight to 2.0. The consensus was that they should jump straight to 2.0, since it’s leaps and bounds better than 1.1 and presumably they would have to upgrade to 2.0 at some point, so why not save that step and upgrade now. The Go-Live license allows them to deploy the application now if they need to, although realistically the conversion likely wouldn’t be complete before the actual RTM (making the beta go-live license moot).

Later in the afternoon I had a meeting about the future of CodeZone (formerly CodeWise) and a MS Central Region party in the evening at Universal (making for another late night).

Keynote Day 2 is starting now, so more later…

<!--EndFragment-->