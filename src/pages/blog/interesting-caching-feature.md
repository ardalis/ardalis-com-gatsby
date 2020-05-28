---
templateKey: blog-post
title: Interesting Caching 'Feature'
path: blog-post
date: 2005-09-30T14:12:46.689Z
description: You may know that I’m a big fan of caching. My latest pet project
  is the creation of a cache wrapper object that extends the capabilities of the
  standards HttpRuntime.Cache (or System.Web.Caching.Cache) object.
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
You may know that I’m a big fan of caching. My latest pet project is the creation of a cache wrapper object that extends the capabilities of the standards HttpRuntime.Cache (or System.Web.Caching.Cache) object. One feature that I’m implementing is capability to insert an entry into the Cache and specify both a sliding and an absolute expiration. This scenario is not supported using the standard .NET Framework Cache object (and this will not change in 2.0), but it is a useful scenario because in a busy site a sliding expiration may never expire. The basic idea I’m going for is “As long as this resource is being actively requested (which we’ll define as having been requested in the last 10 seconds), keep it in the cache, but only keep it cache at most for 10 minutes.” You can get round this using the standard cache mechanism by adding a key dependency on another cache item that has the absolute|sliding expiration you need in addition to the sliding|absolute expiration you add to the ‘real’ cache entry.

Ok, so on to the ‘Feature’ that is the subject of this post. In the course of testing my cache wrapper object (which I will publish when it’s a bit closer to ready, and will almost certainly show off at my upcoming user group and ASPConnections cache talks), I created a test for sliding expiration in my suite of unit tests. Since this was a unit test, I wanted it to run fast, so I set the sliding expiration to just one second and tried accessing it at 200 millisecond intervals to confirm that it worked. It didn’t, oddly enough. The stranger thing is that switching to a SlidingExpirationTimeSpan > 1 second fixes the problem. So, this is hardly a show-stopper issue, but it is interesting and I’m going to code around it in my wrapper.

If you’d like to repro this behavior, compile and run this little command line application:

```
usingSystem;

namespaceConsoleApplication1

{

///<summary>

///Summary description for Class1.

///</summary>

classClass1

{

///<summary>

///The main entry point for the application.

///</summary>

\[STAThread]

staticvoidMain(string\[] args)

{

stringmyKey = “foo”;

stringmyValue = “bar”;

intcacheSeconds = 1;

System.Web.HttpRuntime.Cache.Insert(myKey, myValue,null, DateTime.MaxValue,

TimeSpan.FromSeconds(cacheSeconds), System.Web.Caching.CacheItemPriority.NotRemovable,null);

if(!myValue.Equals(System.Web.HttpRuntime.Cache\[myKey]))

{

Console.WriteLine(“Cached value after Insert does not match stored object.”);

}

for(inti = 1; i <= 20; i++)// read the cache 20 times at 200ms intervals

{

intmsToSleep = 200;

System.Threading.Thread.Sleep(msToSleep);

if(!myValue.Equals(System.Web.HttpRuntime.Cache\[myKey]))

{

Console.WriteLine(“Cached value does not match stored object after ” + i * msToSleep + ” ms.”);

break;

}

else

{

Console.WriteLine(“Cached value still valid after ” + i * msToSleep + ” ms.”);

}

}

System.Threading.Thread.Sleep(cacheSeconds + 100);

if(System.Web.HttpRuntime.Cache\[myKey] !=null)

{

Console.WriteLine(“Cached should have expired (sliding expiration has elapsed).”);

}

Console.ReadLine();

}

}

}
```

You should get this result:

[![SlidngCache fails](<>)](http://ardalis.com/photos/ssmith/picture12959.aspx)