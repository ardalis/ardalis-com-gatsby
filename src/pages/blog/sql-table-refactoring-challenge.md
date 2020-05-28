---
templateKey: blog-post
title: Sql Table Refactoring Challenge
path: blog-post
date: 2010-04-28T06:14:00.000Z
description: I’ve been working a bit on cleaning up a large table to make it
  more efficient. I pretty much know what I need to do at this point, but I
  figured I’d offer up a challenge for my readers, to see if they can catch
  everything I have as well as to see if I’ve missed anything. So to that end, I
  give you my table
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - sql table
category:
  - Uncategorized
comments: true
share: true
---
I’ve been working a bit on cleaning up a large table to make it more efficient. I pretty much know what I need to do at this point, but I figured I’d offer up a challenge for my readers, to see if they can catch everything I have as well as to see if I’ve missed anything. So to that end, I give you my table:

```
<span style="color: #0000ff">CREATE</span> <span style="color: #0000ff">TABLE</span> [dbo].[lq_ActivityLog](<br />    [ID] [bigint] <span style="color: #0000ff">IDENTITY</span>(1,1) <span style="color: #0000ff">NOT</span> <span style="color: #0000ff">NULL</span>,<br />    [PlacementID] [<span style="color: #0000ff">int</span>] <span style="color: #0000ff">NOT</span> <span style="color: #0000ff">NULL</span>,<br />    [CreativeID] [<span style="color: #0000ff">int</span>] <span style="color: #0000ff">NOT</span> <span style="color: #0000ff">NULL</span>,<br />    [PublisherID] [<span style="color: #0000ff">int</span>] <span style="color: #0000ff">NOT</span> <span style="color: #0000ff">NULL</span>,<br />    [CountryCode] [nvarchar](10) <span style="color: #0000ff">NOT</span> <span style="color: #0000ff">NULL</span>,<br />    [RequestedZoneID] [<span style="color: #0000ff">int</span>] <span style="color: #0000ff">NOT</span> <span style="color: #0000ff">NULL</span>,<br />    [AboveFold] [<span style="color: #0000ff">int</span>] <span style="color: #0000ff">NOT</span> <span style="color: #0000ff">NULL</span>,<br />    [Period] [datetime] <span style="color: #0000ff">NOT</span> <span style="color: #0000ff">NULL</span>,<br />    [Clicks] [<span style="color: #0000ff">int</span>] <span style="color: #0000ff">NOT</span> <span style="color: #0000ff">NULL</span>,<br />    [Impressions] [<span style="color: #0000ff">int</span>] <span style="color: #0000ff">NOT</span> <span style="color: #0000ff">NULL</span>,<br /> <span style="color: #0000ff">CONSTRAINT</span> [PK_lq_ActivityLog2] <span style="color: #0000ff">PRIMARY</span> <span style="color: #0000ff">KEY</span> <span style="color: #0000ff">CLUSTERED</span> <br />(<br />    [Period] <span style="color: #0000ff">ASC</span>,<br />    [PlacementID] <span style="color: #0000ff">ASC</span>,<br />    [CreativeID] <span style="color: #0000ff">ASC</span>,<br />    [PublisherID] <span style="color: #0000ff">ASC</span>,<br />    [RequestedZoneID] <span style="color: #0000ff">ASC</span>,<br />    [AboveFold] <span style="color: #0000ff">ASC</span>,<br />    [CountryCode] <span style="color: #0000ff">ASC</span><br />)<span style="color: #0000ff">WITH</span> (PAD_INDEX  = <span style="color: #0000ff">OFF</span>, STATISTICS_NORECOMPUTE  = <span style="color: #0000ff">OFF</span>, <br />IGNORE_DUP_KEY = <span style="color: #0000ff">OFF</span>, ALLOW_ROW_LOCKS  = <span style="color: #0000ff">ON</span>, ALLOW_PAGE_LOCKS  = <span style="color: #0000ff">ON</span>) <br /><span style="color: #0000ff">ON</span> [<span style="color: #0000ff">PRIMARY</span>]<br />) <span style="color: #0000ff">ON</span> [<span style="color: #0000ff">PRIMARY</span>]
```

And now some assumptions and additional information:

* The table has 200,000,000 rows currently
* PlacementID ranges from 1 to 5000 and should support at least 50,000
* CreativeID ranges from 1 to 5000 and should support at least 50,000
* PublisherID ranges from 1 to 500 and should support at least 50,000
* CountryCode is a 2-character ISO standard (e.g. ‘US’) and there is a country table with an integer ID already. There are < 300 rows.
* RequestedZoneID ranges from 1 to 100 and should support at least 50,000
* AboveFold has values of –1, 0, or 1 only.
* Period is a date (no time).
* Clicks range from 0 to 5000.
* Impressions range from 0 to 5000000.
* The table is currently write-mostly. Its primary purpose is to log advertising activity as quickly as possible. Nothing in the rest of the system reads from it except for batch jobs that pull the data into summary tables.
* Here’s the current information on the [database table’s size](http://stevesmithblog.com/blog/determine-all-sql-server-table-sizes):

![image](https://stevesmithblog.com/files/media/image/WindowsLiveWriter/SqlTableRefactoringChallenge_B792/image_3.png "image")

**Design Goals**

This table has been in use for about 5 years and has performed very well during that time. The only complaints we have are that it is quite large and also there are occasionally timeouts for queries that reference it, particularly when batch jobs are pulling data from it. Any changes should be made with an eye toward keeping write performance optimal while trying to reduce space and improve read performance / eliminate timeouts during read operations.

**Refactor**

There are, I suggest to you, some glaringly obvious optimizations that can be made to this table. And I’m sure there are some ninja tweaks known to SQL gurus that would be a big help as well. I’ll post my own suggested changes in a follow-up post – for now feel free to comment with your suggestions.