---
templateKey: blog-post
title: More SqlDependency Gotchas
path: blog-post
date: 2005-09-15T14:23:46.789Z
description: >-
  The necessary trick, which is only for that build so if you’re reading this
  post-release of ASP.NET 2.0 this

  shouldn’t be an issue, is to modify the SQL Server database settings for the database in question
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

I [wrote](http://aspadvice.com/blogs/ssmith/archive/2005/09/07/1919.aspx)

about some issues with SqlDependency in the latest interim build last week,

[](http://aspadvice.com/blogs/ssmith/archive/2005/09/07/1919.aspx)but I forgot to mention one other gotcha that we ran into, which [Scott](http://www.hanselman.com/blog/SqlDependancyStartAndConversationHandleNotFound.aspx)

[Hanselman was struggling with yesterday](http://www.hanselman.com/blog/SqlDependancyStartAndConversationHandleNotFound.aspx). The necessary trick, which is

only for that build so if you’re reading this post-release of ASP.NET 2.0 this

shouldn’t be an issue, is to modify the SQL Server database settings for the

database in question like so:

**alter database Northwind set trustworthy**

**on**

That should fix the “The conversation handle “blah” is not found” bug, if

you’re seeing that.

<!--EndFragment-->