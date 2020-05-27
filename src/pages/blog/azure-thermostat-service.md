---
templateKey: blog-post
title: Azure Thermostat Service
path: blog-post
date: 2009-03-08T07:24:00.000Z
description: By now I assume most readers are familiar with Azure, Microsoft’s
  cloud service offering. Azure provides theoretically limitless scalability to
  online applications, which can be built using existing Microsoft developer
  tools and skills.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Azure
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
By now I assume most readers are familiar with [Azure](http://azure.com/), Microsoft’s cloud service offering. Azure provides theoretically limitless scalability to online applications, which can be built using existing Microsoft developer tools and skills. As part of the deployment process for an Azure application, the number of nodes required to support the application is specified (in configuration or via the web portal). There are two kinds of applications (referred to as *Roles*, unfortunately) supported with the current CTP of Azure: Web Roles and Worker Roles. Web Roles are essentially ASP.NET applications; Worker Roles are basically constantly-running services. An example deployment scenario might use 4 Web Role nodes and 1 Worker Role node used to do transaction processing.

One of the guiding principles behind Azure is that it is billed as a ***utility***. That is, you are only billed for what you use, which will be measured in terms of CPU, bandwidth, nodes, etc. in some as-yet-undetermined formula (to be announced later this year with Azure’s official release, hopefully). Since nobody knows what this formula will be, let’s just pretend that it’s $1 per node per day. In this case, the above setup of 4 Web Roles and 1 Worker Role would cost $5 per day.

Now, imagine that your Azure application suddenly gets very popular, and your Worker Role is starting to back up. Users are seeing orders processed in minutes when before they were picked up and handled within seconds. All you need to do is use the Azure portal to update the number of nodes from 1 to 2, and then wait and see if that solves the bottleneck. Assuming it does, you’ve achieved additional scalability by merely paying $1 more per day. If demand lowers, you could even return back to your original configuration. *Unlike buying more servers, it’s very easy using Azure to reduce purchased scale*.

However, this all assumes that you’re made aware of the problem, hopefully in a timely fashion. You need to put measures in place to notify you if performance is becoming a problem, so that you can manually increase the number of nodes in use by your application. While the situation is likely to change by release time, the current version of Azure cannot automatically ramp up the numbers of nodes used by the roles (Web and Worker) in your application.

**The Azure Thermostat Service**

One can easily see that there is a demand for some kind of automatic service capable of tuning the resources used by an Azure application to meet the current demand. Certain thresholds could easily be set by the application user, such as minimum nodes, maximum nodes, and perhaps min/max CPU usage. If the CPU across all nodes exceeds the maximum, add a node. If CPU usage across all nodes drops below the minimum, drop a node. This would seem to be a fairly simple task, but unfortunately not all bottlenecks revolve around CPU usage. In fact, there are probably as many different ways to identify a need to scale the application up or down as there are applications.

Rather than providing an extremely complicated way to configure the scaling habits of Azure applications, a better approach would be to expose an API that lets Azure developers gather important metrics about their application’s resource usage and also provides a way for developers to modify the current nodes used for each role. With such an API in place, it would be possible to create an Azure Thermostat service to target each application. The Thermostat would monitor resource usage by polling the service periodically, and it would be responsible for adjusting the numbers of nodes used up or down using whatever custom business logic applied to the application.

Assuming such an API is exposed, a sample Azure Thermostat application, which could be used as a starting point for anyone to use (and which could even be deployed as a separate Azure worker role itself), would make a great addition to the [AzureContrib project](http://azurecontrib.codeplex.com/).