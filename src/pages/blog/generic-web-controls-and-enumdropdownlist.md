---
templateKey: blog-post
title: Generic Web Controls and EnumDropDownList
path: blog-post
date: 2007-12-05T11:43:19.124Z
description: I just published an [article on ASPAlliance that shows a few
  different techniques for binding a DropDownList control in ASP.NET to an
  enumerated type (enum)].
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I just published an [article on ASPAlliance that shows a few different techniques for binding a DropDownList control in ASP.NET to an enumerated type (enum)](http://aspalliance.com/1514_Extending_the_DropDownList_to_Support_Enums.all). As part of the article, I wrote a custom control that uses generics to bind a DropDownList<T> to an enum. Unfortunately, I ran into problems with declaratively defining this control within ASP.NET markup, and thus far there is no support from the ASP.NET engine for generic types within the markup (though [it has been discussed here](http://blogs.msdn.com/mikhailarkhipov/archive/2004/08/18/216957.aspx)). In response to my question about this support,[Eilon Lipton blogged another approach that uses a ControlBuilder to allow specification of the proper control and its associated generic type within the ASP.NET markup](http://weblogs.asp.net/leftslipper/archive/2007/12/04/how-to-allow-generic-controls-in-asp-net-pages.aspx), and is worth a read if this problem is of interest to you. If you think Microsoft should standardize on some markup for generics within ASP.NET markup and support it in ASP.NET 4.0, please leave a comment, since I know they read this blog.

<!--EndFragment-->