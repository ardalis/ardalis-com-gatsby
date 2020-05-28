---
templateKey: blog-post
title: MVC Getting Started
path: blog-post
date: 2007-12-12T11:33:34.267Z
description: "[Scott Hanselman] has posted [a very well done screencast on
  getting started with Model View Controller for ASP.NET], which I watched and
  did all the code for last night."
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - mvc
  - video
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Scott Hanselman](http://www.hanselman.com/blog) has posted [a very well done screencast on getting started with Model View Controller for ASP.NET](http://www.hanselman.com/blog/ASPNET35ExtensionsPlusMVCHowToScreencast.aspx), which I watched and did all the code for last night. There was only one hangup in the code portion, which has to do with changes that were made post-production to the [MvcToolkit](http://asp.net/downloads/3.5-extensions/MVCToolkit.zip). The code given in the screencast doesn't work, but this simple fix does:

**<% using (Html.Form<ProjectName.Controllers.HomeController>(x=>x.Update(ViewData.ProductID))) { %>**

Anyway, Scott really went above and beyond on the production of this video, enough so that I wanted to call special attention to it. I told him he should do a blog post and/or screencast on screencasting (here's [one set of tips I've found](http://techsmith.com/camtasia.asp)), and I'm sure he will at some point, though perhaps not soon as he's off until January with a new arrival to his family. He used [TechSmith Camtasia 5](http://techsmith.com/camtasia.asp) for the recording and editing of the video, and some of the things that really made it stand out to me were the integration of the webcam video, along with the panning and zooming.

During portions of the screencast when not much else was going on, Scott would fade in his webcam so you could seem him talking, then fade it out once he had more interesting things to show. If he was working in the Solution Explorer portion of Visual Studio, he would pan and zoom the display to show that area. Both of these effects made the presentation much more engaging and are things I'm going to try and integrate into my own screencasts (which I usually post on [ASPAlliance Videos](http://aspalliance.com/videos)).

<!--EndFragment-->