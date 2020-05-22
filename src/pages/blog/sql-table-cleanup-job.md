---
templateKey: blog-post
title: SQL Table Cleanup Job
path: blog-post
date: 2010-10-23T11:45:00.000Z
description: It’s pretty straightforward to create a job in SQL Server that will
  clean up a table. For instance, for [AspAlliance.com] I use [ELMAH] to record
  errors, and it’s set up to go to a database table (called ELMAH_Error – see
  image at right).
featuredpost: false
featuredimage: /img/sql-server-sql-server-management.png
tags:
  - SQL
  - sql server
category:
  - Software Development
comments: true
share: true
---
It’s pretty straightforward to create a job in SQL Server that will clean up a table. For instance, for [AspAlliance.com](http://aspalliance.com/) I use [ELMAH](http://code.google.com/p/elmah) to record errors, and it’s set up to go to a database table (called ELMAH_Error – see image at right). While doing some maintenance, I noticed that this table had several months’ worth of data in it and over 400k records (many of which were simply 404s). This was needlessly bloating the size of the database, so I did a quick delete to take care of it. Personally, I’m interested mainly in 500 errors, but I don’t mind seeing the odd 404 error in the log as sort of a sanity check to make sure I haven’t done something stupid. So the rule I quickly came up with was that I’d clean up the table daily of anything older than 30 days, and all 404 errors. By scheduling this early in the morning, I’ll still see any 404 errors that have occurred today (since 3am or whatever).

So, how do we create a SQL Table Cleanup Job to purge records and keep log / event tables from growing out of control? It’s very simple (in fact this was the first time I’d done it, but I was pleased to see how easy it is).

**Step 1 – Open SQL Server Agent**

You have to have SQL Server Agent installed and running on your server. If you do, then open up Microsoft SQL Server Management Studio and connect to your database server. If you open up the SQL Server Agent tree you should see a folder called Jobs, which you can open up as well. It should look something like this:

![SQL Server Agent](<> "SQL Server Agent")

**Step 2 – New Job**

Right click on Jobs and select New Job. You should see a dialog like this one:

![New Job dialog](<> "New Job dialog")

Give the job a name and optionally, a description and/or category.

**Step 3 – Steps**

Next click on Steps. Select New at the bottom.



[![New Step](<> "New Step")](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/SQLTableCleanupJob_BCAA/SNAGHTML29b6bf56.png)

Give the new step a name and enter in the script you’d like it to run in the box. Set the database it should target, as well. When you’re done it should look something like this. Note that if you prefer you can execute a stored procedure, which I would recommend for anything but the most trivial of jobs. (Also note that if you’re doing something that involves a lot of business logic, I’d recommend doing that in an EXE or Service, with tests and in source control, not in a one-off job. You’ll thank me later.)

[![New Job Step](<> "New Job Step")](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/SQLTableCleanupJob_BCAA/SNAGHTML29b85e41.png)

Click OK to save your step. You should see it listed in the Job step list. Add any additional steps your job will include, then click on Schedules.

**Step 4 – Scheduling the Job**

After clicking on Schedules, you should see this dialog:

[![Schedules](<> "Schedules")](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/SQLTableCleanupJob_BCAA/SNAGHTML29b9bde1.png)

Click the New button at the bottom. Provide a name for the schedule (e.g. Daily3AM) and set its properties, like so:

[![Daily3AM Schedule](<> "Daily3AM Schedule")](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/SQLTableCleanupJob_BCAA/SNAGHTML29bad396.png)

Click OK. You should see the schedule listed now in the Schedule List. Note that if you already have a schedule that you’d like to use, you can click the Pick button to select it.

**Step 5 – Done!**

You can set up alerts and notifications, as well as target different servers, but assuming the job is running on the local machine and you don’t need to know about it, you’re done. You should see the job listed now under the Jobs folder of SQL Server Agent. You can test it out immediately by right-clicking on it and selecting Start Job at Step…. If your Job has only one step, this will simply run it.

[![Start Job At Step](<> "Start Job At Step")](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/SQLTableCleanupJob_BCAA/image_8.png)

**Summary**

Don’t let your logging tables grow out of control. Eventually they will result in backups that take too long and disk space issues. By setting up a maintenance job for such tables, you can eliminate these issues in the future, and once set up you generally don’t have to think about them. If you’re curious about how big your tables might be, don’t forget that you can easily view a report by right clicking on your database and selecting Disk Usage by Top Tables (see below). This can be a very quick and easy way to see which of your tables are taking up the most space, so you can focus your optimization and cleanup efforts effectively.

[![Database Reports](<> "Database Reports")](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/SQLTableCleanupJob_BCAA/image_10.png)

There are a bunch of built-in reports that are worth checking out if you’ve not noticed them in the past.