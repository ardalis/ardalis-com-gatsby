---
templateKey: blog-post
title: San Francisco and Custom Paging
path: blog-post
date: 2003-03-27T01:12:00.000Z
description: Well, I’m out in San Francisco this week to teach ASP.NET with C#
  to half a dozen students, and that’s going quite well.
featuredpost: false
featuredimage: /img/asp.net-c.jpg
tags:
  - Alan Shalloway
  - ASP.NET DataGrid
  - ASP.NET with C#
  - Curtis Swartzentruber
  - custom paging
  - Doug Seven
  - Steve Sharrock
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

Well, I’m out in San Francisco this week to teach ASP.NET with C# to half a dozen students, and that’s going quite well. I had the opportunity to see [Alan Shalloway](http://www.amazon.com/exec/obidos/tg/detail/-/0201715945/qid%3D1048779304/stevenatorasp/104-1443980-2249560) speak at the [Bay Area User Group](http://www.baynetug.org/) on Tuesday night, and met up with ASPAlliance columnist Steve Sharrock there for the first time as well. We had dinner the next night, and he mentioned something he had used for a solution for a client that I was unaware of.

For a bit of background, it’s commonly understood that the standard paging functionality of the ASP.NET DataGrid is quite limited, especially for any significant amount of data. This is due to the fact that the solution relies entirely on having all of the data available to every page in ViewState, which can meen huge amounts of data being sent to and from the web server with every request. There are several solutions to this problem that use custom paging. One that I had thought was the “best” is described in this [article by Doug Seven](http://www.dotnetjunkies.com/tutorials.aspx?tutorialid=50), which uses stored procedures that are smart enough to return only the rows for a particular page. The code required for this is pretty ugly, though, and the work required on the database side is substantially more than for a simple query. Another custom paging [article by Curtis Swartzentruber](http://dotnetjunkies.com/tutorials.aspx?tutorialid=287) builds on this technique but also doesn’t use the technique Steve Sharrock presented to me.

Apparently, there is an overload for the DataAdapter.Fill() method that I had overlooked. This method lets you fill a DataSet (or DataTable) by providing the following parameters:\
(DataSet dataSet, int startRecord, int maxRecords, string srcTable)

Using this, Steve explained, it was very simple to create a custom paging solution that used the standard stored procedures (e.g. it didn’t require re-writing the sprocs so they understood paging) and which performed as well or better than implementing the paging logic on the database server. It also eliminated the need for passing around tons of ViewState data. All in all, it seems like an elegant solution. I haven’t yet had a chance to put it into practice or (obviously) to benchmark it, but I hope to do so in a future ASPAlliance article if Steve doesn’t beat me to it.

<!--EndFragment-->