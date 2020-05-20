---
templateKey: blog-post
title: Bus or Queue
path: blog-post
date: 2017-01-25T04:07:00.000Z
description: "A common question I encounter is, “what is the difference between
  a message bus (or service bus) and a message queue?” "
featuredpost: false
featuredimage: /img/message-bus-760x360.png
tags:
  - architecture
  - aws
  - azure
  - bus
  - ddd
  - dddesign
  - design
  - queue
category:
  - Software Development
comments: true
share: true
---
A common question I encounter is, “what is the difference between a message bus (or[service bus](https://azure.microsoft.com/en-us/services/service-bus/)) and a message queue?” There has been some blurring of the lines between these two concepts, as some products now support features that previously belonged only to one or the other category (for instance Azure Service Bus supports both approaches).

## Message Queue

![](/img/message-queue.png)

A *message queue* receives messages from an application and makes them available to one or more other applications in a first-in-first-out (FIFO) manner. In many architectural scenarios, if application A needs to send updates or commands to applications B and C, then separate message queues can be set up for B and C. A would write separate messages to each queue, and each dependent application would read from its own queue (the message being removed upon being dequeued). Neither B nor C need to be available in order for A to send updates. Each message queue is persistent, so if an application restarts, it will begin pulling from its queue once it is back online. This helps break dependencies between dependent systems and can provide greater scalability and fault tolerance to applications.

Since the typical scenario involves a separate message queue per dependent system, adding new systems means adding more queues. Writing to new queues typically requires updating the originating application. Thus, for rapidly evolving (or complex and long-lived) applications or systems, this approach tends to violate the [Open/Closed Principle](http://deviq.com/open-closed-principle/). Since messages are typically discarded when read, it is (was – see below) unusual to share a queue among multiple different dependent applications (though a queue might be shared by multiple instances of a single application running in parallel). Thus, there is usually a 1:1 correspondence between message queues and dependent applications (endpoints).

Some modern message queue implementations (such as [Amazon SQS](https://aws.amazon.com/sqs/)) can support having a single message be read by multiple endpoints. Messages become “invisible” to applications that have read them for some period of time before actually being removed. During this time, the message can still be read by other applications. This blurs the line between queues and buses, especially as it pertains to the 1:1 correspondence between queues and destination applications.

## Message Bus

![](/img/message-bus-760x360.png)

A *message bus* or *service bus* provides a way for one (or more) application to communicate messages to one or more other applications. There may be no guarantee of first-in-first-out ordering, and subscribers to the bus can come and go without the knowledge of message senders. Thus, an application A could be written to communicate status updates to application B via a message bus. Later, application C is written that can also benefit from these updates. Application C can be configured to listen to the message bus and take action based on these updates as well, without requiring any update to application A. Unlike queues, where the sending application explicitly adds messages to every queue, a message bus uses a *publish/subscribe* model. Messages are published *to the bus*, and any application that has subscribed to that kind of message will receive it. This approach allows applications to follow the open/closed principle, since they become open to future changes while remaining closed to additional modification.

Just as with queues, subscribers can go offline, and then “catch up” on messages when they come back online. This allows for maintenance windows and increased failure tolerance between dependent applications, in addition to scalability benefits.

These are not the only definitions of these terms, but they’re how I tend to think of them. You can read a bit more about [some other differences here](http://stackoverflow.com/questions/7793927/message-queue-vs-message-bus-what-are-the-differences). Feel free to share your own experience with queues vs. buses in the comments below.