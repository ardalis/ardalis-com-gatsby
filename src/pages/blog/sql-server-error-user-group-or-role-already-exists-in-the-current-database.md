---
templateKey: blog-post
title: SQL Server Error User Group or Role Already Exists in the Current Database
path: blog-post
date: 2010-06-18T15:00:00.000Z
description: >-
  If you restore a database and then try to login to it, you’re likely to run
  into this wonderful SQL Error:


  *User, group, or role ‘whatever’ already exists in the current database (Microsoft SQL Server, Error: 15023).*
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - sql server
category:
  - Uncategorized
comments: true
share: true
---
If you restore a database and then try to login to it, you’re likely to run into this wonderful SQL Error:

*User, group, or role ‘whatever’ already exists in the current database (Microsoft SQL Server, Error: 15023).*

Unfortunately, using Sql Management Studio alone doesn’t seem up to the task of correcting this problem. You have to drop down to calling esoteric stored procedures (who needs a GUI to actually manage users and logins, right?).

Searching for this error at least yields many [results](http://www.aspexception.com/errordepot/error_repository.aspx?eID=12) like [these](http://www.numtopia.com/terry/blog/archives/2007/06/reassociate_microsoft_sql_login_with_a_database_us.cfm). I especially like the second one whose title ends with ‘Aarrgghh!!’ which led to me clicking it since it represented my current thoughts on the matter quite succinctly.

In short order, you will learn about the need to call “sp_change_users_login” to correct this problem, which is known as the ‘orphan user’ problem. Of course, the results above don’t actually show you the syntax required, so you will have to run another search for that sproc name which will lead you to the [MSDN documentation for sp_change_users_login (Transact-SQL).](http://msdn.microsoft.com/en-us/library/ms174378.aspx)

Let me save you some time. If you have a user in your recently restored database named ‘someuser’ and you have already created the login on the server (which is why you got the …already exists in the current database… error), then all you have to run is this:

```
sp_change_users_login 'AUTO_FIX', 'someuser'
```

You should see results similar to this:

> *The row for user ‘someuser’ will be fixed by updating its login link to a login already in existence.*
>
> The number of orphaned users fixed by updating users was 1.
>
> The number of orphaned users fixed by adding new logins and then updating users was 0.

Hope that saves you some frustration.