---
templateKey: blog-post
title: Microsoft Cloud Services
path: blog-post
date: 2008-04-17T01:12:06.829Z
description: One of the quietly announced (at MIX – WMV here) new things coming
  from Microsoft “soon” is SQL Server Data Services (SSDS).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Microsoft
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

One of the quietly announced (at MIX – [WMV here](http://msstudios.vo.llnwd.net/o21/mix08/08_WMVs/BT05.wmv)) new things coming from Microsoft “soon” is SQL Server Data Services (SSDS). The [SSDS team has a blog](http://blogs.msdn.com/ssds) on MSDN. [Ryan Dunn](http://dunnry.com/blog) discussed it with me recently and also has been [blogging about it](http://www.dunnry.com/blog/IntroducingSQLServerDataServices.aspx). Last week he announced the release of [PhluffyFotos](http://dunnry.com/blog/PhluffyFotosSampleAvailable.aspx), a sample site built on top of SSDS. You can sign up for the beta of SSDS [here](http://www.microsoft.com/sql/dataservices/default.mspx). Roger Jennings has some comments [here](http://oakleafblog.blogspot.com/2008/03/sql-server-data-services-to-deliver.html).

So, what is SSDS ([read the FAQ](http://www.microsoft.com/sql/dataservices/faq.mspx))? Essentially, it’s a way for you to access data from “the cloud” providing a highly scalable and globally available data access story. One scenario that benefits greatly from this approach is the application that suffers from extreme spikes in activity punctuated by lengthy lulls. For instance, a ticket sales company that has millions of requests within the hour that some tickets go on sale, and then just thousands of requests the rest of the month.

Amazon and Google are both pushing cloud services and clearly this is an area that Microsoft is moving into as well. SSDS is the first of what I expect will be other such services, and it will be interesting to see how the various offerings compare. If nothing else, the competition between the various companies should drive pricing down, both for these services directly as well as for traditional application hosting solutions. Eventually, I expect a developer could upload an application and configure its data source requirements and host the entire thing “in the cloud” paying some metered rate for the various resources (disk, cpu, bandwidth, and extra services) consumed by the application.

<!--EndFragment-->