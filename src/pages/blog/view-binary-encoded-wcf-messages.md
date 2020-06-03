---
templateKey: blog-post
title: View Binary Encoded WCF Messages
path: blog-post
date: 2009-12-19T19:45:00.000Z
description: If you’re doing any work with WCF (and perhaps Silverlight, for
  example, but any client will do) and you’d like to maximize the performance of
  your messages, you’re probably using binary encoding as it’s much less verbose
  than other options.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - encoding
category:
  - Software Development
comments: true
share: true
---
If you’re doing any work with WCF (and perhaps Silverlight, for example, but any client will do) and you’d like to maximize the performance of your messages, you’re probably using binary encoding as it’s much less verbose than other options. However, this makes tools like [Fiddler](http://www.fiddler2.com/fiddler2) much less useful when it comes to debugging why the thing isn’t doing what you thought it was doing, because by default Fiddler doesn’t have a useful view of such messages.

[![WCFBinaryFiddlerPlugin](/img/fiddler-wcf-binary.png)

Well, look no further. There is a [WCF Binary-encoded Message Inspector for Fiddler](http://code.msdn.microsoft.com/wcfbinaryinspector) which solves this need. It’s free and hosted on code.msdn.microsoft.com. You can read more about it on the [Functional Fun blog](http://blog.functionalfun.net/2009/11/fiddler-plug-in-for-inspecting-wcf.html).
