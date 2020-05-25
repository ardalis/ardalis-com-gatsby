---
templateKey: blog-post
title: VS 2005 Breaking Changes (from PDC Bits)
path: blog-post
date: 2004-03-28T13:08:00.000Z
description: As I mentioned in [an earlier post], I’ve just installed VS 2005
  and am now ready to start reporting on it. Some folks like [Rick] have
  reported stability issues with this build but I haven’t had any such problems
  thus far, and it is working much better than an interim build I had installed
  about a month ago.
featuredpost: false
featuredimage: /img/vslogo-760x360.png
tags:
  - VS 2005
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

As I mentioned in [an earlier post](http://aspadvice.com/blogs/ssmith/archive/2004/03/27/1793.aspx), I’ve just installed VS 2005 and am now ready to start reporting on it. Some folks like [Rick](http://west-wind.com/weblog/posts/325.aspx) have reported stability issues with this build but I haven’t had any such problems thus far, and it is working much better than an interim build I had installed about a month ago. One of the first things I’m doing is looking for breaking changes from the previous alpha, of which I’ve been told to expect quite a few. I pulled up my samples for my GridView/DetailsView article for AspNetPRO back in October and immediately discovered some changes to the GridView and the SqlDataSource controls.

With the PDC bits, the collection of columns in the GridView was called **ColumnFields**, seemingly to make it clear that a) this is not a DataGrid (which has **Columns**), and b) the columns in this non-DataGrid are called *fields*. This has been changed — the GridView now has a **Columns** collection, but it still contains Field objects (e.g. **BoundField**).

The SqlDataSource control’s parameters used to have a **TreatEmptyStringAsNull** boolean property. This has apparently been replaced with **ConvertEmptyStringToNull** (still boolean). The SqlDataSource also blows up now if you don’t turn on ‘server-side paging’. The error message is pretty clear:

## *The SqlDataSource ‘PubsDataSource’ does not have server-side paging enabled. Either set EnableSqlPaging to true to enable server-side data paging, or set the DataSourceMode to DataSet to enable non-server paging.*

Examining the DataSource in question, I see that I can either turn on EnableSqlPaging or set DataSourceMode to DataSet (instead of DataReader). In my case, it appears that DataSet is already set, which should mean based on this exception that I should have no issues, but it’s an alpha, so what do you expect? I try turning on EnableSqlPaging… The page loads without error (paging doesn’t work, though). Oh well, at least we got past that exception.

The DetailsView object had a few changes as well, including one I ran into where the ItemUpdated event’s event args type has changed. Instead of DetailsViewStatusEventArgs as the type, it is now DetailsViewUpdatedEventArgs. Further, you can no longer just use one event handler for any status change (edit, delete, etc) — you need a separate event handler for each type of change. This is actually pretty nice, since it offers more granular flexibility. The IDE doesn’t seem to want to auto-generated the event handlers on a double-click in the lightning bolt area of the property sheet in design view, unfortunately, but hopefully that will be fixed for the beta. Essentially, this change required me to create 3 event handlers, one each for Update, Insert, and Delete, instead of just a StatusChange event handler as I had previously.

<!--EndFragment-->