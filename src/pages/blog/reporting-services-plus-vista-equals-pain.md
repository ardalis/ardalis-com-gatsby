---
templateKey: blog-post
title: Reporting Services Plus Vista Equals Pain
path: blog-post
date: 2007-02-05T17:08:10.815Z
description: I spent quite a few hours yesterday trying to get Reporting
  Services to work on my Vista laptop. It didn’t end up working.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Reporting Services
  - sql2005
  - SSRS
  - windows
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I spent quite a few hours yesterday trying to get Reporting Services to work on my Vista laptop. It didn’t end up working. For quite a long time I got a login prompt when trying to go to localhost/reports, which would bomb after 3 tries and had references to several KB articles, including this one:

<http://support.microsoft.com/?id=907273>

None of the ones listed helped.

I found plenty of others with similar problems. I made sure to install the December CTP of SQL Server 2005 SP2 but that didn’t help. I found [this newsgroup post](http://groups.google.com/group/microsoft.public.sqlserver.reportingsvcs/browse_thread/thread/e889bf8ebb78ccc6/c4a91d20408176b9?lnk=st&q=reporting+services+vista&rnum=3&hl=en#c4a91d20408176b9) that seemed like it might help, but didn’t. Perhaps it will help someone else.

As it stands now, going to localhost/reports requires a login, and when I sign in with my standard user (who is also an administrator) it does let me in without a 401.1 error, but now all I see is the header. There is nothing below the header, where the reports and folders should be located.

It was a frustrating evening, but I think I’m going to have to stick with XP/Win2k3 for now.

<!--EndFragment-->