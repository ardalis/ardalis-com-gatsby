---
templateKey: blog-post
title: Excel, Pivot Tables, and OfficeWriter
path: blog-post
date: 2006-10-27T01:29:55.028Z
description: I’ve been playing around with trying to analyze some performance
  data that spans numerous periods over time as well as multiple channels.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Excel
  - Pivot Tables
  - OfficeWriter
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve been playing around with trying to analyze some performance data that spans numerous periods over time as well as multiple channels. Using SQL I’m able to get some results that look something like this:

Channel | Period | Activity\
A | 1/2006 | 1342\
B | 1/2006 | 3433\
A | 2/2006 | 1543\
B | 2/2006 | 3785

However, going from this to a chart or something useful is not terribly easy. SQL 2005 has a Pivot function, and I have a similar function for SQL 2000 that [Gregg](http://aspadvice.com/blogs/gstark) gave me, but really this is something Excel shines at, and I’ve been wanting to play around with [OfficeWriter](http://officewriter.softartisans.com/) more for some time.

Using their [documentation](http://docs.softartisans.com/OfficeWriterWindows/3.0.3/ReportingServices) and a [couple](http://msdn.microsoft.com/msdnmag/issues/06/06/Toolbox/default.aspx) of [articles](http://aspalliance.com/982_Using_SoftArtisans_OfficeWriter_with_SQL_Server_Reporting_Services_2005) online I was able to quickly convert an existing SQL Server Reporting Services report into a [Pivot Table](http://docs.softartisans.com/OfficeWriterWindows/3.0.3/ReportingServices/howto/xlw_PivotTables.aspx) with [Pivot Chart](http://docs.softartisans.com/OfficeWriterWindows/3.0.3/ReportingServices/howto/xlw_PivotCharts.aspx). Make sure you actually follow all of the instructions in the docs – especially the parts about replacing the data placeholders with dummy data of the appropriate type and changing the table properties to check the **Refresh on open** box. Not doing either of these steps will result in your Pivot table not working properly.

However, once I actually followed the directions, things went quite smoothly, and I actually got my data in this format:

Channel | 1/2006 | 2/2006 | …\
A | 1342 | 1543 | …\
B | 3433 | 3785 | …

with some nice charts, making it much easier to visualize what was going on over time across multiple channels. I’m planning on doing a video showing how to do this in the next week or so to post on the [ASPAlliance Videos](http://aspalliance.com/videos) site. Let me know if you have any particular requests for things you’d like to see demonstrated.

<!--EndFragment-->