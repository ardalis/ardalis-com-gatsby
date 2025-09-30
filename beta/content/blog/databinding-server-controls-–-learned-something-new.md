---
title: Databinding Server Controls – Learned Something New
date: "2003-08-16T18:54:00.0000000-04:00"
description: I was running into an issue databinding an ImageButton's ImageUrl
featuredImage: img/databinding-server-controls-–-learned-something-new-featured.png
---

I was running into an issue databinding an ImageButton's ImageUrl property to a string comprised partly of literal text and partly of a string I was pulling from my ConfigurationSettings.AppSettings collection. I was using the standard <%# … %> syntax for the databinding, but the result kept showing my databinding syntax in the button's URL, rather than the actual value. It seems that while you can do the databinding to the control property, it's all or nothing. So if you want the string to be:


```
<asp:ImageButton … ImageUrl="/folder/<%# MyConfigVariable %>/Add.gif" … />
```


Then you need to code it like this (VB):


```
<asp:ImageButton … ImageUrl='<%#"/folder/" & MyConfigVariable &"/Add.gif" %>' … />
```


Thanks a bunch to [Andy Smith](http://weblogs.asp.net/asmith) for helping me see the light.

Listening to: Command and Conquer – Hell March

