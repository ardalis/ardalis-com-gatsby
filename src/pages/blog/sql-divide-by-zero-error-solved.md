---
templateKey: blog-post
title: SQL Divide By Zero Error Solved
path: blog-post
date: 2009-09-25T22:08:00.000Z
description: Recently a report that had been running fine for months began
  failing with a Divide By Zero exception. This report is a summary of a lot of
  data and is contained in a stored procedure which uses quite a few table
  variables to do its job.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - SQL
category:
  - Uncategorized
comments: true
share: true
---
Recently a report that had been running fine for months began failing with a Divide By Zero exception. This report is a summary of a lot of data and is contained in a stored procedure which uses quite a few table variables to do its job. Here’s part of it:

```
<span style="color: #0000ff">declare</span> @AccountManagerRevenueByFormat <span style="color: #0000ff">table</span> 
(FormatID <span style="color: #0000ff">int</span>, AccountManagerRevenue money)
insert <span style="color: #0000ff">into</span> @AccountManagerRevenueByFormat
<span style="color: #0000ff">select</span> CreativeFormatID, <span style="color: #0000ff">sum</span>(AmountEarned)
<span style="color: #0000ff">from</span> lq_AccountManagerRevenueDetail amr
    <span style="color: #0000ff">inner</span> <span style="color: #0000ff">join</span> lq_Placement p <span style="color: #0000ff">on</span> amr.PlacementID = p.ID
<span style="color: #0000ff">where</span> DateRecorded <span style="color: #0000ff">between</span> @StartDate <span style="color: #0000ff">and</span> @EndDate
<span style="color: #0000ff">group</span> <span style="color: #0000ff">by</span> CreativeFormatID
```

Ultimately, after a bunch of such tables are created, all of the results are pulled out using a final select that joins together each of the table level variables. One of the columns displayed is a CPM value, or “cost per thousand,” which is how online ad impressions are typically priced (this report was part of [AdSignia, Lake Quincy Media’s ad network management platform](http://lakequincy.com/)). In order to calculate CPM, the query included something like this:

```
isnull( isnull(Revenue,0) / ( <span style="color: #0000ff">nullif</span>(Impressions,0) / 1000),0) [CPM],
```

The purpose of the various i snull and nullif functions is to guard against divide by zero exceptions and to ensure that any lack of results is shown as zero. For instance, the following returns 0 as expected:

```
<span style="color: #0000ff">select</span> isnull( isnull(1,0) / ( <span style="color: #0000ff">nullif</span>(0,0) / 1000),0) [CPM]
```

And when impressions are 1000 and revenue is 1, the CPM of 1 is returned as expected:

```
<span style="color: #0000ff">select</span> isnull( isnull(1,0) / ( <span style="color: #0000ff">nullif</span>(1000,0) / 1000),0) [CPM]
```

However, despite all of these guards, one thing can still go wrong. Do you see it?



…



The problem has to do with the fact that Impressions are an integer field, so by default the division is going to drop any remainder. Thus, the following doesn’t evaluate to slightly more than 1, but rather results in a divide by zero error:

```
<span style="color: #0000ff">select</span> isnull( isnull(1,0) / ( <span style="color: #0000ff">nullif</span>(999,0) / 1000),0) [CPM]
```

To counteract this, the Impressions field needs to be converted to a numeric or floating point data type before being divided, like so:

```
<span style="color: #0000ff">select</span> isnull( isnull(1,0) / ( <span style="color: #0000ff">nullif</span>(<span style="color: #0000ff">convert</span>(<span style="color: #0000ff">float</span>,999),0) / 1000),0) [CPM]
```

which results in: 1.001001001001.

Returning to the original snippet, it looks like this:

```
isnull( isnull(Revenue,0) / ( <span style="color: #0000ff">nullif</span>(<span style="color: #0000ff">CONVERT</span>(<span style="color: #0000ff">float</span>,Impressions),0) / 1000),0) [CPM],
```