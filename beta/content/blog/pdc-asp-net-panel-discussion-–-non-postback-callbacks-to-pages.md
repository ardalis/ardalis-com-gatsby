---
title: PDC ASP.NET Panel Discussion – Non-Postback Callbacks to Pages
date: "2003-10-29T18:22:00.0000000-05:00"
description: A new feature in Whidbey will allow controls to make calls directly
featuredImage: img/pdc-asp-net-panel-discussion-–-non-postback-callbacks-to-pages-featured.png
---

A new feature in Whidbey will allow controls to make calls directly back to page methods without making full postbacks. This features uses XMLHTTP behind the scenes and allows controls to talk to the server in an optimized fashion without requiring a full postback. In the 1.x timeframe, a solution for this which you can use today (and which actually may be simpler to implement based on what I've seen), is remote scripting. Remote scripting was available in ASP 3.x but wasn't widely known to most ASP developers. [Jonathan Cogley](http://authors.aspalliance.com/thycotic/default.aspx) of [AspAlliance](http://aspalliance.com/) has written up a toolkit that makes implementing cross-browser remote scripting (non-postback callbacks to the server) very easy to implement in ASP.NET, including 1.x.

[Cross Browser Remote Scripting Client](http://authors.aspalliance.com/thycotic/articles/view.aspx?id=4)

[ASP.NET Remote Scripting](http://authors.aspalliance.com/thycotic/articles/view.aspx?id=1)

