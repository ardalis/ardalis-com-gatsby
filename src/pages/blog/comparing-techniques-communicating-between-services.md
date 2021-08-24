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

In distributed software applications, different services or processes or apps frequently need to communicate with one another. Modern architectural trends toward microservices and containers and cloud-native apps have all increased the likelihood that apps will increasingly be deployed not as single monoliths, but as collections of related services. There are only so many different ways these applications can communicate with one another, and each choice brings with it certain benefits as well as consequences and tradeoffs. Let's consider the options and assess each one based on its relative performance, scalability, app isolation or independence, and complexity.

## A Simple Scenario

In evaluating each of the techniques and patterns shown below, consider that a user is attempting to complete a purchase of some products from a web application (A). The web application relies on a separate system (B) for product catalog information, including the latest pricing for each product. During the checkout process it needs to query the product catalog to get the latest price for the items being purchased. Ignore for a moment whether this is the optimal design for an ecommerce system and instead simply consider how this communication might take place.

## Shared Data

Traditionally, many companies would have a single database ([one database to rule them all](https://deviq.com/antipatterns/one-thing-to-rule-them-all)), and all of their applications would connect to it. Databases were expensive and mission-critical, so by having just one of them it made it easier to employ specialists to safeguard and optimize it. Today, data stores are commodities that can easily be deployed as part of any individual application or service, and it's widely understood that using a database as the primary mechanism for inter-process communication has a lot of negative impacts on service/app independence. After all, [using a single, mutable, global container for state is a well-known antipattern in software application development](https://softwareengineering.stackexchange.com/questions/148108/why-is-global-state-so-evil), but many teams didn't realize this applied to shared databases until relatively recently.

![Services Communicating via a Shared Database](img/interprocess-communication-shared-database.png)

In the ecommerce example, both the order processing service (A) and the product catalog (B) keep their data in the same database. This means that service A can simply query the appropriate table(s) to fetch the price data it needs to complete the customer's order.

### Performance

A single database can provide adequate performance for a large number of requests, especially reads. However, relational databases can see performance suffer when tables grow large and are not properly indexed, or when large amounts of updates are being applied.

### Scalability

Cloud provides allow individual databases to scale to massive sizes, though this is not without substantial costs.

### App Isolation

The biggest problem with using a shared mutable global state as the means of integration between apps is that they all become tightly coupled to the shared state provider (database). Any time the database is down, all apps are down, and any change to the database can potentially bring down any number of apps that depend on it.

### Complexity

Since most web apps need to store at least some state in an external data store, leveraging a shared data store usually doesn't add significant complexity to an application. Indeed, every app that depends on a shared database can be built just as if it were the only user of that database, with the caveat that it can't make any breaking changes to the database without potentially breaking other apps.

## Direct API Call

Call the service to get what you need.

## Direct API Call with Async Polling

Call a service and get a result, eventually.

## Async Messaging Everywhere

(need diagram)

## Local Cache with Direct API Updates from Source of Truth

## Local Cache with Update Events from Source of Truth

## Summary

