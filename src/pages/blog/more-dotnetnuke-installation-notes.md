---
templateKey: blog-post
title: More DotNetNuke Installation Notes
path: blog-post
date: 2007-01-17T17:47:03.363Z
description: Went with the 4.4 Source this time instead of the starter kit. Ran
  into an [FAQ item regarding Name ‘Config’ is not declared but found the answer
  in this blog]
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - dotnetnuke
  - dnn
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Went with the 4.4 Source this time instead of the starter kit. Ran into an [FAQ item regarding Name ‘Config’ is not declared but found the answer in this blog](http://www.dotnetnuke.com/Community/BlogsDotNetNuke/tabid/825/EntryID/240/Default.aspx). Since I’m running this on Vista it had some issue with the app pool that was being used, but it offered me the following command line to fix the issue, which worked:

c:windowssystem32inetsrvappcmd.EXE set app “Default Web Site/DotNetNuke_2” /applicationPool:“Classic .NET AppPool”

So I was able to complete the install:

![](<>)

Yay!

And I go to my portal, and it comes up (yay!) but… it’s got a critical error from some **Object Reference not set to an instance of an object**. Boo! Oh well, if it was easy, everybody would do it. I’ll figure this out and post back with the fix.

\[categories: dotnetnuke, dnn]

<!--EndFragment-->