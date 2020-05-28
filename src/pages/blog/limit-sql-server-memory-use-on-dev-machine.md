---
templateKey: blog-post
title: Limit SQL Server Memory Use on Dev Machine
path: /limit-sql-server-memory-use-on-dev-machine
date: 2012-11-06
featuredpost: false
featuredimage: /img/limit-sql-server-memory-use-on-dev-machines.png
tags:
  - developers
  - performance
  - Productivity
  - sql server
  - tips and tricks
category:
  - Productivity
  - Software Development
comments: true
share: true
---

If you’re a developer running SQL Server locally, you may sometimes need to limit how much memory the database is consuming. Under normal conditions, SQL Server likes to use as much memory as it can get, since keeping results in memory improves the database’s performance. In typical production scenarios, this is the ideal behavior, but on a dev machine you probably want your RAM for other things. In my case, I noticed my RAM was creeping up to over 9.5 GB and saw this:

![SNAGHTML7145c85f](/img/SNAGHTML7145c85f_1.png "SNAGHTML7145c85f")

First of all, it’s somewhat telling that on my dev machine here, I’m not even running my dev environment, and my browser windows are collectively using more RAM than anything else (and what’s up with SnagitEditor.exe? It’s not even active at the moment). Clearly I need to spend more time working in Visual Studio and less time working in Outlook. But leaving that aside, and ignoring the fact that I still have loads of RAM free since this machine has 12GB, I’d still like to reduce the memory SQL Server is using since I’m not using that at all and if I don’t do something about it, it will just keep getting bigger until I restart.

Fortunately, it’s rather simple to fix. Just open SQL Server Management Studio, connect to your server (localhost in this case), and right click on the server in the server explorer. Choose Properties. Then choose the Memory section, shown here:

![SNAGHTML714a0a95](/img/SNAGHTML714a0a95_1.png "SNAGHTML714a0a95")

Change that big number (2,147,483,647 MB ~= 2 Petabytes) to something more reasonable. In my case, I’m already using about 577MB, but 100 MB is probably more than enough for my dev needs.

If this doesn’t work for you, there are some additional tips and things to try on this [StackOverflow question](http://stackoverflow.com/questions/856575/sql-server-2008-takes-up-a-lot-of-memory).
