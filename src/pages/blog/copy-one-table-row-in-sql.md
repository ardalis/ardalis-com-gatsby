---
templateKey: blog-post
title: COPY One Table Row in SQL
path: blog-post
date: 2007-01-18T17:43:21.267Z
description: I have a table with a bunch of columns in it that I wanted to be
  able to duplicate so that I could just change a couple of columns and not have
  to re-enter all of the columns and their values.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - SQL
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I have a table with a bunch of columns in it that I wanted to be able to duplicate so that I could just change a couple of columns and not have to re-enter all of the columns and their values. I did some searching and the closest I came to what I wanted was[this](http://forums.devshed.com/ms-sql-development-95/copy-rows-and-change-1-value-370378.html). So, working with[Gregg](http://aspadvice.com/blogs/gstark)on IM we came up with a more flexible solution that doesn’t require typing in the 20–some column names one might have (twice):

<!--EndFragment-->

```
ALTER PROCEDURE [dbo].[aa_widget_Copy] (

@widget_id int

)

AS
BEGIN

declare @columns varchar(5000)

select @columns = case when @columns is null then column_name else @columns + ‘,’ + column_name end

from information_schema.columns 
where table_name = ‘aa_widget’

and column_name <> ‘widget_id’

declare @query varchar(8000)

set @query = ”

select @query = ‘INSERT aa_widget (‘ + @columns + ‘) SELECT ‘ + @columns + ‘ FROM aa_widget WHERE widget_id = ‘ + convert(varchar(10), @widget_id)

exec (@query)

END
```

<!--StartFragment-->

This could be modified to be even more flexible by testing the source table to see which columns (if any) were IDENTITY columns, and exclude them in the “and column_name <> … clause. Once this was done, the table name could be a parameter and this could be a general purpose CopyTableRow() method. As it stands now, it’s good enough that I can use cut-and-paste and just change the table name and key name and reuse it if I need it again.

\[categories: SQL]

<!--EndFragment-->