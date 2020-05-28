---
templateKey: blog-post
title: ASP.NET Model View Controller Architecture
path: blog-post
date: 2007-10-16T11:31:03.808Z
description: "A little while ago, Scotts [Guthrie] and [Hanselman] presented on
  MVC in ASP.NET (and Dynamic Languages) at the oddly named ALT.NET conference
  in Texas. I’m [with ScottH that “Alt” is a pretty silly name and something
  like Agile or Pragmatic would be a much better descriptor] "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - announcement
  - asp.net
  - tdd
  - Test Driven Development
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

A little while ago, Scotts [Guthrie](http://weblogs.asp.net/scottgu) and [Hanselman](http://www.hanselman.com/blog) presented on MVC in ASP.NET (and Dynamic Languages) at the oddly named ALT.NET conference in Texas. I’m [with ScottH that “Alt” is a pretty silly name and something like Agile or Pragmatic would be a much better descriptor](http://www.hanselman.com/blog/ScottGuMVCPresentationAndScottHaScreencastFromALTNETConference.aspx). Alternative is not terribly descriptive since anything that differs from the norm is alternative, and not necessarily better. It reminds me of how all music sought to be “alternative” regardless of its actual style just to earn cool points. And nevermind that calling something alt.net and not actually owning that domain name is just asinine. Incidentally, you can find the conference’s actual domain at [http://altnetconf.com](http://altnetconf.com/).

As regards the conference, ScottH was good enough to record ScottGu and his own sessions, which he’s made available for direct download (from Microsoft no less):

[Scott Guthrie on MVC (about 70 minutes)](http://download.microsoft.com/download/f/0/8/f0830f07-44db-4eea-ace3-8865856c8d65/ScottGuOnMVCatALTNET.wmv)

[Scott Hanselman on DLR and MVC (about 30 minutes)](http://download.microsoft.com/download/f/0/8/f0830f07-44db-4eea-ace3-8865856c8d65/ScottHaOnDLRandMVCatALTNET.wmv)

If you’re an ASP.NET developer, you should definitely watch at least ScottGu’s presentation, as this is a technique that you’ll want to be familiar with when it ships, probably in Spring 2008. I don’t know that a huge number of shops will run out and adopt this approach the day it ships, but you can bet you’ll see a lot more using these techniques once Microsoft has an officially supported framework than are currently doing so.

If you’re unfamiliar with the whole [Model-View-Controller (MVC) pattern](http://en.wikipedia.org/wiki/Model-view-controller), watching the video is a great way to see it in action. The short version, in my own words, is that this pattern allows a great deal of “separation of concerns” which make up any individual web request. The typical codebehind model used in ASP.NET has a lot of tight coupling – between the URL and the physical location of the ASPX file, between the HTML emitted and the logic used to validate and display it, between the data and the controls on the page, etc. This makes it difficult to unit test individual components of ASP.NET pages today (though a [number](http://codeplex.com/plasma) of [frameworks](http://nunitasp.sourceforge.net/) are [available](http://artoftestinc.blogspot.com/2007/05/light-weight-aspnet-unit-testing-go.html) that [help](http://www.codeproject.com/useritems/WatiN.asp) with this today). By separating the handling of the URL from the display of the results from the binding of data from the web context, MVC makes it much easier to test each of these pieces in isolation, even allowing for Test Driven Development, in which the tests are written before the code. This is very exciting to followers of Agile methodologies, as it can result in much higher quality code. It is, however, a very different way of architecting web applications from the typical ASP.NET ASPX-postback-centric page paradigm, so it will take some getting used to and it will take some time for tools to become available that fit this new approach. I’m definitely excited by it, though, and hope to start using this approach for some projects of mine once bits are made available.

<!--EndFragment-->