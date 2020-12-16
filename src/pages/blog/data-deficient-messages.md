---
templateKey: blog-post
title: Data Deficient Messages
path: blog-post
date: 2020-12-16T08:20:00.000Z
description: In distributed applications and microservices that send events or notifications to other apps or services, take care to include sufficient information in the messages themselves. Failure to do so will likely result in downstream services needing to call back to request additional details. This can result in a flood of incoming requests responding to each message, essentially denial-of-service attacking the source app.
featuredpost: false
featuredimage: /img/data-deficient-messages.png
tags:
  - .NET
  - .NET Core
  - Architecture
  - Distributed Applications
  - Microservices
category:
  - Software Development
comments: true
share: true
---

A common feature of distributed architectures is message-based communication between systems or microservices. Whether using a [message bus or queue](https://ardalis.com/bus-or-queue/), messages provide a means of reducing coupling between systems, [allowing overall systems to remain available even when some subsystems are not](https://ardalis.com/cap-pacelc-and-microservices/). However, when designing the messages that will be used in such systems, care must be taken to include sufficient information in the message to allow consuming systems to act on it, at least most of the time. Otherwise, unintended feedback loops may be created, resulting in excess load within the system.

## An Example

Consider an online shopping example in which an application is responsible for recording orders. When an order is recorded, an event is dispatched to an event bus with several subscribers. The subscribing systems need to perform additional tasks related to the order (notifications, inventory requests, etc.). Each of these downstream systems has different data requirements, but all of them need to know basic details about the order to perform their respective tasks. If the message doesn't include basic actual details of the order, then they will have no choice but to call back to the originating system to request these details (assuming it exposes an API for such purposes).

> The most obvious example of a **data deficient message** is one that includes only IDs and no other details, essentially forcing downstream systems to call back to get any additional information they might require.

![animated image of process](/img/data-deficient-messages.gif)

The result of this approach is an immediate flood of requests back to the originating app in response to each message it sends, as downstream systems request additional information. *The originating app or service can initiate a denial-of-service attack against its own API if there are enough downstream consumers of its messages and it is producing messages rapidly enough.* This is the biggest risk to the data deficient message antipattern.

## Designing Messages

Obviously you can't include every possible piece of information another system might require in your messages. But if you have at least one known consumer of the message, you can design the message so that it at least contains sufficient information for that consumer. At a minimum you might consider including the basic properties of the top level objects or [aggregates](https://deviq.com/aggregate-pattern/) involved in the operation generating the message, leaving out the rest of the object graph (navigation properties in .NET entities). This isn't a blanket recommendation - use your best judgment to determine which properties should or should not be included in messages and integration events that will be shared between [microservices](https://ardalis.com/tags/microservices/) or apps.

## Summary

Messages that cross app boundaries should include sufficient information to allow their consumers to act on them at least a majority of the time. Data deficient messages lack the data needed to perform any meaningful task in response to them without requesting additional details, and so tend to result in floods of requests for additional information from consumers. In situations with a single publisher and subscriber the impact of this may be minimal, but when a message bus with an arbitrary number of subscribers is involved, the effect is multiplied and can quickly become an issue.
