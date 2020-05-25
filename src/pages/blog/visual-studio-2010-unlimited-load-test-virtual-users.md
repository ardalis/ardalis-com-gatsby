---
templateKey: blog-post
title: Visual Studio 2010 Unlimited Load Test Virtual Users
path: blog-post
date: 2011-03-21T22:07:00.000Z
description: "You may have heard the recent announcement that Visual Studio 2010
  Ultimate and MSDN subscribers now have access to the Visual Studio 2010 Load
  Test Feature Pack, which enables load testing of applications with unlimited
  virtual users. "
featuredpost: false
featuredimage: /img/background-2462434_1280.jpg
tags:
  - load testing
  - performance
  - Scalability
  - visual studio
category:
  - Software Development
comments: true
share: true
---
You may have heard the [recent announcement that Visual Studio 2010 Ultimate and MSDN subscribers now have access to the Visual Studio 2010 Load Test Feature Pack](http://blogs.msdn.com/b/vstsqualitytools/archive/2011/03/08/announcement-unlimited-load-testing-for-visual-studio-2010-ultimate-with-msdn-subscribers-now.aspx), which enables load testing of applications with unlimited virtual users. Unfortunately, it’s not entirely clear at first, at least to me, how to get this to work if you’ve simply installed VS2010 Ultimate and now want to take advantage of this. The first thing you will find in MSDN is the Visual Studio 2010 Load Test Feature Pack Deployment Guide, which is just a PDF:

![image](<> "image")

Of course, it’s a PDF wrapped in an EXE which only extracts but doesn’t open the resulting files. One you’ve extracted it, there’s not a lot to it – I’m not sure why it’s in subscriber downloads and not just online as an HTML page. It’s a 6-page file that has a title page, a table of contents, a page of “What is a Feature Pack?” and “What is the VS2010 Load Test Feature Pack?” and a whole page devoted to one of the only useful things in the doc:

![image](<> "image")

The other useful bit is on page 5, which describes how to configure your Test Controller with the Virtual User License Keys:

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Visual-Studio-2010-Unlimited-Load-Test-V_F1FE/image_8.png)

Of course, in my case, I don’t have a Microsoft Visual Studio Test Controller 2010 Configuration Tool listed in my All Programs anywhere. Where do I get this? A bit of searching yields this:

> [Visual Studio Agents 2010 – ISO](http://www.microsoft.com/downloads/en/details.aspx?FamilyID=a3216d2a-0530-4f6c-a7c9-0df37c54a902&displaylang=en)
>
> ##### Brief Description
>
> - - -
>
> Visual Studio Agents 2010 includes Test Controller 2010, Test Agent 2010 and Lab Agent 2010. Test Controller 2010 and Test Agent 2010 collectively enable scale-out load generation, distributed data collection, and distributed test execution. Lab Agent 2010 manages testing, workflow and network isolation for virtual machines used with Visual Studio Lab Management 2010.

It’s about 500MB, but after downloading, mounting the ISO image, and installing Test Controller 2010:

![SNAGHTML1473c443](<> "SNAGHTML1473c443")

I now have the Test Controller 2010 Configuration Tool needed. You can learn more about what you need to install in order to do various kinds of things by [reading the install guide here](http://msdn.microsoft.com/library/dd648127%28VS.100%29.aspx). After installing the Test Controller app, you need to configure it here, and then click the Manage virtual user licenses button at the bottom:

![SNAGHTML14d4224e](<> "SNAGHTML14d4224e")

Here, finally, you can enter in the license key you got from MSDN:

[![SNAGHTML14d4f761](<> "SNAGHTML14d4f761")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Visual-Studio-2010-Unlimited-Load-Test-V_F1FE/SNAGHTML14d4f761.png)

After which it should look something like this:

![SNAGHTML14d5fb73](<> "SNAGHTML14d5fb73")

And that’s it! If you weren’t already using the Test Controller tools, there’s a bit of setup involved, but if you were then it’s a pretty simple matter to enter in the key and increase the number of virtual users supported. And before you go thinking that “hey, it’s not really unlimited, it’s just set to 1000” note that you can keep on adding license keys with increments of 1000 virtual users as many times as you’d like:

![SNAGHTML14d85ee6](<> "SNAGHTML14d85ee6")

So it really is unlimited, as far as I can tell, though of course at some point you’ll reach the useful limit of users your hardware supports.

**Update (25 Mar 2011)** – Here are some screenshots of a 20 minute test run I did, adding 5 users per second, hitting the home page of a locally installed [MvcMusicStore](http://mvcmusicstore.codeplex.com/) app (my [fork](http://mvcmusicstore.codeplex.com/SourceControl/network/Forks/ssmith/MvcMusicStoreRepositoryPattern)).

First, the overall key indicators graph – I’ve moved the vertical scale to go from 0 to 24 to better show the results.

![image](<> "image")

Errors/Sec (violet, highlighted) is a good indicator of when the system has started to run into problems, and these first occur at about the 4 minute mark, and then pick up to a near-constant level around 4.5 minutes. If you’re trying to see how many users your system can support, you usually want this counter to remain at zero – the number of users shown here was 250 when the first errors began occurring according to this graph. You can also see the blue line climbing, climbing, climbing. That’s Avg. Page Time. The page I’m hitting has a threshold of 1 second for its required response time, so when this number exceeds 1 second, that’s an Error, and that’s what triggers the initial Errors/Sec. Those aren’t actually HTTP timeouts or 500 errors at that point, they’re just errors by virtue of the fact that I told the test runner that this page must execute in under 1 second.

Note what happens around the 17 minute mark, which is where the number of users just passes 1000. The blue page response time drops dramatically, while Errors/Sec goes up dramatically. The aqua line with the yellow warnings at its peaks is % Time in GC. You’ll see that it really starts thrashing at this point as well. What’s happening here is the system is truly at its limit, and the GC is thrashing. At the same time, IIS is throwing back actual 500 errors (503 Service Unavailable). The good news is, IIS can send these errors a lot faster than ASP.NET can process the home page of my app, and so the average page time drops quite a bit. You can actually drill into the graph and view a point in time, like this:

![image](<> "image")

With this zoomed-in view, it’s easy to pick out what’s going on at this instant. There’s also a summary table view:

![image](<> "image")

And a Detail view that shows each individual user request, which you can also zoom in and out of. The users’ sessions are color-coded, with red users indicating errors. In this view, you can see the first set of users who encountered page times greater than 1 second:

![image](<> "image")

And here’s what things look like around the 17 minute mark:

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Visual-Studio-2010-Unlimited-Load-Test-V_F1FE/image_21.png)

So, that shows what you can do with over 1000 virtual users hammering on a system. In this example, everything was running on localhost. I’m going to try and post some examples using multiple machines in the near future.