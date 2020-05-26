---
templateKey: blog-post
title: List Options using CSS (e.g. avoiding HTML tables)
path: blog-post
date: 2005-03-03T02:36:09.552Z
description: I’ve recently been converted to the “kill all unnecessary tags used
  for layout” camp. I’ve been working for the last couple of months on usability
  and structural improvements to [AspAlliance.com]
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - CSS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’ve recently been converted to the “kill all unnecessary

tags used for layout” camp. I’ve been working for the last couple of months on usability and structural improvements to [AspAlliance.com](http://aspalliance.com/) and have reduced the total size of each page significantly. The site **flies** now compared to a few months ago. However, it still uses a lot of TABLE tags for the main body, since I’ve thus far only had time to redo the header using DIV tags and CSS.

That said, I’m also working on a few applications that require some menu systems for the administration, and I’ve been looking at the easiest way to create a tabbed navigation (without 3rd party components, to keep things simple and if necessary redistributable without coupling). I’m amazed at the power of the UL / LI elements when coupled with CSS, and how widely these constructs are now supported. In particular, I [one site with a large selection of examples of how easily this can be done](http://css.maxdesign.com.au/listamatic). Check it out — I’m pretty sure .Text’s admin page uses one of these horizontal techniques for its tabs.

**Update:** After browsing through my CommunityServer install, I see they use [SilverOrange Labs CSS Tabs](http://labs.silverorange.com/archives/2004/may/updatedsimple), which are pretty cool, too. I may go with these!

<!--EndFragment-->