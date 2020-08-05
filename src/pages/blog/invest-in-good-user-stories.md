---
templateKey: blog-post
title: Invest in Good User Stories
path: blog-post
date: 2020-08-05T12:23:49.487Z
description: User stories are a useful tool for describing requirements of
  software applications. You can use the proven mnemonic INVEST to remember
  important principles of good stories.
featuredpost: false
featuredimage: false
tags:
  - user stories
  - xp
  - agile
category:
  - Software Development
comments: true
share: true
---


User stories are a useful tool for describing requirements of software applications. [User stories have been a part of agile methodologies](https://www.agilemodeling.com/artifacts/userStory.htm) like XP and Scrum for over twenty years. You can use the proven mnemonic INVEST to remember important principles of good stories.

## What is a User Story

A user story is "a placeholder for a conversation." It's meant to describe a high level requirements from an end user's perspective. They're meant to be written by stakeholders, not the programmers who will implement them. User stories are meant to be small - smaller than more formal methods of describing requirements like use cases, usage scenarios, or [UML diagrams](https://creately.com/blog/diagrams/requirements-gathering-techniques). In XP, teams are supposed to have a close relationship with their stakeholders, also known as customers. Getting more information when it's time to begin work on a user story should be a matter of asking the customer - who is a part of the team - for more information about how a particular thing is supposed to work. If you don't have ready access to your customer, or someone who can easily answer these questions as-needed, user stories may not provide sufficient context for team members to begin work and it may delay the work for the just-in-time analysis to occur. You need to consider how much time will take place between a developer deciding to work on a story and asking a stakeholder to discuss it with them until that discussion takes place. Seconds or minutes is best, hours is acceptable. Days to weeks of delay will not work well.

## Good User Stories

Good user stories have certain characteristics. As someone who appreciates the value of [kanban](https://www.pluralsight.com/courses/kanban-fundamentals), I believe one of the most important characteristics is that they be small. The smaller the individual stories (or work items) in a process, the more quickly they can flow through the system, and optimizing flow and minimizing cycle time are goals of any kanban process. Of course, it doesn't matter how small a single story is if it's dependent on other stories, so ideally individual stories should be independent from one another. In practice the ability to achieve this varies widely, as there are many parts of software system that depend on other parts.

Some time ago, someone came up with a handy mnemonic for describing good user stories. Wikipedia seems to think it was [Bill Wake in this article](http://xp123.com/articles/invest-in-good-stories-and-smart-tasks) from 2003. The mnemonic lays out 6 principles of good user stories, including the two I've just highlighted, and arranges them to form the word INVEST. It's handy that this then lets us talk about INVESTing in good user stories...

Let's examine the 6 principles that make up INVEST for good user stories below.

## Independent

User stories work best when they're independent. We don't want them to overlap. We want to be able to work on them in parallel. We want to be able to prioritize them in whatever order makes sense for the business. All of these things are only possible if they're not inextricably linked to one another.

Sometimes a particular story may require some investment that any number of other similar stories will benefit from. Maybe the first report you write requires purchasing, learning, and installing a report generator tool, but after the first report is done, the rest of them take significantly less time. Or perhaps you recognize that certain business cases all represent individual rules, so you decide to quickly build a rules engine to manage them. The first rule you implement in this way will take more time, because you're building the engine, too, but after that every future rule you add will require substantially less effort.

## Negotiable

Bill Wake writes:

> <!--StartFragment-->
>
> A good story is *negotiable*. It is not an explicit contract for features; rather, details will be co-created by the customer and programmer during development. A good story captures the essence, not the details. Over time, the card may acquire notes, test ideas, and so on, but we don’t need these to prioritize or schedule stories.
>
> <!--EndFragment-->

I'm not sure "negotiable" is the best term for this, but hey it works with the mnemonic. The idea here is that the details of the user story are TBD - to be determined. User stories shouldn't be so detailed that they act as a specification of the work to be done. They should have just enough detail to remind the developer and the stakeholder of the feature to be discussed, and then a discussion should be had. That's not to say the story can't contain additional valuable context (notes, sketches, etc) from past discussions, all of which can be brought into the just-in-time discussion. Most likely, though, these things were added after the story was first created, during prioritization or other conversations while it was in the backlog. User stories should require extensive notes or diagrams to be considered "done".

## Valuable

User stories should be valuable... but value is subjective. Valuable to whom? User stories have the word "user" right in their name. They represent features of the software that the user can interact with. They are valuable *to the user* (or stakeholder or customer). Keep this in mind when you have larger stories that you want to split (remember we want them to be small). It's best to split them as [vertical slices](https://deviq.com/vertical-slices/), not horizontal layers. Here's an example of what building features as vertical slices looks like:

![Animated slices running through horizontal layers](/img/verticalslices.gif "Vertical Slices")

Avoid creating user stories that have no user-facing component. Tasks like designing the database schema or configuring the firewall or setting up the git repository may be important to ultimately delivering the software, but they are not good user stories.

## Estimable

Quoting from Bill Wake again:

<!--StartFragment-->

A good story can be *estimated*. We don’t need an exact estimate, but just enough to help the customer rank and schedule the story’s implementation. Being estimable is partly a function of being negotiated, as it’s hard to estimate a story we don’t understand. It is also a function of size: bigger stories are harder to estimate. Finally, it’s a function of the team: what’s easy to estimate will vary depending on the team’s experience. (Sometimes a team may have to split a story into a (time-boxed) “spike” that will give the team enough information to make a decent estimate, and the rest of the story that will actually implement the desired feature.)

<!--EndFragment-->

In my own experience and research, I've found that estimates in software have dubious value beyond very unscientific guesses. Any task that one estimates will take more than a day of dedicated effort is likely to vary wildly in actual time required to complete. I've written up my experience as what I call the [5 Laws of Software Estimates](https://ardalis.com/the-5-laws-of-software-estimates/). At the end of the day, if you prioritize splitting your stories until they're as small as possible, then you can prioritize your work strictly based on which stories are most important to deliver first, regardless of size. On average, your delivery will flow at a certain rate, and you'll be able to deliver value faster than if you'd devoted time and resources to estimating the work.

Think about how Windows copies files, especially over the network. Any time you try to copy a bunch of files, the first thing that happens is a dialog pops up saying "Calculating time to copy/move these files" which can last quite a long time before it actually starts doing any work. There are popular articles online devoted to avoiding this wasted effort (most of which say, [don't use Explorer to copy files](https://superuser.com/a/135295)). The time spent calculating isn't free - it takes away from time that could be spent on actual, valuable work. So, estimate if you must, but try to keep in mind the opportunity cost of the time you're spending on estimating.

## Small

If there were a better mnemonic than INVEST, I would definitely put S for SMALL at the start of the word (STEVIN? SVETIN? Sigh...). Good user stories should be small. This is similar to advice for functions in your software. Try to keep them small. Think about how small your user stories/functions are. No, smaller than that. :)

Remember, user stories should be placeholders for a conversation. They're meant to describe a small piece of how a user interacts with the system. The more scope they cover, the longer the actual text of the story probably needs to be to describe it accurately (or else it risks being impossibly vague, even as a placeholder). And that conversation with the stakeholder isn't meant to be a 4+ hour marathon planning session, but a few moments of clarification.

If you find your user stories are larger than they should be, split them. Splitting user stories is a skill, but the first thing to remember is that you want to split them vertically, as described above, so that each new smaller story still represents something of (incremental) value to the user. Delivering stories as vertical slices has the added benefit of constantly delivering working software without a lot of hidden-but-so-far-useless effort in it. The sooner you can bring your effort to market in the form of working software, the better, for a host of reasons. Smaller user stories support this.

## Testable

Finally, you should be able to verify that a user story is working properly. This should be a part of your "definition of done." If you don't have a test that verifies that a given user story is working, how do you know it's working? How can you prove it to one of your teammates or to your customer? If you have to manually walk through the scenario to demonstrate it, where do you do that? On your machine? How do you know it doesn't just work on your machine?

User stories should be delivered alongside tests that demonstrate their functionality and ideally can be run as part of a continuous integration (and potentially continuous delivery) process. Doing so increases the likelihood that the stories are actually fully working, including edge cases and environment issues that may be local to one machine or another. It's still possible for bugs to exist, of course, but at a coarse-grained level, having tests for user stories dramatically reduces the chances that a story is "delivered" in a completely broken state.

## Summary