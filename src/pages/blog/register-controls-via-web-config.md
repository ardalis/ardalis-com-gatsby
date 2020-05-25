---
templateKey: blog-post
title: Register Controls via Web.Config
path: blog-post
date: 2005-08-27T14:35:14.886Z
description: "I had a conversation with ScottW about this about a year ago
  (almost exactly, from Iraq, no less), and yet I still keep forgetting this
  technique every time I need it. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Web.Config
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I had [a conversation with ScottW about this](http://scottwater.com/blog/archive/2004/08/29/13121) about a year ago (almost exactly, from Iraq, no less), and yet I still keep forgetting this technique every time I need it. So I’m blogging it myself this time just to try to keep it in my (online) memory bank.



**NOTE TO SELF: IF YOU WANT TO USE CONTROLS FROM APP_CODE IN A PAGE YOU NEED TO DEFINE THE REFERENCE IN WEB.CONFIG, NOT IN A <%@ Register %>BLOCK.**

Here’s a sample:

Observant readers may notice that I’m playing with Post-Cache Substitution at the moment, along with some samples from Nikhil Kothari, found [here](http://www.nikhilk.net/PostCacheSubstitution.aspx).

<!--EndFragment-->