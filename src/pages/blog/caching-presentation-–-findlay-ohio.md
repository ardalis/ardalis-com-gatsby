---
templateKey: blog-post
title: Caching Presentation – Findlay, Ohio
path: blog-post
date: 2005-10-27T13:21:30.555Z
description: As I mentioned in my previous post, I presented on Caching in
  Findlay last night. The presentation was remarkable because I did it without
  my laptop, which sadly decided to die as I was booting it up for the meeting.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Caching
  - Events
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

As I mentioned in my previous post, I presented on Caching in Findlay last night. The presentation was remarkable because I did it without my laptop, which sadly decided to die as I was booting it up for the meeting. I was ill-prepared in that I failed to have a backup of my slide deck on a USB drive or online somewhere, so I ended up grabbing an older version of the slide deck from my training company site, [ASPSmith.com](http://aspsmith.com/). I borrowed the user group leader’s laptop, and presented from there. Overall I think it went passably well, all things considered. The group was a lot quieter than the Fort Worth crowd from last week, but that might be because I told them last week’s presentation lasted 2+ hours and perhaps they wanted to get home at some point…

The highlight of the presentation, for me at least, was my Application Center Test simulation, using MS Paint. The laptop had ACT and I set up my demo that I normally show in which I have a page display a table from Northwind or Pubs in a DataGrid, then I hit that page with ACT and tweak it while the test is running (Rob Howard does a similar demo, I think I stole this idea from him). Anyway, I adjust the EnableSessionState and EnableViewState parameters for the page and everyone watches as the Requests/Second graph jumps up 5% or 10% with these adjustments, and then I turn on output caching and the graph goes vertical and jumps up 500% or so. Well, ACT wasn’t working on this laptop for some reason, so in an effort to get some of the same effect from the demo, I fired up MS Paint and drew the graph by hand. Then I tweaked the page, saved it, and went back to Paint and drew some more of what the graph would look like. Hopefully the audience didn’t think I was totally full of it — it seemed to at least entertain them.

I’m speaking at DevConnections in two weeks – I think for that I’m going to bring a backup laptop and make sure all my stuff works on both machines. And a USB drive just in case.

<!--EndFragment-->