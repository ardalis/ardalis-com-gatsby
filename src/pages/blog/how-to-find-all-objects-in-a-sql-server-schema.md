---
templateKey: blog-post
title: How to find all objects in a SQL Server Schema
path: blog-post
date: 2016-04-07T11:47:00.000Z
description: Today I’m migrating some databases from one server to another. Some
  of these applications are quite old, and user accounts that were created for
  them belong to people who have long since left the project.
featuredpost: false
featuredimage: /img/how-to-find-all-objects-in-sql-server-schema-760x360.png
tags:
  - database
  - SQL
  - sql server
category:
  - Software Development
comments: true
share: true
---
Today I’m migrating some databases from one server to another. Some of these applications are quite old, and user accounts that were created for them belong to people who have long since left the project. As I delete the users, SQL Management Studio asks me if I want to delete the associated schema. My thought process is “Yes… ? Wait, what will that delete, exactly?” Unfortunately, it doesn’t tell you what that schema has in it. Fortunately, there’s a simple query you can run that will show you:

`SELECT *  `\
`FROM sys.objects 
WHERE schema_id = SCHEMA_ID('dbo')`

Run the above query in the database you’re working in (not master). Replace ‘dbo’ in the query above with the schema you’re interested in. In my case, it was the schema matching the SQL Server database user I was about to delete (you probably don’t want to delete the user or schema ‘dbo’, by the way).

Incidentally, if you’re moving databases with existing users and setting up new logins for them, you’ll probably run into the “User, group, or role ‘thing’ already exists in the current database” error at some point. I wrote [a quick article on how to fix this](https://ardalis.com/sql-server-error-user-group-or-role-already-exists-in-the-current-database), too.