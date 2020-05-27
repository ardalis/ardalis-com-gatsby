---
templateKey: blog-post
title: Production Database Migration
path: blog-post
date: 2003-12-13T22:58:00.000Z
description: I thought I’d share my experience with moving a heavily used
  production database for a live website from one server to another this
  weekend.
featuredpost: false
featuredimage: /img/asp-net-mvc-logo.jpg
tags:
  - asp
  - asp.net
  - production database migration
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

I thought I’d share my experience with moving a heavily used production database for a live website from one server to another this weekend. The database in question is used to support [AspAlliance.com](http://aspalliance.com/), but since it has been around for a long time, and since getting additional databases has not always been easy or free, there are several other sites that rely on this same database. Additionally, on AspAlliance.com there are a large number of individual ASP and ASP.NET applications, many of which store their connection string information locally. I’m still not 100% done tracking down all the apps that need updated, but the important ones are done.

**Why The Move?**

The move was required for a few reasons, mainly centered around performance. The site’s old db server was a shared box that was housing several dozen clients for my host, [OrcsWeb](http://www.orcsweb.com/), and I was using about 90% of the resources of the server, so it was time for me to be politely asked to leave. Also, my negotiations for hosting for 2004 netted me a dedicated database server, and moving to it would let me take advantage of its serious horsepower.

**Planning**

I worked closely with Scott Forsyth of Orcsweb. Scott is an [AspInsider](http://www.aspinsiders.com/) and general IIS and hosting guru. He also is one of the few people that sleeps as little as I do (though I’m not sure that’s by his choice), and he has always been a great aid for me whenever I screw up my sites. We decided last week that the best time for the move would be late Friday/early Saturday, when traffic to the impacted websites would be minimal. We pulled some baseline performance benchmarks for the destination server (which was already handling all of the mailing list data for [AspAdvice.com](http://aspadvice.com/)) so that we would be able to see how much this new load would impact the server. In the course of watching how the database performed on the shared server, we were able to observe, by Sql Server login, how many cpu cycles were used in a given time period. Using this information led us to an idea: since this database is used by half a dozen different websites, including several busy ones, it would be useful to know which ones were responsible for varying amounts of the total load.

**Logging Performance By Username**

Since we needed to update connection strings for all of the sites anyway, we decided that instead of using the same connection string everywhere, we would set up logins for each site. So we created logins like ‘aspadvice.com’, ‘aspalliance.com’, ‘ads.aspalliance.com’, etc. After testing that Sql Server didn’t mind the ‘.’ in the names, we decided this would work.

**Flipping the Switch**

Shortly after midnight Saturday morning, Scott took detached the old database, copied the files to the new server, and re-attached them. This process took about 5 minutes, during which time I was ftp-ing web.config files to the various sites to update their connection string information, and Scott was updating a couple of machine.config entries that held similar info. When the database came up, it didn’t work immediately. We found that for some reason IIS or ASP.NET’s connection pool was holding a connection to the old database but was trying to use the new uid. Each site needed to have its appdomain restarted. Another issue was that some sites had been using ‘ssmith’ as their user id, and some of the objects (tables and stored procedures) they were refencing were owned by ssmith. Now that they were using a domain name as their username, they couldn’t view these objects, so we needed to change the owner of these objects to ‘dbo’ so that all users could use them. An [old script](http://authors.aspalliance.com/stevesmith/articles/ViewArticle.aspx?id=39) I have (which David Penton originally provided to me) came in very handy, and allowed us to quickly switch all the important objects over to ‘dbo’ ownership.

Checking each site and making these db changes, as well as generally monitoring things and seeing how well the new server was performing, took us another hour or so. Once I was confident that all of the critical sites had been migrated, we set up a Sql Profiler on the shared server to record the requests that were still coming in to it so that I could track down the applications responsible and point them to the new database.

**Lessons Learned**

1. I’ve moved databases before, so having centralized connection strings was something I already knew the importance of. Having everything in web.config and/or machine.config files made this move a lot easier than it might otherwise have been.

2. Even though total downtime was only a matter of minutes, I still got a few concerned IM’s from people about the site being down. I would love to have a better way to move a database from one box to another with less downtime. A tool that would allow one to copy files from a live database (without the need to detach it) would be helpful here, I think.

3. Having the right skills is very important. Some of the tasks required I didn’t know how to do or had never done before, but Scott was easily able to accomplish. I was intimately familiar with my own applications, so I was able to quickly track down the needed configuration settings and change them myself or direct Scott to them. If either one of us had been novice or unfamiliar with the application, things would have been a lot hairier.

4. Use separate logins for different sites (and possibly applications) so that you can determine easily which users of your database are responsible for most of its load. I wasn’t sure if the major contributor to the db’s load was AspAlliance.com, with its 4M page views per month, or Ads.AspAlliance.com, which serves almost 50M advertisements per month. It turned out that AspAlliance.com was the major culprit, so now I know I need to work on optimizing its design further (it’s quite db chatty at the moment).

<!--EndFragment-->