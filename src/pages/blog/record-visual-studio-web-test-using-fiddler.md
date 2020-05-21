---
templateKey: blog-post
title: Record Visual Studio Web Test Using Fiddler
path: blog-post
date: 2011-05-29T20:24:00.000Z
description: "Fiddler is a great tool for examining and working with HTTP
  requests.  If you’re a web developer, it’s one of those tools that you should
  definitely be at least aware of.  "
featuredpost: false
featuredimage: /img/record-vs-1.png
tags:
  - fiddler
  - load test
  - visual studio
  - web test
category:
  - Software Development
comments: true
share: true
---
[Fiddler](http://www.fiddler2.com/Fiddler2/version.asp) is a great tool for examining and working with HTTP requests. If you’re a web developer, it’s one of those tools that you should definitely be at least aware of. The most recent version has some nice new features, like being able to very easily isolate which window or process it’s recording, so you don’t end up with a lot of noise from messengers and other background HTTP requests. The feature I want to describe for this post has actually been around for a while, so even if you’re using an older version of Fiddler, you can probably take advantage of it. That is, you can easily export a Fiddler session as a Visual Studio Web Test (or Web Performance Test).

> *In Visual Studio 2005 and 2008, these tests are called Web Tests. In Visual Studio 2010, the name was changed to Web Performance Test. The extension in either case is .webtest, and the file formats are compatible.*

Since Fiddler is a free and very small tool, it’s something you could easily provide to remote testers or technical end users who could then record sessions with it showing problems they’d encountered or scenarios that were particularly important from a performance perspective. They wouldn’t need to install or learn Visual Studio or its testing tools, but they could provide these scripts and you would be able to run them and incorporate them into your Visual Studio testing projects, ensuring that you were testing these important scenarios.

To get started, simply begin capturing traffic with Fiddler (F12 or File – Capture Traffic). Open up the site you want to record and make a few requests. If you’re using IE9 you should be able to go against localhost if necessary, but with earlier versions of IE and with some other browsers, you may need to do some additional configuration to get localhost to work. Hitting any other name, including your own machinename, should work, though. Once you have some requests, stop capturing traffic. The result should look something like this:

![](/img/record-vs-1.png)

Next, go to File – Export Sessions – All Sessions.

![](/img/record-vs-2.png)

Select the Visual Studio WebTest export format:

![](/img/record-vs-3.png)

Save the file – hit OK on the Select Plugins window.

Now, from a Visual Studio Test Project, choose Add Existing Item and add the file you just saved. You should be able to immediately run the test, like so:

![](/img/record-vs-4.png)

And there you have it. Now you or your users can record web tests using Fiddler, without the need for Visual Studio, and you can import these easily into your web projects. Enjoy!