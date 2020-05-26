---
templateKey: blog-post
title: Big Update To AspAlliance
path: blog-post
date: 2005-02-12T03:07:30.270Z
description: I’m getting ready to push a big update of [AspAlliance.com]
  tonight. I’ve implemented a number of [Scott Mitchell’s] articles/samples into
  the site now, including his [UrlRewrite] article (which someone referred me to
  when I was asking about resources on the topic, and ironically this was a
  topic I felt comfortable enough with a year ago that I almost co-authored with
  Scott for the MSDN piece. Guess I’m rather rusty, ugh.)
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

I’m getting ready to push a big update of [AspAlliance.com](http://aspalliance.com/) tonight. I’ve implemented a number of [Scott Mitchell’s](http://scottonwriting.net/sowBlog) articles/samples into the site now, including his [UrlRewrite](http://scottonwriting.net/sowBlog/posts/867.aspx) article (which someone referred me to when I was asking about resources on the topic, and ironically this was a topic I felt comfortable enough with a year ago that I almost co-authored with Scott for the MSDN piece. Guess I’m rather rusty, ugh.) and [ELMAH](http://scottonwriting.net/sowblog/posts/2113.aspx) error logging module. In addition, I finally got rid of the menu system that had been on the site for some time, for two major reasons:

1) I don’t think it was terribly easy to use, either by real people, or most certainly by web spiders. The latter resulting in much more difficulty for the site to be indexed by spiders, since most of the major content was linked off the menu categories.

2) The menu was really, really, bloated in terms of HTML output. The new home page, with more content, will be about half the size (not including images) as the old version.

Right now I’m working through an issue with postbacks and rewritten urls. I found [this link](http://www.devhood.com/messages/message_view-2.aspx?thread_id=94884)on one solution, and I’m also looking at what [Scott](http://scottonwriting.net/sowBlog)had to say in his article on the subject. Hopefully in another hour or so I’ll be ready to go live. For posterity, here is a picture of the site prior to the update:

![AspAlliance Home Page 11 Feb 05 Before Redesign](<>)

*Update (10 minutes later):[Scott’s Article on MSDN](http://msdn.microsoft.com/asp.net/articles/extend/default.aspx?pull=/library/en-us/dnaspp/html/urlrewriting.asp#urlrewriting_topic6) did indeed have the solution, using his ActionlessForm class. The problem I was having was not quite the same as what he described in the article (annoying URL change) — mine was more serious because I’m rewriting URLs that appear to be subfolders. So, my postback was trying to hit the actual filename, but in a non-existent subfolder, resulting in not just an annoying URL change, but a 404 error… All better now, though!*

<!--EndFragment-->