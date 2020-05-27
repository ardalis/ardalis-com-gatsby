---
templateKey: blog-post
title: Azure Table Storage Gotcha
path: blog-post
date: 2009-02-11T01:38:00.000Z
description: Steve Marx gave a great talk on getting started with Azure at PDC.
  You can watch the whole thing here and download his samples. Once you download
  the Azure SDK (I’m using the January CTP) and ASP.NET MVC (I’m using the RC),
  you can get his stuff up and running without too much trouble.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Azure
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
[Steve Marx](http://blog.smarx.com/) gave a great talk on getting started with Azure at PDC. You can watch the whole thing [here](http://channel9.msdn.com/pdc2008/ES01) and download his samples. Once you download the Azure SDK (I’m using the January CTP) and ASP.NET MVC (I’m using the RC), you can get his stuff up and running without \*too\* much trouble. However, one thing that took me a little while to figure out is that for some reason even when Azure Storage was running, the blog would error out saying that it couldn’t find the table it was looking for. Of course, it was a little more cryptic than that – what it actually said was:

![](/img/azure1.png)

**Resource not found for the segment ‘BlogEntryTable’.**

I tried making sure the table existed and even added some rows to it manually and everything checked out fine. I doublechecked my storage connection settings and that storage was running. I read and reread the readme. And then finally I looked at the Development Storage UI a little bit closer:

![](/img/azure2.png)

I had naturally run it using the SDK’s rundevstore.cmd script, and it was using its own database, not the one that I had set up for the Blog sample. Clicking on Tools – Table Service Properties allowed me to quickly change over to the blog tables (note – this only worked after running devtablegen Blog_WebRole.dll as described in the readme) let me update the Table storage provider to work against the correct instance.

![](/img/azure3.png)

With that out of the way, I was good to go until the next problem presented itself (see next post).