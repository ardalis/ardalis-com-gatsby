---
templateKey: blog-post
title: Exporting Blog Content from Community Server
path: blog-post
date: 2011-04-27T20:12:00.000Z
description: I have some old blog content scattered around a few different
  sites, and it’s on my list for the near future to consolidate it as much as
  possible onto a single blog engine and domain – one blog to rule them all – at
  least for my own stuff.
featuredpost: false
featuredimage: /img/wordpress-589121_1280.jpg
tags:
  - wordpress
category:
  - Software Development
comments: true
share: true
---
I have some old blog content scattered around a few different sites, and it’s on my list for the near future to consolidate it as much as possible onto a single blog engine and domain – one blog to rule them all – at least for my own stuff. I wasn’t sure how to get my content out of <http://weblogs.asp.net/> but a quick email got me the answer, which I thought I’d share. To export your content from weblogs.asp.net in BlogML format, just log into your dashboard and select Syndication Settings under Global Settings. Then, click the Export button under “BlogML Export”, as shown here:

![image](<> "image")

That’s it. That will open up as a big block of XML – simply save it to a file. Then you can use a BlogML import tool to get your content into your blog of choice:

* [Orchard BlogML Import/Export Module](http://orchardproject.net/gallery/List/Modules/Orchard.Module.NGM.BlogML)
* [WordPress BlogML Importer Plugin](http://wordpress.org/extend/plugins/blogml-importer)

Hope that helps!