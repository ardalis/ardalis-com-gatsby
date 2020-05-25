---
templateKey: blog-post
title: Caching in O/R Mappers and Data Layers
path: blog-post
date: 2006-09-01T02:40:31.926Z
description: Frans Bouma, creator of LLBLGen, MVP, and all around very smart
  guy, wrote yesterday about the ‘myth’ that caching inside an Object-Relational
  (O/R) mapper makes queries run faster or makes the O/R mapper more efficient.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - C#
  - Caching
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Frans Bouma](http://weblogs.asp.net/fbouma), creator of [LLBLGen](http://llblgen.com/), MVP, and all around very smart guy, [wrote yesterday about the ‘myth’ that caching inside an Object-Relational (O/R) mapper makes queries run faster or makes the O/R mapper more efficient](http://csharpfeeds.com/post.aspx?id=1593). I think he’s missing a few key usage scenarios (and, what’s more, I think he generally has a dislike of caching for whatever reason, which may bias his opinion), which I’d like to examine here.

First, let me look at his definition of a *cache*, since it’s likely that a disagreement on this point may be the cause of my general disagreement with his statement. Frans defines a cache as an object store which manages objects so they can be reused. I would tend to call this an *object pool*, or something similar. When I talk about caching, most of the time, I’m talking about caching *data*. Yes, the data is represented as (serialized) objects, but usually that is simply a side effect (in .NET, *everything* is an object). This doesn’t really change the definition of a cache, so much as the idea of how one uses it.

Frans goes on to try and show that having a cache *almost* never helps, and “where a cache can help, though these are minor or require a lot of consessions.” His example considers a CRM app from which he wants to know how many customers have placed at least 5 orders in the last month. He then asserts that the *only correct way* of determining this information is to directly query the database, and goes on from this assertion to show why caching can’t possibly help. In his words:

*Obviously: fetching the data from the persistent storage, as the entities live there, and only then we’ll get all known and valid customer entities matching the query. We can consult our cache first, but we’ll never know if the entities in the cache are all the entities matching my query: what if there are many more in the database, matching the query? So we can’t rely on the cache alone, we always have to consult with the persistent storage as well.*

This is where we part ways. First of all, he’s making the mistake of thinking that the end user of this application needs 100% accurate, 100% up-to-date information. This is almost never the case, and in fact can be shown to be impossible given that any query is out of sync with the source data by the time it’s rendered to the user’s machine (albeit perhaps only milliseconds). Given that some non-zero delay in the data is acceptable (in fact unavoidable given physics), it then seems appropriate to gather, as part of the system’s requirements, what the user’s tolerance of delay in the data is, given the benefits to be had of accessing older data. I also tend to think it presupposes a small user group — as the number of users increase, the need for scalability often outstrips the need for instant data. As an example, perhaps the application must support 100 concurrent users, and the hardware costs to support this user base with constant, direct data access is $20,000. However, let’s say that existing hardware could be used to serve up to 10 concurrent users, or 100 concurrent users with caching absorbing 90% of the data hits, at the cost of some delay in the data. The *business* might decide it is worthwhile to save the additional money in order to get the cost savings (or in order to bake in scalability in anticipation of future growth).

Frans does start to talk about data being *‘up to date’ enough* — which is exactly what I’m talking about — but he goes on to apply his own *business rules* to this question (e.g. *“if correctness is in order, you can’t be more sure than by reading from the database and bypass the cache.”)* rather than letting the business user make this decision. Yes, it’s possible that the cache will have outdated data. But the tolerance level for this uncertainty should be determined by the business user, not by the developer, given that increases in tolerance for stale data can yield very large increases in performance and scalability by removing load from the database.

But wait, it gets better. With the addition of SQL Cache Invalidation, as one of Frans’ comments points out, we can now have our cake and eat it too. If you want to limit the number of requests to the persistent data storage but you don’t want to accept older-then-physics-allows data, you can do so with SQL Cache Invalidation. In this scenario, the Entity classes of the O/R mapper populate themselves as usual on first load, but store their data in an appdomain-specific cache. Subsequent requests for the same data would check the cache, see that the data is there, and populate themselves from the cache without hitting the database. However, if the database changes, the cache is automatically expired, and any object that relies on it will retrieve its state from the persistent storage the next time it’s requested. (this works very well in a web application, in which O/R entities typically only live for a few milliseconds, being created and discarded within each request).

Finally, Frans seems to think that the only valid use of a cache is uniquing. This is not something I usually worry about much with caching, since I’m more interested in taking load off of my database server and boosting performance and scalability.

**Conclusion**

Frans understands how caching works and has all of the technical skills needed to implement it. He’s a great guy and extremely bright and I love his tools, so I feel bad criticizing him on this topic. His issue with caching is a philosophical one, mainly, summed up with this statement: “if correctness is in order, you can’t be more sure than by reading from the database and bypass the cache.” This statement, while true, is used to justify his entire case that the benefits of caching are all myth, and that simply isn’t the case. The truth of the matter is that in any real-world application, a lot of data is read-mostly — that is, it doesn’t change very often. Reading this kind of data from the database over and over again is wasteful, and often times there is no harm done if the data is out of date by a few seconds (or minutes or hours, in some cases). This kind of data benefits immensely from caching. Further, with the ease of implementing SQL Cache Invalidation included in .NET 2.0, the negative effects of outdated data are by and large eliminated, so that almost any kind of data that is likely to see reuse can be cached by the O/R mapper without fear of incorrect data being displayed to end users.

The myth of caching is that users are intolerant of old (e.g. typically a few seconds or perhaps minutes) data. The truth is that users are intolerant of slow systems, and businesses are intolerant of unnecessary expenses. With caching, especially with sql cache invalidation, it is possible to achieve the best of all worlds, and provide high performing systems which scale well, do not require excessive hardware resources, and provide up-to-date information to end users.

<!--EndFragment-->