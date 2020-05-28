---
templateKey: blog-post
title: When is it OK to use a DataReader
path: blog-post
date: 2003-04-07T00:10:00.000Z
description: There is a good article on the actual performance characteristics
  of DataReaders vs. DataSets on MSDN. In it, you will find that DataSets are
  not always slower than DataReaders, especially when there is any significant
  latency between the web server and the database server or when there are a
  limited number of connections available.
featuredpost: false
featuredimage: /img/datareaders-vs-datasets.jpg
tags:
  - DataReader
  - DataReaders vs DataSets
  - DataSets
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

I just responded to a discussion on this topic on the [ASP.NET Forums](http://asp.net/forums)…

There is a good article on the actual performance characteristics of DataReaders vs. DataSets on MSDN [here](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnbda/html/bdadotnetarch031.asp). In it, you will find that DataSets are not always slower than DataReaders, especially when there is any significant latency between the web server and the database server or when there are a limited number of connections available. Still, a DataReader is generally going to be the fastest way and almost always the least resource intensive (memory) way to pull some data from the database. However, that speed is not the only basis on which you should make your decision on whether or not to use it.

In addition to raw performance, another important consideration is what I call dummy-proofing. If you pass an open DataReader back from a Data Access Layer in an N-Tier application so that someone else can use it on a web form, you are asking for trouble. You’re depending on that individual to know how to properly clean up the DataReader and to remember to do so, and it is completely out of your hands whether or not they do so. If they do not, it can have severe consequences on the application’s performance. You’re basically handing them a loaded gun with the safety off and hoping they know which end the bullet comes out of.

When I teach or present on this topic, I offer some guidelines that I’ve come up with that help one to determine whether to use a DataReader or another data container (like a DataTable or a strongly typed custom class). Here are the conditions that must exist in order for you to use a DataReader:\
1) You do NOT need to cache the data.\
2) You do NOT need to serialize the data via web services or remoting.\
3) You are NOT delegating responsbility for cleaning up the Reader beyond code that you immediately control, either a function or a class. Passing between application layers is definitely ill-advised.\
4) You do not want to use the updating capabilities of the DataAdapter to do batch updates.

<!--EndFragment-->