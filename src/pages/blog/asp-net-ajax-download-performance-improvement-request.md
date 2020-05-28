---
templateKey: blog-post
title: ASP.NET AJAX Download Performance Improvement Request
path: blog-post
date: 2008-04-15T01:16:23.438Z
description: I’m a big fan of ASP.NET AJAX in general, but one concern I have
  and something that has forced me to use other technologies is the size of the
  library.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ajax
  - asp.net
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’m a big fan of [ASP.NET AJAX](http://asp.net/ajax) in general, but one concern I have and something that has forced me to use other technologies is the size of the library. It’s about 85kb when compressed and unfortunately that is quite large if you’re trying to include it on most every page on a site (or, much much worse, every advertisement in a [large Microsoft developer advertising network](http://lakequincy.com/)). One can certainly argue that this will be cached, and that is true, but for many sites that get most of their traffic from search engines ([ASPAlliance](http://aspalliance.com/) gets over 70% of its traffic from this), you have to assume that many users will not have the .js file cached, and that is a significant increase in the total page size.

I would like to suggest (and have done so previously, but less publicly) that it would be a good thing if the ASP.NET AJAX javascript library were hosted by Microsoft as an option. This would involve some slight changes to the coding (specifically I would add a property to the <ScriptManager> control to enable using the Microsoft provided library), and would require that Microsoft make a commitment to having the .js file available via their infrastructure. In practice this would not be very different from the distribution model that they are currently using for [Silverlight](http://silverlight.net/) deployment, but would be much smaller (per file – 85kb vs 4mb).

The chief advantage of this approach would be a huge reduction in the number of downloads of the AJAX javascript file required for clients, and an increase in performance across the board as a consequence. The likelihood that any given browser would have a cached version of the AJAX javascript would be much higher if a large number of AJAX-enabled sites referenced the Microsoft hosted AJAX library. The cost (in bandwidth) to use AJAX would go down. The performance for all AJAX-enabled web applications would go up. Clients that do not wish to cede control of the distribution of the download could continue hosting the files themselves without any change. The change in behavior of ScriptManager could easily be rolled out in an SP or as part of vNext, and would make AJAX more attractive when compared to alternate (lighter weight) JavaScript frameworks such as [jQuery](http://jquery.com/).

<!--EndFragment-->