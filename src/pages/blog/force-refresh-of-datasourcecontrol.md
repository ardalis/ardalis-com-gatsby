---
templateKey: blog-post
title: Force Refresh of DataSourceControl
path: blog-post
date: 2007-08-25T11:55:21.064Z
description: I had a situation where I was using a DataSourceControl (actually
  an LLBLGenProDataSource2,which inherits from DataSourceControl) bound to a
  grid, and I wanted the grid to refresh its contents whenever I added or
  deleted an item from it.
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

I had a situation where I was using a DataSourceControl (actually an LLBLGenProDataSource2,which inherits from DataSourceControl) bound to a grid, and I wanted the grid to refresh its contents whenever I added or deleted an item from it. I discovered a neat trick noted here, which is that if you touch the SelectParameters collection of the DataSourceControl, it will cause it to DataBind in its PreRender stage. So in my case, wherever I wanted it to rebind my grid, I would simply do this:

PaymentDataSource.SelectParameters.Add(“foo”, “0”); // hack to force grid to rebind

In my case I wasn’t using any parameters, and this is probably not the \*best\* way to do this, but it’s 2am and it worked for me so I’m going to keep it until some noble commenter offers the proper way to do this.

<!--EndFragment-->