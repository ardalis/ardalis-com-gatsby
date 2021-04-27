---
templateKey: blog-post
title: Little's Law
path: blog-post
date: 2020-11-24T21:20:00.000Z
description: Little's Law describes the relationship between throughput, wait time, and work-in-progress. Understanding it can help with designing and optimizing systems and processes.
featuredpost: false
featuredimage: /img/littles-law.png
tags:
  - Lean
  - Little's Law
  - kanban
category:
  - Software Development
comments: true
share: true
---

Little's Law was first described in 1954 and later proved by John Little in 1961. It is typically expressed as:

  L = λW

- L represents the "long term average" number of customers in a stationary system
- λ represents the "long term average effective arrival rate" of new customers
- W represents the average time a customer spends in the system

It's important to recognize that Little's Law is used in the realm of probability, so its effects are generally concerned with aggregates over time, not snapshots or individual cases.

Little's Law is often applied to lean methodologies and kanban. I discuss it in my [Kanban Fundamentals course on Pluralsight](https://www.pluralsight.com/courses/kanban-fundamentals). In the realm of kanban and process optimization, rather than customers, the things represented by the formula are more often work items. Applied in this fashion, you can think of the components of the equation like this:

`(number of work items in system) = (work completion rate) * (time spent in system)`

How can this be applied to a system? Let's look at two examples.

## Server load

Let's say you're designing a system and you need to make sure you have sufficient capacity for anticipated load. You know that the system is going to be busy on a certain date, with a peak of 10 requests per second for a heavily utilized service. You also know that on average the service takes 200ms to complete. If you need to ensure you have sufficient resources to handle the number of concurrent requests, all you need to do is determine the resources needed per request and apply Little's Law to see that your total number of concurrent requests is the rate (10 requests/sec) times the time spent in the system (200ms), which yields 2. Now remember 2 is the average, and the average is by definition going to be smaller than the maximum number, so plan accordingly.

## System throughput

Of course, it doesn't just work with servers. What if instead we look at team productivity. Let's imagine a software development team that delivers (on average) 10 work items per (5 day) work week. On average, a work item spends 3 days in the system. Given this information, we can determine the work in progress (WIP) of the team (2 items / day) * (3 days) = 6.

## Can you reverse engineer it?

Little's Law yields a number, L, given two other numbers, λ and W. But can you reverse them and have the equation hold? Think about Einstein's famous equation E = mc^2. You have to realize c is a constant - you can't say c = sqrt(E/m) and then optimize the speed of light by changing how much mass (or energy) you use.

With Little's Law, though, you can make some improvements to the system by reverse-engineering it and optimizing different pieces. One of the key tenets (*not* tenants) of kanban is to **Limit WIP**. Why? Because it tends to reduce the time things spend in the system, which improves flow and customer responsiveness.

What if we consider the (already very effective) software team with the WIP of 6 who deliver work at an average rate of 2 items per day. If we drop the total WIP in the system from 6 to 3, but don't change the team's effectiveness at all (so they'll still deliver 2 items/day on average), then Little's Law tells us the average time a given item will spend in the system will drop from 3 to 1.5.

## Conclusion

Little's Law is one of many equations you'll encounter if you start learning about lean, kanban, and related methodologies and processes. When applying it, you need to remember it only applies to stationary systems that are in equilibrium, and you need to keep in mind what you can change and what you can't. Limiting work in process is frequently the easiest thing to change in a system, since it can be done by eliminating intermediate queues within the process, without investing anything in new or better team members or equipment.
