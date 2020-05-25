---
templateKey: blog-post
title: BoundField DataFormatString attribute not working
path: blog-post
date: 2006-07-03T04:03:23.665Z
description: I was stuck with a problem a few weeks ago where my
  DataFormatString on a BoundField in an GridView was not being applied.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - DataFormatString
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I was stuck with a problem a few weeks ago where my DataFormatString on a BoundField in an GridView was not being applied. I had a chance to look at the code again today and found [this very helpful post by Raj Kaimal](http://weblogs.asp.net/rajbk/archive/2005/10/31/429090.aspx) with the fix this morning. The short answer is that you need to set HtmlEncode=”false” in order for the DataFormatString to work. The HtmlEncoding by default is designed to defeat cross site scripting attacks, but unfortunately the way it is implemented results in DataFormatString being ignored.

<!--EndFragment-->