---
templateKey: blog-post
title: Caching Key Generation Considerations
path: blog-post
date: 2009-08-24T23:22:00.000Z
description: Recently I was reviewing some code and ran across this – can you
  spot the problem?
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - cache
category:
  - Uncategorized
comments: true
share: true
---
Recently I was reviewing some code and ran across this – can you spot the problem?

```
var parameters = <span style="color: #0000ff">new</span> List&lt;SqlParameter&gt;
     {
        <span style="color: #0000ff">new</span> SqlParameter(<span style="color: #006080">&quot;@SomeID&quot;</span>, someId), 
        <span style="color: #0000ff">new</span> SqlParameter(<span style="color: #006080">&quot;@SomeOtherID&quot;</span>, someOtherId), 
        <span style="color: #0000ff">new</span> SqlParameter(<span style="color: #006080">&quot;@ServerDate&quot;</span>, serverTime)
                                };
      <span style="color: #0000ff">string</span> cacheKey = <span style="color: #0000ff">string</span>.Format(<span style="color: #006080">&quot;ResultSetName-sid{0}-soid{1}-date{2}&quot;</span>,
                                  parameters.Select(x =&gt; x.Value).ToArray()); 
      var resultSet = Cache[cacheKey] <span style="color: #0000ff">as</span> List&lt;Foo&gt;;
      <span style="color: #0000ff">if</span> (resultSet == <span style="color: #0000ff">null</span>)
      {
      <span style="color: #008000">// do stuff and add resultSet to cache with cacheKey</span>
      }
```

There are actually a couple of different issues with this approach. The first one is that the serverTime parameter is literally sending in the current time (not date), which means that when it is .ToString()’d and joined into the cacheKey, it’s going to have information down to the second. Since this method is being called several times per second, that just means that there is going to be a new cache entry *every second* as a result of the choice of cache key. What’s worse, the old items won’t automatically be purged since there isn’t any 1-second absolute expiration here, so the ASP.NET Cache has to use its [standard LRU algorithm](http://en.wikipedia.org/wiki/Cache_algorithms) to clean things up when it starts feeling memory pressure (which will probably happen pretty quickly). End result, a fair bit of needless thrashing and memory usage.

That’s the main problem, and in some performance tests using [CacheManager](http://aspalliance.com/cachemanager) I saw the total number of cache entries for the application reach up to six figures with this code in place. The simplest fix that retains the date parameter is to change the 3rd SqlParameter line to use serverTime.ToShortDateString() which ensures the key only varies by date and not by second, resulting in 86,399 fewer cache entries per day per other variation in the key.

The other question of course is why the date is in the key at all? If you really want the key to expire frequently, that’s what AbsoluteExpiration cache dependencies are for, and these will automatically clean up (or at least mark as ready to clean up) the expired entries, rather than just widowing their keys and leaving it up to the Cache’s memory management to take care of the mess. In general, dates make a poor choice for inclusion in cache keys, and raw datetimes are especially a bad idea.