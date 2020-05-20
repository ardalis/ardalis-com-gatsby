---
templateKey: blog-post
title: Avoid Lazy Loading Entities in ASP.NET Applications
path: blog-post
date: 2017-04-04T03:15:00.000Z
description: "*Lazy Loading* is an Entity Framework feature that lets you worry
  less about the specific amount of data you need to fetch with a given query."
featuredpost: false
featuredimage: /img/conferencesessionslazyloading.png
tags:
  - asp.net
  - asp.net core
  - entity framework
  - entity framework core
  - lazy loading
  - performance
  - Scalability
category:
  - Software Development
comments: true
share: true
---
*Lazy Loading* is an Entity Framework feature that lets you worry less about the specific amount of data you need to fetch with a given query. Instead, you write simple queries, and Entity Framework (or other OR/M tools that support this feature) will load the minimal amount of data (which is a good thing), and then will only fetch additional data on an as-needed basis. That is, rather than *eager loading* all of the related data a given entity might have, lazy loading is a technique that has EF perform the minimal amount of work needed up front, and then only performs additional work if it turns out to be necessary. This sounds like a great feature, but you should turn it off in your ASP.NET web apps. I’ll explain below, but first let’s look at an example.

You should turn lazy loading off in your web applications.

## TL;DR: Disable Lazy Loading in Web Apps

In EF Core the lazy loading feature isn’t even implemented yet, so if you’re already using EF Core, no need to worry about it. However, in EF 6 you can globally disable lazy loading in several ways. For just one query:

`context.Configuration.LazyLoadingEnabled = false;`

Globally in your DbContext class:

`Configuration.LazyLoadingEnabled = false;`

### Why Lazy Loading is Bad in Web Apps

Suppose you have a simple object model that involves several related entities. Let’s say you have a conference web site and you want to display a list of Sessions (presentations). Each Session can have one or more Speaker. And each Session may have one or more Tag. An EF6 object model might look like this:

```
public abstract class BaseEntity
{
    public int Id { get; set; }
}
 
public class Speaker : BaseEntity
{
    public string Name { get; set; }
 
    public virtual List<SpeakerSession> SpeakerSessions { get; set; } = new List<SpeakerSession>();
}
 
public class SpeakerSession : BaseEntity
{
    public int SpeakerId { get; set; }
    public virtual Speaker Speaker { get; set; }
    public int SessionId { get; set; }
    public virtual Session Session { get; set; }
}
 
public class Session : BaseEntity
{
    public string Name { get; set; }
    public string Description { get; set; }
    public virtual List<SpeakerSession> SpeakerSessions { get; set; } = new List<SpeakerSession>();
    public virtual List<SessionTag> SessionTags { get; set; } = new List<SessionTag>();
}
 
public class SessionTag: BaseEntity
{
    public int SessionId { get; set; }
    public virtual Session Session { get; set; }
    public int TagId { get; set; }
    public virtual Tag Tag { get; set; }
}
 
public class Tag : BaseEntity
{
    public string Name { get; set; }
    public virtual List<SessionTag> SessionTags { get; set; } = new List<SessionTag>();
}
```

Now let’s look at what’s involved to display a page like this one:

![](/img/conferencesessionslazyloading.png)

This simple demo page has 3 sessions on it, one of which has 2 tags. Two of the sessions have one speaker, and one has two speakers.

**Question**: How many database queries should be required to render this page?

Ideally, 0, because the page will be cached, but that’s a bit of a non-answer. There are plenty of examples of data that can’t or shouldn’t be cached, but which has relationships similar to what’s shown here. So, if we can’t escape hitting the database by using caching, where does that leave us? How many queries should it require?

Ideally, just one. Database queries are expensive within web requests. Every round trip eats up a lot of time and adds to the total time the user is waiting before their browser even gets back a response and can start the work of rendering the page (and loading its zillion scripts, CSS files, and images that most sites have today). Also, if you’re planning on running in a cloud environment, be careful you’re not using a data plan that charges per-query (instead of or in addition to per-hour for the database instance). Your costs can quickly skyrocket if you’re using lazy loading and per-query pricing!

