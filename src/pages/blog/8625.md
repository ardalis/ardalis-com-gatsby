---
templateKey: blog-post
title: Handy Tracing Utility
path: blog-post
date: 2003-06-11T23:52:00.000Z
description: "There are three features I wish ASP.NET tracing had out of the box:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - logging
  - tracing
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

There are three features I wish ASP.NET tracing had out of the box:

* Check for a null context and gracefully disable if context is null (e.g. at design time)
* If I don’t specify a category, default to the name of the method in which the trace is being called.
* Automatically compile out of production code via the Conditional(“DEBUG”) attribute or something similar. Today, Trace routines carry overhead even when tracing is turned off.

To provide these features, I have a simple wrapper class. You can name the class itself whatever you like but I recommend it be something short so that you don’t have to type much to get Tracing into your code. Feel free to use this wherever you like.

I tried to paste the code here, but the editor choked on the attributes, so go view it at ASPAlliance.com from the link below.

I’ll keep this updated in article form here: [Better Tracing in ASP.NET](http://aspalliance.com/stevesmith/articles/bettertrace.asp)

<!--EndFragment-->