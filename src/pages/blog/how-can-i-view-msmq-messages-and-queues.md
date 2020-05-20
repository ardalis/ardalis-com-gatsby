---
templateKey: blog-post
title: How Can I View MSMQ Messages and Queues?
path: blog-post
date: 2012-06-17T22:52:00.000Z
description: I’m working with [NServiceBus](http://nservicebus.com/) to send
  messages to and from different parts of my application. NServiceBus is a
  mature tool that sits on top of MSMQ and provides a great developer experience
  for working with a number of different scenarios.
featuredpost: false
featuredimage: /img/nature-2616213_1280.jpg
tags:
  - msmq
  - nservicebus
category:
  - Software Development
comments: true
share: true
---
I’m working with [NServiceBus](http://nservicebus.com/) to send messages to and from different parts of my application. NServiceBus is a mature tool that sits on top of MSMQ and provides a great developer experience for working with a number of different scenarios. One thing that’s challenging when working with queues is figuring out where a message went when it doesn’t show up at the other end of the message bus. Where did things go wrong? How can I see the messages in the queue for MSMQ? Is the queue set up and working?

It turns out that there is built-in support for viewing details of MSMQ baked into the MMC snap-in, though it’s not immediately obvious where to find it. It’s actually under Computer Management > Services and Applications > Message Queuing. Once you get that far, you’ll see a listing of Outgoing Queues, Private Queues, System Queues, and Triggers. You most likely are interested in Private Queues. Here’s a listing of my Private Queues on my dev machine at the moment:

![](/img/console-1.png)

If you want to look at a particular message (that no application has picked up), you can drill down into the queue and inspect the Queue messages. Double-clicking on one will show you details of its contents:

![](/img/console-2.png)

Of course, once the message is picked up off the queue, it’s no longer there for you to inspect, but NServiceBus and other frameworks provide support for Journal messages, or you could always log things to a queue that nothing is subscribed to, which would let you see the messages here any time you needed to do so.

Using a message bus in your application(s) can have huge benefits in terms of scalability and keeping your applications decoupled from one another. MSMQ is one of the obvious choices on the Microsoft Windows platform (Azure Queues are another one to consider), and NServiceBus makes working with MSMQ from .NET relatively straightforward, once you learn the basics of what you need to do.

By way of reference, here is the NServiceBus configuration responsible for 3 of the queues shown above (datapumpoutgoinginputqueue, error, mainqueue):

```
<MsmqTransportConfig
putQueue="DataPumpOutgoingInputQueue"
rorQueue="error"
mberOfWorkerThreads="1"
xRetries="5"
/>
 
<UnicastBusConfig
  DistributorControlAddress=""
  DistributorDataAddress="">
  <MessageEndpointMappings>
    <add Messages="DataPump.Infrastructure" Endpoint="MainQueue" />
  </MessageEndpointMappings>
</UnicastBusConfig>
```

The names are mine and are likely to change. This is all the configuration that was required for my web application to be able to start sending messages to a separate process (currently on the same machine, but that’s going to change once deployed). Like I said, pretty straightforward.