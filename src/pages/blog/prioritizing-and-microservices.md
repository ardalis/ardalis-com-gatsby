---
templateKey: blog-post
title: Prioritizing and Microservices
date: 2021-06-15
description: A common requirement for back end systems is to be able to prioritize requests. With a small number of moving pieces, a simple prioritization system works fine. But things grow more complicated when a full microservices architecture is considered.
path: blog-post
featuredpost: false
featuredimage: /img/prioritizing-and-microservices.png
tags:
  - programming
  - software architecture
  - azure
  - microservices
category:
  - Software Development
comments: true
share: true
---

It's not unusual to have different levels of prioritization in backend systems. Imagine you have a process that generates and sends reports that users have requested. Some of these might be low-priority reports that are simply generated periodically so they're available to view, while others might be generated on demand, with a user actively waiting for the results. These could be further differentiated based on the user's role or whether they're a free user or a paying subscriber, etc.

How might such a system be architected?

## One Server

If you just have a single web server in which everything is in process, then you probably don't have much of a way to deal with these issues. Your web server will attempt to serve requests as they come in, and if some of those requests are being triggered by a service somewhere that makes requests on a schedule to generation of prepared reports, and others are being made by free and paid users, the server is going to give all of these requests equal weight. And eventually it's going to reach a scalability limit and things are going to get rapidly slower for all users involved.

The system basically looks like this:

![Basic Report WebServer](/img/report-webserver.png)

The first step to enable prioritization, then, is to decouple the handling of requests from their completion. We can't change the way HTTP works and even low-priority users should have their requests processed in a timely manner, even if the final product of their request isn't immediately available. So instead we'll complete the request quickly and let the user know their request has been received, and that they should check their inbox for the requested report when it's ready (or for the scheduled jobs, they will simply be published to their destination).

## Separate Web Server and Backend Processor

One approach to the problem now is to have each request complete quickly, but generate a command which is placed into a [priority queue](https://docs.microsoft.com/en-us/azure/architecture/patterns/priority-queue). The priority queue pattern is a variation of a typical First-In-First-Out (FIFO) message queue, except that new messages are inserted into the existing queue ahead of less important messages. Typically priority 1 is the most important, and so these messages are placed into the queue in front of priority 2 or priority 3 messages.

![Priority Queue Pattern](/img/priority-queue-pattern.png)

Adding a priority queue to the webserver-based system yields this architecture:

![Web server with back end process and priority queue](/img/webserver-backendserver-priorityqueue.png)

At this point, *as far as we know*, the commands should be processed in priority order. Assuming the report generating and sending service only pulls new items from the queue as it completes other requests, it should always pull the most important command next. If it doesn't behave this way, and instead it pulls things from the queue faster than it processes them, it's possible that lower-priority items might impact the processing of higher priority ones.

There's also the potential problem that lower priority commands may starve and never be processes, or at least not for a long, long time, if there are always higher priority commands coming in.

## Separate Web Server and Multiple Backend Processes

The address the issue of low priority commands never being processed, or because priority queues are not a feature supported by the chosen messaging infrastructure, another approach can be used. This is called the [competing consumers pattern](https://docs.microsoft.com/en-us/azure/architecture/patterns/competing-consumers), and it can use separate queues for each priority, with one or more consumers processing each queue. The processors can be scaled independently based on queue length, CPU load, etc.

![Priority Queue Pattern with Separate Queues](/img/priority-queue-separate.png)

Using separate queues based on priority would yield a design like this:

![WebServer with multiple priority queues](/img/webserver-multiple-queues.png)

This approach works well. It ensures that all priorities are serviced but that higher priority requests receive more resources. Each priority can scale independently if necessary.

But let's revisit the assumption we made above, which was that the "report service" behaves in a FIFO manner and doesn't start more work than it can handle. Let's assume rather than it being as single service, there are actually a number of microservices in play.
