---
templateKey: blog-post
title: SqlDependency Issue Resolved
path: blog-post
date: 2006-11-06T02:24:01.015Z
description: I’m doublechecking my demos for my sessions at DevConnections this
  week and I think I finally fixed an issue that has plagued me off and on for
  the last year or more when I’ve been demonstrating the new SQL 2005
  SqlDependency features.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Caching
  - sql2005
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’m doublechecking my demos for my sessions at DevConnections this week and I think I finally fixed an issue that has plagued me off and on for the last year or more when I’ve been demonstrating the new SQL 2005 SqlDependency features. It seems like almost half the time, the notifications don’t work when it’s time for me to give the demo, though they work fine when I test them prior to the user group meeting or conference where I am presenting. The last time this happened I noted that it probably had something to do with my network connectivity since I had tested the demo mere hours before the presentation and it had problems in the Internet-less presentation room.

Turns out the problem is related to this event log entry:

*The activated proc \[dbo].\[SqlQueryNotificationStoredProcedure-b6be17ba-35b4-4051-adc5-146f6cf6c11a] running on queue Northwind.dbo.SqlQueryNotificationService-b6be17ba-35b4-4051-adc5-146f6cf6c11a output the following: ‘Could not obtain information about Windows NT group/user ‘LAKEQUINCYMEDIASteve’, error code 0x54b.’*

*For more information, see Help and Support Center at <http://go.microsoft.com/fwlink/events.asp>.*

The interesting thing about this error is that both my connection I’m using to test the SqlDependency and the one I’m using to alter the table data are connecting as ‘sa’. I’m not using my domain account for anything! Or so I thought. Some searching yielded [this forum post](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=542041&SiteID=1) with the answer. The key is that the table I was querying, Northwind, had been created under my domain user account. The notification sproc that is created by the SqlNotification is created with EXECUTE AS OWNER, and in this case that owner was my domain account. When I’m at my office, and can connect to my domain controller, everything works fine. When I’m not in the office or connected by VPN (like, say, when I’m presenting and there’s no open wireless connection), the sproc fails because it cannot verify the user.

Solution – change the owner of the database to ‘sa’ (or any other named account that doesn’t require a domain to authenticate against). This can be done with this command (change Northwind to your DB name):

**ALTER AUTHORIZATION ON DATABASE::Northwind TO sa;**

You can view which databases are owned by whom with this:

**select name,suser_sname(owner_sid) from sys.databases**

*To everybody who’s seen me demo the SQL 2005 Cache Dependencies and scratch my head when it didn’t work in front of the room when it \*just\* worked at my office, sorry it took me so long to track this down. But it really \*does\* work! Honest!*

**\[categories:sql2005, caching]**

<!--EndFragment-->