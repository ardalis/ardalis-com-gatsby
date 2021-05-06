---
templateKey: blog-post
title: How to Reset a SQL Server SA Password
date: 2011-06-28
path: blog-post
description: Sometimes you need to reset the password of a SQL Server database installation. This article shows you how.
featuredpost: false
featuredimage: /img/reset-sql-sa-password.png
tags:
  - sql
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

If you need to reset the SA (system administrator) password on a MS SQL Server database because you've lost or forgotten the old password or you've change your active directory domain, you can do so provided that you can access the server with an account that has local administrator permissions.  This article describes the steps required to do so.

## Step by Step

First off, you need to log into the machine as a user with local admin rights.

Next, you should open Management Studio on the local sql server machine and change the default startup condition so that it doesn't automatically launch the object explorer.  You do this by opening Tools - Options (Environment - General) and selecting something other than Open Object Explorer in the At startup: option.

For instance, you can set it to Open new query window.

We're disabling the object explorer because it will make a connection to the local database, and we're going to be setting the database to use Single User Mode.  In that mode, as the name implies, only one connection can be made to the database at a time.  If our object explorer has already used up that connection (even if it didn't authenticate correctly), then our query window won't have an available connection and will fail.  So, we're avoiding that issue.

After making the change, close SQL Server Management Studio.

Next, stop all SQL Server services on the server.  The easiest way to do so is to open up the SQL Server Configuration Manager.

Right-click on each Running service and select 'Stop'.  When done, hit F5 or click on the Refresh icon to confirm that all services are in fact stopped.

Now open a command window as an administrator and type in the following:

```powershell
NET START MSSQLSERVER /f /T3608
```

(Note that you can also start the service in single user mode by adding ";-m" to the Startup Parameters used by the SQL Server (MSSQLSERVER) service from Sql Server Configuration Manager.  If you do so, remember to remove the change when you're done with these steps)

It's possible that more than one service started up in response to the above command, in which case the "extra" services may use up the single connection available.  In Sql Server Configuration Manager, refresh the services, and make sure the only one running is SQL Server (MSSQLSERVER) or whatever instance it is you're trying to work with.  Stop any other services that are not already Stopped.

Now open SQL Server Management Studio and click New Query (or use the query window that opened on startup if you configured it to do so).  Type in the following:

```sql
Use master
Go
Alter login [sa] with password=N’CHOOSEPASSWORDWISELY’
Go
Alter login [sa] enable
Go
```

Assuming this runs without error, your sa password should now be set (hopefully to something secure).  Return the SQL Server Configuration Manager and restart the SQL Server (MSSQLServer) services, and start any other services you require.

You should now be able to return to SQL Server Configuration Manager and log in (via query or object explorer) using SQL Server authentication and the sa user account with the password you specified above.  At which point, you can add whichever windows accounts you need to have access to the server.

It's generally a best practice not to use the sa account, and in fact if you've disabled it, that's likely one of the reasons why you would need the steps described in this article.  Be sure to re-disable it once you have re-established the windows accounts you wish to use to access the database.

## Summary

Assuming you can access the local machine with local administrator rights, it is relatively straightforward to reset the system administrator (sa) password on a MS SQL Server installation.  This can be a lifesaver if you have no other way to connect to the server, but it can also be used by black hats to hack into your server.  The key to avoiding this is to ensure the server itself is secure and to keep enemies from gaining access to an account with local admin privileges.

Originally published on [ASPAlliance.com](http://aspalliance.com/2066_How_to_Reset_a_SQL_Server_sa_Password)
