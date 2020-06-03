---
templateKey: blog-post
title: Windows Azure Pricing and Shared Hosting
path: blog-post
date: 2010-01-20T18:03:00.000Z
description: Windows Azure, Microsoft's cloud computing platform, has recently
  gone into production and will begin charging customers next month. You can
  keep up on Azure news and blogs at AzureFeeds.com, a community moderated
  resource.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Windows Azure
category:
  - Software Development
comments: true
share: true
---
[Windows Azure](http://azure.com/), Microsoft's cloud computing platform, has recently gone into production and will begin charging customers next month. You can keep up on [Azure news and blogs at AzureFeeds.com](http://azurefeeds.com/), a community moderated resource. One of the promises of Azure is to treat application hosting like a utility service, through which one pays for what one uses, just as with electricity or telephone usage. In fact, you'll find that, like your phone plan, there are many options to consider when trying to estimate what an application will cost while running on Azure, but there are also many ways to test out an application for free (such as via MSDN Premium). You can [learn more about Azure pricing here](http://www.microsoft.com/windowsazure/pricing). There's also a [pricing calculator application for Azure](http://azureroi.cloudapp.net/), written in Silverlight and hosted in Azure, that you may find useful.

## It's a Hotel, not Electricity

![hotel](/img/hotel.jpg)

Currently Windows Azure costs $0.12 / hour for “Compute.” There are other costs for Storage, Storage Transactions, and Data Transfers. The latter three are all pretty self-explanatory, I think, but Compute has been a source of some confusion. Many assume that this corresponds to some kind of CPU load, and that therefore if they have a low-impact application that sits idle (but on and available) most of the month, they would only need to pay for a small fraction of the actual time their application was running. However,**Windows Azure Compute time is calculated like a Hotel room**– you're paying for the reservation whether you use the room or not. You will pay the same for your blog that never uses more than 2% of the CPU as you will for a busy data-crunching application that's constantly at 80+% CPU. Just like you'll pay the same for a night booked at a hotel whether you end up crashing there or just staying out all night. In both cases, you're consuming resources by virtue of the fact that they are reserved for your use, and cannot be committed to other customers.

## Minimum Monthly Cost

If you're thinking about hosting your blog on Windows Azure, you should understand that it's going to probably cost more than your ultra-cheap shared hosting plan at one of the many .NET hosting companies. But that's not really an apples-to-apples comparison, since Windows Azure is all about having an abstracted application fabric that allows for linear, elastic scalability. That's not available for $9.95 from your hosting company's shared web site plan. Last summer,[Chris Pietschmann calculated that his blog would cost about $99/mo to host on Azure](http://pietschsoft.com/post/2009/07/14/Minimum-Hosting-Cost-for-Windows-Azure.aspx). I'm not sure that's still exactly correct now, but I think it's still in the ballpark.

## The Hotel Metaphor Breaks Down

If you've ever traveled with a bunch of buddies on a road trip, conference, vacation, or whatever on the cheap where you've all shared one or two hotel rooms, you know that your per-person cost on a hotel can go down dramatically when you start packing people into the rooms. That $99 hotel room split 5 ways is under 20 bucks. Likewise, if you decide to host your blog, along with several other family members' or coworkers' blogs, and maybe a couple of other hobby apps you're working on, all in one Azure instance, now that relatively high price tag starts to get very reasonable. Unfortunately, the current version of Azure requires everybody to have their own hotel room. Your web Azure web role is going to have one, and only one, domain address (e.g. [http://codeproject.cloudapp.net](http://codeproject.cloudapp.net/)), and that corresponds to one ASP.NET application.

Now, you're certainly welcome to write ASP.NET code to detect what URL the user entered and render something different accordingly. However, that's a lot of work and tends to make it difficult to use third party applications (like an open source ASP.NET blog framework, for instance). What's really needed is a way to have a single Web Role in Azure allow for multiple different web applications, just as a single virtual server can host multiple web sites (each with a separate IP address, port, and/or host header). I hope that we will see support for what I call a Shared Web Role in v2 (or 1.1?) of Windows Azure.

[http://www.flickr.com/photos/lori_greig/](http://www.flickr.com/photos/lori_greig)/[CC BY-ND 2.0](http://creativecommons.org/licenses/by-nd/2.0)