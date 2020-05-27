---
templateKey: blog-post
title: DevConnections Spring Slides and Demos
path: blog-post
date: 2008-04-28T01:48:55.043Z
description: "Last week I gave three presentations at the DevConnections spring
  show in Orlando. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Last week I gave three presentations at the DevConnections spring show in Orlando. I received a lot of great feedback from attendees which I definitely appreciate, especially since I was feeling a little bit bad about having run out of time in my first two talks (and overcompensating a bit on my last one, which ended a few minutes early). I definitely try to err on the side of too much content, with the idea being that if I can’t fit it all in, at least the slides and demos are there for attendees to reference, and I’m happy to answer emails with questions about any of the material.

**What’s New in ASP.NET 3.5**

[Slides and Demos](http://static.aspalliance.com/download/smith_aspconnections_AGN101_Whats_New_in_ASP.NET_3.5.zip)

My first talk was on What’s New in ASP.NET 3.5, and it was well-attended for a Tuesday 8am talk. I did make it through everything that’s actually new in ASP.NET 3.5 and VS 2008 that I had prepared – the only things I had left that I couldn’t get to were actually things that are still pre-release, like Silverlight 2 and ASP.NET MVC which I very briefly showed. There was a lot of interest in LINQ as well, and there were some good questions about LINQ-to-SQL and how to fit LINQ into existing N-Tier architectures. The recurring theme of “Are DataSets dead?” was interesting as well, and I’m sure some of the other speakers had similar discussions (I hope some of the attendees interested in the topic went to some of the LINQ-specific talks). The main content for this talk was the ListView and DataPager, along with some simple LINQDataSource stuff and LINQ demos using LINQPad. I also showed off some VS2008 new features like nested master pages and JavaScript debugging and Intellisense.



**Pragmatic ASP.NET Tips, Tricks, and Tools**

[Slides and Demos](http://static.aspalliance.com/download/smith_aspconnections_agn211_pragmatic_aspnet_tips_tricks_tools.zip)

The second talk was a tips and tricks talk, which drew from my own experience as well as a variety of blog posts and other similar talks which I tried to credit in the slide deck. One attendee came up to me at the attendee party Tuesday night, while I was standing with three other speakers, and gave me a nice ego boost (while simultaneously embarrassing me). He exclaimed that he was extremely grateful for my tips and tricks talk because it had made the conference worthwhile for him, and that “it was good to see a speaker who brought some real technical content to their presentation” or something close to that. This, with three other very good speakers standing there… I thanked him and introduced him to the other speakers and suggested he check out their excellent talks on Wednesday.

At any rate, I apologize again for running out of time with this one. I know I crammed way too much material in for a 75 minute talk, and next time perhaps I’ll consider giving a 2-part talk. Many attendees came to this one and then also went to my third talk, and since I had a few minutes left after finishing that one I actually completed the tips and tricks presentation then, for about 20-30 people who had asked for it.



**Improve User Experience with Asynchronous Processing**

[Slides and Demos](http://static.aspalliance.com/download/smith_aspconnections_APF211_Improve_User_Experience_through_Async_Processing.zip)

My third and final talk for Tuesday was on asynchronous processing in ASP.NET. I basically covered three scenarios and did so with a minimum of tangents and user discussion, allowing me to get through the material a bit quicker than expected (plus I really didn’t want to go over 3 times in one day). The first scenario was async fetching of files by the browser (increasing the number of files the browser can fetch simultaneously). The second one discussed async on the server, within ASP.NET requests, and showed a couple of different techniques for achieving this with web services and web requests. This is an important technique for both scalability and performance. The third scenario demonstrated how to defer loading of long-running user controls to the client by rendering the page quickly with empty DIVs which populate themselves using AJAX callbacks. This was the meant to be the high point of the presentation and shows an extremely cool way to achieve great usability. I didn’t get a standing ovation or anything, so I’m not sure that I effectively demonstrated how cool it is (I’ve shown it at user groups with much greater response). Perhaps by 5pm on the 2nd day of the conference everyone was worn out. I still need to write up these techniques for ASPAlliance.com but I still haven’t had a chance. For now, download the slides and demos and check it out.

<!--EndFragment-->