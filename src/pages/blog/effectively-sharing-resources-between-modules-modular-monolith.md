---
templateKey: blog-post
title: "Effectively Sharing Resources Between Modules in a Modular Monolith"
date: 2024-05-24
description: "A question from a student of my Modular Monolith course about how to effectively share related but cross-module data. And my answer."
path: blog-post
featuredpost: false
featuredimage: /img/effectively-sharing-resources-between-modules-modular-monolith.png
tags:
  - .NET
  - CSharp
  - dotnet
  - Web APIs
  - Architecture
  - Modular Monolith
  - APIs
category:
  - Software Development
comments: true
share: true
---

One of the key challenges in developing a modular monolith is managing the communication between different modules, especially when it comes to handling data dependencies across module boundaries. Recently, I received an interesting question from one of the students of [my modular monoliths course](https://dometrain.com/bundle/from-zero-to-hero-modular-monoliths-in-dotnet/), which I thought others might appreciate.

## Student Query

*Hi Steve, I have another question for you after finishing the deep dive course. Let's say that now I have multiple modules, each of them with IDs of other entities in their domain. I don't want to serve data from module A in module B, so I just return the ID to the consumer and let them call module A with it. The problem is that following this pattern, the consumer could be forced to do a lot of calls just to jump between our domains. Could it make sense to implement an API Gateway? How could it be implemented in a modular monolith environment?*

### My Response

If you have a single client, like a SPA (Angular, React, Blazor), I would typically use the Backend-For-Frontend (BFF) pattern, which can be implemented either as its own separate project or simply configured as an API Gateway (using something like [Azure API Gateway](https://learn.microsoft.com/en-us/azure/api-management/api-management-key-concepts#api-gateway) or something as simple as [YARP](https://microsoft.github.io/reverse-proxy/)). In microservices architectures, it's usually a separate standalone instance that has access to the public internet while the rest of the services are behind the firewall. In a modular monolith scenario, it would typically be the same — a separate instance.

The tradeoff you're making is between modularity/coupling and performance. If you just pass an ID all the way to the client, and then it needs to make a new call to get the details for that record, it's another round trip compared to if you just gave it the data directly. This is a minor problem if it's just one thing, but it gets much worse if it's a collection of things (the [classic N+1 problem](https://stackoverflow.com/questions/97197/what-is-the-n1-selects-problem-in-orm-object-relational-mapping) but via APIs not database queries).

My usual approach is to not worry about the performance problems prematurely, but once you can see (and ideally measure!) them, take some steps to mitigate them. These steps include some usual suspects and some unique to this problem:

1. **Add Indexes**: Ensure fetching the data is as fast as you can easily make it. Optimized database queries can significantly reduce the latency of data retrieval.
2. **Read Store Optimization**: Consider having a separate read store that's optimized for queries. This store can be updated asynchronously from the main data store.
3. **Server Caching**: Implement server-side caching. It's always faster to serve data from memory than to fetch it from a database. Use an in-memory cache or a separate service like Redis.
4. **Materialized Views**: Add a materialized view to module A containing module B's data. When module A returns data referencing module B items, it can (optionally, with an API parameter specifying the extra data should be pulled back) include those items in its payload directly without the need for any server-side communication (and also eliminating the need for any client-side fetches for the module B items).
5. **Batch Fetching**: Add APIs for fetching multiple IDs at a time. For instance, when module A returns 10 records and those 10 records include references to 10 module B IDs, those 10 records can be fetched with one call to module B.

By implementing these strategies, you can maintain the modularity of your monolith while also mitigating potential performance issues that arise from cross-module data dependencies.

Does that make sense?

## Student Response

*Steve, you’re simply the best. Thanks for the detailed answer, everything makes sense. Have a wonderful day!*

### Conclusion

It's worth considering how the client of your APIs will consume them, and how it may be necessary for it to make separate calls to fetch the details of any associated IDs you include in your payloads. It's always a tradeoff in API design between sending too much or too little data, and [data deficient messages](https://ardalis.com/data-deficient-messages) are a common problem.

By leveraging patterns such as BFF (which lets you customize your APIs and their messages specifically to suit the needs of your client), server caching, and optimized data fetching techniques, you can achieve a balance between modular design and system performance.

### References

1. [Backend For Frontend Pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/backends-for-frontends)
2. [Caching Guidance](https://docs.miclocrosoft.com/en-us/azure/architecture/best-practices/caching)
3. [Materialized Views](https://learn.microsoft.com/en-us/azure/architecture/patterns/materialized-view)
4. [Optimizing Read Stores - CQRS](https://martinfowler.com/bliki/CQRS.html)
5. [API Gateway Pattern](https://microservices.io/patterns/apigateway.html)

## Keep Up With Me

If you're looking for more content from me in your inbox [subscribe to my weekly tips newsletter](/tips) and be sure to follow me on [YouTube](https://www.youtube.com/ardalis?sub_confirmation=1).
