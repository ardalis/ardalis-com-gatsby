---
title: InfoPath Tidbit
date: "2003-08-07T18:49:00.0000000-04:00"
description: InfoPath forms can only be viewed and filled out by folks who have
featuredImage: img/infopath-tidbit-featured.png
---

InfoPath forms can only be viewed and filled out by folks who have InfoPath installed… or can they? As it turns out, InfoPath.xdr files are really just CAB files. This means you can use the 'expand' utility (in Windows 2000 and later, I believe) to pull out the pieces of the XDR file, one of which contains a definition of the form (actually, one.xsl file per form). With a little search-and-replace or perhaps another XSL transform, it would not be too terribly hard to convert the input controls used by InfoPath into, say, web controls, allowing the forms to be displayed via ASP.NET.

Unfortunately, that would be the closest you could get InfoPath to.NET. Although it can consume web services and is an all around very cool tool, it uses VBScript/JScript and ADO for all of its programmability. You'd think 3 years after.NET hit the scene (publicly) that a brand new application would at least support the CLR, but noooooo.

