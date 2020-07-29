---
templateKey: blog-post
title: Data Access Principles
path: blog-post
date: 2020-07-21T21:01:00.000Z
description: Software design principles to consider when evaluating data access patterns, frameworks, and tools. These principles apply regardless of programming language.
featuredpost: false
featuredimage: /img/data-access-principles.png
tags:
  - data access
  - principles
category:
  - Software Development
comments: true
share: true
---

What are some guiding principles that can be applied to data access in software applications and architecture? In preparing a workshop on evolving data access patterns, I've been considering the principles that are most important when it comes to data access in software applications. I collected the start of this list of data access principles in a [twitter thread](https://twitter.com/ardalis/status/1285613661730545671) in which I asked for additional suggestions.

Below you'll find my current list of the most important data access principles. If you have one that I've missed, please leave a comment below. Thanks!

## Acquire late; release early

This principle applies to any shared external (and therefore probably expensive) resource. Most modern data access tools, especially ORMs like Entity Framework, hide the details of this from you. But before they were the norm, hand-coding connections and managing connection pools was common and this was a guiding principle. Still today it's worth considering, especially if you're writing your own low-level data access code, how long you need to keep a connection open, for instance.

When applying this principle, the idea is to keep your thread of execution's use of the shared resource as brief as possible. Acquire the connection you need for your data as late as you can in your code, and as soon as you're done with it (as early as you can), release it.

## Prefer "chunky" to "chatty" data access

Especially in web applications, but in any application were performance is important, round trips to remote data sources are expensive. When looking at how you access data within your application, try and count how many round trips to the data store occur between a user request or interaction and your application's response. The smaller the number, the better.

In my presentations and training workshops, I'll sometimes ask what the ideal number of database requests should be for a given API endpoint or web page. It's a bit of a trick question, because the **idea** number is zero (which is often achievable even for pages that need data - keep reading). But in many instances the correct answer is going to be one. There are instances where it makes sense to make multiple requests, but usually these are trading performance for another desirable characteristic.

One example of chatty access that's commonly (and often unknowingly) introduced when data access is abstracted is "N+1" query problems (thanks, [Vicky Harp](https://twitter.com/vickyharp/status/1285615369730785281)). A number of things can cause this to happen, one of the most common is [lazy loading, which I generally recommend against in ASP.NET applications for this reason](https://ardalis.com/avoid-lazy-loading-entities-in-asp-net-applications/).

## Minimize data movement

When accessing data, frequently you need to process it in some fashion. Most of the time, it's best to perform any processing on the data where it's located, and then move only the result, as opposed to fetching all of the data and then processing it. This processing usually takes the form of filtering, but other operations like sorting and paging results apply as well. If all you need is to display the most recent five orders a customer placed, there's no reason to query the datasource for all orders placed by anyone, ever, pull those over the wire and into memory in your application, and then loop through them to find only those belonging to the current customer, and then sort these, and then take only the most recent records. Instead, a query should be sent to the datasource itself, which can then perform the necessary filtering, sorting, and taking of records to then transfer over the network only the 5 records needed.

As with all of these principles, there are occasionally exceptions, usually as a result of some production constraints. For example, if the data in question is highly contentious, with many queries being made to it frequently to the point where it's impacting the performance of the datasource, it may make sense to keep one or more copies of the data as a cache, and to perform the operations against the cached data (even if populating the cache occasionally means moving more data than a single operation might require). See the next principle for more on caching.

## Cache frequently-used, rarely changing data

Data that doesn't change often but is read frequently is often referred to as "read mostly" data. This kind of data is ideal for caching at the data access level. If you analyze your application's requests to your data store, and you see that you're requesting the same exact data over and over again, you can probably improve your application's performance and reduce the load on your data store by introducing a cache.

