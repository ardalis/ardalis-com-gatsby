---
templateKey: blog-post
title: CodeSmith – Improved Sproc Generation Templates
path: blog-post
date: 2005-01-27T03:21:29.946Z
description: I edited my first [CodeSmith] templates today and found it to be
  quite straightforward, and a very powerful tool. I think I’m going to be
  hooked.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - CodeSmith
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I edited my first [CodeSmith](http://www.ericjsmith.net/codesmith) templates today and found it to be quite straightforward, and a very powerful tool. I think I’m going to be hooked. Anyway, I was using it to generate some CRUD sprocs for a couple of tables I need in a small project I’m working on now for [AspAlliance.com](http://aspalliance.com/), and I decided that the default templates that shipped with it didn’t fit my needs because my tables have prefixes on them and I didn’t want the prefixes to be in the sproc names (e.g. for a table sas_Product it was creating a sproc called Deletesas_Product instead of just DeleteProduct). So I fixed them and now you can specify a table prefix which is ignored when the sprocs are named (you can also set a global sproc prefix). In this way, all of my tables and sprocs have the same common prefix for each common piece of functionality, but the sprocs don’t have extra table prefixes in their names (end result is something like sas_DeleteProduct). You can download the updated templates [here](http://authors.aspalliance.com/stevesmith/download/SprocTemplates.zip).

<!--EndFragment-->