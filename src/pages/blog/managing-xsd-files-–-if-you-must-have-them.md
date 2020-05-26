---
templateKey: blog-post
title: Managing XSD Files – if you must have them
path: blog-post
date: 2007-09-05T11:53:06.613Z
description: "For an admin application I’ve been working on, we’re using a
  third-party reporting tool to serve up reports to our users over the Internet.
  The reports have a nice designer that works with XSD files in Visual Studio. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - ADO.NET
  - asp.net
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

For an admin application I’ve been working on, we’re using a third party reporting tool to serve up reports to our users over the Internet. The reports have a nice designer that works with XSD files in Visual Studio. Not particularly fond of XSDs as a means of data access, I thought I would limit the damage by having only one of them (and worse yet, the XSD file(s) have to be in the root of the website). Unfortunately, by the time we were up to our 5th or 6th report and we had about 10 DataTables and TableAdapters in the XSD file, it was generating upwards of 10,000 lines of code. This resulted in delays of 10 or more seconds just to open or save the XSD file, with the problem growing with each new entity added.

The solution, of course, was to split out the queries into separate XSD files, which we’re now organizing so there is one XSD file per report. They still need to be in the root of the site, which is lame because now there’s going to be at least a dozen of these things cluttering up the site, but at least working on each of them only takes a few seconds. If you’re working with a large XSD file and it’s getting slow, you should consider this approach.

The other immediate pain point with the XSD files is that there is now easy way to manipulate the command timeout of the SqlCommand in the generated code. You can hand-edit it in the generated .cs file, but naturally that’s gone the next time you save the XSD file. Unfortunately I haven’t determined a way to inject a longer timeout from a separate partial class or similar approach. If anyone knows of a way to control the command timeout (not connection timeout) for an XSD file, please let me know.

<!--EndFragment-->