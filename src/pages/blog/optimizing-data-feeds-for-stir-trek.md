---
templateKey: blog-post
title: Optimizing Data Feeds for Stir Trek
path: blog-post
date: 2011-04-22T20:28:00.000Z
description: I wrote a couple of weeks ago about using Visual Studio 2010’s
  Performance and Load Testing tools to analyze and correct some performance
  concerns with the Stir Trek Conference web site (which, by the way, is 2 weeks
  from today!).
featuredpost: false
featuredimage: /img/cloud-native.jpg
tags:
  - performance
category:
  - Software Development
comments: true
share: true
---
I wrote a couple of weeks ago about [using Visual Studio 2010’s Performance and Load Testing tools to analyze and correct some performance concerns](/real-world-performance-and-the-stir-trek-web-site) with the Stir Trek Conference web site (which, by the way, is 2 weeks from today!). I realized, though, that there are a bunch of mobile applications that are set up to use [the site’s XML and JSON data feeds](http://stirtrek.com/Extras), and I hadn’t measured or tuned these at all. It’s likely that more traffic on the day of the event will come via these feed URLs than through the actual web site, since I expect most attendees to be using their phones rather than full computers to access the site’s data (there being no WiFi at the theater, nor any tables on which to set computers).

If you missed the last post on how to do this kind of stuff, go read it and come back. I basically did the same thing for these two new URLs. The results were actually quite good. I ramped up to 600 users each hitting the feed URLs at a rate of one request per second, and up to about 350 users the load time for the feed URLs stayed at an average of about 27ms – very acceptable. However, that’s on my rather beefy dev box, and with those 350 users I was seeing an average of 10,300 database requests per second. Not so good, especially considering that every page request was getting back the exact same data (formatted either as XML or JSON).

So naturally I applied the tried and true fix of caching to the problem. I also eliminated a private member in the FeedController class that was instantiating a context object whenever the object was created. This is bad – don’t do it. It looks like this:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> FeedController : Controller
{
<span style="color: #0000ff">private</span> <span style="color: #0000ff">readonly</span> DataContext _context = <span style="color: #0000ff">new</span> DataContext(); 

}
```

Any time you see code like this, be \*very\* suspicious. It’s almost certainly not what you want to be doing. It kills testability as well as performance. Beware.

It turned out that the _context member variable above was only used in one method in this little class:

```
<span style="color: #0000ff">private</span> IEnumerable&lt;Session&gt; GetSessions()
{
<span style="color: #0000ff">return</span> _context.Sessions.GetAll().Where(x =&gt; x.TimeSlot != <span style="color: #0000ff">null</span>).ToList();
}
```

To add caching, I simply applied the double-check locking cache access pattern to the method, and moved the actual data access method to another method in the same class (I just renamed it). This controller still violates SRP, and in a more important app I would refactor the data access into a Repository interface and then apply the [CachedRepository pattern](/introducing-the-cachedrepository-pattern)to it, but this was much quicker and provides “good enough” code, IMO, for the needs of the customer for a one day per year application. Here are the revised methods:

```
<span style="color: #0000ff">private</span> List&lt;Session&gt; GetSessions()
{
<span style="color: #0000ff">string</span> cacheKey = <span style="color: #006080">&quot;sessions&quot;</span>;
 var result = HttpRuntime.Cache[cacheKey] <span style="color: #0000ff">as</span> List&lt;Session&gt;;
<span style="color: #0000ff">if</span> (result == <span style="color: #0000ff">null</span>)
    {
 <span style="color: #0000ff">lock</span> (lockObject)
{
 <span style="color: #0000ff">if</span> (result == <span style="color: #0000ff">null</span>)
 {
result = GetSessionsFromDb().ToList();
HttpRuntime.Cache.Insert(cacheKey, result, <span style="color: #0000ff">null</span>, DateTime.Now.AddMinutes(5), TimeSpan.Zero);
         }

        }

    }

    <span style="color: #0000ff">return</span> result;

}

<span style="color: #0000ff">private</span> IEnumerable&lt;Session&gt; GetSessionsFromDb()

{
<span style="color: #0000ff">return</span> <span style="color: #0000ff">new</span> DataContext().Sessions.GetAll().Where(x =&gt; x.TimeSlot != <span style="color: #0000ff">null</span>).ToList();
}
```

I re-ran my load test after this change. Average SQL Batch Requests per Second over the life of the 11 minute test the first time was 7,977 (max of 12,174). After adding the caching (for 5 minutes), the average is 0.67 (max of 56.2). There’s also no change in the app’s performance with up to 600 users.

**No Caching**

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/2854f66be24f_920E/image_2.png)

**Caching Added**

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/2854f66be24f_920E/image_4.png)

**One Last Minor Fix**

One thing I did when I added the caching method is change the method signature to return List<T> instead of IEnumerable<T>, because you can’t cache an IEnumerable. When calling the original method, I simply added a .ToList() to the call in order to make this change. However, on final review I noticed this about the original method:

![image](<> "image")

I’m not sure why, but it was already calling .ToList(). Doing so again just means extra needless work for the server, since my method will enumerate through the list returned and populate a new list with the items. While normally it’s a good practice to return an IEnumerable rather than a list, in this case since it’s a private method that is only called by one other method, I’m comfortable changing its signature to simply return a List<T>, and that eliminates the need for a .ToList() in my GetSessions() method.