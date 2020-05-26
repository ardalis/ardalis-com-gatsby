---
templateKey: blog-post
title: DevExpress TechSummit
path: blog-post
date: 2008-11-04T12:09:00.651Z
description: "I'm in Vegas a few days early (before DevConnections) to attend
  DevExpress's TechSummit2007, where they've invited a bunch of MVPs, authors,
  speakers, etc. to come and learn more about their controls and tools. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - asp.net
  - Cool Tools
  - visual studio
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I'm in Vegas a few days early (before [DevConnections](http://devconnections.com/)) to attend [DevExpress's](http://devexpress.com/) TechSummit2007, where they've invited a bunch of MVPs, authors, speakers, etc. to come and learn more about their controls and tools. Yesterday we saw some of what they're working toward in the WPF space, with some charts and grids that are not quite ready yet, but look like they will be pretty nice. I'm not doing much with WPF at the moment, since I'm mainly holding out for Silverlight 1.1 and whatever subset of WPF it supports, but DevExpress is also working on (mainly planning and proof-of-concept given the early nature of Silverlight 1.1) some controls for that as well.

Today we're looking at the ASP.NET controls and story. One thing they have that seems to distinguish them from their competitors' grid components is a data source control that the grid works with to intelligently query for just the rows needed as the user moves through the data in the control. This capability exists in their Windows grid as well as the ASP.NET grid, and you can think of it as working similarly to how Google Maps (or other online maps) are able to allow the user to seamlessly scroll through mapping data while fetching the next image tiles required in the background. One area where this shines is in filtering and grouping, which are both very fast compared to other grids for large result sets, because only the data needed is fetched.

For their booth this week, DevExpress is doing a promotion for CodeRush where they'll have a model (Sarah) they've hired for this week write some code head-to-head with a conference attendee. We saw her go up against [Dustin Campbell](http://diditwith.net/) (using just VS2005's codesnips and intellisense) earlier today as sort of a rehearsal for later this week, and she beat him pretty handily. If you're at the show, and you compete with Sarah and manage to beat her, you'll be able to spend some time in a money booth (one of those booths with bills flying around that you can try and snatch out of the air) depending, I imagine, on how much you beat her by.

![](<>) So also today we're watching [Mark Miller](http://www.doitwith.net/) and Dustin show off CodeRush and Refactor. I've seen these demos, for the most part, before, having spent an inordinate amount of time with these guys at TechEd2007. However, they've added a bunch of new features in the meantime. It's definitely fun watching Mark and Dustin demo this stuff (which is part of why I hung out at their booth so much in June at TechEd).

A couple of things we suggested to Mark that would be cool to add to RefactorPro were alphabetizing of all properties in a class, [which he actually did on DNRTV](http://www.dnrtv.com/default.aspx?showNum=5), and fixing [IDisposable classes that aren't using try-catch-finally or using(), which he covered in his blog](http://www.doitwith.net/2007/04/26/HighlightingIDisposableLocalsThatDon'tCallDisposePartIII.aspx). So, both are feature requests he's already done, they're just not yet productized.

**Updated – DX has some great discounts for volume pricing – check it out.**

<!--EndFragment-->