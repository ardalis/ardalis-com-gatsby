---
templateKey: blog-post
title: Database cannot be opened – version 655
path: blog-post
date: 2011-01-30T11:06:00.000Z
description: I’m working with the new
  [MvcMusicStore](http://mvcmusicstore.codeplex.com/) sample application, and
  immediately I’m having trouble with the database. When I try and open the .mdf
  file that’s in my App_Data,
featuredpost: false
featuredimage: /img/error.jpg
tags:
  - database
  - entity framework
  - error
  - sql server
category:
  - Software Development
comments: true
share: true
---
I’m working with the new [MvcMusicStore](http://mvcmusicstore.codeplex.com/) sample application, and immediately I’m having trouble with the database. When I try and open the .mdf file that’s in my App_Data, I’m presented with this error message:

> *The database ‘C:DEVSCRATCHMVCMUSICSTORE-V2.0MVCMUSICSTORE-COMPLETEDMVCMUSICSTOREAPP_DATAMVCMUSICSTORE.MDF’ cannot be opened because it is version 655. This server supports version 612 and earlier. A downgrade path is not supported.\
> Could not open new database ‘C:DEVSCRATCHMVCMUSICSTORE-V2.0MVCMUSICSTORE-COMPLETEDMVCMUSICSTOREAPP_DATAMVCMUSICSTORE.MDF’. CREATE DATABASE is aborted.\
> An attempt to attach an auto-named database for file C:DevScratchMvcMusicStore-v2.0MvcMusicStore-CompletedMvcMusicStoreApp_DataMvcMusicStore.mdf failed. A database with the same name exists, or specified file cannot be opened, or it is located on UNC share.*

And it looks something like this:

![SNAGHTML1efa79f7](<> "SNAGHTML1efa79f7")

My first (and as it turns out, *incorrect*) thought is that maybe it’s using SQL CE 4, which was [just recently announced](http://weblogs.asp.net/scottgu/archive/2011/01/13/announcing-release-of-asp-net-mvc-3-iis-express-sql-ce-4-web-farm-framework-orchard-webmatrix.aspx). Reading on, it appears that you need to [install some tooling for Visual Studio 2010 (SP1) and SQL CE](http://weblogs.asp.net/scottgu/archive/2011/01/11/vs-2010-sp1-and-sql-ce.aspx). To proceed, it looks like I need to:

* Download and Install [VS2010 SP1 (beta)](http://www.microsoft.com/downloads/en/details.aspx?FamilyID=11ea69cb-cf12-4842-a3d7-b32a1e5642e2&displaylang=en)
* Download and Install [SQL CE Tools for Visual Studio](http://go.microsoft.com/fwlink/?LinkID=206994)

Note to the reader – the SP1 installer is all of 666kb, but it’s one of ***those*** installers that really just phones home to download the real update, which is not small. Expect this to take a few minutes. The SQL CE VS Tools installer is about 1.8MB, and that’s actually the whole thing.

Here’s my SP1 installer after a few minutes (with a 3Mbps up/down connection dedicated to the task):

![SNAGHTML1f01442f](<> "SNAGHTML1f01442f")

While waiting for this to install (I had some time), I did some more research on my error message and found out that it’s probably not a SQL CE issue after all, but [an issue of the version of SQL Server Express that I have installed](http://mvcmusicstore.codeplex.com/Thread/View.aspx?ThreadId=220031). The error message I’m seeing is also described in this post about [\*.MDF cannot be opened because it is version 655. This server supports version 612 and earlier](http://conceptdev.blogspot.com/2009/04/mdf-cannot-be-opened-because-it-is.html) – sounds familiar…

I waited for SP1 to finish installing, rebooted, installed SQL CE tools, and tried to open the file again, but got the same error. So, if you’re actively trying to get past the error noted at the top of this post, **don’t both installing SP1 as it doesn’t fix it**.

So I updated my database instance name in Visual Studio – Tools – Options – Database Tools – Data Connections to SQL2008 as directed in the above post.

![SNAGHTML8310b](<> "SNAGHTML8310b")

This at least got me to a new error message when trying to open MvcMusicStore.mdf:

![SNAGHTML9cf98](<> "SNAGHTML9cf98")

So at this point it looks like I either **need to install SQL Server 2008 Express**, or else **run the database scripts by hand on my own instance of SQL 2008**. I elect for the latter. You can download the scripts needed to populate your own database [here](http://www.codeplex.com/Project/Download/FileDownload.aspx?ProjectName=mvcmusicstore&DownloadId=147007). The script includes the schema as well as sample data for the application.

Once installed, I updated my connection string to refer to my localhost database and things started to work:

![image](<> "image")