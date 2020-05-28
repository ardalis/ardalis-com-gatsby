---
templateKey: blog-post
title: UrlRewriter Bug Fix
path: blog-post
date: 2006-02-13T13:18:39.383Z
description: Some of you may know that I’m pretty interested in caching as a
  means to improving performance.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - C#
  - Caching
  - Cool Tools
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Some of you may know that I’m pretty interested in caching as a means to improving performance. I also try to tell everybody that will listen that the default method of accessing the ASP.NET cache, as taught in most online tutorials and courses, is wrong. I blogged about the proper [caching pattern](http://weblogs.asp.net/ssmith/archive/2003/06/20/9062.aspx) a while ago, and it’s helped others including my friend [Scott Cate for kbAlertz.com](http://scottcate.mykb.com/Article_5CB26.aspx). So, given all of that, I thought it was **pure irony** that the intermittent server error that’s been plaguing [ASPAlliance.com](http://aspalliance.com/) for a while now would end up being improper cache access. I’m using the fantastic [UrlRewriter](http://msdn.microsoft.com/asp.net/using/building/web/default.aspx?pull=/library/en-us/dnaspp/html/urlrewriting.asp) from [Scott Mitchell](http://scottonwriting.net/), and I located where I thought the bug was and asked Scott if he could get MSDN to update the article download with the fix. He’d long since heard about the error, but as yet [the fix is only on his blog](http://scottonwriting.net/sowblog/posts/1982.aspx), not with the article. Hopefully they’ll update the source article, especially since it is such a great tool for ASP.NET sites so I’m sure many others are experiencing problems as well. In the meantime, I thought I’d blog about it to give it a little bit of a visibility boost and perhaps help a few others correct their implementations (and remember, access the caching using my [caching pattern](http://weblogs.asp.net/ssmith/archive/2003/06/20/9062.aspx)!).

The [UrlRewriter cache bug fix](http://scottonwriting.net/sowblog/posts/1982.aspx):

Replace:

```
if (HttpContext.Current.Cache\[“RewriterConfig”] == null)\
HttpContext.Current.Cache.Insert(“RewriterConfig”,\
ConfigurationSettings.GetConfig(“RewriterConfig”));\
\
return (RewriterConfiguration)\
HttpContext.Current.Cache\[“RewriterConfig”];
```

With

```
RewriterConfiguration config =\
(RewriterConfiguration)HttpContext.Current.Cache\[“RewriterConfig”];\
if (config == null)\
{\
config = ConfigurationSettings.GetConfig(“RewriterConfig”);\
HttpContext.Current.Cache.Insert(“RewriterConfig”, config);\
}\
return config;
```

<!--EndFragment-->