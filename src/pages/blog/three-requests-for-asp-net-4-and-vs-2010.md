---
templateKey: blog-post
title: Three Requests for ASP.NET 4 and VS 2010
path: blog-post
date: 2008-03-16T13:34:51.878Z
description: I have three things that have been on my wish list for ASP.NET
  and/or Visual Studio that I’m curious to know what others think.
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

I have three things that have been on my wish list for ASP.NET and/or Visual Studio that I’m curious to know what others think. I’ve mentioned [some of these before](http://aspadvice.com/blogs/ssmith/archive/2007/12/05/Generic-Web-Controls-and-EnumDropDownList.aspx) on [my blog](http://aspadvice.com/blogs/ssmith/archive/2004/04/02/1802.aspx) or elsewhere – they’re not exactly earth shattering and I’m not saying that I want them more than any other feature they might add. But each one would make my life at least a little bit easier, if they were included by default.

So, in no particular order, here they are:

**Support For Generics in ASPX Markup**

[Eilon posted not too long ago about this topic](http://weblogs.asp.net/leftslipper/archive/2007/12/04/how-to-allow-generic-controls-in-asp-net-pages.aspx). The idea here is that you should be able to write controls that take advantage of generics, and be able to declaratively specify them within your ASPX/ASCX markup. This would allow for things like strongly typed DropDownList controls or even TextBoxes, and would also allow for MVC views to specify their ViewDataType without having to resort to code. In the WPF world, I understand that this can be done by using the x:TypeArguments attribute. As Silverlight 2.0 takes off, it would be great to see support for generics in its XAML markup, as well. Limiting the discussion to ASP.NET for the moment, what should the markup look like? [Mikhail Arkhipov discussed some of the options and challenges](http://blogs.msdn.com/mikhailarkhipov/archive/2004/08/18/216957.aspx) 4 years ago, and apparently the solution was not trivial or I have to believe we would already have it. However, I have confidence in the ASP.NET team’s ability to figure this one out.

**Save VS Preferences in the cloud**

Since VS 2005 we’ve been able to save out our VS preferences to disk and then import them. This is a great feature that I’ve never used – I just usually don’t have access to my primary dev machine when I sit down at another one, and if it’s a coworker’s machine I don’t want to mess with their settings. With things like pair programming, it can be tough to use customized settings since there is no easy way to swap back and forth depending on who’s at the controls. What I would like to see is a way to recover my settings from “the cloud” so that I can get them anywhere I go via my Live ID or OpenID or whatever. Having a quick way to switch between a couple of these would make the pair programming scenario even better. I suggested this four years ago, and I still want it. Another option that might help this situation is being able to run VS from a USB drive, so that it’s completely portable. This would be cool for the “walk up to any machine” scenario but a bit less useful in the pair programming scenario. I’d go for both. The other thing I think would be invaluable for the service method is that Microsoft would be able to mine data about users’ preferences (with opt-in for the privacy paranoiacs) so that their future versions of Visual Studio would ship with defaults that were informed by thousands of real world users’ preferences.

**Recursive FindControl**

Do a quick search for this and you’ll find a number of similar implementations. This [generic recursive findcontrol](http://intrepidnoodle.com/articles/18.aspx) looks like a pretty good one, based on some code from [Palermo](http://weblogs.asp.net/palermo4/archive/2007/04/13/recursive-findcontrol-t.aspx) and [myself](http://aspadvice.com/blogs/ssmith/archive/2006/08/23/Add-Profile-Items-in-CreateUserWizard-and-Recursive-FindControl.aspx). Basically, these let you get a reference to a control even if it is not in the current control’s Controls collection. This happens quite often with templated controls like CreateUserWizard or LoginView or MultiView, and having a recursive findcontrol is quite a bit more flexible than hardcoding the name with $ etc ([see tip 4 here](http://weblogs.asp.net/dwahlin/archive/2007/04/17/simple-asp-net-2-0-tips-and-tricks-that-you-may-or-may-not-have-heard-about.aspx)). Since I found the need for this technique, I’ve been adding it to my [Base Page class](http://aspadvice.com/blogs/ssmith/archive/2006/09/14/Ultimate-ASP.NET-Base-Page-Class.aspx) or common class in every ASP.NET project I work on, so it seems to me it should really be built into the framework.

<!--EndFragment-->