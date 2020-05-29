---
templateKey: blog-post
title: Slack and Constraints and Optimizing Throughput
path: blog-post
date: 2008-09-21T16:13:00.000Z
description: This is my second post that’s related to my recent reading of
  Poppendiecks’ Lean Software Development– read the first one here on Delaying
  Decisions.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Optimizing
category:
  - Uncategorized
comments: true
share: true
---
This is my second post that’s related to my recent reading of [Poppendiecks’ Lean Software Development](http://www.amazon.com/exec/obidos/ASIN/9780321150783/aspalliancecom)– read the first one here on [Delaying Decisions](/delaying-decisions).

A related book (and one thing I loved about Lean Software Development were the many references to other great books, some I’d read, some not) that I’ve read and recommend is [Slack](http://www.amazon.com/exec/obidos/ASIN/0767907698/aspalliancecom), by Tom DeMarco. It’s referenced on page 81 of Lean Software Development, in reference to optimizing for flow as opposed to optimizing for utilization / efficiency.

In both books, the point is made that total throughput and resource efficiency are opposed to one another. To prove this, consider the case where you have a worker who is only 60% utilized on time-critical tasks. When you give this worker a task that takes 15 minutes, you can typically expect that it will get done in 15 minutes, and sometimes a little longer if you just gave them some other work ahead of this batch.

Now, clearly, this worker is not being used efficiently – they’re only 60% utilized on critical tasks! So management decides to assign this worker to two people, each of whom now puts their work requests into a queue, and the worker processes them FIFO as they are received. Now the worker is typically 100% utilized and the queue is never empty, with some things sitting in it for several hours during busy periods of the day. That 15 minute task you needed done now is going to take 2 hours, (but at least the worker isn’t idle at all). Overall throughput – the total time for a request to get through the system – as plummeted!

Highways, server CPUs, project schedules, and yes employees are all resources that need to have some *slack* available if they’re to be used in the most effective fashion from the point-of-view of productivity. If you measure the flow of widgets shipped or project velocity or server requests served per second and average time to last byte – you’ll find that all of these are better when resources have excess capacity than when they are 100% utilized, even though the latter is the most efficient use of those resources.

**Clearly 100% efficiency is the enemy of overall system productivity.**

Poppendiecks summarize with:

> *Just as a highway cannot provide acceptable service without some slack in capacity, so you probably are not providing your customers with the highest level of service if you have no slack in your organization.*

Highways are being used most efficiently when they are completely gridlocked, if you measure the number of cars using the resource / total area of the highway. Yet clearly from the perspective of an individual vehicle trying to get from point A to point B the highway’s throughput is far better when it is underutilized.

On the very next page, they cite the Theory of Constraints, which I’ve quoted often in my presentations on performance tuning (though I haven’t yet read the [book](http://www.amazon.com/exec/obidos/ASIN/0884271668/aspalliancecom)– it’s on my list). It relates not only to software performance, but to organizational performance as well:

> *According to the [theory of constraints](http://www.amazon.com/exec/obidos/ASIN/0884271668/aspalliancecom), the best way to optimize an organization is to focus on the throughput of the organization, because this is the key to generating profitable revenue. The way to increase throughput is to look for the current bottleneck that is slowing things down and fix it. Once that is done, find the next bottleneck and fix it. Keep this up and you will have a fast moving value stream.*

Find the bottleneck. Eliminate it. Repeat. This is performance tuning, of anything, in a nutshell.