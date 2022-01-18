---
templateKey: blog-post
title: Simple Localization in ASP.NET Core
date: 2022-01-18
description: Localization is a common requirement for many web applications today. Using ASP.NET Core, it's simple to get basic Localization set up for an API-based app. Learn the steps required and run the sample GitHub repo to see the results in action.
path: blog-post
featuredpost: false
featuredimage: /img/why-use-datetimeoffset.png
tags:
  - software architecture
  - software design
  - object-oriented design
  - software engineering
  - ASP.NET Core
  - Localization
  - .net
category:
  - Software Development
comments: true
share: true
---

Localization is a common requirement for many web applications today. Using ASP.NET Core, it's simple to get basic Localization set up for an API-based app. Let's look at the steps involved.

## Configure Localization

The first thing you need to do is add support for localization to your app's services:

```csharp
TODO Move this to NimblePros Gatsby Blog.
```

## DateTimeOffset

DateTimeOffset is both a .NET type and a SQL Server type (other databases have equivalents, too). The main difference between it and the simpler DateTime type we all know and love is that it includes a time zone offset from UTC. Thus, it's always clear when looking at a DateTimeOffset what time is meant, whether UTC or local.

> It is always clear what actual time is depicted by DateTimeOffset, whether it's UTC or local.

Adding to the example above, it can be helpful to see what DateTimeOffset values look like when represented as strings:

```csharp
DateTimeOffset rightNowHere = new DateTimeOffset(rightNow);

Console.WriteLine(rightNowHere);
// 1/17/2022 6:11:30 PM -05:00

Console.WriteLine(rightNowHere.ToLocalTime());
// 1/17/2022 6:11:30 PM -05:00

Console.WriteLine(rightNowHere.ToUniversalTime());
// 1/17/2022 11:11:30 PM +00:00

Console.WriteLine(rightNowHere.ToString("yyyy-MM-ddTHH:mm:ss"));
// 2022-01-17T18:11:30
```

Two things to note in the listing above: the ToLocalTime value is correct and the standard ToString values all include the timezone offset (-05:00 when local, +00:00 when UTC). The last value's format string doesn't include the offset, which is represented in the format string as taking a nap: `zzz`.

```csharp
Console.WriteLine(rightNowHere.ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss zzz"));
// 2022-01-17T18:11:30 -05:00
```

## DateTimeOffset in SQL Server

SQL Server supports both DateTime and DateTimeOffset values. DateTimeOffset uses variable precision and so *can* take up more space than DateTime, but doesn't *always* do so. [Compare DateTimeOffset and DateTime on SQL Server](https://database.guide/datetime-vs-datetimeoffset-in-sql-server-whats-the-difference/) and choose which one makes sense for your needs. If you just want to quickly see the difference, run these queries:

```sql
select GetDate()
select SYSDATETIME()
select SYSDATETIMEOFFSET()
```

Results (note precision difference in second and third result):

```sql
2022-01-17 18:30:18.227
2022-01-17 18:30:18.2292271
2022-01-17 18:30:18.2292271 -05:00
```

If you're using EF Core and Migrations, they support DateTimeOffset just fine, so no need to avoid using it because of issues there.

## Aside

This idea to write this article comes from a [bug](https://github.com/DevBetterCom/DevBetterWeb/issues/620) in the current [DevBetter.com](https://devBetter.com/) website source code caused by using a DateTime property rather than a DateTimeOffset. The group developer mentoring program includes an archive of all past coaching session videos, and new videos list their date of publication using the familiar "x minutes/hours/days ago" format, rather than the explicit time itself. Because of differences in the server time, the upload time, and the user's local time, some videos were being shown as "-11089 seconds ago" which would mean they were uploaded some time in the future...

We'll fix the issue, probably by using DateTimeOffset, and chalk it up as another learning experience for the group based on the open source web site's code.

## Summary

DateTime values lack any knowledge of time zone, or lack thereof. If you need to know when things actually occurred, with more precision than just the approximate date, and you can't be 100% sure that your dates are ALWAYS stored in UTC, then you should consider using DateTimeOffset to represent your datetime values. These are unambiguous about their time zone, or lack of (when in UTC time), and thus can eliminate a host of errors that plague many real world systems.
