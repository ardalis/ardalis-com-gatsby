---
templateKey: blog-post
title: Kanban Book Review
date: 2012-03-16
path: /kanban-book-review
featuredpost: false
featuredimage: 
tags:
  - kanban
  - review
category:
  - Productivity
  - Software Development
comments: true
share: true
---

![](/img/Kanban-book-image1.jpg)While researching material for my [Kanban Fundamentals](http://www.pluralsight-training.net/microsoft/courses/TableOfContents?courseName=kanban-fundamentals&highlight=steve-smith_kanban-fund-m2-personal*10,11,0,2,5,7,8,12,1,3,4,6,9!steve-smith_kanban-fund-m3-team*1,4,6!steve-smith_kanban-fund-m1-basic*1,0,2,8,9,4,3,5,6,7#kanban-fund-m2-personal) video [training course on Pluralsight](http://ardalis.com/training-classes), I read [Kanban: Successful Evolutionary Change for Your Technology Business](http://amzn.to/wpRfnF), by David J. Anderson. I’ve previously reviewed a couple of other related books, including [Personal Kanban](http://ardalis.com/personal-kanban-book-review) and [Scrumban](http://ardalis.com/reviewing-scrumban-the-book), if you’re interested in learning more about this topic. I would recommend Personal Kanban as the most introductory, followed by Kanban, which goes into greater depth and does a good job of building on Personal Kanban (even though it was written first). Scrumban is more advanced and is a collection of essays/blog posts that are more loosely organized than the other two books.

Getting back to Kanban, the book, I really enjoyed this book for several reasons. I’m a fan of David Anderson’s and have seen some of his presentations on lean and kanban, so I was looking forward to the book. You can [learn more about David here](http://www.agilemanagement.net). Before getting into the book, take a closer look at the image on the cover at right. Notice that the three workers’ statuses are obvious based on the board behind them. One of the beautiful effects of kanban implementation is the easy, visual communication of status to everyone without the need to ask for status reports.

The book is organized into 20 chapters spanning just over 250 pages. Different people will find different parts of the book valuable. Chapters 3-5, representing “Part 2 – Benefits of Kanban,” were my favorite, and in particular the case study presented in chapter 4, “From Worst to Best in 5 Quarters,” is particularly compelling. In it, Anderson describes a dysfunctional team that sees dramatic improvement in lead time and customer satisfaction. To wit:

> _the team had reduced the lead time to an average of 14 days against an 11-day engineering time. The due-date performance on the 25-day delivery time target was 98 percent. The throughput of requests had risen more than threefold, while lead times had dropped by more than 90 percent, and reliability improved almost as much. No changes were made to the software development or testing process. The people working \[on the team\] were unaware of any significant change._

Think about that. This team’s performance (measured in throughput, lead times, quality) was dramatically improved, and the individuals on the team were unaware of any significant change. Chapter 4 alone is enough to merit buying and reading this book if you’re involved in shipping software. I spend some time on this same case study in my Kanban Fundamentals training class, because I think it’s a great testimony to the power of these ideas in practice.

Part Three, chapters 6-15, discusses Implementing Kanban. There’s a ton of great material here for anyone interested in using kanban to improve their organization or team, from creating card walls and describing what to put on each card to negotating and establishing service level agreements with clients. One of the recommended steps to successfully implement kanban is to change the way work is delivered to and from the team implementing kanban, and establishing service level agreements with downstream collaborators is one way to accomplish this. In this section David also discusses some of the theory of queues and the need to limit work in progress, as well as how to scale kanban to larger projects.

Part Four, Making Improvements, looks at how to eliminate waste, reduce variability, keep things flowing through bottlenecks, and introduces economics to the discussion. In the simplest case, lean proponents tend to adhere to certain basic principles, like “reduce variability to increase flow” and “the ideal is one piece flow”, that is, a batch size of one with zero queues. Donald Reinertson, whom Anderson references in this section, does a great job of applying real-world economics and payoff functions to these ideals. He explains how the world of software development has very different economic payoff functions for things like variability and batch size than does a physical factory (where lean and kanban originated) in [The Principles of Product Development Flow](http://amzn.to/yzqWOR) (review coming). One term Anderson introduces in this section that I found worth noting is _failure load_.

> _Failure load is demand generated by the customer that might have been avoided through higher quality delivered earlier… Failure load still adds value. But what is important is that it adds value that should have been there already._

It seems to me that failure load is conceptually related to [technical debt](http://deviq.com/technical-debt). When you deliver software that has a large amount of technical debt, there may be resulting defects or extra resources required to modify the system that shouldn’t have been there. Fixing them, paying down the debt, adds value, but it’s value that should have been there already if the _quality_ of the software had been better.

Each chapter in the book ends with a bulleted list of takeaways that highlight the important ideas covered. Like this:

## Takeaways

- Kanban is a great book for learning about and implementing kanban for teams
- The case study in chapter 4 is, I think, worth the price of the book all by itself
- Beyond the mechanics of setting up a visual card wall or board, the book describes how to implement kanban within an organization
- Think about how much failure load your team has, and how you could reduce it
- Learn more about [kanban from Pluralsight](http://www.pluralsight-training.net/microsoft/Courses/Find?highlight=true&searchTerm=kanban)
