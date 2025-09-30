---
title: Continuous Integration Using Team System
date: "2006-03-15T07:56:23.0010000-05:00"
description: I'd like to get continuous integration (CI) working for my TFS
featuredImage: img/continuous-integration-using-team-system-featured.png
---

I'd like to get continuous integration (CI) working for my TFS server here at the office as my next step. A little googling led to [Khushboo's post](http://blogs.msdn.com/khushboo/archive/2006/01/04/509122.aspx) on doing just this with the RC bits that I'm using at the moment. The instructions were pretty simple to follow and with minimal headache (aside from the need to install VS on the build box in order to run tests, a stupid requirement but one I already knew about) I got things working.

My next goal is to create some kind of visual status board that shows the current state of the build. [Knut Hamang has a nice implementation using an LCD-TV](http://www.hamang.net/index.php?option=com_content&task=view&id=16&Itemid=9) that would pretty well suit my needs. I've also seen the [ambient orb](http://blogs.msdn.com/mswanson/articles/169058.aspx)and [lava lamp implementations](http://www.pragmaticprogrammer.com/pa/pa.html), but I think I'd prefer something I can show on a monitor with some additional information. So far I haven't dug into the TFS API enough to determine for myself how best to learn the status of a particular build, but I'm hoping to get some help on that front from [Knut](http://www.hamang.net/) or the [TeamSystemRocks Forums](http://teamsystemrocks.com/forums). If you have any suggestions, I'm open to them.

**Update: Knut now has the source code posted! I got it working on my TFS server in about 10 minutes! Sweet!**

