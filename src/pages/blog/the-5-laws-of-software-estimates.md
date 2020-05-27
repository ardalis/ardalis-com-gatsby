---
templateKey: blog-post
title: The 5 Laws of Software Estimates
path: blog-post
date: 2015-11-24T13:30:00.000Z
description: Estimates are typically a necessary evil in software development.
  Unfortunately, people tend to assume that writing new software is like
  building a house or fixing a car, and that as such the contractor or mechanic
  involved should be perfectly capable of providing a reliable estimate for the
  work to be done in advance of the customer approving the work.
featuredpost: false
featuredimage: /img/one-does-not-simply-estimate-task-duration.jpg
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
Estimates are typically a necessary evil in software development. Unfortunately, people tend to assume that writing new software is like building a house or fixing a car, and that as such the contractor or mechanic involved should be perfectly capable of providing a reliable estimate for the work to be done in advance of the customer approving the work. This is pretty attainable by building contractors and auto mechanics, who generally are working with known materials building known things in known ways. Your auto insurance company already knows how long it should take and how much the parts should cost for just about anything you might need to fix on your car (not to mention everything about your model of car). With custom software, however, a great deal of the system is being built from scratch, and usually how it’s put together, how it ultimately works, and what exactly it’s supposed to do when it’s done are all moving targets. It’s hard to know when you’ll finish when usually the path you’ll take and the destination are both unknown at the start of the journey.

![](/img/one-does-not-simply-estimate-task-duration.jpg)

I realize that estimates are a hard problem in custom software development, and I am certainly not claiming to be the best at producing accurate estimates. However, I have identified certain aspects of estimates that I believe to be universally (or nearly) true. In typical Internet clickbait style, I’ve dubbed these “laws” of (software) estimates (“and you won’t believe what happens next!”):

## 1st Law of Estimates: Estimates are Waste

Time spent on estimates is time that isn’t spent delivering value. It’s a zero-sum game when it comes to how much time developers have to get work done – worse if estimates are being requested urgently and interrupting developers who would otherwise be “in the zone” getting things done. If your average developer is spending 2-4 hours per 40-hour week on estimates, that’s a 5-10% loss in productivity, assuming they were otherwise able to be productive the entire time. It’s even worse if the developer in question is part-time, or is only able to spend part of their work week writing software.

