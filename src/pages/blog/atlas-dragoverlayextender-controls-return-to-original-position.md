---
templateKey: blog-post
title: Atlas DragOverlayExtender Controls Return To Original Position
path: blog-post
date: 2006-07-27T03:22:11.788Z
description: While using the DragOverlay in a demo I ran into a problem where
  the controls I wanted to drag around the page kept on returning to their
  original position when I released my mouse button.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Atlas and Ajax
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

While using the DragOverlay in a demo I ran into a problem where the controls I wanted to drag around the page kept on returning to their original position when I released my mouse button. A quick internet search found me [Rob Garrett’s post](http://robgarrett.com/cs/blogs/software/archive/2006/05/16/1958.aspx), which describes this issue and the fix:

Basically, you can’t drag items beyond the rendered area of the HTML page. For a demo, there’s not a lot of HTML on the page, so the rendered area is quite small (and basically consists of where the controls already are). The fix for this is to force the page body to be larger, like so:

<body style=”height:100%;”>

or add this in your CSS file:

body { height : 100%; }

<!--EndFragment-->