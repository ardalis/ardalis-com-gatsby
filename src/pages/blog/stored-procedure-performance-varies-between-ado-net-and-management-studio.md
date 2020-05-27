---
templateKey: blog-post
title: Stored Procedure Performance Varies Between ADO.NET and Management Studio
path: blog-post
date: 2008-02-15T13:53:40.419Z
description: I ran into this very annoying issue earlier this week, that my
  buddy and SQL guru Gregg Stark was able to track down for me.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ADO.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I ran into this very annoying issue earlier this week, that my buddy and SQL guru [Gregg Stark](http://sqladvice.com/blogs/gstark) was able to track down for me. I have a fairly intense [XtraReport](http://devexpress.com/) report that gets its data from a stored procedure. When I run that stored procedure in SQL Management Studio, it returns in less than a second. When I run it on my web site, it takes over 30 seconds and times out. WTF? I confirmed, ad nauseum, that it really was running the same sproc with the same parameters.

So I hit up Stark and he suggests I try messing with ARITHABORT settings in Management Studio. Lo and behold, when it’s ON it’s fast – less than one second. **When it’s OFF it takes 90 seconds**. Apparently, ADO.NET uses different settings by default than Management Studio, and as a result it’s using a really awful horrible bad query plan for this stored procedure. [Now, rather than hardcoding the ARITHABORT setting in the sproc, Stark suggested adding WITH RECOMPILE to the stored procedure](http://sqladvice.com/blogs/gstark/archive/2008/02/12/Arithabort-Option-Effects-Stored-Procedure-Performance.aspx). This will lose the “benefit” of having a cached query plan, but it will help ensure that SQL Server uses a good query plan (instead of a godawful slow one). Gregg posted about this solution a couple of days ago, so check it out [there](http://sqladvice.com/blogs/gstark/archive/2008/02/12/Arithabort-Option-Effects-Stored-Procedure-Performance.aspx).

One nice thing about this fix – it took about 2 seconds to implement once the issue was discovered! If you see a discrepancy between the performance of your stored procedure in Management Studio (or Query Analyzer) and your web site or ADO.NET code, then consider the WITH RECOMPILE option on the stored procedure (right before AS) as a possible fix.

<!--EndFragment-->