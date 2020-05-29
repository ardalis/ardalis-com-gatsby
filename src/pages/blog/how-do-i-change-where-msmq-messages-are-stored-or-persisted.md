---
templateKey: blog-post
title: How do I Change Where MSMQ Messages are Stored or Persisted?
path: blog-post
date: 2011-01-18T11:13:00.000Z
description: "If you are using MSMQ, either directly or with the help of a
  package like NServiceBus, you may encounter errors if your server becomes
  overloaded with messages either due to high load or as a result of a failure
  in your message handling process. "
featuredpost: false
featuredimage: /img/asp-net-mvc-logo.jpg
tags:
  - architecture
  - messaging
  - msmq
category:
  - Software Development
comments: true
share: true
---
If you are using MSMQ, either directly or with the help of a package like NServiceBus, you may encounter errors if your server becomes overloaded with messages either due to high load or as a result of a failure in your message handling process. If this happens, you may see exceptions like this one (ask me how I know this…):

> **System.Messaging.MessageQueueException (0x80004005): Insufficient resources to perform operation. at System.Messaging.MessageQueue.SendInternal(Object obj, MessageQueueTransaction internalTransaction, MessageQueueTransactionType transactionType) at NServiceBus.Unicast.Transport.Msmq.MsmqTransport.Send(TransportMessage m, String destination) in d:BuildAgent-01work20b5f701adefe8f8srcimplunicastNServiceBus.Unicast.MsmqMsmqTransport.cs:line 346 at NServiceBus.Unicast.UnicastBus.SendMessage(IEnumerable`1 destinations, String correlationId, MessageIntentEnum messageIntent, IMessage\[] messages) in d:BuildAgent-01work20b5f701adefe8f8srcunicastNServiceBus.UnicastUnicastBus.cs:line 593 at NServiceBus.Unicast.UnicastBus.SendMessage(String destination, String correlationId, MessageIntentEnum messageIntent, IMessage\[] messages) in d:BuildAgent-01work20b5f701adefe8f8srcunicastNServiceBus.UnicastUnicastBus.cs:line 559 at NServiceBus.Unicast.UnicastBus.NServiceBus.IBus.Send(IMessage\[] messages) in d:BuildAgent-01work20b5f701adefe8f8srcunicastNServiceBus.UnicastUnicastBus.cs:line 518**

The Insufficient resources to perform operation MessageQueueException means just what it says – the computer is out of resources. In my case, the issue was disk space.

The problem in this case was that the C drive on the server in question had filled up with messages (nearly 1 million of them, each with a fair bit of data). The default location for MSMQ messages is in **c:windowssystem32msmqstorage**, assuming that your queue is set up to be persistent, and not just in memory. If you want to change this location to a non-system drive, which I would strongly recommend, you can do so fairly easily through the MSMQ user interface. Of course, you may not know where [the MSMQ user interface is, or even how to view MSMQ messages and queues, in which case, read this](/how-can-i-view-msmq-messages-and-queues).

Once you’re at the MSMQ user interface, simply right-click on the Message Queuing item in the treeview, and select properties.

![image](<> "image")

Next, select the Storage tab, and choose whatever new location you like for the files. I recommend putting all three in the same folder on a data drive.

![image](<> "image")

There’s unfortunately no way to script this action, and if you have services that depend on message queueing, they will be restarted as part of this process (or it will try to, anyway). When you change the options on the storage tab, it takes the following actions:

* Checks that the location is valid (a local disk with correct file system, etc)
* Creates the necessary directory structure
* Sets permissions
* Moves the data to the new location

You can read more details about how this works and why you have to perform these actions through the UI, rather than scripting them, [here](http://blogs.msdn.com/b/johnbreakwell/archive/2009/02/09/changing-the-msmq-storage-location.aspx).

In my own situation, I moved things to D:msmqstorage, and I found that if I created this folder structure first, then the folder permissions were not set correctly and the message queueing service could not restart. If instead I only created the d:msmq folder and still set the folder in the UI’s textboxes to d:msmqstorage, then MSMQ successfully created the storage folder and did everything else correctly. Might have just been a fluke in my case, but if you run into problems, give that a shot.