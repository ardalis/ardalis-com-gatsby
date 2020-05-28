---
templateKey: blog-post
title: Caching Talk in Columbus
path: blog-post
date: 2005-04-28T21:10:57.821Z
description: Gave my first presentation since over a year ago this evening to
  the [.NET Developers Group](http://www.netdevelopersgroup.org/Main.aspx) in
  Central Ohio. Seemed well-received.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Events
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Gave my first presentation since over a year ago this evening to the [.NET Developers Group](http://www.netdevelopersgroup.org/Main.aspx) in Central Ohio. Seemed well-received. It was in Columbus, Ohio, just 2 hours south of my home, and where I used to work and go to school. Thanks to [Drew](http://drewby.net/) and [Dave](http://loudcarrot.com/Blogs/dave) and Nate for having me down, and to INETA for organizing it. I think there were like 50 or so people but I’m not a great judge. There were a few questions I had that I wasn’t sure what the answer was so I’m going to list them here and either I’ll follow up with answers later or more likely somebody more knowledgeable than me will answer them:

1) Does the Yukon/Sql2005 call to Http.Sys to notify that a change has occurred use managed code? I have no idea. I’m not sure why that would matter, but the question came up so now I’m curious.

2) Another Yukon question – hmm – now I can’t even recall what it was. Drat. Next time I’ll have to be blogging during the presentation (or, \[gasp], take notes). It was definitely a Yukon internals question which I had no idea about…

The only thing that didn’t go well was my Sql Cache Invalidation with SQL2005/Yukon. I had the output caching examples working last night but they didn’t want to work for me during the presentation. And the Cache API SqlDependency with Yukon also didn’t want to work. I’ve since learned that I was doing one thing wrong in my sample code — I was new-ing the SqlCacheDependency after the command it referenced had already been executed. That’s bad. However, this evening I’ve corrected that issue and the stuff still isn’t working for me, so I’m not sure what’s up at this point. [Julia](http://www.thedatafarm.com/blog) gave me some samples a while back I’ll have to dig up and compare against.

Update: [Expire Page Output Cache Entries Article](http://aspalliance.com/668) now live.

<!--EndFragment-->