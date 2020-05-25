---
templateKey: blog-post
title: DevConnections Fall 2006 Summary
path: blog-post
date: 2006-11-10T02:20:39.302Z
description: Got back home last night from DevConnections in Las Vegas. It was a
  very good show this year in terms of content, products being launched, and
  numbers of attendees and exhibitors.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Caching
  - ci
  - devconnections
  - Events
  - tdd
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Got back home last night from [DevConnections](http://devconnections.com/) in Las Vegas. It was a very good show this year in terms of content, products being launched, and numbers of attendees and exhibitors. I think I had more people in my sessions than usual, too, and they all went well (i.e. the demos worked, nobody threw tomatoes at me).

The keynote on Monday night suffered a bit from some audio issues and in general wasn’t as tremendously exciting as I thought it should have been given that ASP.NET AJAX Beta 2 was announced, along with Office 2007 and Sharepoint 2007 and, I believe, .NET 3.0. Perhaps the sheer volume of announcements of products being released made it difficult to build buzz for any one of them. I have a feeling this was part of the reason the Vista RTM announcement was not made until Wednesday. Another issue with the keynote(s) on Monday night was their combined nature. This conference was a combination of ASP.NET, Visual Studio, SQL Server, SharePoint, Mobile, Windows, Exchange, and Office users. At any rate, the Monday night keynotes would have likely fared better if they were targeted to ward separate conference tracks. ASP.NET developers don’t care that there is some new button in the Exchange admin control panel. Exchange admins probably don’t care that ASP.NET now has this ‘AJAX’ thing. This theory is supported by the large number of attendees who began filing out during the latter part of the keynote (the part I cared about).

Tueday morning was better. There were two separate keynotes, one for Exchange and one for ASP.NET. The ASP.NET one went well, I thought. Better than the night before, and fairly well attended, especially for 8am in Vegas. Tuesday was Microsoft presenter day, and I went to Scott Guthrie’s talk on LINQ (which was different from his LINQ talk at TechEd in June) and continued to be excited about what LINQ will offer… some day. One question I have that I didn’t get a chance to ask was how caching, especially the new SQL Cache Invalidation features of ASP.NET 2.0, fit into the LINQ model. I’m sure there is a way to configure it, but I haven’t seen it demonstrated yet.

Tuesday night the exhibit hall opened with an appetizer party. I think the exhibit hall usually opens after the keynote, so this was later than usual, but I think it worked out well because it allowed exhibitors to have the day to set up and it ensured that the exhibit hall was packed for the event. The following day the exhibit hall continued to be very well attended, and several of the exhibitors I spoke with said it was a very good conference in terms of the constant stream of attendees they were seeing at their booths. That’s a good thing for the show, since having happy exhibitors helps ensure the show’s future success.

Wednesday I presented twice, once in the morning on .NET Caching Best Practices and once in the afternoon on Improving .NET Application Performance and Scalability. Both were in a very large room and were very well attended. One thing I failed to mention during my caching talk that I thought about afterward while speaking with Bill Bain of [ScaleOut Software](http://www.scaleoutsoftware.com/) was how to implement distributed caching in a web farm scenario. I told Bill I’ll definitely include a mention of ScaleOut’s software in my slide deck in the future, but since it is such a frequently asked question, I wanted to include something here as well. If want to use caching, but you need for the cache to be synchronized between multiple web servers, then you should definitely check out [ScaleOut State Server](http://www.scaleoutsoftware.com/products/stateServer/index.html). It does this particular thing very well. In the performance talk, I plugged the book by the same name, and later had an attendee inform me that the book wasn’t being sold at the conference and so I was losing money. Just to clear any confusion, I didn’t write the book on [Improving .NET Performance and Scalability](http://www.microsoft.com/products/info/product.aspx?view=22&pcid=8a7bbc4a-7906-40c0-9c98-7caba7526593&type=ovr), I just think it’s an awesome book. Go get it if you want to write high performance .NET apps – I don’t make any money for telling you so.

Thursday I had an 8am session on Test Driven Development and Continuous Integration using ASP.NET and Visual Studio Team System (quite a mouthful). Given that it was 8am, I thought attendance was quite good (and, given that it was 8am, I thought my being in attendance was quite good). I actually got up exceptionally early and set up for the talk at like 630 in the morning because I was really afraid my Virtual PC image was going to die or just be incredibly slow, but it went ok. It was slow, but not unbearably so, and I thought the talk went pretty well. I had one person ask me afterward if VSTS Web Tests could be configured to be driven from a database (for example, hit the same page one time per row, with form contents determined by each row in the database). I’m not sure if that’s possible yet, but it’s something I’ll investigate (and if anybody reading this has done it, please comment).

After my last session, I spent the day catching up with friends and customers before heading home. Security at the airport was backed up quite a bit, but otherwise the trip home was uneventful, and after leaving the hotel at 1pm I arrived back at home in Kent at 11pm or so, three time zones ahead.

For those of you who are interested in my slides and demos, I have posted them in the [File Gallery](http://index.aspalliance.com/FileGallery/default.aspx)on ASPAlliance.com’s Resource Directory. Direct links:

[Caching Best Practices](http://index.aspalliance.com/FileGallery/Presentations/Details/219_CachingDevConnectionsFall2006.aspx)\
[Improving Performance and Scalability](http://index.aspalliance.com/FileGallery/Presentations/Details/220_Improving.NETPerformanceandScalability.aspx)\
[TDD and CI with ASP.NET and VSTS](http://index.aspalliance.com/FileGallery/Presentations/Details/221_TDDandCIforASP.NETandVSTS.aspx)

**Update**: Some folks were having trouble downloading, so I uploaded to an alternate location as well:\
Weird, works for me. Here are some alternate links:\
<http://aspalliance.com/download/DotNet_Caching_Best_Practices_20061108.zip>\
<http://aspalliance.com/download/Improving_dotNET_Application_Performance_and_Scalability_20061108.zip>\
<http://aspalliance.com/download/TDD_CI_ASPNET_VSTS_20061109.zip>

Sorry for the trouble.

<!--EndFragment-->