---
title: Search Stored Procedures
date: "2008-07-01T22:06:35.8880000-04:00"
description: Sometimes, especially on very old applications that have gone
featuredImage: img/search-stored-procedures-featured.png
---

Sometimes, especially on very old applications that have gone through several rewrites but are still using the original database, I find myself wondering which stored procedures reference a given table, or each other, or whether changing the name of a view or column name will break something somewhere in the database. There are some tools out there to help this kind of thing, such as Red Gate's Refactor tool, but at a simpler level if you just need to search your stored procedures for a particular string, you can do it using this query that I just saw come across the [Sql Server SQL list](http://sqladvice.com/lists/SignUp/list.aspx?l=197&c=32) on [SQL Advice](http://sqladvice.com/):


```
<span style="color: #0000ff">SELECT</span> ROUTINE_NAME, ROUTINE_DEFINITION
<span style="color: #0000ff">FROM</span> INFORMATION_SCHEMA.ROUTINES
<span style="color: #0000ff">WHERE</span> ROUTINE_DEFINITION <span style="color: #0000ff">LIKE</span> <span style="color: #006080">'%lq_Campaign%'</span>
<span style="color: #0000ff">AND</span> ROUTINE_TYPE=<span style="color: #006080">'PROCEDURE'</span>
```


I'm not sure where [Keith](http://sqladvice.com/lists/message.aspx?MessageID=233298) found it, but it works great for my needs, and hopefully you'll find it useful as well.

