---
templateKey: blog-post
title: SELECT from a Stored Procedure
path: blog-post
date: 2010-02-24T12:25:00.000Z
description: "Occasionally I find myself wanting to SELECT from a SPROC in SQL
  Server. Usually this is because I want to ORDER the results or filter them
  further with a WHERE clause. Unfortunately, you can’t just do this:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - SQL
category:
  - Uncategorized
comments: true
share: true
---
Occasionally I find myself wanting to SELECT from a SPROC in SQL Server. Usually this is because I want to ORDER the results or filter them further with a WHERE clause. Unfortunately, you can’t just do this:

```
SELECT *
FROM
(EXEC mySproc foo, bar)
```

There are several workarounds here, and the appropriate one depends mostly on whether you have any control over the use of the stored procedure, or how it works. For example, you could choose to use a VIEW instead of a stored procedure. Unfortunately, a VIEW usually won’t work if you need to pass parameters to your stored procedure (which I’m guessing you are). If your sproc is literally just a wrapper for a query that has no dependencies on parameters, then yeah, you probably should just use a view, and then of course you can select from it to your heart’s content.

**INSERT-EXEC**

The simplest approach that doesn’t require making any changes to your perfectly good stored procedure is to declare a temporary table with the appropriate schema to match what the sproc outputs. Then INSERT the stored procedure’s results into the temp table and SELECT from it. An example looks like this:

```
CREATE TABLE #Result
(
  ID int,  Name varchar(500), Revenue money
)
INSERT #Result EXEC RevenueByAdvertiser '1/1/10', '2/1/10'
SELECT * FROM #Result ORDER BY Name
DROP TABLE #Result
```

This is the approach I favor when I simply need to apply a WHERE or an ORDER BY to an existing stored procedure. There are actually quite a few other ways to share data between stored procedures or between ad hoc queries and stored procedures. Erland Sommerskog has a nice article outline [How to Share Data Between Stored Procedures](http://www.sommarskog.se/share_data.html) that you might want to read for more options.

Erland also notes a few [limitations](http://www.sommarskog.se/share_data.html#INSERTEXEC) to the above approach, which you should keep in mind. I only use this approach for quick ad hoc queries, not for use in production code, because of the limitations involved.