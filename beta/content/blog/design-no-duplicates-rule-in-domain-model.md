---
title: Design a No Duplicates Rule in your Domain Model?
date: "2020-07-16T05:01:00.0000000-04:00"
description: Eleven ways to design a no duplicates names rule in a domain model following domain-driven design (DDD).
featuredImage: /img/design-no-duplicates-rule-domain-model.png
---

### Update 17 May 2023

I haven't been streaming on Twitch for a while (as noted in the original article) but I have continued to use this sample to demonstrate how to perform work in your domain model that requires data. I've updated [the GitHub repo](https://github.com/ardalis/DDD-NoDuplicates) a bit, but overall the concepts remain pretty much the same. One thing I haven't added (that you generally should avoid) is just a static method that performs the necessary work. I may add that as a bad option (with some demonstration of the pain it causes) if there are some requests for it, though.

Have I missed anything? Add an issue or leave a comment if there's an approach you've used that you think should be represented here.

(original article below)

I'm [streaming about open source software development most Fridays on Twitch](https://twitch.tv/ardalis) - follow me to get notified when I go online. Recently I was working on building a new API for the [eShopOnWeb reference application](https://github.com/dotnet-architecture/eShopOnWeb) and one of the commenters wanted to see how to add validation. Not just simple model validation, but something requiring server-side work: verifying that a product name was unique in the system. I [coded up a solution using domain events and Mediatr (in a way I hadn't tried before) and managed to get it working](https://www.youtube.com/watch?v=x-UXUGVLMj8) (starting around 1:15). I wrote up the steps to [add domain events with mediatr](https://ardalis.com/immediate-domain-event-salvation-with-mediatr/) in a separate article, and that generated [some discussion](https://twitter.com/kamgrzybek/status/1280868055627763713) as to whether the approach is a good one.

The discussion led me to implement the requirement in a few different ways, all of which you'll find in this GitHub repository, [DDD-NoDuplicates](https://github.com/ardalis/DDD-NoDuplicates). To summarize, the approaches covered are:

1. Database UNIQUE / key constraint
2. Use a *domain service*
3. Pass necessary data (all existing names) into method on entity
4. Pass unique checking service into method on entity
5. Pass unique checking function into method on entity
6. Pass filtered data (all matching names) into method on entity
7. Use an *aggregate* and put all logic relating to names in it
8. Use an aggregate and *double dispatch* to have logic on entity with aggregate assistance
9. Use an aggregate with logic on the entity and C# events
10. Use an aggregate with MediatR *domain events*
11. Use MediatR *domain events* on entities without a parent aggregate

Personally, I'm a fan of domain events, so I'd probably go with options 10 or 11 in most cases. This presumes that there's a need to model the rule in the domain layer. In many real world scenarios option 1 makes the most sense, and it's probably the most common approach to this particular problem.

Beware of option 7, putting child entity logic into the aggregate root. It leads to anemic children and is generally a result of folks misunderstanding the need for the root to be involved in any update to its children. The children shouldn't be added/removed/modified without the aggregate being involved, but that **does not** mean the aggregate root needs to micromanage the state of the child entities. See options 8-10 for better ways to involve the aggregate root with changes to its children.

**Note (17 May 2023)**: I used to like using domain events for validation, with the handler throwing an exception. Since a few years ago I've moved away from this design, because it can cause problems. Basically I've concluded that **domain events (and their handlers) should never throw exceptions as part of their design**. If there's an exception in an event handler, it's because something went wrong, not because it's designed to work that way.

**Note:** Another option similar to option 8 above would be to have a navigation property on the entity back to its aggregate parent. However, for a variety of reasons I prefer to model navigation relationships one-way, from parent to child, so I haven't covered this option here. Julie Lerman and I cover the thinking behind this in our [DDD Fundamentals course](https://www.pluralsight.com/courses/domain-driven-design-fundamentals).

Do you have another approach? Add an issue or submit a pull request to the [repository](https://github.com/ardalis/DDD-NoDuplicates).

