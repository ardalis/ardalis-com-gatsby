---
templateKey: blog-post
title: Atlas, IIS7, and BLINQ
path: blog-post
date: 2006-06-16T04:12:01.028Z
description: Scott Guthrie presented on Atlas and BLINQ this afternoon at
  TechEd. The latest Atlas bits seem to be coming along very nicely, allowing
  standard ASP.NET controls to be decorated with functionality without the need
  to replace or modify the original controls.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Events
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Scott Guthrie](http://weblogs.asp.net/scottgu) presented on Atlas and BLINQ this afternoon at TechEd. The latest Atlas bits seem to be coming along very nicely, allowing standard ASP.NET controls to be decorated with functionality without the need to replace or modify the original controls. One nice concequence of this “add on” nature of the tool is that it can be used to correct deficiencies that were present when ASP.NET 2.0 shipped. For instance, drag-and-drop of SharePoint Web Parts for FireFox did not make it in the November 2005 RTM, but with a reference to the Atlas library on the SharePoint page, this is corrected.

Microsoft is working on an Atlas Control Toolkit, with community involvement, using their new [CodePlex](http://codeplex.com/) website as a means of managing the project with community involvement. Scott’s hope is that the toolkit will have an initial release late this year with 50–100 Atlas controls, and full source and a permissive license.

IIS7 will include a bunch of improved admin capabilities for ASP.NET sites, including the ability to manage users and roles from within IIS. On a humorous note, during the demo Scott asked the audience for some suggested roles, and I threw out “executives” since a previous request had given him Bill (gates) as his test user account. So during the demos, Scott’s adding and removing BillG to and from the executives role, not realizing how prophetic this would later turn out to be in light of [Bill’s announcement](http://news.com.com/Gates+stepping+down+from+full-time+Microsoft+role/2100-1014_3-6084396.html?tag=newsmap).

Scott’s last demo was BLINQ, which isn’t really an acronym so much as a play on words (as in, “in the blinq of an eye”). BLINQ is basically a UI generator similar to some [CodeSmith](http://codesmithtools.com/) templates or third party RAD tools like [Iron Speed Designer](http://ironspeed.com/). It’s still very simple at this point, with just a simple command line interface, but it generates LINQ-based ASP.NET database admin code for all tables in the database using either VB or C#, such that you can add/edit/delete/insert rows into the tables using standard ASP.NET grids and Atlas features. You can download BLINQ from the [ASP.NET web site](http://asp.net/).

<!--EndFragment-->