---
templateKey: blog-post
title: Principles of Product Development Flow Book Review
path: blog-post
date: 2012-04-25T02:11:00.000Z
description: "One of the more advanced books I’ve read relating to the subjects
  of Software Development and Lean is The Principles of Product Development
  Flow: Second Generation Lean Product Development by Donald G. Reinertsen."
featuredpost: false
featuredimage: /img/economic-batch.png
tags:
  - book
  - kanban
  - lean
  - product development
  - review
category:
  - Software Development
comments: true
share: true
---
[](http://amzn.to/yzqWOR)One of the more advanced books I’ve read relating to the subjects of Software Development and Lean is [The Principles of Product Development Flow: Second Generation Lean Product Development](http://amzn.to/yzqWOR) by Donald G. Reinertsen. I recently published [a Pluralsight course on Kanban Fundamentals](http://www.pluralsight-training.net/microsoft/courses/TableOfContents?courseName=kanban-fundamentals), and as part of my research for that introductory-level course I read a few related titles, including this one. I previously reviewed some of the others:

* [Personal Kanban Book Review](http://ardalis.com/personal-kanban-book-review)
* [Kanban Book Review](http://ardalis.com/kanban-book-review)
* [Scrumban Book Review](http://ardalis.com/reviewing-scrumban-the-book)

![](/img/flow.png)

If you were looking into learning more about kanban and lean as it relates to software development projects, I would probably suggest you read them in the order I have listed above, with Principles of Product Development Flow following these. It is certainly the most advanced of the books. It also has the most to offer to any product-oriented business, and does a good job of debunking certain myths about lean as it relates to software development. Unsurprisingly, writing custom software without a script is not entirely analogous to manufacturing known goods using known techniques as quickly as possible. Reinertsen does a good job of demonstrating where and how lean manufacturing principles do not directly apply to software product development, and provides models and principles that can be applied with confidence.

Principles of Product Development Flow is organized into nine sections. The first one, The Principles of Flow, sets up the rest of the book by describing the problems with the current accepted best-practices of product development. It is in this section that the author first mentions that the book is organized into 175 principles. When I first read that, I thought it was a typo, but it is in fact correct. The book’s organization into small, cohesive principles is actually a great feature, as they are easily able to reference one another and they are easy to refer to yourself as needed. In some ways, the author’s organization of the book is akin to well-designed software, with small, focused modules organized into larger, cohesive modules.

If you’re debating whether to buy this book, this section is the one to read, as it will “sell” you on the book’s promise (not in a bad way – it does a good job of demonstrating the need for the book to exist). Just a few of the important points described are a general failure to apply basic economics to decisions relating to product development, a systemic blindness to queues in software and knowledge work development, a worship of efficiency, and a blind hostility toward all sources of variability. These, and eight other, problems are described in the first section, with the remainder of the book dedicated to solutions to these problems.

The second section focuses on the economics of how we control projects. One of the recurring themes in the book is the U-Curve, first introduced in this chapter with principle E6: The U-Curve Principle: Important trade-offs are likely to have U-curve optimizations. That is, when making a decision, it’s unlikely that only a single variable is involved – usually there are at least two worth considering. For example, when considering the optimal batch size for a given process, one should consider, at a minimum, the Holding Cost, which increases as batch sizes (and presumably time) increase, and Transaction Cost, which increases as batch sizes shrink. A typical curve is shown here.

![](/img/economic-batch.png)

Reinertsen suggests that when considering the optimal batch size, one should consider the U-Shaped Total Cost, as opposed to blindly believing that small batches are always better or striving for One Piece Flow (a nirvana of some lean approaches). Note too that these curves are merely examples, and that in order to apply this principle you must first understand the nature of the holding and transaction costs that apply to your process. You can also then work on changing the shape of these curves in order to lower your total cost, perhaps reducing transaction costs through automation.

The next eight sections of the book cover these major themes:

1. Economics
2. Queues
3. Variability
4. Batch Size
5. WIP Constraints
6. Cadence, Synchronization, and Flow Control
7. Fast Feedback
8. Decentralized Control

Again, there are 175 principles covered. A few highlights I noted include:

Principle Q14: Don’t control cycle time, control queue size. Cycle time is a trailing indicator; queue size is a leading indicator. Thus, measure and manage queue size.

Queue size multiplies the cost of delays. When we have 20 jobs in a queue, a 5 minute delay generates 100 minutes of delay time. When there are only two jobs in line, a 5 minute delay generates 10 minutes of delay time. You can apply this same logic to overloaded web servers, for which queued HTTP requests immediately result in massive performance degradation.

On variability: *We cannot add value without adding variability, but we can add variability without adding value.*

A key point in the variability chapter and the book as a whole is that small batch sizes and low variability are not universally desirable. Rather, there are economic payoff functions for each and cases where reducing batch size or variability can actually be the wrong decision, economically (which of course should be our basis for decision-making). When we do wish to reduce variability, one way to do so is by using principle V5, Variability Pooling: Overall variation decreases when uncorrelated random tasks are combined.

On WIP constraints, there are several principles that can be used to attack queues as they emerge. W9 suggests that when a queue begins to emerge, adding even inefficient resources to it can have a dramatic effect on throughput. W10 notes that part-time resources that are up-to-speed on the task at hand have great “surge” potential when needed. W11 suggests that the “Big Guns” – the best talent in the organization – be kept available to combat emerging bottlenecks rather than being over-utilized, as is typically the case in most organizations. Finally, W12 introduces the notion of “T-Shaped Resources” – team members who have a wide breadth of skill but are masters of one area, or “jack of all trades, master of ONE.” These offer great flexibility, as they can shift to other assignments as needed to combat queues.

There’s a wealth of additional information on the effects of congestion on highways and how this applies to product teams as well as comparisons of synchronized and unsynchronized batches and adjacent operations. Reinertsen uses telecommunication and Internet routing protocols as models for how to efficiently route and prioritize work packets from a source to a destination, and then shifts gears to explain how the US Marines Corps deftly combines centralization and decentralization to successfully manage warfighting in the face of extreme uncertainty. I found the many principles to be well-founded, interesting, and applicable to software deve

lopment in general and product development in particular.

Have you read the book? What did you think of it? Let us know.