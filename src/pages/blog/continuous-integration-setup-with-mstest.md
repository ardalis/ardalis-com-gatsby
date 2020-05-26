---
templateKey: blog-post
title: Continuous Integration Setup with MSTest
path: blog-post
date: 2008-03-18T13:31:22.602Z
description: "I’m working with a client this week to set up Continuous
  Integration for their development environment. They’re a small shop who are
  using Visual Studio 2008 Professional, and don’t intend to upgrade to Team
  Suite or Team Edition any time soon. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ci
  - Team System
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’m working with a client this week to set up Continuous Integration for their development environment. They’re a small shop who are using Visual Studio 2008 Professional, and don’t intend to upgrade to Team Suite or Team Edition any time soon. The build environment would therefore be running [CruiseControl.NET](http://ccnet.thoughtworks.com/), not Team Foundation Server. They’re not doing unit testing at the moment, but that’s something that’s being added as part of the project, so the question because whether to use MSTest, which is built into VS2008 Pro, or another unit test framework like NUnit or MbUnit or csUnit or abcUnit or xyzUnit or whatever. They were leaning toward MSTest because it’s built in and has the basic functionality one needs for unit testing, but then the question arose about how to run it on the build server – and what about licensing?

**MSTest 2008 on a Build Server**

The bad news is that you still cannot just install MSTest.exe on a build machine and run it. It’s tightly coupled with Visual Studio and therefore you must install Visual Studio on the build server just for the privilege of being able to run MSTest. This is something that I believe the Visual Studio team is hoping to address in the next release of Team System, but for now it’s just something we must live with. I don’t think there are any other test frameworks that have over a 1GB install footprint, but hey that’s what you get for wanting something “built in” to the product.

The good news is that you can install Visual Studio (Pro or Team Edition for whoever or Team Suit) on the build server for use with automated builds without additional licensing requirements. As long as the developers writing the tests are using licensed copies of the proper version of Visual Studio, the build server can run it too. [This is clarified nicely in a recent post by Jeff Beehler (MS),](http://blogs.msdn.com/jeffbe/archive/2008/03/18/licensing-team-system-editions-for-your-build-machine.aspx) who also references the [VSTS Licensing Whitepaper](http://www.microsoft.com/downloads/details.aspx?familyid=1FA86E00-F0A3-4290-9DA9-6E0378A3A3C5&displaylang=en#filelist).

<!--EndFragment-->