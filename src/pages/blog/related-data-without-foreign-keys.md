---
templateKey: blog-post
title: Designing for Related Data without Foreign Keys
date: 2021-03-03
description: A recent discussion on devBetter.com about how to model data in a loosely-coupled manner spurred this article which describes a few different ways to model data without referential integrity and foreign keys.
path: blog-post
featuredpost: false
featuredimage: /img/related-data-without-foreign-keys.png
tags:
  - sql
  - data
  - databases
category:
  - Software Development
comments: true
share: true
---

A recent discussion on the [devBetter.com private server](https://devBetter.com/) spurred this article. One of the members was trying to work out a fairly complex design involving many different parts, and the idea of trying to model all of this as a set of database tables with primary key and foreign key relationships was daunting. The sheer number of many-to-many and one-to-many relationships along with recursive and optional relationships made the whole design difficult to approach and begin, much less complete.

This inspired a separate thread about how to *decouple* related concepts in a system, and the idea that you don't *have* to use foreign keys and [third normal form](https://en.wikipedia.org/wiki/Third_normal_form) for every data model. There are other ways to model data, and they involve tradeoffs. This whole idea came as a bit of a shock to the developer in question, who had learned "the rules" of data, of which [referential integrity](https://en.wikipedia.org/wiki/Referential_integrity) and key relationships were near the top.

> "What you must learn is that these rules are no different than rules of a computer system. Some of them can be bent, others can be broken." -- Morpheus

![Morpheus quote image](https://i.imgflip.com/505vbr.jpg)

## Keys and Ids and Relationships

Many developers are quite familiar with how to model data using referential database concepts, including primary and foreign keys and associated relationships. Referential integrity is enforced by the database engine itself, ensuring that certain constraints are enforced, such as not allowing an orphaned foreign key (a key with a value that doesn't exist in the related table's specified key column). If you've ever gotten an error trying to delete a row in a table telling you it would violate a foreign key constraint, you've experienced this firsthand.

There are **many advantages** to using this approach and this article is not in any way trying to talk you out of using this approach as your default, go-to way to model data in your systems.

However, you should understand that it is not the *only* way.

## Foreign Keys without the constraints

You don't *have* to configure a foreign key constraint on a column just because it refers to another column. You could instead configure two tables such that one refers to the other, but without any defined foreign key. For instance, let's say you have a Customer table with its own ID column, and you have a User table with its own ID as well. You could add a UserId column to Customer and still use it for querying purposes. You could make it NULLABLE if desired (which you can also do if it's an optional key - I'm not saying this can't be done). You could even make it another data type entirely, such as a varchar, while the User table's ID column might be an int or Guid/uniqueidentifier.

Why might you do this? Maybe you need the flexibility because you import data and the imported data doesn't always have a user associated with it, or it includes dirty historic data that spans multiple identity systems and some user ids are keys and others are email addresses. A big reason why you might choose this approach is to support less-than-ideal data.

Another reason you might want to go this route is to maintain some looser coupling in your system. Maybe there is an effort in place to move the User table to another database, or even another service entirely. Eliminating the foreign key could be a step toward making this migration happen.

## Really foreign keys

Jumping off from the end of the last section, what if your data is really spread out? Maybe you need to refer to some data that doesn't even exist in your database at all? For instance, maybe you have a system that adds metadata or tracking to Amazon products. You're not going to save Amazon's entire catalog (and keep it updated), so instead you might store just its ID (for example, `B001DJLD1M`). Then, if you need to pull some data about that item as part of a query or for a report, you can fetch it with an HTTP request.

Obviously this has big implications on performance and reliability. How are you going to do this for millions of rows? (spoiler alert: you're probably not) What do you do when the data isn't available or it's moved? How do you handle updates and ACID-style transactions?

Well, you probably need to give up some things to play in this space. This approach is introducing a *partition* in the data, which means [CAP Theorem](https://ardalis.com/cap-pacelc-and-microservices/) applies.

So, why might you do this? Again in this made-up scenario you don't necessarily have the capability store all of the data locally. Or perhaps you're using a vendor that you want to avoid tightly coupling to. Today it's Amazon, but tomorrow it could be NewEgg (or both). Having ways to key into other systems lets your system remain less coupled to its dependencies, which helps keep it maintainable.

## Related patterns

Once you have non-tightly-coupled data relationships to data that might live in other local databases, remote databases you own, or even other companies' data, you're able to think about ways to partition your data differently. If your database's entity relationship diagram looks the one shown below, it may be difficult to segment into smaller pieces.

![big entity relationship diagram](/img/entity-relationship-diagram.png)

[Domain-Driven Design](https://www.pluralsight.com/courses/domain-driven-design-fundamentals) strives to identify subdomains within large businesses or apps and use bounded contexts to break these down into smaller, more manageable problem spaces. Within a bounded context, a domain model is developed, described using a [ubiquitous language](https://deviq.com/domain-driven-design/ubiquitous-language). Related primitives are grouped together as value objects, which are referenced using entities, and related groups of entities are organized into [aggregates](https://deviq.com/domain-driven-design/aggregate-pattern). Aggregates should be persisted as a whole, and a frequently design challenge for teams applying DDD is to identify aggregates within a given domain model. When bounded contexts are identified, systems outside of the context's boundaries, whether internal or third-party, are accessed through an [anti-corruption layer](https://deviq.com/domain-driven-design/anti-corruption-layer). The ACL is comprised of types that implement well-known design patterns like [Adapter](https://www.pluralsight.com/courses/c-sharp-design-patterns-adapter) and [Facade](https://www.pluralsight.com/courses/csharp-design-patterns-facade) to map from the other system's model and API to the local one.

None of these patterns work terribly well when a system has one big database in which everything is connected through key references. One of the first tasks developers must do when they're trying to tame a big ball of mud system is to identify where the system can be teased apart. Usually when doing this, strong key-based relationships are replaced with less constraining relationships like the ones described above. This in turn facilitates the introduction of separate contexts, with boundaries, and patterns like aggregates. Eventually (and optionally), large data-centric systems can migrate to distributed applications in which separate applications (or, yes, even *microservices*) collaborate with one another through established protocols and interfaces instead of merely a shared data store.

P.S. Bonus points to the first person who to identify the amazon product I referenced by ID and leave a comment below.
