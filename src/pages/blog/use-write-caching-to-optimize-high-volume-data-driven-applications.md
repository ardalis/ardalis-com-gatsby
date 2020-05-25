---
templateKey: blog-post
title: Use Write Caching to Optimize High Volume Data Driven Applications
path: blog-post
date: 2005-04-03T21:33:40.184Z
description: Today I published another caching-related article on
  [AspAlliance.com]. This time I’m looking at caching from another angle —
  caching **write** data rather than **read** data.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Today I published another caching-related article on [AspAlliance.com](http://aspalliance.com/). This time I’m looking at caching from another angle — caching **write** data rather than **read** data. Another term for this is batch updating, and it can have a significant impact on performance for applications that do a lot of writing.

**Abstract**:

*The typical use of caching applies to read caching, or caching data in the application to avoid reading it from the database. However, for applications that must frequently write back to the database, write caching can provide dramatic improvements to performance. This article describes how to implement write caching for an ASP.NET application. Use of Sql Server XML capabilities is also touched on.*

**Link**: [Use Write Caching to Optimize High Volume Data Driven Applications](http://aspalliance.com/649)

<!--EndFragment-->