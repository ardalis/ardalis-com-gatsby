---
templateKey: blog-post
title: Update Cache in Background Thread
path: blog-post
date: 2007-06-28T13:30:01.488Z
description: In my original article, I lamented the general uselessness of the
  CacheItemRemovedCallback feature, and wished for a
  CachedItemExpiredButNotRemovedCallback.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Caching
  - performance
  - Scalability
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Peter Bromberg recently wrote an article on [refreshing the ASP.NET cache](http://www.eggheadcafe.com/tutorials/aspnet/223319d8-6366-492a-8eae-e3c7a26c88a4/refreshing-aspnet--cache.aspx), which referenced my [ASP.NET Caching Best Practices article on MSDN](http://msdn2.microsoft.com/en-us/library/aa478965.aspx). In my original article, I lamented the general uselessness of the CacheItemRemovedCallback feature, and wished for a CachedItemExpiredButNotRemovedCallback. Sadly, this feature is still lacking despite the release of .NET 2.0 and 3.0 since my article was published in 2003.

Peter’s approach is a simple and effective one, and works well for a limited number of operations. The one issue he doesn’t address is that his background thread is permanently using one of the application’s threads from its thread pool. This is not a problem if it’s the only timer being used, but it’s good to note that this approach, as written, cannot easily be wrapped up in a helper class and scaled to suit any number of cached values a site may wish to have automatically updated. The reason is due to the limited number of worker threads available to each ASP.NET application, which defaults to 20 (per cpu) and should only be modified with caution ([configuration details](http://msdn2.microsoft.com/en-us/library/7w2sway1(vs.71).aspx)).

There are several ways to address this concern, all of which only really matter if you have a busy site and you have many things you are trying to keep fresh in your cache. If neither of these applies, then just cut and paste Peter’s code into Global.asax and you’re set.

The first option is to pull the code out of the web application entirely and perform your updates that require external services using scheduled jobs. These can be done as simple .NET applications (EXEs) running in the scheduler, as SQL jobs, or even using windows services (though this is probably overkill). The scheduled job fetches the data and stores it somewhere accessible to the web application in a dependable and reasonably performing fashion, such as the site’s database or file system. The site then serves the data from this location and can use standard cache expirations without fear of long waits for updates. If desired, file system or sql cache dependencies can be added.

The second option is geared mainly at developers using hosting environments that do not permit them access to the server directly. In these cases, having the web site do everything is desirable, and is also useful for anyone developing a sample web site or site framework. In this case, the timer code is set up as in Peter’s example, but rather than tying each timer to a specific piece of data, a single timer is used for all data. Within the timer’s callback method, each item stored in the cache that is configured to be periodically renewed is inspected to determine if it needs renewed during this pass. If so, the timer performs the renewal logic. This will work fine unless the timer takes longer to perform several updates than the time remaining in the cache for the items involved — this is simply a configuration optimization, and if necessary a second or third timer could be added (but again, you don’t want to just have a 1:1 relationship between cached pieces of data and timers – that won’t scale).

One last nitpick in Peter’s code is that he bothers to use an expiration for the cached data (of 6 minutes with an auto-refresh of 5 minutes). I don’t see the point. It should never be used. If the timer fails, or takes a long time to work, the data will end up being flushed from the cache and some user will have to wait while their page tries to fetch the data. If the source of the data is down for 10 minutes, Peter’s app will be without data for at least 5 minutes (the timer period). *Assuming that for this data it is better to have old data than no data* **\[important assumption]**, it would be better to simply store the data in the Cache with no expiration at all, and perhaps even with a CachePriority.NotRemovable parameter to ensure it is not scavenged.

<!--EndFragment-->