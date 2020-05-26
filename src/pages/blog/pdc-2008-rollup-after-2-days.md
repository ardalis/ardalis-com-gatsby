---
templateKey: blog-post
title: PDC 2008 Rollup After 2 Days
path: blog-post
date: 2008-10-28T13:42:00.000Z
description: It’s the morning of Day 3 of PDC 2008 and as I’m waiting for the
  next keynote to begin, I thought I’d summarize what I’ve seen announced thus
  far this week.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - PDC
category:
  - Uncategorized
comments: true
share: true
---
It’s the morning of Day 3 of [PDC 2008](http://microsoftpdc.com/) and as I’m waiting for the next keynote to begin, I thought I’d summarize what I’ve seen announced thus far this week.

On Monday, Microsoft chief software architect Ray Ozzie announced [Windows Azure](http://azure.com/), Microsoft’s new cloud services platform that provides scalable, available application hosting and supporting services. Azure, combined with other services such as Windows Live Services and Live Mesh, can create some very compelling business value, especially for startups and organizations with applications that require burstable scalability. That is, they require large amounts of scalability during brief or seasonal periods, intermixed with periods of greatly reduced activity. Today such applications must typically be built with the necessary hardware and architecture to support the largest spike in traffic they may ever require. This requires organizations to invest heavily in infrastructure that may rarely, if ever, be required from the running application. One key value proposition of services in the cloud is that they allow companies to treat their application hosting requirements the same way they treat their electric bill, with a pay-for-use model that grows and shrinks with resource usage. Oh, and if you happen to see 0x007FFF somewhere, like on a Microsoft employee’s shirt, that’s the hex code for the azure color.

Other companies have their own cloud strategies and product offerings. One of the key differentiators of Microsoft’s Azure platform to developers like me is that it will use all of the development tools Microsoft developers are familiar with. Azure applications will behave as either standard ASP.NET applications or simple executable services, both of which are built and tested using Visual Studio 2008. In addition, the deployment story for these services is very clean, and provides both for local deployment to “the cloud on your desktop” and for uploading of packaged applications to the cloud itself. When working offline, the cloud on your desktop allows the application to be fully tested. And once it’s time to deploy for real, a staging model is used to allow the uploaded application to be fully tested, and then swapped out with the existing live application, if any, with one press of a button. If problems arise, a rollback is as simple as re-swapping the two applications.

On Tuesday, Microsoft demonstrated some of the new features that will be shipping with Windows 7, along with some upcoming improvements to Office, WPF, and Silverlight. One of the demo applications from from the BBC, and showed a very cool integration of Live Mesh, Azure, and Silverlight to create a ***Meshzurelight*** application with some pretty amazing capabilities. In Windows 7, we’ll see improvements to simple things like task bars and file management, much better multi screen support, support for multi screen in remote desktop, and some much needed updates to old favorites like MS Paint and Wordpad. Several demos involved a multi-touch display available from HP, the HP Touchsmart, available today for about $1500. This provides for a multi-touch interface that is kind of like an MS Surface on your desktop.

In addition, Scott Guthrie announced a number of improvements to Visual Studio 2010, including a WPF coding environment and integration with MEF to provide simple extensibility accomplished by simply dropping a DLL into a folder. Some new control libraries for Silverlight are now available, and ScottGu also noted that in a future version Silverlight will run out-of-browser, something I for one have been eagerly anticipating as it greatly increases the power of that platform to deliver applications.

This is my third PDC, and as usual Microsoft has done an excellent job of announcing some exciting things that are coming. In addition, the networking opportunities with Microsoft team members, exhibitors, and other attendees are the best of any shows around. Definitely if you need to choose between a PDC and another developer event in the future, I’d strongly recommend the PDC. Let’s see what Day 3 has in store today.