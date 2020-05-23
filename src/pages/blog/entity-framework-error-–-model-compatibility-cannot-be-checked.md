---
templateKey: blog-post
title: Entity Framework Error – Model compatibility cannot be checked
path: blog-post
date: 2011-06-03T19:14:00.000Z
description: If you’re using Entity Framework Code First and you have everything
  working with, for instance, a SQL CE database, but then you want to move to a
  full SQL Server database, you may encounter this message if you don’t do
  things in the right order.
featuredpost: false
featuredimage: /img/sql-server-sql-server-management.png
tags:
  - entity framework
category:
  - Software Development
comments: true
share: true
---
If you’re using Entity Framework Code First and you have everything working with, for instance, a SQL CE database, but then you want to move to a full SQL Server database, you may encounter this message if you don’t do things in the right order. In my case, what I did was open SQL Management Studio, Create my new database, then popped into Visual Studio, Server Manager, added a connection to it. Then I grabbed the connection string and stuffed it into my config file. When I ran my application, I got this error message:

> **Model compatibility cannot be checked because the database does not contain model metadata. Ensure that IncludeMetadataConvention has been added to the DbModelBuilder conventions.**

After a bit of searching, [this post had the answer](http://social.msdn.microsoft.com/Forums/en/adodotnetentityframework/thread/ccf25dbe-5452-47b1-9a8f-080668922dd7). My mistake was in creating the database. EF apparently \*really\* wants to create the database itself, so even if all you did was create the database but nothing else, it will fail with this message. My solution – drop the newly created database and let EF recreate it itself. Worked like a charm.