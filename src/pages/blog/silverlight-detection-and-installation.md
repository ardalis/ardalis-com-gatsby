---
templateKey: blog-post
title: Silverlight Detection and Installation
path: blog-post
date: 2008-10-30T12:13:58.848Z
description: "[Tim Sneath] just posted some tips for [optimizing the Silverlight
  install experience] for your site’s end users. I’ve noticed many people on
  mailing lists and forums discussing (lamenting) the fact that Silverlight’s
  install process requires the user to leave the site they’re on, but this is
  not the case."
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - silverlight
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Tim Sneath](http://blogs.msdn.com/tims) just posted some tips for [optimizing the Silverlight install experience](http://blogs.msdn.com/tims/archive/2007/10/29/optimizing-the-silverlight-install-experience.aspx) for your site’s end users. I’ve noticed many people on mailing lists and forums discussing (lamenting) the fact that Silverlight’s install process requires the user to leave the site they’re on, but this is not the case. Silverlight supports two modes of installation: direct and indirect. Direct means the installer launches directly from the website the user is visiting. Indirect redirects the user to download Silverlight from its source website, after which they can return to the original site. The inplaceInstallPrompt parameter in the CreateSilverlight.js file controls whether or not the install will be direct or indirect (true=direct).

There is a [Silverlight Installation Experience Guide white paper](http://www.microsoft.com/downloads/details.aspx?FamilyId=F487DF43-1AFB-4F76-82C8-BB5ACBFFBA1B&displaylang=en) available as well to help developers become familiar with the Silverlight installation process. The download includes not just the white paper but also sample code.

<!--EndFragment-->