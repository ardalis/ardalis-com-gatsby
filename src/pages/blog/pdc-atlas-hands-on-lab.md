---
templateKey: blog-post
title: "PDC: Atlas Hands-On Lab"
path: blog-post
date: 2005-09-16T14:22:37.712Z
description: I just completed the ASP.NET “Atlas” hands-on lab. It was very well
  put-together considering how completely new Atlas is. I imagine a few members
  of the ASP.NET team probably lost some sleep the week prior to PDC getting all
  of this put together in time.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Events
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I just completed the ASP.NET “Atlas” hands-on lab. It was very well put-together considering how completely new Atlas is. I imagine a few members of the ASP.NET team probably lost some sleep the week prior to PDC getting all of this put together in time. You can complete the lab yourself — it’s available from the [Atlas website](http://atlas.asp.net/). At the moment it requires the Beta 2 version of ASP.NET, but a new lab targeting the RC build of .NET 2.0 should be available very soon.

The lab has 5 parts and shows you first how to set up a master page to hold your Atlas script library references, then quickly moves into useful examples. You learn how to use asynchronous callbacks to web services to set the value of a label (without a postback, naturally) using a bit of javascript. Then again, using a new declarative tag model that is unique to Atlas’s approach (as opposed to, say, AJAX.Net) and parallels the ASP.NET server control syntax. The next lab further encapsulates things by using Atlas server controls, which remove the need for the developer to write any client side code. You’ll create an auto-completion textbox which is pretty slick, and finally the lab wraps up with a no-code, templated, databound listview which is populated via callbacks.

Considering how new ASP.NET “Atlas” is, it’s very impressive. I spoke with one of the Microsofties on the Atlas team, and he explained that one of their goals was to make the whole architecture for this kind of thing easier, as opposed to just creating another library allowing XML-HTTP calls back to the server. To that end, they’re encapsulating the browser differences in their script libraries, and encapsulating the client script in their server controls. They’re also using client-side declarative blocks to define control behavior, which is something I haven’t seen before and something that parallels how ASP.NET developers work with controls today on the server side. I think it will also enable some powerful design time enhancements in a future version of Visual Studio (although today they actually break the designer in visual studio, but that’s sure to be fixed).

<!--EndFragment-->