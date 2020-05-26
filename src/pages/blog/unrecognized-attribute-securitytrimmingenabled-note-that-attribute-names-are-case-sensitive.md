---
templateKey: blog-post
title: Unrecognized attribute 'securityTrimmingEnabled'. Note that attribute
  names are case-sensitive
path: blog-post
date: 2008-11-05T12:06:08.656Z
description: Saw this error today working with the SiteMapDataSource in ASP.NET
  3.5/VS2008. Apparently this is a bug that has been around for a while and is
  discussed
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Saw this error today working with the SiteMapDataSource in ASP.NET 3.5/VS2008. Apparently this is a bug that has been around for a while, and is discussed [here](http://forums.asp.net/p/901922/1170951.aspx) and logged in [Connect here](http://connect.microsoft.com/VisualStudio/feedback/ViewFeedback.aspx?FeedbackID=102255).

The issue, however, is that the securityTrimmingEnabled attribute pops up in Intellisense in VS2008 when editing the web.sitemap file. However, using it results in the error:

**Unrecognized attribute ‘securityTrimmingEnabled’. Note that attribute names are case-sensitive.**

The bug is in the VS Intellisense – it should not be showing an attribute that is not a viable option. This property is actually set on the provider and configured in web.config. The forum link above has the solution, which I’m reproducing here:

```
<siteMap defaultProvider=”XmlSiteMapProvider” enabled=”true” >\
<providers>\
<clear />\
<add name=”XmlSiteMapProvider”\
description=”Default SiteMap provider.”\
type=”System.Web.XmlSiteMapProvider”\
siteMapFile=”Web.sitemap”\
securityTrimmingEnabled=”true” />\
</providers>\
</siteMap>
```

<!--EndFragment-->