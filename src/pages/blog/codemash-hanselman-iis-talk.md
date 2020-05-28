---
templateKey: blog-post
title: CodeMash Hanselman IIS Talk
path: blog-post
date: 2008-01-10T14:28:55.630Z
description: I’m at CodeMash today and Scott Hanselman gave the afternoon
  keynote on IIS7 mashups. The talk was preceded by a very funny introduction
  Scott gave that introduced me to the LOLCode.NET language with the help of
  some LOLCats and humorous sample code.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - conference
  - Events
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’m at CodeMash today and [Scott Hanselman](http://www.hanselman.com/blog) gave the afternoon keynote on IIS7 mashups. The talk was preceded by a very funny introduction Scott gave that introduced me to the [LOLCode.NET language](http://lolcode.com/) with the help of some [LOLCats](http://lolcat.com/) and humorous sample code. The talk focused on how to hook up a PHP application in IIS7, and then enhance it with a few features by adding modules to the HTTP pipeline. For instance, authentication using ASP.NET Forms authentication was trivial to add. Url rewriting and response filters came next, also with HTTP modules managed through IIS7. Finally, output caching was added which naturally boosted the performance of the application by 100x. Scott had a nice quote (which I will likely steal) about the effect of caching that I liked:

“Running an application with caching is like shooting a bullet; running one without caching is like throwing the bullet.” The bullet’s going to go farther and faster with caching.

Another place I could really see value in the area is with legacy ASP applications. There are still a ton of legacy ASP apps out there that haven’t been (and maybe don’t need to be) upgraded to ASP.NET. Many of these would benefit from integration with ASP.NET authentication providers (this is a very common scenario) or their life could be extended if their perf were better, and adding ASP.NET output caching to them could do the trick there. Scott and I talked about this and one of us may write up an article on the topic “when we have time” but it’s definitely something to look at if you’re looking to integrate ASP with ASP.NET.

[CodeMash](http://codemash.org/) this year is doing well – the keynotes were pretty much standing room only. For the price the conference is definitely an awesome value.

<!--EndFragment-->