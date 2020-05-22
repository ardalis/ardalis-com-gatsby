---
templateKey: blog-post
title: Building a CachedRepository via Strategy Pattern
path: blog-post
date: 2011-02-15T03:54:00.000Z
description: In part one of this series, I introduced the CachedRepository
  pattern, and demonstrated how it can be applied through the use of simple
  inheritance to an existing Repository class.
featuredpost: false
featuredimage: /img/blank-color-colorful-209678-760x360.jpg
tags:
  - asp.net
  - asp.net mvc
  - cachedrepository
  - Caching
  - decorator
  - design patterns
  - proxy
  - repository
  - strategy
category:
  - Software Development
comments: true
share: true
---
In part one of this series, I [introduced the CachedRepository pattern](https://ardalis.com/introducing-the-cachedrepository-pattern), and demonstrated how it can be applied through the use of simple inheritance to an existing Repository class. This allows us to easily configure whether or not we want to use caching at the repository level through the use of an IOC Container like StructureMap. However, using inheritance to achieve the behavior isn’t always desirable, since generally it’s better to use object composition if possible (this tends to result in more flexible designs).

One benefit of the inheritance-based approach is its simplicity. Both in terms of the code required and in terms of wiring up the interfaces and implementations in the IOC container. You end up with something like this in your StructureMap Initialize() method:

```
// Hardcoded Proxy / Decorator Pattern

// Use Caching
// x.For<IAlbumRepository>().Use<CachedAlbumRepository>();

// Don't Use Caching
x.For<IAlbumRepository>().Use<EfAlbumRepository>();
```

Switching between the two is trivial and the behavior is very clear.

Now, to implement the same *strategy* using the [Strategy Pattern](http://en.wikipedia.org/wiki/Strategy_pattern), only a few minor changes are required. First, the CachedRepository class needs to be modified to no longer inherit from EfAlbumRepository, but rather to simply implement IAlbumRepository. Next, it needs to take in an IAlbumRepository in its constructor and assign it to a local instance. Finally, the GetTopSellingAlbums() method needs modified to no longer specify the override keyword, and to call _albumRepository rather than base. The modified version is shown below (the original is in [the first CachedRepository article](https://ardalis.com/introducing-the-cachedrepository-pattern)):

```
public class CachedAlbumRepository : IAlbumRepository
{
    private readonly IAlbumRepository _albumRepository;

    public CachedAlbumRepository(IAlbumRepository albumRepository)
    {
        _albumRepository = albumRepository;
    }

    private static readonly object CacheLockObject = new object();

    public IEnumerable<Album> GetTopSellingAlbums(int count)
    {
        Debug.Print("CachedAlbumRepository:GetTopSellingAlbums");
        string cacheKey = "TopSellingAlbums-" + count;
        var result = HttpRuntime.Cache[cacheKey] as List<Album>;
        if (result == null)
        {
            lock (CacheLockObject)
            {
                result = HttpRuntime.Cache[cacheKey] as List<Album>;
		if (result == null)
                {
                    result = _albumRepository.GetTopSellingAlbums(count).ToList();
                    HttpRuntime.Cache.Insert(cacheKey, result, null, 
                        DateTime.Now.AddSeconds(60), TimeSpan.Zero);
                }
            }
        }
        return result;
    }
}
```

With the new class in place, we need to adjust how we configure its use in our IOC container’s initialize method. The code required to avoid the cache remains the same, but the code to set up the correct creation of the CachedRepository object is slightly more involved, as we must now specify the type to provide to the constructor. The result is shown here:

```
// Strategy Pattern Proxy/Decorator Pattern
// Use Caching
x.For<IAlbumRepository>().Use<CachedAlbumRepository>()
    .Ctor<IAlbumRepository>().Is<EfAlbumRepository>();

// Don't Use Caching
// x.For<IAlbumRepository>().Use<EfAlbumRepository>();
```

This approach requires some more advanced features from the IOC container. In many systems, access to the IOC container is abstracted away behind a common interface, with simple methods like Register<T> and Resolve<T>, and probably not many overloads for things like specifying constructor parameters. In such setups, the inheritance-based approach will most likely be the simplest one to follow, since it is amenable to this kind of simplistic type resolution. However, if you have access to your IOC container’s more advanced methods, and it supports this kind of resolution specification (as StructureMap does), then the strategy pattern based approach may offer more flexibility.

Thanks to [Kyle Malloy on the StructureMap Users mailing list](http://groups.google.com/group/structuremap-users/browse_thread/thread/89346663d254486d?hl=en) for his assistance with the SM syntax required for this case.

You can think of the CachedRepository as being a Proxy for the real repository, and I describe it in these terms in the [Design Pattern Library course on Pluralsight](https://ardalis.com/ps-stevesmith), which you can view if you want to learn more.