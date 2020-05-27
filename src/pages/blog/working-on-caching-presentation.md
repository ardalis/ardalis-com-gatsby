---
templateKey: blog-post
title: Working on Caching Presentation
path: blog-post
date: 2005-08-26T14:49:13.218Z
description: I’m working on my caching presentation for Fall ASP.NET Connections
  and a few user group presentations. Those few who read my blog can enjoy some
  early looks at my research, which I’ll detail here for my own future reference
  (and yours!).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ADO.NET
  - asp.net
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’m working on my caching presentation for [Fall](http://www.devconnections.com/shows/aspfall2005/default.asp?s=65)

[ASP.NET Connections](http://www.devconnections.com/shows/aspfall2005/default.asp?s=65) and a few user group presentations. Those few who

read my blog can enjoy some early looks at my research, which I’ll detail here

for my own future reference (and yours!).

First of all I only recently found a great article on [Query](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnvs05/html/querynotification.asp)

[](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnvs05/html/querynotification.asp)

[Notifications in ADO.NET 2.0](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnvs05/html/querynotification.asp) which goes into depth about how Query

Notifications work in SQL Server 2005. This architecture is used by the

SqlCacheDependency in ASP.NET 2.0’s Cache when it is working with a SQL Server

2005 database (an alternate technique is used with SQL7/2000). It’s a

great article and one I’m definitely going to reference in my updated slide

deck.

However, even though the article was just updated in June 2005, it is out of

date based on some recently published [Changes](http://msdn.microsoft.com/asp.net/beta2/beta2rtmchanges/default.aspx)

[](http://msdn.microsoft.com/asp.net/beta2/beta2rtmchanges/default.aspx)

[For ASP.NET 2.0 from Whidbey Beta 2 to RTM](http://msdn.microsoft.com/asp.net/beta2/beta2rtmchanges/default.aspx). Specifically, the need for

SqlCacheDependency.Start() to be called did not exist in Beta 2, but is a

requirement in RTM. To quote:

> *If you are creating cache dependencies based on SQL Server 2005, you*
>
> must call the `System.Data.SqlClient.SqlDependency.Start` method to
>
> *initialize SQL Server 2005-based dependencies.*

Another change that will affect my slides — no more Disk-based

caching. According to the same document, disk-based caching was not

meeting the team’s performance goals.

I’ll be speaking on my favorite topic of caching as well as on build

management using NAnt (in one session) or MSBuild (and probably VSTS) (in a

follow-up session) at [ASP.NET](http://www.devconnections.com/shows/aspfall2005/default.asp?s=65)

[Connections in Las Vegas](http://www.devconnections.com/shows/aspfall2005/default.asp?s=65). Hope to see you there.

<!--EndFragment-->