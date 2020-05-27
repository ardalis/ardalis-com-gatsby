---
templateKey: blog-post
title: LINQ and the new DevExpress Grid
path: blog-post
date: 2008-03-31T12:18:14.612Z
description: Mehul has a couple of screencasts up on his blog that demonstrate
  how to use their new LINQ datasource to do optimized paging/updating of their
  ASPxGridView control.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ajax
  - asp.net
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Mehul](http://community.devexpress.com/blogs/aspnet) has a couple of screencasts up on his blog that demonstrate [how to use their new LINQ datasource to do optimized paging/updating of their ASPxGridView control](http://community.devexpress.com/blogs/aspnet/archive/2008/03/25/aspxgridview-screencast-enable-server-mode-using-linq.aspx). At just over 2 minutes, the screencast does a very good job of showing how easy it is to set up LINQ to SQL (not that that hasn’t been done before, but the more times you see it, the more likely it will stick). That’s more than half the time, then there’s just a few mouse clicks to wire up the Grid control with the DataSource control, and you can see the thing in action.

I’ve seen demos of [DevExpress’s](http://devexpress.com/) data transfer technology and it’s really sweet because it only sends the bare minimum of data on the wire both to and from the server. This demo doesn’t quite do it justice since Mehul’s only working on localhost, but where it really shines is in a real Internet scenario where the clients have some lag time between them and the server. Avoiding full postbacks (even with UpdatePanels) makes the control far more responsive, especially with large amounts of data, than the stock grid and data controls.

<!--EndFragment-->