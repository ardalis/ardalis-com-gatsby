---
templateKey: blog-post
title: Data Access Application Block (Enterprise Library)
path: blog-post
date: 2005-04-19T21:12:40.858Z
description: I used to be a big fan of the [Data Access Application Block]. It
  used to be nice, simple. It would save me a lot of repetitive code. It was a
  standalone library with basically one class I needed to learn. It just worked.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Data Access
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I used to be a big fan of the [Data Access Application Block](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dnpag2/html/daab.asp). It used to be nice, simple. It would save me a lot of repetitive code. It was a standalone library with basically one class I needed to learn. It just worked.

Enter the [Enterprise Library](http://www.microsoft.com/downloads/details.aspx?FamilyID=0325B97A-9534-4349-8038-D56B38EC394C&displaylang=en). This thing is aptly named, in that its complexity is something only an Enterprise would really want to deal with. In addition to the DAAB, the other various application blocks have been consolidated into the library. This is probably a good thing, but it would be nice if they were not all tightly coupled together now. I can no longer use the DAAB by itself (this version – naturally I can keep using the older version). Although the DAAB features a lot of improvements and enhancements, it is also a great deal more complex. Gone is the SqlHelper class and its static methods. Instead there are factories and instance objects. Gone is the simplicity of passing the connection string into the methods (and the flexibility of storing the connection string wherever I like). Instead the DAAB is tightly linked to the Configuration Application Block, which must be used to create the config file that stores the connection string information for the DAAB to use. And the Config block requires a command line Windows Forms tool to be run just to set the config file up.

I was considering using the DAAB to reduce some repetitive DB logic in a Whidbey project which is being measured, in part, on its lines of code reduction. However, I think the Enterprise Library DAAB would add to the needed lines of code, and significantly increase the complexity of the application, so at the moment I’ve decided against using it. For a ‘real’ IT application, I would probably look at it more seriously, but unfortunately for quick hobby apps, the Enterprise Library is, to me, way to cumbersome to use at this point.

<!--EndFragment-->