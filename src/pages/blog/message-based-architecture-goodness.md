---
templateKey: blog-post
title: Message-Based Architecture Goodness
path: blog-post
date: 2011-02-06T03:27:00.000Z
description: Recently at Lake Quincy Media we upgraded our logging system for
  the AdSignia ad platform so that it uses messaging rather than direct SQL
  database access.
featuredpost: false
featuredimage: /img/database.jpg
tags:
  - architecture
  - cqrs
  - messaging
  - msmq
category:
  - Software Development
comments: true
share: true
---
Recently at Lake Quincy Media we upgraded our logging system for the AdSignia ad platform so that it uses messaging rather than direct SQL database access. This allows us to log much more detailed data, which we can then analyze, and also improves the performance of every ad request, since it eliminates a database call and replaces it with a local queue operation, which is much faster and less likely to suffer from any kind of contention. Prior to this, the logging information was stored in the application’s only database, which also included all of the reporting tables, user data, advertiser, site, and advertisement records, etc. The new design sets logging aside as a separate concern with its own database for storage, which also allows us to put it on different hardware from the main system. The only communication with the logging database is via services that run on each web node, check the local message queue there, and add records to the logging database from these messages.

One of the benefits of this de-coupled and message-based architecture, which is our first step toward a full Command Query Responsibility Separation (CQRS) architecture, is that the system no longer directly depends on the presence of the database. A couple of days ago, I got to experience how nice this is firsthand when I needed to take the Logging database offline, in order to move its location on disk. If the advertising software, which serves upwards of 200 requests per second, were directly communicating with this database (as it was previously), there would be no way to achieve this without some down time. In this case, down time affects thousands of publisher sites throughout the Microsoft developer web community, and thus, is a BAD THING. However, the new architecture allowed the move to occur completely transparently, and with no loss of data.

In order to service the database without a disruption in the web applications, I simply stopped the service on each web node that was pulling messages from the queue and adding them to the database. This took a few seconds. Then, I did the necessary maintenance on the database, in this case detaching it, moving the data files, and re-attaching it. Finally, I started the services. During this time, the local message queues accumulated several thousand messages corresponding to logged information that occurred during the maintenance window. Once the services were started, these queues were quickly reduced to zero as the system caught up.

Since this was the first time I was doing this, I did all of the above steps by hand, including starting and stopping the services. However, you can [use PowerShell to script the starting and stopping of services across remote servers – read how here](/starting-and-stopping-services-on-remote-servers-using-powershell).