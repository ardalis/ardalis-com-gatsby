---
templateKey: blog-post
title: Old Databases and Sql Query Notifications (cache invalidation)
path: blog-post
date: 2005-09-07T14:32:35.878Z
description: "Julie and I were having issues with getting Sql Query
  Notifications to work for ASP.NET cache dependencies (for our DevConnections
  talks). "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - ADO.NET
  - asp.net
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Julie](http://www.thedatafarm.com/blog/default.aspx) and I were having issues with getting Sql Query Notifications to work for ASP.NET cache dependencies (for our [DevConnections](http://www.devconnections.com/) talks). The trick was this:

**sp_dbcmptlevel yourdatabasename,90**

Julie did most of the research on this one, with help from Sushil Chordia and Leonid Tsybert from Microsoft. [She has more on her blog](http://www.thedatafarm.com/blog/PermaLink.aspx?guid=ae9ac2c4-775c-4c9b-86f9-30d54a142793), but I’m noting here so I might remember this next time.

<!--EndFragment-->