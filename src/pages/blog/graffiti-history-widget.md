---
templateKey: blog-post
title: Graffiti History Widget
path: blog-post
date: 2008-10-22T13:48:00.000Z
description: Graffiti CMS doesn’t ship with an archive/history widget to display
  the number of posts published by month, as is common in many other blog
  engines. I’ve been looking for such a widget for several months and Keyvan
  pointed me to one a few days ago that I got up and running in just a few
  moments today.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Graffiti
category:
  - Software Development
comments: true
share: true
---
[Graffiti CMS](http://graffiticms.com/) doesn’t ship with an archive/history widget to display the number of posts published by month, as is common in many other blog engines. I’ve been looking for such a widget for several months and [Keyvan](http://nayyeri.net/) pointed me to one a few days ago that I got up and running in just a few moments today. You’ll find it linked from [this forum thread](http://support.graffiticms.com/t/170.aspx), which I’m quoting the relevant post below to make things easier for you:

![](/img/ghw1.png)

> *Okay, here is the [binary](http://theboneblog.com/files/downloads/ArchiveWidgetBinary.zip).\
> Here is a [VS2008 Solution](http://theboneblog.com/files/downloads/ArchiveWidgetSource.zip).\
> And here are the [view and layout files](http://theboneblog.com/files/downloads/ArchiveViews.zip) that I used.\
> Again, I based this on Jon Sagara’s original Archive Widget. Jon included several Plug-ins for cache invalidation. Honestly I did not look into these at all, everything seems to be functioning the way I wanted for now. As this was my first Widget, and I based it on “borrowed” code, converted to VB, I’m sure there are some things that may not be best practice. Feel free to critique, you won’t hurt my feelings.\
> Basic setup is to drop the dll in your bin folder, go into Widget section of the control panel and add it to a sidebar, choose the number of months you want displayed and your “Older Items” link text. Then create two uncategorized posts, one called “archive”, one called “olderitems”. Tweak the layout and view files I included above and you should be in business.*
>
> *Thanks-*
>
> *Greg*

Got it up and running in really about 5 minutes – very nice, and a great example of how easy it is to extend Graffiti. Thanks Greg!