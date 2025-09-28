---
title: Get MSMQ Queue Counts in C#
date: "2011-11-08T00:00:00.0000000"
description: This article demonstrates a simple way to quickly retrieve the length of MSMQ queues from an ASP.NET MVC application using C#.
featuredImage: /img/msmq-queue-counts.png
---

I'm working with NServiceBus and MSMQ for one of my projects, and I wanted to be able to show a simple dashboard with the numbers of messages in each of the relevant queues for the application. Unfortunately, there isn't a simple ".Count()" method or property in the built-in System.Messaging namespace for MSMQ queues, so if you want to get the message count there are a few ways to go about it. You can use COM interop, but just as [this blog's author](http://jopinblog.wordpress.com/2008/03/12/counting-messages-in-an-msmq-messagequeue-from-c/), I didn't want to take that dependency. In the end, the result I came up with is from that post's comments, which is to specify a MessagePropertyFilter on the Queue, and then when you call GetAllMessages() it will use this filter and will avoid pulling back the full message body contents as well as avoid removing the messages from the queue. Here's my simple function for fetching the count for a given queue:

```csharp
protected int GetMessageCount(MessageQueue q)
{
 var filter = new MessagePropertyFilter()
 {
 AdministrationQueue = false,
 ArrivedTime = false,
 CorrelationId = false,
 Priority = false,
 ResponseQueue = false,
 SentTime = false,
 Body = false,
 Label = false,
 Id = false
 };
 q.MessageReadPropertyFilter = filter;
 return q.GetAllMessages().Length;
}
```

I created a simple MVC Controller to display the counts, with an action like this one:

```csharp
public ActionResult Index()
{
 string machine = Environment.MachineName;
 string [] queues = new []{machine + @"\private$\queue1",
 machine + @"\private$\queue2",
 machine + @"\private$\queue3"};

 Dictionary<string, int> qcounts = new Dictionary<string, int>();

 foreach (var queue in queues)
 {
 var messageQueue = new MessageQueue(queue);
 qcounts.Add(queue, GetMessageCount(messageQueue));
 }

 return View(qcounts);
}
```

And just to make things complete, here's the View:

```csharp
@model System.Collections.Generic.Dictionary<string,int>
@{
 ViewBag.Title ="Queue Counts";
}
<h2>Queue Counts</h2>
<table>
 <thead>
 <tr>
 <td>Queue</td>
 <td>Message Count</td>
 </tr>
 </thead>
 <tbody>
 @foreach (KeyValuePair<string, int> keyValuePair in Model)
 {
 <tr>
 <td>@keyValuePair.Key</td>
 <td>@keyValuePair.Value</td>
 </tr>
 }
 <tr>
 </tr>
 </tbody>
</table>
```

With that, you can quickly view the counts of the queues on the local machine. I'm assuming this will work for remote queues just the same, provided you have the necessary security credentials for the appdomain your web app is running under, but I admit I've not yet tried that.

Originally published on [ASPAlliance.com](http://aspalliance.com/2086_Get_MSMQ_Queue_Counts_in_C)

