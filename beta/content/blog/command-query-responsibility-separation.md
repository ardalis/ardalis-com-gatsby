---
title: Introducing Command Query Responsibility Separation (CQRS)
date: "2011-01-11T00:00:00.0000000"
description: The Command Query Responsibility Separation (CQRS) pattern is an enterprise pattern that can be used to increase the performance, scalability, and reliability of distributed applications that may experience heavy load. This article briefly describes the pattern, along with some of the tradeoffs involved in adopting it, and demonstrates how to get started with it using NServiceBus.
featuredImage: /img/cqrs.png
---

## Introduction

The Command Query Responsibility Separation (CQRS) pattern is an enterprise pattern that can be used to increase the performance, scalability, and reliability of distributed applications that may experience heavy load. It is especially effective in situations where an immediate response is not required, or often even expected, by the user, or to offload processing that need not occur while the user is interacting directly with the system.

## The CQRS Pattern

The Command Query Responsibility Separation pattern introduces a logical separation between read and write operations within a distributed application. There are several reasons for and benefits that result from this separation, as well as some application design implications. Typically, the CQRS pattern is implemented by introducing the concept of message queues into an application, eliminating the need for direct access to the central data store for write operations for the application.

The intent of CQRS is to allow the individual nodes in a distributed application (assuming it is a web-based application, these would be the web servers) to handle user requests with a minimum of interaction with or dependency on difficult-to-scale resources (most often, the central data store, but also other resources such as sending emails). This can be achieved by creating a local read-only copy of the data the individual node requires (for Queries) and introducing a reliable messaging system that can handle writes (for Commands) in an offline, asynchronous fashion. As individual user requests come into the server, it reads data from its local store, and writes any Commands to its local message queue (which is then picked up and handled outside of the web application and its limited pipeline). The result is a huge increase in performance and scalability for the web node, since there is no longer synchronous, transactional access to a single, shared data store involved in each request.

## TANSTAAFL

Of course, There Ain't No Such Thing As A Free Lunch. As with all design decisions, there are tradeoffs involved in implementing CQRS. The first such tradeoff is in complexity - there are more moving parts in the system, resulting in more things that might go wrong, at least during the initial setup stage, and more knowledge (and time) required by staff to learn how this pattern works and architect the application appropriately. Further, there is an underlying assumption that it is OK to tell the user the wrong thing some of the time. For instance, using a CQRS architecture for an order processing system, as Amazon.com does, a customer order may be responded to with merely a "Thank you, your order has been received and is being processed" rather than an actual order confirmation. The actual confirmation is sent later, via email, once Amazon determines the item is in stock, the payment was properly processed, etc. If for some reason there is a problem with the order, then a different notification needs to be sent to the customer, who by now has probably left Amazon's site and is no longer involved in the transaction. If this is a rare exception, and if customers are OK with these kinds of things occurring from time to time, then this tradeoff is likely very acceptable. However, if the application absolutely must provide an immediate, accurate answer to the user, then this kind of"I'm working on it and will let you know later" approach may not be appropriate.

## Implementation

The easiest way I've found to get started implementing a CQRS system is to download the community edition of [NServiceBus](http://nservicebus.com/) and run through some of the samples. NServiceBus is a mature open-source application designed to minimize the amount of work needed to get started with using messaging within your applications. There is a significant learning curve involved with NServiceBus, but it's one of the easiest ways to get started.

As I write this, NServiceBus' latest version is 2.5, and there are both community and commercial versions available.

When implementing CQRS using NServiceBus, consider creating a local data store on your web server (for instance, using SQL Server Express) which only includes the data needed to be displayed currently. This data may be in a completely different format than your production database, and will often be denormalized and pre-computed so that reports and summaries can be displayed extremely quickly.

Once this data store is in place, the next step is to ensure it is periodically updated. You can do this on some kind of a scheduled basis, and depending on your application's needs this might be as simple as removing the node from the load balancer, wiping out the database, and running a fresh population script from the canonical data store. More typically, updates to the local read-only stores can be done by using a Publisher-Subscriber messaging model, in which the main data store publishes updates that are of interest to the read-only stores, and each read-only store subscribes to these messages and responds to them by updating the data in question. Typically the messages sent in this scenario do not contain the data updates themselves, but rather act as a notification to the subscriber that it needs to update its data.

The web application can continue to use SQL (assuming that's what it used before) to access its read-only data, with the only difference being the location of the data store and perhaps the schema of the tables involved (which should more closely map to the individual pages in the application).

With a local data store in place and a Pub-Sub mechanism in place to ensure these are kept up-to-date, the system will already be much more scalable, as the read load on the primary data store will be greatly reduced. The second part of the equation (which of course can be implemented first or instead of the local data store) is to remove direct writes between the application and the canonical data store.

Rather than issuing INSERT or UPDATE or DELETE commands to the data store, these commands are encapsulated into messages which are written to a local, transactional queue. These queued messages are picked up by a handler that is responsible for applying them to the data store, as well as handling any issues that may occur (including retrying the operation or handling exceptions). From the web application's point of view, rather than calling a method to perform the command, which in turn executes some SQL or calls a stored procedure, a message is created and sent. This might look something like this:

```csharp
var message = new OrderMessage(
 customerId,
 orderItems,
 shippingDetails,
 paymentDetails);

var bus = IoC.Resolve<IBus>();
bus.Send(message);
```

The configuration required to get started with NServiceBus is pretty minimal as well. For message processing, the Generic Host application provides an good starting point and can be installed as a service, with built-in profiles for dev/integration/production settings in terms of logging and persistence. For the web application, something like the following needs to run prior to the first message being sent:

```csharp
Configure.WithWeb()
.StructureMapBuilder((IContainer) container)
.Log4Net()
.XmlSerializer()
.MsmqTransport().IsTransactional(true)
.UnicastBus()
.LoadMessageHandlers()
.CreateBus()
.Start();
```

And a little bit of configuration needs to be added to web.config:

```csharp
<configuration>
 <configSections>
 <section name="MsmqTransportConfig"
 type="NServiceBus.Config.MsmqTransportConfig, NServiceBus.Core" />
 <section name="UnicastBusConfig"
 type="NServiceBus.Config.UnicastBusConfig, NServiceBus.Core" />
 <section name="Logging" type="NServiceBus.Config.Logging, NServiceBus.Core"/>
</configSections>
...
 <MsmqTransportConfig InputQueue="webinputqueue" ErrorQueue="error"
 NumberOfWorkerThreads="1"
 MaxRetries="5"
 />

 <UnicastBusConfig
 DistributorControlAddress="
 DistributorDataAddress=">
 <MessageEndpointMappings>
 <add Messages="Application.Infrastructure" Endpoint="mainqueue" />
 </MessageEndpointMappings>
 </UnicastBusConfig>

 <Logging Threshold="WARN" />
```

This is just an example, and is meant to show how little code is required to get started with sending messages from your web application and handling them from an NServiceBus Host application/service.

## Summary

In this article we've just touched on the surface of CQRS. To learn more, I highly encourage you to play with the NServiceBus samples, and watch the video and/or listen to the podcast below. Although CQRS is not currently mainstream, it is a mature pattern that has been used successfully in many high-scale web applications. I'm currently implementing it for an application that serves hundreds of requests per second and am already seeing benefits.

## References

[NServiceBus](http://nservicebus.com/)

Link no longer active: Udi Dahan on CQRS at TechEd 2010 (video)

Link no longer active: Pluralcast 27: CQRS with Chris Tavares (podcast)

Originally published on [ASPAlliance.com](http://aspalliance.com/2039_Introducing_Command_Query_Responsibility_Separation_CQRS)