A few years ago, a Microsoft department was able to increase team productivity by over 150% without any new resources or changes to how the team performed software engineering tasks (design, coding, testing, etc). The primary change was in when and how tasks were estimated. Ironically, much of this estimating was at the request of management, who, seeking greater transparency and hoping for insight into how the team’s productivity could be improved, put in place policies that required frequent and timely estimates (new requests needed to be estimated within 48 hours). Even though these estimates were only ROMs (Rough Orders of Magnitude), the effort they required and the interruptions they created destroyed the team’s overall productivity. Learn more about this project in[this Microsoft white paper](http://images.itrevolution.com/images/kanbans/From_Worst_to_Best_in_9_Months_Final_1_3-aw.pdf) or David Anderson’s book, [Kanban](http://amzn.to/1P7qpI0) (learn more about kanban in my Pluralsight course, [Kanban Fundamentals](https://www.pluralsight.com/courses/kanban-fundamentals)).

## 2nd Law of Estimates: Estimates are Non-Transferable

Software estimates are not fungible, mainly as a corollary to the fact that team members are not fungible. This means one individual’s estimate can’t be used to predict how long it might take another individual to complete a task.

![](/img/estimating-things-you-know-nothing-about.jpg)

What’s even worse than having to complete an estimate written by another developer on your team is being held to a deadline based on an estimate produced by a salesperson whose incentive is to win the sale, not deliver a realistic estimate.

![](/img/estimates-deadlines.jpg)

The transferability of estimates is obviously improved when the estimator and the implementer have similar experience levels, and even moreso when they work together on the same team. Some techniques, like [planning poker](https://en.wikipedia.org/wiki/Planning_poker), will try to bring in the entire team’s experience when estimating tasks, ensuring estimates don’t miss key considerations known to only some team members or that they’re written as if the fastest coder would be assigned every task. This can help produce estimates, or estimate ranges (uncertainty is a part of estimating – see the 3rd Law below), that are more likely to be accurate, but it does so by multiplying the time spent on estimating by the entire team’s size.

## 3rd Law of Estimates: Estimates are Wrong

Estimates aren’t promises. They’re guesses, and generally the larger the scope and the further in the future the activity being estimated is, the greater the potential error. This is known as the [Cone of Uncertainty](http://www.construx.com/Thought_Leadership/Books/The_Cone_of_Uncertainty/).

![](/img/080906.ike_.path_.jpg)

Possible paths expand the further into future one tries to predict

**Nobody should be surprised when estimates are wrong; they should be surprised when they are *right*. If estimates were always accurate, they’d be called *exactimates*.**

![](/img/estimates-way-off.jpg)

Since smaller and more immediate tasks can be estimated more accurately than larger or more future tasks, it makes sense to break tasks down into small pieces. Ideally, individual sub-features that a user can interact with and test should be the unit of measuring progress, and when these are built as [vertical slices](http://deviq.com/vertical-slices/), it is possible to get rapid feedback on newly developed functionality from the client or product owner. [Queueing theory](https://en.wikipedia.org/wiki/Queueing_theory) also suggests that throughput increases when the work in the system is small and uniform in size, which further argues in favor of breaking things down into reasonably small and consistent work items.

Estimates of individual work items and projects tend to get more accurate the closer the work is to being completed. The most accurate estimate, like the most accurate weather prediction, tells you about what happened yesterday, not what will happen in the future.

## 4th Law of Estimates: Estimates are Temporary

Estimates are perishable. They have a relatively short shelf-life. A developer might initially estimate that a certain feature will take a week to develop, before the project has started. Three months into the project, a lot has been learned and decided, and that same feature might now take a few hours, or a month, or it might have been dropped from the project altogether due to changes in priorities or direction. In any case, the estimate is of little or perhaps even negative value since so much has potentially changed since it was created.

To address this issue, some teams and development methodologies recommend re-estimating all of the items in the product backlog on a regular basis. However, while this does address the perishable nature of estimates, it tends to exacerbate the waste identified by the 1st Law of Estimates. Would you rather have your team estimate the same backlog item, half a dozen times, while never actually starting work on it, or would you rather they deliver another feature every week? Again, see the Microsoft white paper referenced above for empirical evidence on the effect repeated estimation can have on overall team productivity.

We know from the 3rd Law of Estimates that estimates tend to grow more accurate the later they’re made (and the closer they are to the work actually being done). Thus, the longer an estimate can be reasonably delayed, the more accurate it is likely to be when it is made. This ties in closely with Lean Software Development’s principle of delaying decisions until [the last responsible moment](http://www.ben-morris.com/lean-developments-last-responsible-moment-should-address-uncertainty-not-justify-procrastination/). Estimates, too, should be performed at the last responsible moment, to ensure the highest accuracy and the least need to repeat them. In some cases, the “estimate” can in fact be done *after the work is done*, when it can be 100% accurate (at virtually zero cost!).

## 5th Law of Estimates: Estimates are Necessary

Despite the first four Laws of Estimates, estimates are often necessary. Businesses cannot make decisions about whether or not to build software without having some idea of the cost and time involved. Service companies frequently must provide an estimate as part of any proposal they make to build an application or win a project. Just because the above laws are true doesn’t magically mean estimates can go away ([\#NoEstimates](https://twitter.com/hashtag/noestimates)). However, one can better manage expectations and time spent on estimating if everybody involved, from the customer to the project manager to the sales team to the developer, understands these truths when it comes to custom software estimates.

It’s worth remembering [Goodhart’s Law](https://en.wikipedia.org/wiki/Goodhart%27s_law): “When a measure becomes a target, it ceases to be a good measure.” If accurate estimates are desired, they should not be used as commitments or deadlines. If they’re going to be used as targets, they’re going to be modified (read the comments below or on [reddit](https://www.reddit.com/r/programming/comments/3u7w9g/the_5_laws_of_software_estimates/) for examples).

## Summary

These are my 5 Laws of Software Estimates. They apply to just about every custom software project I’ve been involved with, in roles ranging from developer to architect to salesperson to customer. There’s no such thing as a free lunch, and estimates have real real costs associated with them that should be considered before making them too central to your software development process. Once sufficient high-level estimation and ROI analysis has been done for a project to be approved, additional work estimating may not deliver as much value as more rapid delivery of the actual work to be done.

As usual, Dilbert has some great comics on the topic of estimates:

* [“Let’s spend the next 4 hours reviewing the project plan.”](http://dilbert.com/strip/1994-05-22)
* [The Budget Trap](http://dilbert.com/strip/1996-07-28)

And finally, if you’ve read this far and are interested in software development, you may want to check out the[2016 Software Craftsmanship Wall Calendar, available now on Amazon](http://amzn.to/1PZ0gtg).

[Updated and published on Medium](https://medium.com/@ardalis/the-5-laws-of-software-estimates-fd13af46000b#.siynvp7y5), with fewer meme gifs.

If you’re in a position where you want a reliable estimate for a software project, and you’re having a hard time getting one from your developer/team, remember this quote (source unknown – I heard it from Ron Jeffries but he didn’t attribute it): “You can’t find someone who knows how long this will take, but you can probably find someone who will lie to you.”

Essentially: The more difficult it is for you to get an estimate, the more likely it is that when you finally do, it’s not terribly accurate.