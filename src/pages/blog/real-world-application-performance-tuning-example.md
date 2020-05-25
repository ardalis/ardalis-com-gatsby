---
templateKey: blog-post
title: Real World Application Performance Tuning Example
path: blog-post
date: 2007-01-15T20:36:43.496Z
description: "Many of you know that I’m very much into high performance and
  scalability techniques. One thing you need to remember when applying
  performance tweaks is that as your application changes, your performance
  optimizations may need to change and evolve with it. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Caching
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Many of you know that I’m very much into high performance and scalability techniques. One thing you need to remember when applying performance tweaks is that as your application changes, your performance optimizations may need to change and evolve with it. Let me demonstrate this with a case in point.

On ASPAlliance.com, a fairly busy web site with about a thousand articles and tutorials on software development, each article displays its total views and its views in the last 10 days. Now, perhaps the ideal design for this data, from a performance standpoint, would be to schedule a job to calculate these fields and store them in the database in the Article table, and then fetch them as simple data elements when the rest of the article data is fetched. However, as this is a real-world application with some legacy baggage, the Views data was actually hacked into the display page with the requirement that the underlying Article table and object not be updated. Not ideal, but a perfect example of a real world reality.

Now, in order to optimize the site to limit total database hits and ensure that the each Article page being shown caused the least possible load on the database, caching was used. However, with hundreds of articles, it was clear that rather than caching every individual article’s total views, it would be far more efficient to fetch back a resultset holding all articles with their views, and then to simply use ADO.NET logic to fetch the particular row from the DataTable (from the Cache) for the article ID in question.

This did in fact work splendidly for several years. Then, last week, the GetTotalViews method started to time out. At first it was only once or twice a day, but by the weekend it was happening several times per hour (basically every time the cache expired). The problem was that fetching the entire result set for all articles was taking too long, since the total number of articles had grown as had the total number of Views being counted. It didn’t help that the web application is running on 3 servers in a (shared) cluster, so when the app would start up, typically all three would be requesting the result set at the same time.

The ideal solution, again, would be to aggregate the data using a scheduled job and store the aggregate results in the Article table. However, in the interests of time, another band-aid was applied. In this case, I chose to fall back to the somewhat less efficient approach of having every article grab just its own total views from the database, and caching each article’s total views individually. Since implementing this fix, no timeouts have occurred. Refactoring the application to use the proper technique will remain on the TODO list, however…

<!--EndFragment-->