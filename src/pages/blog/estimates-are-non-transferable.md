---
templateKey: blog-post
title: Estimates Are Non-Transferable
path: blog-post
date: 2020-09-22T09:30:00.000Z
description: Estimates are made by individuals, with individual assumptions. As such, they don't transfer well between individuals, even within the same role or skillset.
featuredpost: false
featuredimage: /img/estimates-are-non-transferable.png
tags:
  - agile
  - estimates
  - estimation
  - lean
  - noestimates
  - waste
category:
  - Software Development
comments: true
share: true
---

This is the second of the [5 Laws of Software Estimates](/the-5-laws-of-software-estimates/). I expanded on the [first law of software estimates in my previous article](https://ardalis.com/estimates-are-waste/).

Estimates generally cannot be transferred between individuals. If I ask five team members to estimate a given story, using whatever units they wish (time, points, etc.), I'm likely to get a range of answers that could vary by 200% or more! The hope may be that averaging this out will help with accuracy, or perhaps an ensuing discussion will help everyone arrive at a consensus. While there are some benefits to be had from these discussions, in practice, the individuals are still going to take varying amounts of time to perform the work if they do it themselves, and thus even if they estimate with perfect accuracy, their estimates will be different.

And of course, the more people involved in the discussing and analyzing the estimates, the more waste (lost productivity) there is from their collective time spent estimating.

## Software Estimates Are Not Fungible

Fungibility is great. In economics, fungibility describes the property of a good whose individual units are essentially interchangable, and each of its parts is indistinguishable from another part ([wikipedia](https://en.wikipedia.org/wiki/Fungibility#:~:text=In%20economics%2C%20fungibility%20is%20the,is%20indistinguishable%20from%20another%20part.)). This is huge for efficiency, and allows for things like open markets to exist. In programming, [value objects](https://deviq.com/value-object/) have this characteristic, since they have no identity and can always be compared using only their properties. Money is typically considered to be fungible, since if we agree on a price of $10 we typically don't care if the payment is made in $1 bills or a $10 or what the serial numbers are on the paper notes. We might even pay electronically or with a check. The individual unit of currency is irrelevant in almost all cases.

What does this have to do with estimates?

When an individual estimates the effort required to complete a given task, they are making a host of assumptions. They are using some methodology, even if they don't realize it. The most common methodology is, "I've done something like this before; I think that took me X time, so I'm going to guess this will take something similar to X time." Because the experience of every individual is different, as is their memory and perception of that experience (even if they were working with a teammate on a previous feature, both will recall it differently), the basis for their estimates will differ. Probably not as much as if their experience levels are wildly different, but they still won't match up.

So, the input for the estimates, the experiences of the estimator, obviously vary. But that's not all. There are often assumptions that vary as well. Let's say you're presented with a new feature request for the application you're working on. You think about it and determine that it's going to require a new form for the user to enter data into. Now, you need to estimate how much effort that will take to complete (along with your teammates). You come up with an estimate that seems reasonable and you're ready to share it via planning poker or something similar. But, how many of these considerations went into your estimate?

Does your estimate include:

- Unit testing any business logic?
- Integration tests to verify the form works?
- Writing and testing input validation? Client- and Server-side?
- Logging failures (and important business activities)?
- Calendar time or actual work time?
- Ideal work time or work time with meetings, interruptions, etc?
- Time spent updating your tools and applying updates to your machine?
- Time spent in meetings and emails discussing the details with your team?
- Any work required to push the changes to production?
- A single fixed result or a range with probability (e.g. 20% confident to finish in 5 points, 90% finish in 13 points)
- Assumptions about availability of help/collaboration from teammates or other teams?

Sitting around the table (tele-meeting), your teammates are ready with their estimates, too. What are the odds they're even considering the same things you are, much less that they've made all the same assumptions you have?

## The Problem

The problem with the lack of fungibility of estimates is that most work tracking software treats estimates like value objects. The estimate for a given work item is stored as a fixed numeric value, not a range of survey results from multiple team members. There's nothing that says "Alice estimated this at 3 points" or "Bob estimated this at 5 points". All of that nuance is lost and some average value is used instead. Later, someone will actually need to perform the work (or not, in which case most of the time worrying about estimating it was likely wasted, though it may have helped focus effort on more important activities). The person ultimately implementing the feature or performing the work may or may not have been involved in estimating it. Even if they were, if any time has passed, their knowledge of the system and experience working with it will be different today than it was then. It's likely if they had it to do over again, they would come up with a very different estimate than they might have in the past, or than is currently assigned to the work item. But most methodologies have no allowance for adjusting estimates after they've been established, and certainly not while the work is in progress. Thus, it's not at all unusual for someone to begin work on a story that's been estimated to take just 3 "points" but ends up taking far longer than other stories that were similarly estimated.

The other problem estimate non-transferability is that you can't just outsource the task or deal with it using specialization. Many areas of business benefit from some degree of transferability, such that as the business grows you can take a set of tasks and create a new role responsible for just that task. Then you can hire and staff many people to fill that role. We see this all the time for things like customer support, where a very small business might have the owner doing all of this work, but a larger business might have hundreds of employees offshore performing this work. Even without outsourcing, it's not at all unusual to hire specialists to perform certain roles within the organization. Every distinct job title is evidence of this practice. But you don't, and probably shouldn't, see roles within software organizations like "Lead Task Estimator". Why not? Because if one individual or group were responsible for producing all estimates, they would have little basis in the reality of the teams who would actually be doing the work.

And because estimates can't be transferred, they need to be done by the people who will be doing the work, and unfortunately those people tend to be highly utilized and relatively expensive.

Learn more about the [5 Laws of Software Estimates](/the-5-laws-of-software-estimates/), and share your own experience in the comments below.

*Photo Credit [https://flic.kr/p/8zGJdn](https://flic.kr/p/8zGJdn)*
