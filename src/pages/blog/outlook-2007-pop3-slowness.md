---
templateKey: blog-post
title: Outlook 2007 POP3 Slowness
path: blog-post
date: 2007-04-13T14:32:51.598Z
description: Outlook 2007 has a number of issues with performance, one of which
  relates to downloads taking a very long time with POP3 email accounts.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Outlook 2007
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Outlook 2007 has a number of issues with performance, one of which relates to downloads taking a very long time with POP3 email accounts. Microsoft has recently published a [KB article](http://support.microsoft.com/default.aspx?scid=kb;EN-US;935400) that should fix some scenarios where this occurs, specifically on Windows Vista, which may be caused by network hardware device(s) that do not support a networking feature called TCP Window Scaling.

The short version of this is to run this command as administrator and see if it helps your situation any:

**netsh interface tcp set global autotuninglevel=disabled**

If not, then probably your Outlook 2007 performance problems have other causes (of which there could be many), but this is worth a shot and known to greatly improve performance in some cases.

[Read the complete KB Article here](http://support.microsoft.com/default.aspx?scid=kb;EN-US;935400).

Tags: [Outlook+2007](http://technorati.com/tag/Outlook+2007)

<!--EndFragment-->