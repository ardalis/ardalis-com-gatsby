---
templateKey: blog-post
title: Micro Caching Article Published
path: blog-post
date: 2004-05-04T12:24:00.000Z
description: Basically, the idea is that even a very short-term cache can make a
  big difference in site performance for a high-volume application or resource.
  I’d known about this in theory for some time, but I finally demo’d it to a
  class I was teaching at Ohio Savings Bank in April to get some hard numbers.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Caching
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

Those of you interested in caching should read my article on [AspAlliance](http://aspalliance.com/) about what I’ve termed *[micro-caching](http://aspalliance.com/251)*.

Basically, the idea is that even a very short-term cache can make a big difference in site performance for a high-volume application or resource. I’d known about this in theory for some time, but I finally demo’d it to a class I was teaching at Ohio Savings Bank in April to get some hard numbers. On that machine (whose stats I don’t know, but it had Win2k pro and sql 2000 on it) I was able to get about 40 requests per second to a simple page with a datagrid loaded with the contents of Northwind’s products table. By adding one second of cache (and removing session and viewstate) I was able to boost this up to over 300 requests per second.

Monday night at ASPNETConnections I saw Scott Guthrie do a similar thing using WAST/Homer and showing off the new Sql Cache Invalidation features of ASP.NET 2.0. He started hitting the page, got around 40 requests per second, then implemented the caching and demonstrated how the requests/sec spiked up to over 250 or 300 or so. It’s a great demo, but **you don’t have to wait for 2.0 and SqlCacheDependency to pull that off**! Just implement a 1-second output cache on your page, and you’ll get nearly the same performance boost (assuming your page is being hit more than 1/second).

<!--EndFragment-->