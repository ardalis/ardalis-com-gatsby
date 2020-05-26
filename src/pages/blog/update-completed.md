---
templateKey: blog-post
title: Update Completed
path: blog-post
date: 2005-02-12T03:05:51.282Z
description: First off, it won’t look anything like this if your CSS file is
  cached. So if it looks goofy to you, hit CTRL-F5 to refresh all files
  including the new CSS.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - AspAlliance
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Updated the AspAlliance.com a few minutes ago. The new site looks like this:



![New AspAlliance Home Page](<>)



First off, it won’t look anything like this if your CSS file is cached. So if it looks goofy to you, hit CTRL-F5 to refresh all files including the new CSS.

I ran into one problem that threw me for a loop when I deployed. I started getting Site is Invalid errors, which I tracked down to my XslTransform class’s Load method. Apparently since the web cluster that hosts [AspAlliance.com](http://aspalliance.com/) uses a network file system (several web servers all share one file server which has the site’s files), there were some security issues. I [Googled](http://google.com/) and found these references:

[This one](http://www.developersdex.com/vb/message.asp?p=1121&r=3803535)I found first – no resolution. Then [this one](http://groups-beta.google.com/group/microsoft.public.dotnet.framework.aspnet/browse_thread/thread/a337ac052b2f431f/ce9d6acf38dce726?q=%22Invalid+Site%22+XslTransform&_done=%2Fgroups%3Fhl%3Den%26lr%3D%26q%3D%22Invalid+Site%22+XslTransform%26&_doneTitle=Back+to+Search&&d#ce9d6acf38dce726), which gave the key piece of info (thanks Bret @ MS):

*If you trust the remote XSLT, you give XsltTransform the same level of trust\
as the calling assembly by passing this.GetType().Assembly.Evidence to the\
evidence parameter of the Load method.*

Unfortunately, there isn’t an overload of the XsltTransform’s Load method that accepts just a string file path and some Evidence. So I searched a bit more and found [this post](http://fuzzysoftware.com/newsgroups.asp?action=showmsgs&group=microsoft.public.dotnet.xml&messid=26061)which gave me the XmlTextReader overload syntax, and that did the trick.

**My final code:**

```
XmlDocument docXml = new XmlDocument();\
docXml.Load(Server.MapPath(siteMapFileLocation));\
XslTransform docXsl = new XslTransform();\
XmlTextReader reader = new XmlTextReader(Server.MapPath(transformFileLocation));\
docXsl.Load(reader, null, this.GetType().Assembly.Evidence);\
System.IO.Stream myStream = new System.IO.MemoryStream();\
docXsl.Transform(docXml, null, myStream);
```

Now, I’m getting tons of emails from ELMAH because I turned on admin emails. I’ve since turned it off. Has anybody modified this part of ELMAH to have it batch error messages (instead of 1/email)? Or to make it ignore 404 errors (at least for emails)? I would like to be notified of \*real\* problems with the site, but I don’t need to see every 404… Oh well, if nobody tells me they’ve already done this, which is what I expect, then I’ll do the mods myself perhaps next week.

<!--EndFragment-->