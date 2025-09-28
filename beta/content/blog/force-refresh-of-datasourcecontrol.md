---
title: Force Refresh of DataSourceControl
date: "2007-08-25T07:55:21.0640000-04:00"
description: I had a situation where I was using a DataSourceControl (actually
featuredImage: img/force-refresh-of-datasourcecontrol-featured.png
---

I had a situation where I was using a DataSourceControl (actually an LLBLGenProDataSource2,which inherits from DataSourceControl) bound to a grid, and I wanted the grid to refresh its contents whenever I added or deleted an item from it. I discovered a neat trick noted here, which is that if you touch the SelectParameters collection of the DataSourceControl, it will cause it to DataBind in its PreRender stage. So in my case, wherever I wanted it to rebind my grid, I would simply do this:

PaymentDataSource.SelectParameters.Add("foo","0"); // hack to force grid to rebind

In my case I wasn't using any parameters, and this is probably not the \*best\* way to do this, but it's 2am and it worked for me so I'm going to keep it until some noble commenter offers the proper way to do this.