So, we’d like to see this page load with a single query. At most maybe a couple because of all the joins involved. But if we go from 3 sessions to 40 or 100 we shouldn’t see the database queries multiply by a factor of 10, too. How do we know how many queries are being executed?

There are a few ways to see how many queries are being executed by Entity Framework. One of the simplest with EF6 is to [enable logging with one line of code in the DbContext class](http://ardalis.com/logging-in-entity-framework). Another good choice is to install [Glimpse](http://getglimpse.com/), which will show you how many queries and how long they took right on the page. You can also use performance monitor (perfmon), either in realtime as you’re developing, or [set up to run over time](http://ardalis.com/configuring-performance-counters-to-run-over-time) on your production server so you can review stats periodically based on real user activity. Another option is to run SQL Profiler. Some of these require more tools than others – the simplest approach is the first one: log queries from EF.

Now, before we get to the query count, let’s look at how the page is implemented. The controller is very simple:

```
private readonly ApplicationDbContext _db = new ApplicationDbContext();
public ActionResult Index()
{
    var sessions = _db.Sessions;
    return View(sessions);
}
```

The view just takes the Sessions types and loops through them, joining if necessary for results that may have multiple values (speakers, tags). Incidentally, this is a good solution to the “how do I avoid having a trailing comma in my list” problem. This is the whole Index.cshtml view file:

```
@{
    ViewBag.Title = "Home Page";
}
@model IEnumerable<LazyLoadingMvc5.Models.Session>


<h2>Sessions</h2>

@foreach (var session in Model)
{
    <div class="row">
        <h3>@session.Name</h3>
        <h4>@string.Join(",", session.SpeakerSessions?.Select(ss => ss.Speaker.Name).ToArray())</h4>
        <h4>@string.Join(",", session.SessionTags?.Select(st => st.Tag.Name).ToArray())</h4>
        <p>@session.Description</p>
    </div>
}
```

When this page is rendered, it makes **22 queries to the database**. You can view a log of the query output [here](https://github.com/ardalis/LazyLoading/blob/master/LazyLoadingMvc5/QueryLogOutput.txt). This is an example of the class N+1 queries problem that OR/M tools can run into, especially with lazy loading. In this case, it’s exacerbated by my use of multiple many-to-many relationships and virtual navigation properties, but in my experience this kind of code is not uncommon.

#### Note

I also had to enable MultipleResultSets on my connection string, since this view and its use of lazy loading was opening multiple concurrent connections to the database.

Now, what if you run the equivalent sample using EF Core, which doesn’t use (or currently support) lazy loading? The code needs to be updated slightly to ensure the related entities are eagerly loaded (otherwise they will be null):

```
private readonly ApplicationDbContext _db;
public SessionsController(ApplicationDbContext db)
{
    _db = db;
}
public IActionResult Index()
{
    var sessions = _db.Sessions
        .Include(s => s.SessionTags)
        .ThenInclude(st => st.Tag)
        .Include(s => s.SpeakerSessions)
        .ThenInclude(ss=>ss.Speaker);
    return View(sessions);
}
```

Loading the same page, with the same data, logging to the console, yields these results:

![](/img/efcorenolazyloading.png)

As you can see, the same page now loads with just 3 queries. We’re not down to 1, but this is a huge improvement over 22 queries. We just saved 19 requests, or 86% of the total queries we would have had using lazy loading.

## Summary

Avoid using lazy loading in your web applications. Disable it by default, since otherwise it can be difficult to detect. Avoid using virtual navigation properties in web application models, too, since typically this is only done to facilitate lazy loading. You should only go this route if you’re sharing your model between a non-web application and a web application (which should be rare – ideally each application should have its own bounded context and model).

PS – Don’t directly reference DbContext from your Controllers, or return your EF model types to views or as web API results. The code shown here is meant only to show lazy loading, not to model [clean architecture](https://github.com/ardalis/cleanarchitecture).

PPS – If you want to try this yourself, [grab the code and run it](https://github.com/ardalis/LazyLoading). See what happens when you add a few dozen Sessions, Speakers, and Tags. Leave a comment.