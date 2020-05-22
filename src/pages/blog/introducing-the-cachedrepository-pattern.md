---
templateKey: blog-post
title: Introducing the CachedRepository Pattern
path: blog-post
date: 2011-02-14T09:35:00.000Z
description: In this first part of a series on adding support for caching to the
  Repository Pattern, I’d like to show how to very simply control whether or not
  caching is performed on a per-repository basis through the use of an
  [Inversion of Control
  Container](http://martinfowler.com/articles/injection.html).
featuredpost: false
featuredimage: /img/steve-desktop.png
tags:
  - cachedrepository
  - Caching
  - decorator
  - design patterns
  - proxy
  - repository
category:
  - Software Development
comments: true
share: true
---
In this first part of a series on adding support for caching to the Repository Pattern, I’d like to show how to very simply control whether or not caching is performed on a per-repository basis through the use of an [Inversion of Control Container](http://martinfowler.com/articles/injection.html). In this case, I’ll be [using StructureMap with ASP.NET MVC 3](https://ardalis.com/how-do-i-use-structuremap-with-asp-net-mvc-3). One of the primary goals of this implementation is to follow principles of object oriented design, in particular the [Single Responsibility Principle](http://en.wikipedia.org/wiki/Single_responsibility_principle) and the [Don’t Repeat Yourself Principle](https://ardalis.com/don-rsquo-t-repeat-yourself).

To start, take a look at the [MVC Music Store](http://mvcmusicstore.codeplex.com/) sample application. The Jan 13 2011 release doesn’t include any usage of the Repository pattern, so the first thing we will do is add a simple repository to it. The initial [HomeController, which you can view online here](http://mvcmusicstore.codeplex.com/SourceControl/changeset/view/b783a1bfa56c#MvcMusicStore%2fControllers%2fHomeController.cs), includes code like this:

```
public class HomeController : Controller
    {
        MusicStoreEntities storeDB = new MusicStoreEntities();
 
        public ActionResult Index()
        {
            var albums = GetTopSellingAlbums(5);
            return View(albums);
        }
 
        private List<Album> GetTopSellingAlbums(int count)
        {
            return storeDB.Albums
                .OrderByDescending(a => a.OrderDetails.Count())
                .Take(count)
                .ToList();
        }
    }
```

The first step of course is to pull out the data access into an interface, implement the interface, and inject the interface into the class via its constructor. The revised HomeController looks like this:

```
public class HomeController : Controller
{
    private readonly IAlbumRepository _albumRepository;
 
    public HomeController(IAlbumRepository albumRepository)
    {
        _albumRepository = albumRepository;
    }
 
    public ActionResult Index()
    {
        var albums = _albumRepository.GetTopSellingAlbums(5);
 
        return View(albums);
    }
}
```

In order to make this work, we had to create an interface and a default implementation of that interface, like so:

```
public interface IAlbumRepository
{
    IEnumerable<Album> GetTopSellingAlbums(int count);
}
public class EfAlbumRepository : IAlbumRepository
{
    MusicStoreEntities storeDB = new MusicStoreEntities();
 
    public virtual IEnumerable<Album> GetTopSellingAlbums(int count)
    {
        Debug.Print("EfAlbumRepository:GetTopSellingAlbums");
        return storeDB.Albums
            .OrderByDescending(a => a.OrderDetails.Count())
            .Take(count)
            .ToList();
    }
}
```

Finally, we had to[configure StructureMap in ASP.NET MVC 3](https://ardalis.com/how-do-i-use-structuremap-with-asp-net-mvc-3), which you can also do by issuing the following NuGet command:

```
PM&gt; install-package -Id StructureMap-MVC3 -version 1.0.2
```

With StructureMap wired up, we simply need to ensure that it knows to provide the EfAlbumRepository class whenever a type of IAlbumRepository is requested, which this achieves:

```
using MvcMusicStore.Core.Interfaces;
using MvcMusicStore.Infrastructure.Repositories;
using StructureMap;
 
namespace MvcMusicStore
{
    public static class IoC
    {
        public static IContainer Initialize()
        {
            ObjectFactory.Initialize(x =>
                                         {
                                             x.Scan(scan =>
                                                        {
                                                            scan.TheCallingAssembly();
                                                            scan.WithDefaultConventions();
                                                        });
                                             x.For<IAlbumRepository>().Use<EfAlbumRepository>();
                                         });
            return ObjectFactory.Container;
        }
    }
}
```

Now at this point if you’ve been following along, you should be able to run the Music Store application and ***it should do exactly what it did before*** (which, ideally, is to run correctly and show you the store’s home page). Let’s assume that’s what you get.

**Implementing a Cached Repository**

At the most basic level, implementing a cached repository is simply a matter of overriding the methods of the base repository implementation (which must be marked as virtual), and then updating the IOC container’s registration to use the new type. Implementing a CachedAlbumRepository would look something like this:

```
public class CachedAlbumRepository : EfAlbumRepository
{
    private static readonly object CacheLockObject = new object();
    public override IEnumerable<Album> GetTopSellingAlbums(int count)
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
                    result = base.GetTopSellingAlbums(count).ToList();
                    HttpRuntime.Cache.Insert(cacheKey, result, null, 
                        DateTime.Now.AddSeconds(60), TimeSpan.Zero);
                }
            }
        }
        return result;
    }
}
```

Note that although the above code does use best practices for implementing caching logic, it is using a hard-coded cache duration, which should be avoided. We also would find that as we implemented this approach again and again for various repository methods, we would have a lot of duplicate code, in violation of the DRY principle. The next article in this series will address these concerns.

The above code is an example of the [Proxy](http://en.wikipedia.org/wiki/Proxy_pattern) (or perhaps [Decorator](http://en.wikipedia.org/wiki/Decorator_pattern)) design pattern. Proxies are all about controlling access, and the CachedAlbumRepository controls access to the EfAlbumRepository by first checking to see whether the data exists in the cache (one could make the argument that this is about adding behavior to the underlying repository, in which case the Decorator pattern, which has the same structure, would be the more appropriate label). PluralSight has a nice [video series on Design Patterns](http://www.pluralsight-training.net/microsoft/olt/Course/Toc.aspx?n=patterns-library).

Wiring it up in the IOC container is simply a matter of replacing the existing x.For<IAlbumRepository().Use<EfAlbumRepository>(); line with this one:

```
x.For&lt;IAlbumRepository&gt;().Use&lt;CachedAlbumRepository&gt;();
```

Now, if you hit the site and monitor the debug output using a tool like[DebugView](http://technet.microsoft.com/en-us/sysinternals/bb896647.aspx), you should see something like this as you start and then refresh the page:

![](/img/steve-desktop.png)

With this in place, you’re now ready to start controlling whether your individual repositories are using caching or not through your IoC container. This makes performance testing and tuning much easier, as you’re now able to compare test results with and without caching for any given part of the application by changing one line of code in one class (the IoC.cs class in this case).

You can view and download the code used in this article from the [MvcMusicStoreRepositoryPattern fork on CodePlex](http://mvcmusicstore.codeplex.com/SourceControl/network/Forks/ssmith/MvcMusicStoreRepositoryPattern).

In the second article in this series, we look at [how to achieve the CachedRepository pattern using the Strategy Pattern](https://ardalis.com/building-a-cachedrepository-via-strategy-pattern), rather than simple inheritance.