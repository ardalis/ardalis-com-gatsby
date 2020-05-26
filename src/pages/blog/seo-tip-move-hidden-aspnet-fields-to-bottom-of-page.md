---
templateKey: blog-post
title: SEO Tip Move Hidden ASPNET Fields To Bottom of Page
path: blog-post
date: 2008-12-05T11:54:00.000Z
description: "Here’s a quick SEO tip from Teemu (via email) that I’ve been
  meaning to mention – there’s a new feature in .NET 3.5 SP1 that lets you
  control where hidden form fields are rendered by ASP.NET. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
Here’s a quick SEO tip from [Teemu](http://aspadvice.com/blogs/joteke) (via email) that I’ve been meaning to mention – there’s a new feature in .NET 3.5 SP1 that lets you control where hidden form fields are rendered by ASP.NET. To set it, go into web.config and add the following:

```
<span style="color: #0000ff">&lt;</span><span style="color: #800000">pages</span> <span style="color: #ff0000">renderAllHiddenFieldsAtTopOfForm</span><span style="color: #0000ff">=&quot;false&quot;</span> <span style="color: #0000ff">/&gt;</span>
```

The default for this is true (which is how it’s always behaved since 1.0). You can read more about it on [MSDN](http://msdn.microsoft.com/en-us/library/system.web.configuration.pagessection.renderallhiddenfieldsattopofform.aspx).

**What’s the point?**

There are pros and cons to which way you go with this setting. The default setting ensures that the data in hidden form fields like __VIEWSTATE is available early in the browser-side page loading cycle, so that if a user clicks a button and posts back the page before it has fully rendered/loaded, the server will still get the contents of these hidden fields. This is a good thing, as otherwise the server will likely be unable to process the page.

On the other hand, there’s a good argument to be made that search engines tend to weight content higher based on how close to the top of the page it is, and that in some cases search engine bots may only grab a relatively small chunk of a page (from the top) as part of their indexing process. Assuming there is some truth to this, then pushing real page content as high up in the actual HTML as possible would tend to yield better placements in search engines. Thus, setting this so that hidden fields render at the bottom of the page could make a big difference in how close the page’s real content is to the top of the HTML file, especially if there is a great deal of viewstate on the page.

**YMMV**

Your Mileage May Vary. The best way to determine whether or not this setting is of any use to you is to try it out. It’s really only appropriate for public-facing pages, and most of those shouldn’t be using ViewState or posting back in any event if they’re meant to be indexed by search engines. That said, if they’re not posting back, they really should have ViewState disabled and/or pushed to the bottom of the page since there’s really now down side to doing so.