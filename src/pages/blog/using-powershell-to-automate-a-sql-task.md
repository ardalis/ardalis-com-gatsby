---
templateKey: blog-post
title: Using PowerShell to Automate a SQL Task
path: blog-post
date: 2007-09-15T11:49:00.146Z
description: "I have a very large table in a SQL database that I need to clean
  up some old data on. I’ve already copied all of the data to another table in
  another database with a different schema. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ADO.NET
  - Cool Tools
  - SQL
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I have a very large table in a SQL database that I need to clean up some old data on. I’ve already copied all of the data to another table in another database with a different schema. I have a legacy application that still uses the old data, but the data goes back for years, and now that it’s in the new system, I’m willing to remove at least everything up until the new system started running alongside the old one.

Deleting thousands of rows in SQL Server is an annoyingly difficult task on a disk-deficient server because inevitably the transaction log fills up and the delete statement fails. If I had plenty of disk space, I could get round this issue through cleverness like this:

a) SELECT the data I want to keep into a new table\
b) DROP the existing table\
c) sp_rename the new table to the (until recently) existing table

This has the advantage of being fairly fast and not using the transaction log. However, it would mean having a copy of the data I want to keep along with all of the data I already have. Provided sufficient disk space exists, this would be the way to go.

However, I’m in no particular hurry so I determine that I could delete one day’s worth of data at a time without bloating the transaction log file too much, and then I could simply truncate the transaction log and repeat the process for as many days as I cared to remove. This process could, fairly easily I’m sure, be repeated in a loop in TSQL or SQL-CLR, or even in a C# EXE. However, since I’ve been wanting to play around more with Windows PowerShell I figured I give it a shot with that (and in this case the DB is SQL2000 so SQL-CLR was out, as well). To make my scripting work easier, I took my delete oldest day of data script and made it into the following stored procedure:

**CREATE PROC TruncateStats\
AS\
BEGIN\
DECLARE @Period DATETIME\
SELECT @Period = MIN(period) FROM stats**

**DELETE stats WHERE period = @Period AND period < ‘4/1/07’**

**BACKUP LOG stats WITH NO_LOG\
DBCC SHRINKFILE (stats_log, 2) END**

This worked and took anywhere from 30 seconds to 2 minutes to run.

Next I searched for some [PowerShell samples for working with databases, and found Allen White’s](http://sqljunkies.com/WebLog/marathonsqlguy/archive/2007/01/28/27237.aspx). I also referenced [Windows PowerShell Unleashed](http://www.computerperformance.co.uk/powershell/powershell_loops.htm#Do_While_Loop_) for a bit of help on cmdlets and looping, and found this [useful site on PowerShell looping](http://www.computerperformance.co.uk/powershell/powershell_loops.htm#Do_While_Loop_) as well. In the end, I wrote this script directly into a PowerShell environment (e.g. no cmdlet – I would not need this code again):

**PS> $cn = new-object system.data.SqlClient.SqlConnection(“Data Source=localhost;Initial Catalog=TestStats;Persist Security Info=True;User ID=stats;Password=stats”);\
PS> $cmd = new-object system.data.SqlClient.SqlCommand(“exec TruncateAdStats”, $cn);\
PS> $cmd.CommandTimeout = 600;\
PS> $cn.Open();\
PS> $iterations = (1..100)\
PS> foreach ($n in $iterations) { $cmd.ExecuteNonQuery(); }\
PS> $cn.Close();**

That’s it! This could easily be altered such that the parameter of the max date was passed in as a SqlParameter in the powershell script – in my case I hardcoded it into the sproc because this is a throwaway routine.

<!--EndFragment-->