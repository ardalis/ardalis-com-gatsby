---
templateKey: blog-post
title: Code Query Language
path: blog-post
date: 2006-05-12T04:42:20.140Z
description: http://www.practicaldot.net/en2/main.htmHave you ever wanted to run
  some metrics on your code base, to try and gauge its quality or to try and
  find bad practices?
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - C#
  - Cool Tools
  - Visual Basic
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

<http://www.practicaldot.net/en2/main.htm> Have you ever wanted to run some metrics on your code base, to try and gauge its quality or to try and find bad practices? There are some tools out there for such static analysis, such as [FxCop](http://www.gotdotnet.com/team/fxcop) and the built in tools in [VSTS](http://blogs.msdn.com/fxcop), as well as SSW’s regular expression based [Code Auditor Tool](http://www.ssw.com.au/ssw/CodeAuditor). However, another approach, using a [Code Query Language](http://www.ndepend.com/CQL.htm), seems to have a lot of potential. You can read the specification here:

<http://www.ndepend.com/CQL.htm>

For instance, one issue I have with some code analyzers is that they complain about generated code that was produced by third party tools that I have no control over. With CQL, excluding such things would be trivial, as this example query shows:

SELECTMETHODSWHERENbILInstructions>200AND!NameLike“Generated”ORDERBYNbILInstructionsDESC

The language is still very young and I haven’t seen too many people talking about it yet (which to me means there aren’t many people using it yet), but I think it has great potential as a means of querying code as if it were any other data store. The reporting possibilities for this are endless (and, as such, will likely be abused to the point of reducing productivity in the name of quality, in some projects, but such is life). Anyway, it’s definitely worth checking out. Oh, and it’s written by Patrick Smacchia, [whose book](http://www.practicaldot.net/en2/main.htm) I just plugged in [my last entry](http://ardalis.com/blogs/ssmith/archive/2006/05/12/17729.aspx).

<!--EndFragment-->