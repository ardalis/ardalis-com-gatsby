---
templateKey: blog-post
title: Installing SQL 2005 Management Studio
path: blog-post
date: 2007-09-24T11:46:49.966Z
description: I’ve installed SQL Server on a few dev boxes in my time, and one
  thing I’ve noted on several occasion is that even if you check the box during
  the install to say you want to install all of the client tools, usually they
  don’t install.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - SQL
  - sql2005
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve installed SQL Server on a few dev boxes in my time, and one thing I’ve noted on several occasion is that even if you check the box during the install to say you want to install all of the client tools, usually they don’t install. You think they installed, the setup dialog said it would install them, but when everything is said and done you don’t see anything in the Start-Programs menu except a SQL Configuration option. What gives?

So you install again, only this time the setup dialog tells you nothing’s going to change because the client tools were already installed last time. But they weren’t. Eventually, I’ve managed to get them installed, but it was usually a challenge each time because I didn’t make careful note of exactly what I had to do to get it to install. When I encounter such things, I liken it to having to perform some bit of voodoo or sacrificing a chicken in order to achieve the desired results.

Thankfully for you (and the local chicken population), [Brendan has documented the exact problem and how to fix it](http://aspadvice.com/blogs/name/archive/2007/09/24/Installing-SQL-Server-Management-Studio-with-SQL-Server.aspx). Essentially, there seems to be a problem with the default installer in that it is designed only to install the Server portion of SQL Server 2005, even though it lists client tools. Ignore that, and browse to the Tools folder on the disk to run the client install directly, and you should be able to get SQL Server Management Studio installed without any need for voodoo.

<!--EndFragment-->