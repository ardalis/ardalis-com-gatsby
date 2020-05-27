---
templateKey: blog-post
title: VSTS Code Coverage Customization
path: blog-post
date: 2005-09-30T14:11:00.797Z
description: "VSTS originally used intuitive colors for code that was covered,
  code that was not covered, and code that was partially covered. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Test Driven Development
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

VSTS originally used intuitive colors for code that was covered, code that was not covered, and code that was partially covered. In beta 2, these was changed to a bunch of pastel colors, as others like [Dave Donaldson](http://loudcarrot.com/Blogs/dave) notes. Dave [explains how to switch this back to the more obvious primary colors](http://loudcarrot.com/Blogs/dave/archive/2005/09/26/5224.aspx):

To do this, go to Tools, Options, Environment, Fonts and Colors. Under the **Display Items** list, look for **Coverage Not Touched Area**, **Coverage Partially Touched Area**, and **Coverage Touched Area**. Then change the **Item Background** color for each of those as you see fit.

<!--EndFragment-->