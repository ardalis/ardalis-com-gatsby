---
templateKey: blog-post
title: Save SQL Query Results With Column Names
path: blog-post
date: 2007-12-02T11:44:51.960Z
description: A minor frustration I've had with SQL Server for years is that when
  copying the results to Excel, the column names are not included.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - SQL Server
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

A minor frustration I've had with SQL Server for years is that when copying the results to Excel, the column names are not included. Well, [Brendan blogged about this yesterday](http://ardalis.com/blogs/name/archive/2007/11/30/Copying-Data-From-SQL-Server-Management-Studio.aspx), and in a great demonstration of the value of blogging, he received a comment with the answer to this problem within a couple of hours. It turns out this can be done by going to Tools – Options – Query Results – Sql Server – Results to Grid – Include column headers when copying or saving results. Beautiful. Here's a screenshot if you have problems finding it.

![](/img/sql-query.jpg)

<!--EndFragment-->