Caching is a big topic and there are many products and approaches to implementing a cache. At a minimum you should consider adding a simple in-memory cache in your front end application. I demonstrate [how to add caching in a reusable, composable manner for ASP.NET Core applications in this article](https://ardalis.com/building-a-cachedrepository-in-aspnet-core/) and associated code repository.

## Avoid premature optimization

Performance isn't the only thing to optimize for in your application and its data access, and even if it's critical, you should avoid the urge to try and optimize it before you know whether it's good enough. Premature optimization often takes place without any measurements to know how successful the "optimizations" actually were, and can make code more difficult to maintain.

What might be premature optimization in data access? Insisting on stored procedures for all queries. Implementing a complex cache layer for an application that only has 2 users. Insisting that every query be hand edited SQL because ORMs are incapable of generating proper SQL queries. Most of the time, it's better to ship working software built with clean, easily maintained and tested code, and then if there are performance issues, address them when and as they appear. While there are exceptions to this approach (some decisions, especially architectural decisions, are very expensive to change later), it generally helps to optimize team effectiveness in terms of delivering value vs. "gold plating" the system's code.

[Thanks, Tony!](https://twitter.com/antmdvs/status/1285639554054193161)

## Keep it simple, stupid

On that same note, start simple. Einstein is famous for (among many other things) saying "Everything should be made as simple as possible, but no simpler." When it comes to data access, how can you keep things simple for application developers? Don't add complexity where it's not adding value.

Does that mean you can't use more complex design patterns or architectural patterns? No, of course not. But you should bring these patterns to bear in order to solve a specific problem you're sure you have. Avoid speculative generality. Keep your code simple (but easily tested and changed) so that when you need to flex it in response to some new requirement or pain point, you're easily able to do so. One very common pain point in data access for many applications is excess duplication.

## Don't Repeat Yourself (DRY)

Many data access tools and patterns are design to overcome problems with excessive amounts of duplicate, boiler-plate plumbing code. Imagine if every time you needed a bit of data from a data store you had to create a new connection, then create a new command, then create a query, then add parameters to the query, then run the query, then handle errors and retries, then iterate over the result, then try to map the result to a useful type, then return that type. This kind of repetitive plumbing code was common in the early days of .NET, but today most organizations recognize the value of using tools like ORMs to dramatically reduce the amount of low-level data access code they need to write and maintain.

## Command Query Responsibility Segregation (CQRS)

Another principle that's useful when it comes to data access is separating read-only work from commands that change state. In terms of SQL that means separating SELECTs from INSERTs/UPDATEs/DELETEs. Doing this from the start may be a form of premature optimization (see above), but keeping it in mind and realizing it may be helpful later is never a bad thing. There are a variety of benefits to following this principle, just one of which is the way it can help with performance and scalability.

CQRS is helpful for performance because caching (see above) can often be applied to read operations that frequently request data that changes infrequently. Adding a caching layer over top of all read operations (or all that satisfy certain criteria) is an approach that helps keep code DRY by not repeating caching logic unnecessarily. However, it's unusual to add caching to commands, so keeping queries separate from commands is helpful.

Likewise, CQRS can help scalability for write operations by providing a mechanism for queueing and completing the commands out of process. Where an early version of a data access layer might make direct UPDATES to a table, a later version might modify this approach to instead add a command to make the change to a queue to be handled by another process, allowing the current process to complete without waiting for the change to have been performed. Queries typically don't operate this way and must have their returned data in order to proceed, so again separating queries from commands is useful as a means to employ these patterns.

## Other helpful patterns

Most of the [SOLID principles](https://www.pluralsight.com/courses/csharp-solid-principles) are helpful to keep in mind when it comes to data access within object-oriented applications like .NET apps.

### Single Responsibility

Data access libraries can easily grow out of control, with many unrelated methods. Try to ensure your classes have a single responsibility and keep them small and focused.

### Open/Closed

As data access needs grow in complexity, it's not unusual to continually edit and modify existing code to add new capabilities. Avoid changing existing code and instead figure out a way to add behavior by adding new code, ideally new classes. For example, rather than adding caching to a method that already queries data from the database, introduce a [caching decorator](https://ardalis.com/building-a-cachedrepository-in-aspnet-core/) that can be applied without touching the existing (working!) data access code.

### Interface Segregation

If you start adding interfaces to represent data access (you probably should), take care that they remain focused and cohesive. Beware of fat interfaces that have a lot of methods defined that most of their clients never call. Keep your interfaces small and focused on what specific clients need, not a "junk drawer" of ever data access method you might ever need.

### Dependency Inversion

Avoid having your application code depend directly on data access. The best way to do this is to follow the dependency inversion principle and the closely related [Explicit Dependencies Principle](https://deviq.com/explicit-dependencies-principle). Abstract your data access and inject the abstractions (interfaces) into the services and UI types (e.g. controllers) that need them.

### Sargability

[Vicky Harp noted on twitter that this is a good principle for developers to keep in mind when considering data access](https://twitter.com/vickyharp/status/1285615369730785281). It factors in primarily if you're writing SQL code yourself. The term "sargable queries" comes from [combining the terms search, argument, and able](https://en.wikipedia.org/wiki/Sargable). Sargable queries can take advantage of an index. One of the most common ways to make a query non-sargable is by using columns as inputs to functions in a where clause. Many non-sargable queries can be rewritten to be sargable, often with dramatic performance improvements.

