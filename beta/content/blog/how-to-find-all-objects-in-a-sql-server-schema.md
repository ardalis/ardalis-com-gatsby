---
title: How to find all objects in a SQL Server Schema
date: "2016-04-07T07:47:00.0000000-04:00"
description: Use this query to quickly list everything in a given SQL Server Schema.
featuredImage: /img/how-to-find-all-objects-in-sql-server-schema.png
---

Sometimes I need to migrate some databases from one server to another. Sometimes the applications are quite old, and user accounts that were created for them belong to people who have long since left the project. As I delete the users, SQL Management Studio asks me if I want to delete the associated schema. My thought process is "Yes…? Wait, what will that delete, exactly?" Unfortunately, it doesn't tell you what that schema has in it. Fortunately, there's a simple query you can run that will show you:

`SELECT * `\
`FROM sys.objects
WHERE schema_id = SCHEMA_ID('dbo')`

Run the above query in the database you're working in (not master). Replace 'dbo' in the query above with the schema you're interested in. In my case, it was the schema matching the SQL Server database user I was about to delete (you probably don't want to delete the user or schema 'dbo', by the way).

Incidentally, if you're moving databases with existing users and setting up new logins for them, you'll probably run into the"User, group, or role 'thing' already exists in the current database" error at some point. I wrote [a quick article on how to fix this](https://ardalis.com/sql-server-error-user-group-or-role-already-exists-in-the-current-database), too.

## INFORMATION_SCHEMA

[Ian Gratton](https://www.linkedin.com/in/ian-gratton/) let me know about [INFORMATION_SCHEMA](https://en.wikipedia.org/wiki/Information_schema), which may be easier to query than sys.objects in some cases. It's also supported on more RDBMS platforms than just SQL Server. Here's a screenshot:

![information_schema screenshot](/img/information-schema.jpg)

You may find it easier to work with.

