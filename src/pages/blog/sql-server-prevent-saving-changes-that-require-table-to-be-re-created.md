---
templateKey: blog-post
title: Sql Server Prevent Saving Changes That Require Table to be Re-created
path: blog-post
date: 2010-04-27T07:09:00.000Z
description: "When working with SQL Server Management studio, if you use the
  Design view of a table and attempt to make a change that will require the
  table to be dropped and re-added, you may receive an error message like this
  one:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - SQL server
category:
  - Software Development
comments: true
share: true
---
When working with SQL Server Management studio, if you use the Design view of a table and attempt to make a change that will require the table to be dropped and re-added, you may receive an error message like this one:

![sql error drop and recreate table](/img/sql-error-drop-table-recreated.png)

> ***Saving changes is not permitted. The changes you have made require the following tables to be dropped and re-created. You have either made changes to a table that can't be re-created or enabled the option Prevent saving changes that require the table to be re-created.***

In truth, it's quite likely that **you** didn't enable such an option, despite the error dialog's accusations, as it is enabled by default when you install SQL Management Studio. You can learn more about the issue in the KB article,[Error message when you try to save a table in SQL Server 2008: “Saving changes is not permitted”.](http://support.microsoft.com/kb/956176)

**Warning: As the above article states, it is not recommended that you turn off this option (at least not permanently), as it will ensure that you do not accidentally change the schema of a table such that data is lost. Do so at your peril.**

The simplest way to bypass this error is to go into Option – Designers and uncheck the option Prevent saving changes that require table re-creation. See the screenshot below.

![sql server table options](/img/sql-server-table-options.png)

The main reason why you will see this error is if you attempted to do any of the following to the table whose design you are saving:

* Change the Allow Nulls setting for a column
* Reorder columns
* Change any column's data type
* Add a new column

The recommended workaround is to script out the changes to a SQL file and execute them by hand, or to simply write out your own T-SQL to make the changes.
