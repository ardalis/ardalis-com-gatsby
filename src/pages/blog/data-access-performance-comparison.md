---
templateKey: blog-post
title: Data Access Performance Comparison
path: blog-post
date: 2005-02-16T03:02:58.945Z
description: "My article on Data Access Performance Comparison with .NET,
  ASP.NET and ADO.NET was published today on AspAlliance.com. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - AspAlliance
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

My article on [Data Access Performance Comparison](http://aspalliance.com/626) with .NET, ASP.NET and ADO.NET was published today on [AspAlliance.com](http://aspalliance.com/). In it, I compare the performance of several common data access techniques, including using DataReaders vs using DataTable or DataSet constructs. The one big surprise I ran into was just how much an open DataReader can cost on a busy site. The words **instant death** come to mind. One more reason why I’m not completely sold on only [passing DataReaders between methods using delegates](http://aspalliance.com/526).

There’s a [download](http://aspalliance.com/download/626/DataAccessPerfFiles.zip) that didn’t make it into the initial article where you can see all the source code and run the tests yourself. I’m uploading it and linking it now.

<!--EndFragment-->