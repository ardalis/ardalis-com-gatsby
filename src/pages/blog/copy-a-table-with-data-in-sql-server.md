---
templateKey: blog-post
title: Copy a Table with data in SQL Server
path: blog-post
date: 2011-06-20T12:56:00.000Z
description: Sometimes when you’re about to do some major surgery on your
  database, you want the comfort of knowing that you can always rollback if
  there’s a problem.
featuredpost: false
featuredimage: /img/database.jpg
tags:
  - data
  - SQL
  - sql server
  - tips and tricks
category:
  - Software Development
comments: true
share: true
---
Sometimes when you’re about to do some major surgery on your database, you want the comfort of knowing that you can always rollback if there’s a problem. And it’s not always the case that you’ll immediately know there was a problem. Sometimes, you just want a copy of the original data so that you can go back to it, or use it to analyze where you went wrong. Of course, you can backup the whole database, but restoring the full system is often overkill if you’re only working on a handful of tables, not to mention the fact that backups are rather cumbersome and slow compared to standard SQL statements. What if you just need a complete copy of the data from one table in another table? You can easily achieve this using this approach:

```
<span style="color: #008000;">-- Everything</span>
<span style="color: #0000ff;">SELECT</span> * <span style="color: #0000ff;">INTO</span> [Products_backup] <span style="color: #0000ff;">FROM</span> [Products]
<span style="color: #008000;">-- Only Some Columns</span>
<span style="color: #0000ff;">SELECT</span> ID, Name <span style="color: #0000ff;">INTO</span> [Products_backup] <span style="color: #0000ff;">FROM</span> [Products]
<span style="color: #008000;">-- Only Some Rows</span>
<span style="color: #0000ff;">SELECT</span> * <span style="color: #0000ff;">INTO</span> [Products_backup] <span style="color: #0000ff;">FROM</span> [Products] <span style="color: #0000ff;">WHERE</span> ID &gt; 1000
```

Of course, you can also combine “only some columns” version with a where clause, too. Once you’re done with your scary operation and are certain that you won’t need to roll it back, you can drop the _backup table.