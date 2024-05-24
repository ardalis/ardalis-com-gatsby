---
templateKey: blog-post
title: "Clean Architecture Sucks"
date: 2024-05-23
description: "A brief conversation about the Clean Architecture approach and why some teams struggle with it."
path: blog-post
featuredpost: false
featuredimage: /img/clean-architecture-sucks.png
tags:
  - .NET
  - CSharp
  - dotnet
  - Web APIs
  - Architecture
  - Clean Architecture
category:
  - Software Development
comments: true
share: true
---

The other day I was participating in a conversation online in an architecture forum. One of the participants was complaining about the mess they were cleaning up from a team they'd joined. The team had, ostensibly, been following [Clean Architecture](https://ardalis.com/clean-architecture-asp-net-core/), but the code they had produced was a mess. Their conclusion:

> Clean Architecture sucks.

They led with:

> Clean Architecture and its obsession with grouping things into technical concerns can quickly turn into a giant ball of mud as the ability to properly develop and maintain code in such a project style is directly dependent on the technical expertise and skill of each of the developers on the project.

Now, it's true, Clean Architecture is not a silver bullet. Using it, or any other code organization approach, is not going to automatically ensure everyone on the team instinctively writes better, more maintainable code. But it's also not the fault of Clean Architecture that the team produced a mess. It's the fault of the team. I think you'll agree with me in a couple of paragraphs...

Clean Architecture, aka Ports-and-Adapters, has a primary goal of reducing tight coupling from the business rules of the system to infrastructure, and in particular, the database. That's it. It's not a panacea and it doesn't offer feature modularity - [you need modular monoliths or microservices for that](https://ardalis.com/introducing-modular-monoliths-goldilocks-architecture/). [I talk about why in this video](https://www.youtube.com/watch?v=wkAc6K09pKQ&t=147s).

Now, let's get back to this particular conversation, which is a small case study...

## The Team

Another anecdote about the code the original poster was cleaning up:

> I have a ridiculous amount of abstractions.
> For example, I have an interface to inject an `IHtmlSanitizer`.
> It has one method named `Sanitize` that takes a string in and a string out.
> There's then an `HtmlSanitizerService`.
> Why?
> Because CA says that since it uses a a NuGet dependency thus it should be in its own service.
> Literally the answer one of my devs gave me.

Me: Where does CA say that?

> It doesn't, but that's what unexperienced developers understand from it. And left unattended, this is what it produces.

(Sure Jan...)

So, what about this team of developers?

> Every single developer that's ever been hired by this company since the inception of this product have all been university graduates with no prior work experience.

Ah, we might have found *the actual problem*. (ding ding ding)

## The Problem

Clean architecture sucks. No architecture sucks. Microservices architecture sucks. Programming sucks. It all sucks **if you don't know what you're doing**. And if you don't know what you're doing, you're (probably) going to produce a mess. Why? Because you just don't know any better, yet.

And that's exactly what happened with the original poster's project/team that he inherited. The team had **zero experience**. They didn't know how to write good software, much less apply a particular style of architecture, and the result was (in at least some ways) a mess.

And it's not even the team's fault! They were hired with no experience and no mentorship. **They were set up to fail.** And they did.

## The Solution

There are some applications that are simple and don't require much, if any architecture (what I refer to as [YOLO architecture](https://deviq.com/practices/yolo-architecture)). And there are some applications which benefit from minimal structure and just pipelines and handlers (often referred to as [Vertical Slice Architecture](https://www.jimmybogard.com/vertical-slice-architecture/) though of course all software benefits from being delivered as [Vertical Slides](https://deviq.com/practices/vertical-slices)). And there are some applications that benefit from ports-and-adapters (aka hexagonal, onion, or clean architecture) style architecture, where a significant goal is to shield business logic from persistence and other infrastructure concerns. This is true of almost any application that is being built using [Domain-Driven Design](https://www.pluralsight.com/courses/domain-driven-design-fundamentals), for instance (assuming it warrants using DDD, that is).

But new grads don't know enough to know which is which. Most of them probably aren't even aware that there are different approaches to these sorts of problems, or when to consider each, or what the tradeoffs are. And [in software architecture, everything is a tradeoff](https://deviq.com/laws/laws-software-architecture).

The solution is, have at least one experienced developer on the team who can guide the others. And if you don't have one, hire one. Or bring in a consultant. Or send your team to training as a way to [scale the team up, rather than out](https://ardalis.com/scaling-your-software-team-develop-vs-hiring/). Or all of the above.

## An Analogy

Let's say you want to build a house. You have a good idea of the style - you've decided to keep it simple and build a Colonial style home. You're on a budget - so you hire a couple of teens who just graduated from high school and went through the school's construction training program (they built a shed!). You don't actually live locally, so you all agree you'll check in periodically via text message.

You spend an hour describing the house you have in mind to them, give them a credit card to pick up materials from the hardware store, and fly back home. Over the next year or two, you text back and forth with your contractors, who describe various challenges they've encountered but assure you they're overcoming them with grit and creativity.

After a couple of years, you're past ready for this house to be done. But unfortunately, it's not passing inspection by the local building inspector. After looking over the inspector's list of faults, you break down and decide to bring in an experienced contractor (or perhaps a building architect) so you can get an assessment of what needs to be fixed in order to make the house livable.

After taking a look at the mess the inexperienced builders produced, the experienced contractor concludes

"Colonial style homes suck. You should have built a Ranch."

I mean, *obviously* that's the problem 🙄.

## Conclusion

There are no one-size-fits-all architectures, any more than there are one-size-fits-all programming languages. Before blaming whichever architectural style you're using for your problems, make sure you understand that style, its goals, and its tradeoffs. Make sure it's the right choice for your team and application, and that you're using it correctly. If you're not sure, find some help from someone who has the experience to guide you.

## Keep Up With Me

If you're looking for more content from me in your inbox [subscribe to my weekly tips newsletter](/tips) and be sure to follow me on [YouTube](https://www.youtube.com/ardalis?sub_confirmation=1).
