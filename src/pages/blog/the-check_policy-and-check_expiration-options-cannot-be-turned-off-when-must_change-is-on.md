---
templateKey: blog-post
title: The CHECK_POLICY and CHECK_EXPIRATION options cannot be turned OFF when
  MUST_CHANGE is ON
path: blog-post
date: 2010-10-22T11:48:00.000Z
description: "In addition to the dreaded [SQL Server Error: User Group or Role
  Already Exists in the Current Database] error, you may also get this error
  when creating new logins after a database move:"
featuredpost: false
featuredimage: /img/sql-server-sql-server-management.png
tags:
  - sql server
category:
  - Software Development
comments: true
share: true
---
In addition to the dreaded [SQL Server Error: User Group or Role Already Exists in the Current Database](/sql-server-error-user-group-or-role-already-exists-in-the-current-database) error, you may also get this error when creating new logins after a database move:

> **Alter failed for login ‘somelogin’.**
>
> **An exception occurred while executing a Transact-SQL statement or batch.**
>
> **The CHECK_POLICY and CHECK_EXPIRATION options cannot be turned OFF when MUST_CHANGE is ON. (Microsoft SQL Server, Error: 15128)**

The fix for this is to change the password. You can do this via script like so:

USE Master\
GO\
ALTER LOGIN \[somelogin] WITH PASSWORD = ‘samepassword’\
GO\
ALTER LOGIN \[somelogin] WITH\
CHECK_POLICY = OFF,\
CHECK_EXPIRATION = OFF;

That’s all there is to it. I found [this post](http://www.webofwood.com/2009/01/29/fix-a-sql-server-login-which-has-must_change-set-to-on) useful while researching this issue.