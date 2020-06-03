---
templateKey: blog-post
title: Sql Table Refactoring Challenge
path: blog-post
date: 2010-04-28T06:14:00.000Z
description: I've been working a bit on cleaning up a large table to make it
  more efficient. I pretty much know what I need to do at this point, but I
  figured I'd offer up a challenge for my readers, to see if they can catch
  everything I have as well as to see if I've missed anything. So to that end, I
  give you my table
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - sql table
category:
  - Software Development
comments: true
share: true
---
I've been working a bit on cleaning up a large table to make it more efficient. I pretty much know what I need to do at this point, but I figured I'd offer up a challenge for my readers, to see if they can catch everything I have as well as to see if I've missed anything. So to that end, I give you my table:

```sql
CREATE TABLE [dbo].[lq_ActivityLog](
      [ID] [bigint] IDENTITY(1,1) NOT NULL,
      [PlacementID] [int] NOT NULL,
      [CreativeID] [int] NOT NULL,
      [PublisherID] [int] NOT NULL,
      [CountryCode] [nvarchar](10) NOT NULL,
      [RequestedZoneID] [int] NOT NULL,
      [AboveFold] [int] NOT NULL,
      [Period] [datetime] NOT NULL,
      [Clicks] [int] NOT NULL,
      [Impressions] [int] NOT NULL,
      CONSTRAINT [PK_lq_ActivityLog2] PRIMARY KEY CLUSTERED
      (
        [Period] ASC,
        [PlacementID] ASC,
        [CreativeID] ASC,
        [PublisherID] ASC,
        [RequestedZoneID] ASC,
        [AboveFold] ASC,
        [CountryCode] ASC
      ) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, 
        IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
        ON [PRIMARY]
        ) ON [PRIMARY]
```

And now some assumptions and additional information:

* The table has 200,000,000 rows currently
* PlacementID ranges from 1 to 5000 and should support at least 50,000
* CreativeID ranges from 1 to 5000 and should support at least 50,000
* PublisherID ranges from 1 to 500 and should support at least 50,000
* CountryCode is a 2-character ISO standard (e.g. ‘US') and there is a country table with an integer ID already. There are < 300 rows.
* RequestedZoneID ranges from 1 to 100 and should support at least 50,000
* AboveFold has values of –1, 0, or 1 only.
* Period is a date (no time).
* Clicks range from 0 to 5000.
* Impressions range from 0 to 5000000.
* The table is currently write-mostly. Its primary purpose is to log advertising activity as quickly as possible. Nothing in the rest of the system reads from it except for batch jobs that pull the data into summary tables.
* Here's the current information on the [database table's size](/determine-all-sql-server-table-sizes):

![sql database table size](/img/sql-db-table-size.png)

## Design Goals

This table has been in use for about 5 years and has performed very well during that time. The only complaints we have are that it is quite large and also there are occasionally timeouts for queries that reference it, particularly when batch jobs are pulling data from it. Any changes should be made with an eye toward keeping write performance optimal while trying to reduce space and improve read performance / eliminate timeouts during read operations.

## Refactor

There are, I suggest to you, some glaringly obvious optimizations that can be made to this table. And I'm sure there are some ninja tweaks known to SQL gurus that would be a big help as well. I'll post my own suggested changes in a follow-up post – for now feel free to comment with your suggestions.