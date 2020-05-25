---
templateKey: blog-post
title: Get Date From DateTime In SQL
path: blog-post
date: 2006-03-24T12:38:50.231Z
description: Something I need to do from time to time is get just the date part
  of a datetime value in SQL. I found a cool way to do it on SQLJunkies today.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - SQL
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Something I need to do from time to time is get just the date part of a datetime value in SQL. I found [a cool way to do it on SQLJunkies](http://www.sqljunkies.com/Article/6676BEAE-1967-402D-9578-9A1C7FD826E5.scuk) today.

select convert(varchar,DateColumn,101)

The 101 means “mm/dd/yyyy” format, but there are a bunch of other codes you can use. 108 will return just the time “hh:mm:ss” for instance.

**Update: 101 includes 4 digit year ‘yyyy’. A code of 1 would apparently be “mm/dd/yy”, according to user comments. Thanks!**

<!--EndFragment-->