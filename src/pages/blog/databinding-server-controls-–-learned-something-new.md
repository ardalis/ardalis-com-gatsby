---
templateKey: blog-post
title: Databinding Server Controls – Learned Something New
path: blog-post
date: 2003-08-16T22:54:00.000Z
description: I was running into an issue databinding an ImageButton’s ImageUrl
  property to a string comprised partly of literal text and partly of a string I
  was pulling from my ConfigurationSettings.AppSettings collection.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Databinding Server Controls
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

I was running into an issue databinding an ImageButton’s ImageUrl property to a string comprised partly of literal text and partly of a string I was pulling from my ConfigurationSettings.AppSettings collection. I was using the standard <%# … %> syntax for the databinding, but the result kept showing my databinding syntax in the button’s URL, rather than the actual value. It seems that while you can do the databinding to the control property, it’s all or nothing. So if you want the string to be:

<!--EndFragment-->

```
<asp:ImageButton … ImageUrl=”/folder/<%# MyConfigVariable %>/Add.gif” … />
```

<!--StartFragment-->

Then you need to code it like this (VB):

<!--EndFragment-->

```
<asp:ImageButton … ImageUrl='<%# “/folder/” & MyConfigVariable & “/Add.gif” %>’ … />
```

<!--StartFragment-->

Thanks a bunch to [Andy Smith](http://weblogs.asp.net/asmith) for helping me see the light.

Listening to: Command and Conquer – Hell March

<!--EndFragment-->