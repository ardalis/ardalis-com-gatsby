---
templateKey: blog-post
title: More Updates To AspAlliance
path: blog-post
date: 2005-02-22T02:48:58.459Z
description: Last week I built some RSS consuming pieces for AspAlliance.com. I
  decided late in the week that I wanted to go ahead and add a listing of blog
  entries made by any AspAlliance Author,
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - AspAlliance
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Last week I built some RSS consuming pieces for [AspAlliance.com](http://aspalliance.com/). I decided late in the week that I wanted to go ahead and add a listing of blog entries made by any [AspAlliance Author](http://aspalliance.com/AuthorListing.aspx), but although I had all the code to merge the many RSS feeds, I didn’t have a handy way to do so in an async fashion (that is, without causing a page to time out whenever the time came to go load up dozens of separate RSS feeds and process them). The simplest solution I could come up with was to write a tiny console app that included the merge code, have it write the resulting merged feed to a database, and alter the controls on the site to bind to the database’s version. Throw the EXE into the task scheduler to have it run every 4 hours or so, and voila, that did the trick.

Also made some more minor layout changes to maximize the use of “above-the-fold” space, especially on the home page.

<!--EndFragment-->