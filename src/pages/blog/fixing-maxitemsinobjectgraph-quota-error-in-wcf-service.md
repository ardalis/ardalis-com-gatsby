---
templateKey: blog-post
title: Fixing MaxItemsInObjectGraph quota Error in WCF Service
path: blog-post
date: 2011-04-28T20:18:00.000Z
description: Today isn’t the first time I’ve run into this message – I’ve fixed
  this issue before – but since this is the 2nd or more time I’ve run into it, I
  thought I’d post a quick resolution here so I can find it again later myself,
  and perhaps help some others.
featuredpost: false
featuredimage: /img/background-2462434_1280.jpg
tags:
  - WCF
category:
  - Software Development
comments: true
share: true
---
I have a WCF Service that occasionally yields a message like this one:

> Maximum number of items that can be serialized or deserialized in an object graph is ‘65536’. Change the object graph or increase the MaxItemsInObjectGraph quota.

Today isn’t the first time I’ve run into this message – I’ve fixed this issue before – but since this is the 2nd or more time I’ve run into it, I thought I’d post a quick resolution here so I can find it again later myself, and perhaps help some others. There’s [a rather long forum thread on this subject that ultimately includes the solution](http://social.msdn.microsoft.com/Forums/en-US/wcf/thread/c85f3ed2-0b55-4375-af79-5926b6cc527c), but digging it out is a bit painful as is the case with so many forum threads, so I’ll sum up here and just give you what you need.

First, you need to realize that to resolve this issue you will need configuration elements to be specified on both the client and the server. In both cases, the configuration you are looking for is going to be in a named <behavior> as part of a <dataContractSerializer> element. Your service’s configuration might look like this:

<system.serviceModel>\
<behaviors>\
<serviceBehaviors>\
<behavior name="**DefaultBehavior**" MaxItemsInObjectGraph="2147483647">\
**<dataContractSerializer maxItemsInObjectGraph="2147483647" />** <serviceMetadata httpGetEnabled="true" />\
<serviceDebug includeExceptionDetailInFaults="true" />\
</behavior>\
</serviceBehaviors>\
</behaviors>\
<services>\
<service behaviorConfiguration="**DefaultBehavior**" name="MyService">\
<endpoint address="" binding="wsHttpBinding" bindingConfiguration="WSHttpBinding_MyService" contract="IMyService">\
<identity>\
<dns value="localhost" />\
</identity>\
</endpoint>\
<endpoint address="mex" binding="mexHttpBinding" contract="IMetadataExchange" />\
</service>\
</services>\
</system.serviceModel>

I notice that my <behavior /> specifies a MaxItemsInObjectGraph value but I don’t know that that is necessary. I’ve left it here since it’s what I actually have working in production, but the solution I found online only indicates the need for the dataContractSerializer maxItemsInObjectGraph (note case) value. For the client, the configuration should look like this:

<system.serviceModel>\
<behaviors>\
<endpointBehaviors>\
<behavior name="**ClientBehavior**">\
**<dataContractSerializer maxItemsInObjectGraph="2147483647"/>** </behavior>\
</endpointBehaviors>\
</behaviors>

<client>\
<endpoint address=<http://localhost/MyService.svc>\
binding="wsHttpBinding" bindingConfiguration="WSHttpBinding_MyServiceConfiguration"\
contract="ServiceReferences.IMyService" name="WSHttpBinding_MyService"\
behaviorConfiguration="**ClientBehavior**">\
<identity>\
<dns value="localhost" />\
</identity>\
</endpoint>\
</client>\
</system.serviceModel>

Once you have these beautiful and extremely intuitive blocks of user-friendly XML in place, your WCF stuff should magically work again with larger than 65536 object graph sizes! Enjoy!