---
templateKey: blog-post
title: "Azure Tip: How To Deploy a ZIP File to Windows Azure"
path: blog-post
date: 2010-01-30T13:33:00.000Z
description: Last month,The Code Project ran an Azure contest and gave away
  several Amazon Kindles. As part of the contest, which we hosted on Azure, we
  deployed a sample project with all of the necessary install files for getting
  started with Windows Azure.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Windows Azure
category:
  - Uncategorized
comments: true
share: true
---
Last month,[The Code Project](http://codeproject.com/) ran an [Azure contest and gave away several Amazon Kindles](http://www.codeproject.com/Feature/Azure). As part of the contest, which we hosted on Azure, we deployed a sample project with all of the necessary install files for getting started with Windows Azure. It turned out to be slightly more difficult than expected to actually get the zip file deployed to the cloud, so I thought I’d post here in case others ran into the same issue.

![](/img/zip-file1.png)

The issue isn’t related to ZIP files, of course, but to any content file that is added to a web project that isn’t a typical ASP.NET or web file type (e.g. .aspx, .gif, etc.). For instance, if you simply add a .zip file to an ASP.NET web project (in this case, an Azure Web Instance project), it will have project properties like the box to the right.

As you might expect, this won’t actually be deployed. At first glance, it might seem like the right thing to do (especially if you’re in a hurry and are trying things quickly to get this to work) is to change “Do not copy” since obviously we do want this file copied up to our Azure deployment. And you would be wrong.

Simply put, the issue here is that a Build Action of “None” means the build and deploy features of Visual Studio will treat your file like a social pariah and ignore it completely. Pretend your file has leprosy – Visual Studio wants nothing to do with it. But that’s not how Visual Studio treats “cool” files, like images and CSS, which it also doesn’t need to build. Looking at these for reference, we see they look like this:

![](/img/zip-file2.png)

So the fix to get your ZIP files and other “content” to be deployed to the cloud as part of your Azure deployment package is to simply specify a Build Action of “Content.”

Incidentally, this month (Feb 2010) the Code Project is resuming their contest, this time with an even bigger prize: an **HP TouchSmart TX2-1370US 12.1-Inch laptop computer**. All you need to do to enter is create a new Azure application and register it with the Code Project’s site (using the template we provide makes this easy). Check out the [Code Project Feb 2010 Azure contest details page](http://www.codeproject.com/Feature/Azure) for more info.