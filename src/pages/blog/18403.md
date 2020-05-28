---
templateKey: blog-post
title: Atlas Charting Goodness
path: blog-post
date: 2006-06-05T04:24:23.177Z
description: I really love charts and statistics. Give me a decent reporting
  application and I can spend all kinds of time analyzing data this way and
  that, looking for trends.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Cool Tools
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I really love charts and statistics. Give me a decent reporting application and I can spend all kinds of time analyzing data this way and that, looking for trends. The problem is, usually you have to have a separate reporting interface, away from your main application, which limits its usability. One reason for this is that charts take up a lot of room, and so you don’t want to detract from your app’s limited UI space with charts unless the user is looking for charts (in which case you expect them head for the reports area). But, let’s face it, we users are a lazy bunch, so often times we won’t check reports as often as we ought unless they’re spoon fed to us. Wouldn’t it be cool if there were an easy way to integrate some of the most common charts and metrics into the UI of the main application, without having them consume too much of the usable space?

Enter Atlas, DHTML, and “ZoomInCharts”. Using this technique, one can add a small icon to the UI and let the user view the chart with a mouseover. Users are for more apt to mouseover something that won’t take them away from the current URL than they are to go clicking on things – clicking involves a lot more commitment than just mousing. These ZoomInCharts, as I’ve decided to refer to them, are not my idea or even my implementation. [Sonu](http://weblogs.asp.net/sonukapoor)has added them to [DotNetSlackers](http://dotnetslackers.com/), with the aid of [Garbin](http://aspadvice.com/blogs/garbin). If you go to

<http://dotnetslackers.com/>

and scroll down, look for the green bar graph icons on the left, in the News Stats box. Mouse over each of them. Notice how quickly and easily you can view all four charts, without ever having to click to go to some stats or reports url. After seeing this technique in action, I’m sold on it for a number of uses within my own applications. Kudos to these guys for such a slick implementation.

<!--EndFragment-->