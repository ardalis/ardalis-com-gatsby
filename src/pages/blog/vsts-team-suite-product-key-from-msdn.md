---
templateKey: blog-post
title: VSTS Team Suite Product Key From MSDN
path: blog-post
date: 2006-03-10T13:04:36.529Z
description: I noticed that my Visual Studio Team Suite install on my dev
  machine was down to less than 60 days for its trial.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - VS.NET
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I noticed that my Visual Studio Team Suite install on my dev machine was down to less than 60 days for its trial. I’d completely forgotten that I’d installed it as a trial back in October or whatever when it was not quite RTM’d, so I threw in my MSDN Visual Studio Team Suite DVD and went into the Repair option, where it prompted me for a key to upgrade it to a “real” license. No problem – I went out to my MSDN Subscriptions page and went to Product Keys, but no dice. VSTS is not listed. Once again, [Rob Caron](http://blogs.msdn.com/robcaron) saves the day. If you are upgrading a trial edition using your MSDN subscription, you will find your key on the VSTS install DVD, in the vssetup folder, at the \*very\* bottom of the setup.sdb text file.

Rob’s Post: [Upgrading from Visual Studio Team Suite Trial Edition](http://blogs.msdn.com/robcaron/archive/2006/02/09/529033.aspx)

<!--EndFragment-->