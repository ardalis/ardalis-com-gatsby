---
templateKey: blog-post
title: Team Project Creation Failed TF30225
path: blog-post
date: 2007-07-06T13:18:26.966Z
description: So, I get this error now every time I try to create a new Team
  Project. I've checked my SQL Reporting Services configuration and it's all
  Green.
featuredpost: false
featuredimage: /img/smaug-1.jpg
tags:
  - TFS
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

So, I get this error now every time I try to create a new Team Project. I've checked my SQL Reporting Services configuration and it's all Green. I'm creating this project as an administrator. I've searched for help online, of course, but so far, nothing. I'll update this post when I find the answer – in the meantime if you know what kind of animal sacrifice is required, please comment.

**Update**: Worked like a charm. Blog about it, and the answer will come. I found [this forum thread](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=159641&SiteID=1) during one more search. This led me to update my report data source credentials here:\
<http://localhost/Reports/Pages/DataSource.aspx?ItemPath=%2fTfsReportDS> and that did the trick.

<!--EndFragment-->