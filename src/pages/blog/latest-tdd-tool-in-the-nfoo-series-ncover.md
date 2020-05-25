---
templateKey: blog-post
title: "Latest TDD Tool in the NFoo series: NCover"
path: blog-post
date: 2004-02-22T22:16:00.000Z
description: >-
  Everybody’s talking about it, it seems (Jonathan Cogley, Jeff Key, hey, that’s
  everybody, right?).

  NCover (GDN, SF) is a new tool that analyzes source code and unit tests to provide information about test coverage — that is, how much of your code is actually being tested by your tests.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - NFoo
  - TDD Tool
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

Everybody’s talking about it, it seems ([Jonathan Cogley](http://weblogs.asp.net/jcogley/archive/2004/02/22/77867.aspx), [Jeff Key](http://weblogs.asp.net/jkey/archive/2004/01/19/60427.aspx), hey, that’s everybody, right?).

NCover ([GDN](http://www.gotdotnet.com/Community/Workspaces/Workspace.aspx?id=3122ee1a-46e7-48a5-857e-aad6739ef6b9), [SF](http://ncover.sourceforge.net/)) is a new tool that analyzes source code and unit tests to provide information about test coverage — that is, how much of your code is actually being tested by your tests. One nice feature it supports already (the SF version is 0.7 — I haven’t tried the GDN version which I just now noticed is v1.2.2) is HTML formatted reports, showing a breakdown of test coverage by namespace, with line numbers for where additional test coverage is needed. Definitely a cool tool — I’ll write more once I’ve played with the GDN version.

**Update:**

Ok, I’ve installed the GDN NCover and found that it is completely different from the SourceForge NCover. The GDN version is a command line tool that uses .NET profiling to do its thing, and simply dumps out the results in XML. It also requires some environment variables to work, it seems, and uses COM for some reason so it won’t be xcopy-deployable. The SF version is basically just a NAnt task, no command line or GUI, but it requires that code to be analyzed be modified at the source level and re-compiled with the instrumentation, which is a bit of a disadvantage. It produces both XML data and HTML reports, though, which is quite nice. And it’s easier to integrate with NAnt since that is how it was designed.

<!--EndFragment-->