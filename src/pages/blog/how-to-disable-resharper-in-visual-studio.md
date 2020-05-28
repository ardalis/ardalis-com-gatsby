---
templateKey: blog-post
title: How To Disable ReSharper in Visual Studio
path: /how-to-disable-resharper-in-visual-studio
date: 2012-07-31
featuredpost: false
featuredimage: /img/SNAGHTML1ff3360d_1.png
tags:
  - developers
  - performance
  - Productivity
  - resharper
  - tips and tricks
  - visual studio
category:
  - Productivity
  - Software Development
comments: true
share: true
---

Something I’ve had to do from time to time is disable a plug-in in Visual Studio, either permanently or temporarily, such as [ReSharper](http://www.jetbrains.com/resharper). Just now was one of those times, and as in the past I had to hunt through a variety of Visual Studio menus in order to find it. Personally, I think Visual Studio has some work to do on how many kinds of plug-ins, add-ons, and extensions it supports, which I hope I make clear in this post. However, if Bing/Google brought you here and you just want the answer to the question of how to disable Resharper, the steps are:

- Open **Tools > Options**
- Choose the ReSharper option
- Click _Suspend_

![SNAGHTML1ff3360d](/img/SNAGHTML1ff3360d_1.png "SNAGHTML1ff3360d")

Some of the things you might try, as you go hunting for this, are shown below. Note that none of these work, I’m just including them to demonstrate the problem and hence the need for this blog post.

## Try the ReSharper Menu

You might expect to find a way to toggle ReSharper on/off in its menu, but you’ll be disappointed.

![image](/img/image_3_10.png "image")

You might further search within Options… but while there are a host of things that have to do with ReSharper itself, none provide an easy way to disable or suspend ReSharper.

[![SNAGHTML1ff627b6](/img/SNAGHTML1ff627b6_thumb.png "SNAGHTML1ff627b6")](/img/SNAGHTML1ff627b6_thumb.png)

I honestly expected there might be an option under ReSharper Options for this, but no such luck. Clicking on Manage… in some blind hope that that will let you manage whether ReSharper is enabled or not, is also not helpful. It leads to this window:

![SNAGHTML1ff7ac53](/img/SNAGHTML1ff7ac53_1.png "SNAGHTML1ff7ac53")

## Try Various Tools Options

The Visual Studio Tools menu has a bunch of likely candidates and suspects for disabling a Visual Studio plugin like ReSharper. Just look at the choices:

![image](/img/image_6_10.png "image")

You might think that an Add-in like ReSharper would be handled by the Add-in Manager. No.

Maybe it’s an Extension, and the Extension Manager is the way to go? No.

Maybe it’s an External Tool? No.

Maybe you can Customize… Visual Studio, to add or remove ReSharper functionality? Of course not.

In a fit of desperation you might even try the Code Snippets Manager, the Choose Toolbox Items, or even the Library Package Manager, but of course none of these are correct, either.

## Tools Management in Visual Studio

In my opinion, Visual Studio could stand to have some work done on how many ways it can be extended. Yes, the audience is developers, so a bit more technical knowledge can be expected, but even so does the end user of this application really need to know the difference between an Add-in and an Extension? And even if they do, why is a plug-in like ReSharper not shown in either the Add-in Manager or the Extension Manager? Did I miss a menu somewhere called Plug-in Manager that shows yet another way to manage Visual Studio additions? I’ve been using VS2012 a bit recently (it just came out a few days ago) but I don’t have it on this machine, so I can’t say right now whether it makes this any better, but I do think this is an area of usability that can stand to be improved.

## Why Disable ReSharper

One last thing I should add is why one would want to disable ReSharper, or any other plug-in. There are a few reasons. You might be giving a presentation, training, webinar, etc. and you don’t want to distract audience members with non-standard menus and tooltips. You might have installed several different products (like [ReSharper](http://www.jetbrains.com/resharper), [JustCode](http://www.telerik.com/products/justcode.aspx), and [CodeRush](http://www.devexpress.com/Products/Visual_Studio_Add-in/Coding_Assistance)) with similar capabilities and want to try each one in isolation from one another. Or maybe the company you work for has such a tool themselves, and you want to use it instead of a competitor’s product, so that your company’s product can benefit from your feedback. I’m sure there are other possible reasons, as well, and while I’m picking on ReSharper (which I’ve happily used for years) in this post, I’m not suggesting there’s anything specific to ReSharper that should compel you to disable it permanently.

**Update**: Apparently the short version of this question is also [a fairly popular StackOverflow Q&A](http://stackoverflow.com/questions/2189792/how-can-i-disable-resharper-in-vs-and-enable-it-again) that didn’t come up in my initial search on the topic.
