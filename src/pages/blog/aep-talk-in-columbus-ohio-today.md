---
templateKey: blog-post
title: AEP Talk in Columbus Ohio Today
path: blog-post
date: 2006-04-13T11:29:04.852Z
description: "I drove down to Columbus Ohio to speak to the AEP (American
  Electric Power) ASP.NET User Group’s lunch meeting. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Caching
  - Events
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I drove down to Columbus Ohio to speak to the [AEP](http://aep.com/) (American Electric Power) ASP.NET User Group’s lunch meeting. There was a pretty good turnout with about 40 people present locally and another dozen or so connected in from Oklahoma via video conference. The subject was my favorite, .NET Caching Best Practices, and the presentation seemed to be well-received. You can find the [basic slide deck here](http://index.aspalliance.com/FileGallery/Presentations/Details/169_.NETCachingBestPracticesMarch2006.aspx) and more information on [ASP.NET caching here](http://aspalliance.com/ref/caching.aspx).

One question I got that was a new one for me was, “What are the limitations of caching?” Since most of my slide deck is all about how caching can be properly used to **help** your application’s performance, I think this is telling me that I need to focus a little more on some of the pitfalls. My quick answer was that caching can add overhead, can result in stale data, can result in out-of-sync state between multiple servers, and can hurt performance if it is overdone. I would also add now (though I didn’t say it today) that it adds complexity to the application and can introduce new opportunities for bugs, especially when it is not implemented properly using my [cache access pattern](http://ardalis.com/blogs/ssmith/archive/2004/04/02/1803.aspx). I have an example of the wrong way in my slide deck — I’ll try to post it in another post or as an [ASPAlliance article](http://aspalliance.com/) soon.

<!--EndFragment-->