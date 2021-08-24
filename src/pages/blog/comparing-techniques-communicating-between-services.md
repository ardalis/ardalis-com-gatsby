---
templateKey: blog-post
title: Comparing Techniques for Communicating Between Services
date: 2021-08-24
description: There are several typical ways for two services (or microservices) to communicate with one another at runtime. Compare the various techniques and patterns, and their individual pros and cons.
path: blog-post
featuredpost: false
featuredimage: /img/comparing-techniques-communicating-between-services.png
tags:
  - cloud
  - architecture
  - microservices
  - patterns
category:
  - Software Development
comments: true
share: true
---

In distributed software applications, different services or processes or apps frequently need to communicate with one another. Modern architectural trends toward microservices and containers and cloud-native apps have all increased the likelihood that apps will increasingly be deployed not as single monoliths, but as collections of related services. There are only so many different ways these applications can communicate with one another, and each choice brings with it certain benefits as well as consequences and tradeoffs. Let's consider the options and assess each one based on its relative performance, scalability, isolation or independence, and complexity.

## Shared Data

Traditionally, many companies would have a single database, and all of their applications would connect to it. Databases were expensive and mission-critical, so by having just one of them it made it easier to employ specialists to safeguard and optimize it. Today, data stores are commodities that can easily be deployed as part of any individual application or service, and it's widely understood that using a database as the primary mechanism for inter-process communication has a lot of negative impacts on service/app independence.

## Direct API Call

Call the service to get what you need.

## Direct API Call with Async Polling

Call a service and get a result, eventually.

## Async Messaging Everywhere

(need diagram)

## Local Cache with Direct API Updates from Source of Truth

## Local Cache with Update Events from Source of Truth

## Summary

