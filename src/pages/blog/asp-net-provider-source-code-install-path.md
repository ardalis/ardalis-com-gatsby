---
templateKey: blog-post
title: ASP.NET Provider Source Code Install Path
path: blog-post
date: 2008-11-06T12:02:29.612Z
description: Some months ago, [ScottGu announced the availability of source code
  for the ASP.NET providers] This was great news and a great many comments
  followed.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - C#
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[](http://www.flickr.com/photos/41202726@N00/1885250460 "providerinstallpath")Some months ago, [ScottGu announced the availability of source code for the ASP.NET providers](http://weblogs.asp.net/scottgu/archive/2006/04/13/Source-Code-for-the-Built_2D00_in-ASP.NET-2.0-Providers-Now-Available-for-Download.aspx). This was great news and a great many comments followed. In preparation for a talk I’m giving this week at [DevConnections](http://devconnections.com/), I went out to grab the source again to be able to show it off during my talk. But no matter where I told it to install, nothing was installed. By default it wanted to go to

![](/img/sql-tool-kit.jpg)

**C:Program FilesMicrosoftASP.NET Provider Toolkit SQL Samples**

However, nothing showed up there. Nothing in the Start menu. Nothing. So I tried some other paths, but they also failed to work. Finally, I trolled through the comments and found one that explained the actual location:

**C:Program FilesASP.NET Provider Toolkit SQL Samples**

There you’ll find the following files:

**AuthStoreRoleProvider.cs.txt (it really is a .cs file)\
Microsoft Permissive License for ASP.NET 2.0 SQL Provider.rtf\
PersonalizationProviderHelper.cs\
ProviderToolkitSampleProviders.csproj\
ResourcePool.cs\
SecUtil.cs\
SqlConnectionHelper.cs\
SQLMembershipProvider.cs (nice consistent naming/casing of Sql)\
SqlPersonalizationProvider.cs\
SqlProfileProvider.cs\
SQLRoleProvider.cs\
SqlServices.cs\
sqlstateclientmanager.cs\
SqlWebEventProvider.cs\
SR.cs (string resources)\
StaticSiteMapProvider.cs\
XmlSiteMapProvider.cs**

<!--EndFragment-->