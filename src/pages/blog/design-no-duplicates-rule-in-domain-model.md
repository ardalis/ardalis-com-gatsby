---
templateKey: blog-post
title: Design a No Duplicates Rule in your Domain Model?
path: blog-post
date: 2020-07-16T09:01:00.000Z
description: Eleven ways to design a no duplicates names rule in a domain model following domain-driven design (DDD).
featuredpost: false
featuredimage: /img/design-no-duplicates-rule-domain-model.png
tags:
  - ddd
  - dotnet
  - GitHub
  - Domain-Driven Design
category:
  - Software Development
comments: true
share: true
---

I'm [streaming about open source software development most Fridays on Twitch](https://twitch.tv/ardalis) - follow me to get notified when I go online. Recently I was working on building a new API for the [eShopOnWeb reference application and one of the commenters wanted to see how to add validation. Not just simple model validation, but something requiring server-side work: verifying that a product name was unique in the system. I [coded up a solution using domain events and Mediatr (in a way I hadn't tried before) and managed to get it working](https://www.youtube.com/watch?v=x-UXUGVLMj8) (starting around 1:15). I wrote up the steps to [add domain events with mediatr](https://ardalis.com/immediate-domain-event-salvation-with-mediatr/) in a separate article, and that generated [some discussion](https://twitter.com/kamgrzybek/status/1280868055627763713) as to whether the approach is a good one.

The discussion led me to implement the requirement in a few different ways, all of which you'll find in this GitHub repository, [DDD-NoDuplicates](https://github.com/ardalis/DDD-NoDuplicates). To summarize, the approaches covered are:

1. Database UNIQUE / key constraint
2. Use a *domain service*
3. Pass necessary data (all existing names) into method on entity
4. Pass unique checking service into method on entity
5. Pass unique checking function into method on entity
6. Pass filtered data (all matching names) into method on entity
7. Use an *aggregate* and put all logic relating to names in it
8. Use an aggregate and *double dispatch* to have logic on entity with aggregate assistance
9. Use an aggregate with logic on entity and C# events
10. Use an aggregate with MediatR *domain events*
11. Use MediatR *domain events* on entities without a parent aggregate

Personally, I'm a fan of domain events, so I'd probably go with options 10 or 11 in most cases. This presumes that there's a need to model the rule in the domain layer. In many real world scenarios option 1 makes the most sense, and it's probably the most common approach to this particular problem.

**Note:** Another option similar to option 8 above would be to have a navigation property on the entity back to its aggregate parent. However, for a variety of reasons I prefer to model navigation relationships one-way, from parent to child, so I haven't covered this option here. Julie Lerman and I cover the thinking behind this in our [DDD Fundamentals course](https://www.pluralsight.com/courses/domain-driven-design-fundamentals).

Do you have another approach? Add an issue or submit a pull request to the [repository](https://github.com/ardalis/DDD-NoDuplicates).
