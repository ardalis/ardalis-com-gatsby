---
templateKey: blog-post
title: Caching Domain Objects Article
path: blog-post
date: 2006-04-27T11:18:49.886Z
description: "My [DotNetSlackers] news pointed me to this article on [Domain
  Objects Caching Pattern in .NET]. This is actually a pretty good article on
  caching best practices, but I did want to take exception to one statement that
  is clearly in error:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Caching
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

My [DotNetSlackers](http://dotnetslackers.com/) news pointed me to this article on [Domain Objects Caching Pattern in .NET](http://www.alachisoft.com/articles/domain_objects_caching_pattern.htm). This is actually a pretty good article on caching best practices, but I did want to take exception to one statement that is clearly in error:

> *And, your options are ASP.NET Cache, Caching Application Block in Microsoft Enterprise Library, or some commercial solution like NCache from Alachisoft. Personally, I would advise against using ASP.NET Cache since it forces you to cache from presentation layer (ASP.NET pages) which is bad.*

There is no reason why the ASP.NET Cache will not work perfectly well outside of ASP.NET pages (and outside of a presentation layer). I routinely build BLL and DAL classes, and even Console applications (just as demos of this point, but you get the idea) that use the HttpRuntime.Cache object. There is no dependency on IIS or a web server or an ASP.NET Page for the Cache object to function. All that is required is a reference to the System.Web.dll file from the project in question. This is simply an assembly, like any other, and does not make any project that refers to it any more coupled to a web server than referencing a code library of your own in Acme.Utility.dll. It’s just code.

Let me also add one further nitpick, which is that the author should really have qualified his advice a little better than saying “which is bad” with regard to caching in the presentation layer. Why is it “bad”? What’s “bad” about it? Often, adding caching in the presentation layer makes the most sense, provides the best performance gains, and is the easiest to architect thanks to some of the simple mechanisms provided by the ASP.NET Cache. It’s not always the best place to implement caching, but it’s certainly not unequivocally “bad”.

It’s a common misconception that the ASP.NET Cache is restricted to use within ASP.NET pages, which is why I wanted to call attention to this, especially since it’s being presented in a formal manner and is part of an article that on the whole seems very helpful and useful on the topic of caching.

<!--EndFragment-->