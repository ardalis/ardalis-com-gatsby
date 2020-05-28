---
templateKey: blog-post
title: TechEd 2009 Session Aftermath
path: blog-post
date: 2009-05-27T06:34:00.000Z
description: I’m a bit later than usual in posting my slides and demos from my
  talks, and for that I apologize. TechEd this year was a lot of fun, albeit a
  little disappointing due to its being a smaller show than in past years.
  However, it was great to see a lot of my friends whom I typically only
  interact with electronically, and to meet a few new people as well.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - TechEd
category:
  - Uncategorized
comments: true
share: true
---
I’m a bit later than usual in posting my slides and demos from my talks, and for that I apologize. TechEd this year was a lot of fun, albeit a little disappointing due to its being a smaller show than in past years. However, it was great to see a lot of my friends whom I typically only interact with electronically, and to meet a few new people as well. I do wish that this show would have had a bit more to offer developers, but I guess I’ll just have to wait for [PDC](http://www.microsoftpdc.com/) for that.

My two talks both were related to ASP.NET MVC, but neither was specifically an ASP.NET MVC talk. What I mean is, yes, I used ASP.NET MVC for all of my demos and briefly mentioned what ASP.NET MVC is and why one might use it, but I didn’t go into depth describing the plumbing of the ASP.NET MVC project template or DLL. The meat of the talks was something else in each case, and ASP.NET MVCness was merely an interesting side dish.

**SOLIDify Your ASP.NET MVC**

My first talk was one I’ve given several times before, but unfortunately for the TechEd version I had to cut down on some of the cool images I had [borrowed from this post](http://www.lostechies.com/blogs/derickbailey/archive/2009/02/11/solid-development-principles-in-motivational-pictures.aspx) (along with others of my own creation) due to lack of a Creative Commons license for this material. Unfortunately I didn’t learn that these would not be part of my slide deck until late the day before my talk, so I opted to give the talk without them rather than trying to replace them with [iStockPhoto](http://www.istockphoto.com/index.php) images or something like that (another speaker ran into similar problems and was taking pics of other speakers in the speaker lounge in various poses to use for his talk, since there could be no question of his right to use his own photos).

The talk went reasonably well, the demos all worked. I had written myself a little crib sheet of what I wanted to cover in each demo and accidentally left it in my bag as I started the talk, so I was a little bit flustered and I’m sure that detracted a bit, but overall the feedback on the session was positive. It’s a lot of stuff to cover for developers who are unfamiliar with these principles, while at the same time pretty basic for those who know them. My target audience was definitely the former group, as I would like to spread knowledge of the SOLID principles are far and wide as possible within the Microsoft developer camp.

**Overall Score: 3.41 (out of 4); 90 attendees**

Some comments:

> *Excellent! Just what I needed!*
>
> *Gave good information on cerating the classes and things to do and not do*
>
> *Good job Steven. I enjoyed this presentation. As a matter of fact, I plan to implement some of what I learned as soon as I get home. Specifically, the ICalendar concept is such a simple idea but I’m not currently doing it (I do DI already in MVC). I will be now. Thanks for all of the tips.*
>
> *It’s interesting that the software development techniques have long been known in the C and C++ community just now seem to be discovered for ASP.NET.*
>
> *Only one problem, there was nothing about MVC in the session which is why I went. Don’t get me wrong, the content was interesting, just not what I expected.*
>
> *The title of the session was very misleading. I was expecting MVC content.*
>
> *These are concepts well known to us. I was expecting more about ASP.Net MVC. Like testing Views, Verification of IoC config, etc*
>
> *This session focused more on SOLID than I cared to hear about, but touched on some information that I was looking for.*
>
> *This session provided valuable insight on how to properly use MVC with ASP.NET.*
>
> *Well done. Covered the entire SOLID concept in sufficient depth for most users*

One thing I think I need to make more clear for this talk is that it’s primarily about SOLID and OOP principles, and it merely uses ASP.NET MVC as the canvas on which to paint this picture. Obviously my session description didn’t make this clear enough, based on several of the comments.

[Download Slides and Demos](http://ssmith-presentations.s3.amazonaws.com/SolidAspNetMvcTechEd.zip)



**ASP.NET MVC with Windows Azure**

My second talk covered using ASP.NET MVC with Windows Azure. In this case, MVC was a bit more central to the talk, but the main concepts discussed were primarily related to getting an ASP.NET MVC project template working within an Azure project template. I covered two ways of doing this, one that [shows the manual steps involved](http://blogs.msdn.com/blambert/archive/2009/02/13/creating-an-azure-asp-net-mvc-project.aspx) and another that uses the template from [Community4ASP.NETMVC project](http://c4mvc.codeplex.com/Release/ProjectReleases.aspx?ReleaseId=27239). After a simple project was set up, I covered Azure briefly (what’s a worker role, what’s a web role, what’s Azure Storage, how do they work together) and finally showed how to build a simple ASP.NET MVC application on top of Azure (in this case, a very basic social bookmarking site,[AzureTags](http://azuretags.cloudapp.net/)).

My biggest worry with this talk was that the audience would be disappointed that there wasn’t more involved in getting ASP.NET MVC working with Azure. Part of the point of the talk, as I constructed it, was that the use of ASP.NET MVC be a total non-event.

Windows Azure works with ASP.NET. ASP.NET MVC **is** ASP.NET. Therefore, Windows Azure works with ASP.NET MVC.

Because it’s still pre-release, getting the project set up properly requires a slight amount of work, but once that’s done, you can run your ASP.NET MVC apps on Azure just as easily as any other ASP.NET app. And the style of loosely coupled, disconnected components that one tends to write for scalable cloud applications is very much in the same spirit of how ASP.NET MVC applications should be written, so the two are a natural fit together.

**Overall Score: 3.67 (out of 4); 52 attendees**

Some comments (actually, all 3 of them):

> *It’s was a perfect talk. Very informative. Sometimes the audience questions stopped the "flow" and took up too much time. Maybe waiting to the end with questions and answers would make it even better.*
>
> *Really an excellent presentation. This is the second time I’ve heard this presenter and he’s really good.*
>
> *We needed more talks about developing for Azure. This is one of the only ones I could find.*

Sounds like I did pretty well on this session. The attendees were very into the content and asked several good questions during the course of the talk, and actually since this was the last session of the day on Thursday, several of the attendees stayed in the room after the timeslot had ended to continue discussing Azure and MVC for about half an hour (which I believe is on the recorded content if you have access to it and are interested in the discussion). I really enjoyed this session and the discussion in generated, so thanks to those who attended!

Also, if you’re interested in Azure, aside from following [AzureFeeds.com](http://azurefeeds.com/)for web/RSS content, check out <http://twitter.com/azure> as well.

[Download Slides and Demos](http://ssmith-presentations.s3.amazonaws.com/AzureTagsTechEd.zip)

[Live Demo of AzureTags](http://azuretags.cloudapp.net/)