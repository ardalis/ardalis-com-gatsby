---
templateKey: blog-post
title: Finding Untitled Page Titles
path: blog-post
date: 2008-01-29T14:07:13.329Z
description: 'Sadly, Microsoft decided that with the addition of the Title
  attribute on the @Page directive, it would make sense to include it by default
  with some text that one would absolutely never want to use as the title,
  "Untitled Page". '
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

Sadly, Microsoft decided that with the addition of the Title attribute on the @Page directive, it would make sense to include it by default with some text that one would absolutely never want to use as the title, "Untitled Page". They could have named it "Customer Reporting" or "My Britney Fan Page" and it would have been correct some small amount of the time – but instead they chose something about as likely to actually be useful as Class1.cs or WebForm1 (thankfully WebForm1 is gone and new projects start out with Default – **thank you, Microsoft!**).

You can [edit your page template yourself](http://msdn.microsoft.com/msdnmag/issues/06/01/CodeTemplates), of course, but almost nobody does. You can see that Untitled Page is an epidemic by doing [a simple google search limited to "Untitled Page" in the title of the page](http://www.google.com/search?hl=en&q=allintitle%3A++%22untitled+page%22).

**allintitle: "untitled page"**

This returns about 1.3M pages, and while not all of them can possibly be ASP.NET pages, I'm betting a lot of them are. You can refine this search further, for instance, to see how many of Microsoft's own pages suffer from this default title, by using the site: parameter in your search. [This search will show the 1500 or so pages on Microsoft.com that have "Untitled Page" in their page title](http://www.google.com/search?hl=en&q=allintitle%3A++%22untitled+page%22+site%3Amicrosoft.com):

**allintitle: "untitled page" site:microsoft.com**

Now, it would be great if the default title were removed – that's what I would like to see and part of the reason for this post. And in fact I should credit [Plip](http://weblogs.asp.net/plip) for mentioning this issue on a discussion list we're both on, but I wanted to take it a step further by showing developers how to find and correct this problem in their own sites in a fairly easy manner. The way to find out if your site is suffering from an infection of Untitle Page-itis is to do exactly what I did for the microsoft.com site above, but replace that domain with your own. For instance, I immediately wanted to see if any of these had slipped by me for [Lake Quincy Media's](http://lakequincy.com/) web site, the .NET advertising company I co-own. So I ran [the following search](http://www.google.com/search?hl=en&q=allintitle%3A++%22untitled+page%22+site%3Alakequincy.com):

**allintitle: "untitled page" site:lakequincy.com**

And thankfully, came back with nothing. Now that doesn't mean some password protected page here or there isn't still using the default tag – I can do a search in Visual Studio for the string as well. But this is more of an issue in public-facing pages, especially since page titles still get extra weight from search engines, so it's a good idea to put something useful in there for SEO purposes. If you've recently (say, since 2005) built an ASP.NET site, you may want to run this quick check to see if any of your pages went live without a useful title, so that you can correct the problem. If you want to take care of it at its source, replace your Web Form template in Visual Studio with one that doesn't automatically set the Title attribute. Alternately, in your [base page class](http://ardalis.com/blogs/ssmith/archive/2006/09/14/Ultimate-ASP.NET-Base-Page-Class.aspx), add something to the PreRender event handler that detects if the Title is set to "Untitled Page" and have it throw an exception. That should keep these from making it into production, too, if you want to be really sure about it.



**Related Posts:**\
[Ultimate ASP.NET Base Page Class](http://ardalis.com/blogs/ssmith/archive/2006/09/14/Ultimate-ASP.NET-Base-Page-Class.aspx)

<!--EndFragment-->