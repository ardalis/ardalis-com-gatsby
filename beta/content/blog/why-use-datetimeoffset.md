---
title: Why Use DateTimeOffset
date: "2022-01-17T00:00:00.0000000"
description: Using DateTime for entity properties and database fields is ubiquitous, but if you really care about the time portion of the value, it's often ambiguous. What time zone is the date in? Is it stored as UTC? From everywhere that touches it? How can you be sure? DateTimeOffset provides a solution to this problem.
featuredImage: /img/why-use-datetimeoffset.png
---

Raise your hand if you've stored entity values in a database as DateTime.

Ok, everybody has their hand up. You can put your hand down - you look silly doing that while reading an article on some website.

Using DateTime for entity properties and database fields is ubiquitous, but if you really care about the time portion of the value, it's often ambiguous. What time zone is the date in? Is it stored as UTC? From everywhere that touches it? How can you be sure? DateTimeOffset provides a solution to this problem.

## Storing DateTime Values

The simple DateTime type ([which makes a great example of a Value Object](https://ardalis.com/datetime-as-a-value-object/)), always assumes the local machine's relative time. When you ask it for `.Today` or `.Now` it uses the local system clock. This can easily cause problems between machines with different times and/or timezones. It can be helpful to look at the output of a particular DateTime value as a string.

```csharp
var rightNow = new DateTime(2022,1,17,18,11,30);
Console.WriteLine(rightNow);
// 1/17/2022 6:11:30 PM

Console.WriteLine(rightNow.ToLocalTime());
// 1/17/2022 1:11:30 PM

Console.WriteLine(rightNow.ToUniversalTime());
// 1/17/2022 11:11:30 PM

Console.WriteLine(rightNow.ToString("yyyy-MM-ddTHH:mm:ss"));
// 2022-01-17T18:11:30
```

The initial time is 6:11pm on 17 Jan 2022 on my computer here in Ohio, which is Eastern Standard Time (UTC-5). The `rightNow` variable doesn't include any time zone data in it. The `DateTime` functions `ToLocalTime` and `ToUniversalTime` assume that the data they're operating is in UTC or local time, respectively. As a result, of the four different times shown, the one produced by `ToLocalTime` is incorrect, since it's subtracting 5 hours from the actual time of 6:11pm.

Note that when you store datetimes in your application, they'll be stored based on whatever machine timezone they're running on, unless you're extremely disciplined about using UTC times wherever you modify the dates. And even if you are, there's no way to look at your data and see that you were, after the fact. The data simply won't know.

What happens when the same code is run on different developers' machines in different timezones? What happens when tests are run in this case?

What happens when you move your cloud-hosted app from one region to another? What happens if the app spans region in production for high-availability (HA) reasons?

For all of these reasons, it can be worthwhile to store dates in your application using the DateTimeOffset type.

## DateTimeOffset

DateTimeOffset is both a.NET type and a SQL Server type (other databases have equivalents, too). The main difference between it and the simpler DateTime type we all know and love is that it includes a time zone offset from UTC. Thus, it's always clear when looking at a DateTimeOffset what time is meant, whether UTC or local.

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

This idea to write this article comes from a [bug](https://github.com/DevBetterCom/DevBetterWeb/issues/620) in the current [DevBetter.com](https://devBetter.com/) website source code caused by using a DateTime property rather than a DateTimeOffset. The group developer mentoring program includes an archive of all past coaching session videos, and new videos list their date of publication using the familiar"x minutes/hours/days ago" format, rather than the explicit time itself. Because of differences in the server time, the upload time, and the user's local time, some videos were being shown as"-11089 seconds ago" which would mean they were uploaded some time in the future...

We'll fix the issue, probably by using DateTimeOffset, and chalk it up as another learning experience for the group based on the open source web site's code.

## Summary

DateTime values lack any knowledge of time zone, or lack thereof. If you need to know when things actually occurred, with more precision than just the approximate date, and you can't be 100% sure that your dates are ALWAYS stored in UTC, then you should consider using DateTimeOffset to represent your datetime values. These are unambiguous about their time zone, or lack of (when in UTC time), and thus can eliminate a host of errors that plague many real world systems.

