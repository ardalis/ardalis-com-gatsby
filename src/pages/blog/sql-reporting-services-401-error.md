---
templateKey: blog-post
title: SQL Reporting Services 401 Error
path: blog-post
date: 2007-02-09T16:53:31.266Z
description: If you just installed SQL Server Reporting Services and you are
  getting a 401.1 Unauthorized error when you try to go to the
  http://localhost/reports this post may help.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Reporting Services
  - sql2005
  - SSRS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

If you just installed SQL Server Reporting Services and you are getting a 401.1 Unauthorized error when you try to go to the http://localhost/reports this post may help. I ran into this and was having a heck of a time figuring it out, since I **assumed** that since my Reporting Services Configuration Tool was all **GREEN** that I was good to go. Not so.

In my searching I eventually found [this post](http://www.atrevido.net/blog/PermaLink.aspx?guid=3f1a7332-e4e1-4dda-be02-527bfe07e98c) which led me to my old friend, [a KB article](http://support.microsoft.com/default.aspx?scid=kb;en-us;896861)I’d already found once a week ago when [fighting with Reporting Services on Vista](http://aspadvice.com/blogs/ssmith/archive/2007/02/05/Reporting-Services-Plus-Vista-Equals-Pain.aspx). My search also yielded [this](http://groups.archivesat.com/Advanced_ASP.NET_SQL_Server_Reporting_Services/thread149996.htm) (more of the same).

I never did get RS working on Vista so tonight’s task was to get it working on a from-scratch XP Pro install. After installing XP (and IIS 5.1) and all patches I installed SQL 2005 and SQL Reporting Services, I went through the Configuration Manager and got it all green. Finally, I fired up localhost/Reports. It prompted me for a windows login. I gave it mine. Three times. Then it shows me the 401.1 error.

The fix, for me, was this registry hack from [KB 896861](http://support.microsoft.com/default.aspx?scid=kb;en-us;896861) (and incidentally this is not yet listed on [SSW’s SSRS Suggestions Page](http://www.ssw.com.au/ssw/Standards/BetterSoftwareSuggestions/ReportingServices.aspx) or [ASPAlliance.com’s SQL-Reporting Resource](http://aspalliance.com/sql-reporting)):

### Method 1: Disable the loopback check



Follow these steps:

| 1.  | Click **Start**, click **Run**, type regedit, and then click **OK**.   |
| --- | ---------------------------------------------------------------------- |
| 2.  | In Registry Editor, locate and then click the following registry key:  |
| 3.  | Right-click **Lsa**, point to **New**, and then click **DWORD Value**. |
| 4.  | Type DisableLoopbackCheck, and then press ENTER.                       |
| 5.  | Right-click **DisableLoopbackCheck**, and then click **Modify**.       |
| 6.  | In the **Value data** box, type 1, and then click **OK**.              |
|     |                                                                        |

<!--EndFragment-->