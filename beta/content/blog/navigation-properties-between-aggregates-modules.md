---
title: Modeling Navigation Properties Between Aggregates or Modules
date: "2024-06-19T00:00:00.0000000"
description: A question from a student of my Modular Monolith course about how to effectively access related data from a different module. It's a frequent question from DDD students when it comes to modeling aggregates as well.
featuredImage: /img/modeling-navigation-properties-between-aggregates-modules.png
---

One of the key challenges in developing a modular monolith is managing the communication between different modules, especially when it comes to handling data dependencies across module boundaries. Recently, I received an interesting question from one of the students of [my modular monoliths course](https://dometrain.com/bundle/from-zero-to-hero-modular-monoliths-in-dotnet/), which I thought others might appreciate.

## Student Query

*Modular Monolith course question (EFCore Navigation Properties)*

Message:
*Hi Steve,*

*Just got done with your modular monoliths course and loved it. I have a question about how navigation properties work inside each module using EFCore.*

*Let's say I have an entity called Booking, that has a foreign key to a CustomerId, how would I map that using EFCore's `EntityTypeBuilder`? I could usually do:*

```csharp
builder.HasOne<Customer>()
.WithMany()
.HasForeignKey(booking => booking.CustomerId)
.IsRequired();
```

*However this doesn't work, as the Customer entity is in another module so I cannot reference it as the navigation property?*

*Just wondering if you had the answer to this, as i'm struggling to understand it.*

### My Response

Hi *NAME*,

Yes, it's a common question, so don't feel bad about having it.:)

There are a few ways to look at it but the key is to reframe how you think about related data that belongs to a different module. It's natural to think about that data as being all part of "your" application and its data store, and as such to use conveniences like navigation properties and, at the database level, tools like foreign keys to ensure referential integrity. While sometimes you can get away with this (if you opt to use a single database for all of your modules, for instance), it's a tradeoff and always sacrifices independence for that convenience.

Imagine instead that the data owned by other modules is outside not just that module but outside your organization. You're trying to link to a Customer in this example, via a CustomerId. Well, pretend that the Customer record actually lives in a Salesforce.com CRM (or some other external CRM) and all you have is its key/ID. Sure, if you need info on that customer, you can always make an API call to Salesforce to fetch their data. But you're not going to perform a database join on it, because you don't own that data locally. Does that make sense?

So, the short answer is, *don't use navigation properties for entities that live outside your module*. Instead always just use keys, and then use a strategy to get the data like you saw me do in [the course](https://dometrain.com/bundle/from-zero-to-hero-modular-monoliths-in-dotnet/). You can use MediatR queries to make in-process calls to fetch data as-needed between modules. And if you *really* want to have the data locally in your database, you can use the [Materialized View pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/materialized-view) that I demonstrated to keep a local copy of another module's data in your database (and keep it synchronized using events or another strategy). At that point you *can* have navigation properties and perform joins on that data, but you should take care not to modify any of the data in the MV because it's essentially a read-only cache. If you need to make changes, send a command to the module that owns that data.

Hopefully that helps,
Steve

## Student Response

> Hi Steve,

> Thanks for getting back to me so quickly and really appreciate the thorough response.

> That totally makes sense to me now!

> I think what helped me grasp it was changing my mindset on where the other modules could potentially be stored.

> Makes complete sense to not have any hard dependencies on other modules (basically modular monolith 101).

> Much appreciated and look forward to any future content you put out!

### Conclusion

Whenever you're segmenting your application into discrete parts, whether these are [DDD Aggregates](https://deviq.com/domain-driven-design/aggregate-pattern) or Modules in a [Modular Monolith](https://dometrain.com/bundle/from-zero-to-hero-modular-monoliths-in-dotnet/), you're going to want to isolate data dependencies between the parts. One way this manifests is in your design of your domain entities. With Aggregates, a general good practice to follow is to only have navigation properties flowing in **only** one direction from the root to its children (and if necessary, their children). If you follow this advice, your modules will automatically be fine, since there will never be a child of an aggregate defined in a separate module from the aggregate's root. But in any case, data that is outside of an aggregate or module should only be referenced using its key or ID, not as a navigation property.

Note that if, for performance or other reasons, you need to have local access to related data that is owned by another module or system, you can use the Materialized View pattern to keep a local read-only cache of the data you need. And then when it makes sense you can join on this data or include it in EF queries using navigation properties.

### References

1. [Effectively Sharing Resources Between Modules in a Modular Monolith](https://ardalis.com/effectively-sharing-resources-between-modules-modular-monolith/)
2. [Materialized View pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/materialized-view)

## Keep Up With Me

If you're looking for more content from me in your inbox [subscribe to my weekly tips newsletter](/tips) and be sure to follow me on [YouTube](https://www.youtube.com/ardalis?sub_confirmation=1).

