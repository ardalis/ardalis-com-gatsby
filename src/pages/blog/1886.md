---
templateKey: blog-post
title: Visual Studio Team System Class Notes
path: blog-post
date: 2005-06-29T16:07:32.383Z
description: "I’m taking a VSTS class this week at Microsoft in Columbus, Ohio.
  The course is being taught by Chris Menegay, a Microsoft Regional Director and
  principal consultant with Notion Solutions, Inc. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’m taking a VSTS class this week at Microsoft in Columbus, Ohio. The course is being taught by [Chris Menegay](http://weblogs.asp.net/cmenegay), a Microsoft Regional Director and principal consultant with [Notion Solutions, Inc](http://www.notionsolutions.com/). Chris developed the course material and works closely with the VSTS team, and seems to really know VSTS. I took some notes today but I figured they’d be more useful in electronic format, and I figured while I was doing that I may as well just blog it. Note that this is not at all indicative of what Chris focused on or taught today, but is instead just some things I found interesting and worth noting.

**VSTS**– A software life cycle tool (not a coding tool)\
– One of main goals is to increase visibility and transparency of software development\
\
– Visual Studio Professional will inherit many of the features today held by VS Enterprise Architect, since there will be no ent arch sku in the 2005 VS release.

**Team Foundation Server**\
– Designed to have only one per network (not clusterable)\
– Should scale to about 500 users\
– Underlying architecture is ASP.NET, Web Services, and SQL Server\
\
**Process Templates**– Define a lot of the behavior/rules of VSTS\
– XML format\
– Extensible\
– VSTS ships with two out of the box\
* MSF Agile — “evolve and adapt” — lightweight\
* MSF CMMI — “plan and optimize” — formal and measurable (CMMI = Capability Maturity Model Integration, whatever that means)

**Class Diagram Features** (not really VSTS, but cool)\
– No synchronization between model and code required; no metadata stored. The data representation is code.\
– Think of the class diagram as a rendering engine for your code.\
– Limitations — you can only edit class files in your project, and features like ‘Show Derived Classes’ will only show classes in your project (this is a good thing – consider if you used this feature on a framework base class like, System.Object, if its scoped wasn’t so limited)

We did some labs with whitehorse diagrams and such but that doesn’t really excite me very much. Tomorrow I think we’ll get into the testing and stress testing features, and later the build management features, which are what I’m particularly interested in at the moment. If I have time I’ll blog about those as well.

Oh, and read [Rob Caron’s blog](http://blogs.msdn.com/robcaron) if you want more info on VSTS.

<!--EndFragment-->