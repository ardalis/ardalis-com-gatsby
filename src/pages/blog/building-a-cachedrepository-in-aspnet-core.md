---
templateKey: blog-post
title: Building a CachedRepository in ASPNET Core
date: 2018-08-27
path: blog-post
featuredpost: false
featuredimage: /img/building-a-cachedrepository-in-aspnet-core.png
tags:
  - asp.net core
  - cachedrepository
  - Caching
  - design patterns
  - repository
category:
  - Software Development
comments: true
share: true
---

I'm a fan of proper use of [design patterns](https://www.pluralsight.com/courses/patterns-library), and you can get big gains from layering multiple patterns together. One prime example of this in web applications is the combination of the Strategy, Repository, and Proxy/Decorator patterns to create the [CachedRepository pattern](https://ardalis.com/introducing-the-cachedrepository-pattern). This pattern separates caching responsibility from persistence responsibility and makes it simple to add caching to an application globally, or on a per-type basis. You can [learn more about the CachedRepository here](https://ardalis.com/building-a-cachedrepository-via-strategy-pattern). In this article we'll drill into a sample application I've made available on GitHub that demonstrates [how to use the CachedRepository pattern in ASP.NET Core with Entity Framework Core](https://github.com/ardalis/CachedRepository).

## The Sample

The sample application doesn't really do a whole lot. The home page for the web application uses Razor Pages and fetches a list of authors with their associated publications. It captures the time taken to fetch the data as seen from the UI layer:

public class IndexModel : PageModel
    {
        private readonly IReadOnlyRepository<Author> \_authorRepository;

        public IndexModel(IReadOnlyRepository<Author> authorRepository)
        {
            this.\_authorRepository = authorRepository;
        }
        public List<Author> Authors { get; set; }
        public long ElapsedTimeMilliseconds { get; set; }

        public void OnGet()
        {
            var timer = Stopwatch.StartNew();
            Authors = \_authorRepository.List();
            timer.Stop();
            ElapsedTimeMilliseconds = timer.ElapsedMilliseconds;
        }
    }

The elapsed time in milliseconds is displayed on the page along with a list of authors (and a count of their resources). Note that this is all done using eager loading [because of course lazy loading in ASP.NET Core applications is evil](https://ardalis.com/avoid-lazy-loading-entities-in-asp-net-applications) (seriously if you don't believe me read the link)!

Ok so a couple of things to point out here. First, the page is pretty simple. There's no conditional logic to it. There's nothing that indicates where the data is being fetched from or whether or not it should be cached. If we wanted to write a unit test for the OnGet method it would be stupidly easy (though somewhat pointless) to do so. Instead I'd recommend [writing integration tests](https://docs.microsoft.com/en-us/aspnet/core/test/integration-tests?view=aspnetcore-2.1), but that's a separate topic.

Aside from the timer logic things are about as simple as can be. If necessary for a real application, the timer functionality would be pulled into a service, a filter, or some middleware. In this case it's just there to illustrate the effect of caching.

Finally, we can see that this class depends on a service described by an interface. That interface includes the name Repository which tells us it's concerned with persistence. It's also labeled as a ReadOnly repository, so we can expect that it will only contain queries. Looking at the definition, we're not disappointed:

public interface IReadOnlyRepository<T> where T : BaseEntity
{
    T GetById(int id);
    List<T> List();
}

Somewhere there's got to be some actual persistence logic, though, and we find that in an implementation-specific type, EfRepository.cs. This type actually implements a full read/write repository interface, but it's got the ReadOnly methods, too, thus satisfying that interface as well. Its List method is the only one we're concerned with:

public virtual List<T> List()
{
    return \_dbContext.Set<T>().ToList();
}

A more robust implementation of this EF Core repository can be found in the [eShopOnWeb sample](https://github.com/dotnet-architecture/eShopOnWeb/blob/master/src/Infrastructure/Data/EfRepository.cs) or [here](https://deviq.com/repository-pattern/). In this simple sample I haven't yet implemented the Specification pattern, so in order to perform eager loading I'm subclassing the repo with an author-specific version that includes this implementation for List():

public override List<Author> List()
{
    return \_dbContext.Authors
                .Include(u => u.Resources)
                .ToList();
}

Mostly I'm just trying to make sure I'm fetching enough data to make it so it's obvious when the database is being hit compared to when the data is coming from a cache. With just the code we've shown so far, we could add one line to Startup.ConfigureServices and our application would work:

services.AddScoped<IReadOnlyRepository<Author>, AuthorRepository>();

## Adding Caching

The nice thing about the CachedRepository pattern is that it allows us to add caching behavior without modifying the existing functionality for fetching data from persistence, or the code that calls this code. In fact, we can add caching to the above application without touching any code in the repository implementations shown above or the Razor Page that uses them. The only place we will modify code will be in Startup.ConfigureServices, where we will wire in a new service. This ability to change the behavior of existing code without having to change the code itself is an example of the Open/Closed Principle, which I cover in my [SOLID Principles of OO Design course](https://www.pluralsight.com/courses/principles-oo-design). In this case, we achieve it by using the [strategy design pattern](https://deviq.com/strategy-design-pattern/), which is how dependency injection works. If you're counting, so far we're using two design patterns: Repository and Strategy. Here comes one (really two) more.

The Decorator pattern is used to add additional functionality to an existing type. It's essentially a wrapper around existing functionality. We're going to add caching behavior as a decorator that wraps around the underlying Repository instance. The Proxy pattern is functionally the same as the Decorator, but the intent varies. With the Proxy, the intent is to control access to a resource, as opposed to adding functionality. In a sense, though, choosing whether to get data from its source or from a local cached copy is controlling access to the source data, so you can also think of the CachedRepository pattern as being a kind of Proxy, too.

The simple implementation of data caching in the **CachedAuthorRepositoryDecorator** class looks like this:

public List<Author> List()
{
    return \_cache.GetOrCreate(MyModelCacheKey, entry =>
    {
        entry.SetOptions(cacheOptions);
        return \_repository.List();
    });
}

In this case the \_cache refers to an injected instance of IMemoryCache. In some projects, it may make sense to rely on your own interface that might wrap additional behavior, since IMemoryCache is a pretty low-level interface. For instance, if you find that every one of your cached repositories has basically the same code as shown above, you could reduce duplication by putting that logic into your own cache service.

public CachedAuthorRepositoryDecorator(AuthorRepository repository,
            IMemoryCache cache)

Caches require keys, and key generation is an important aspect of a caching strategy. In this sample, the key is simply hard-coded in the Decorator class. You can also build keys based on things like class and method name, as well as arguments. Another place where you can specify and generate keys in in a [specification class](https://deviq.com/specification-pattern/), if you’re using that pattern.

Once you have a CachedRepository class, the only thing left to do is configure your application to use it, in ConfigureServices():

// Requests for ReadOnlyRepository will use the Cached Implementation
services.AddScoped<IReadOnlyRepository<Author>, CachedAuthorRepositoryDecorator>();
services.AddScoped(typeof(EfRepository<>));
services.AddScoped<AuthorRepository>();

Now if you run the application, you will see that loading the large set of records requires some amount of time (100-500ms on my machines I’ve tried it on) on the first load, but then drops to 0ms for subsequent requests. The cache is set up to expire after 5 seconds, so you should see non-zero times every 5 seconds or so as you test the application.

**A Note About Cache Durations**

Imagine you have a page that is accessed very frequently, let’s say 10 requests per second, and it makes one request to the database each time it runs. Obviously that’s going to result in 10 database calls per second. Suppose that data doesn’t change very often, so you determine that you can cache it for a minute. You configure the cache and suddenly your database load for this page drops to essentially zero (and page performance probably improves measurably as well). But now when updates are made, it takes up to a minute for them to be reflected on the web server(s).

If you configure the cache duration to be 1 second, assuming the query is a quick one, you will probably find no difference in the measurable performance characteristics of the page. The difference between hitting the database N times per second where N is a direct function of load, and 1/s where 1 is a constant, is huge. The difference between 1 database request per second and 1 database request per minute is minimal. Your database should easily be able to handle 1 request per second (again, for simple queries).

What this means is, _for high throughput pages_, you should start with the shortest cache duration you can and see if that yields sufficient performance characteristics. Only consider increasing it if warranted.
