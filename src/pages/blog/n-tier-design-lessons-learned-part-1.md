---
templateKey: blog-post
title: N Tier Design Lessons Learned Part 1
path: blog-post
date: 2009-10-09T20:50:00.000Z
description: Eight years ago this month I gave my first presentation at a
  conference. It was DevConnections Fall 2001 show, and it was held in
  Scottsdale, Arizona at the Princess Resort. The show was delayed a couple of
  weeks from its originally scheduled dates, and took place Sep 30 to Oct 3rd,
  as a result of the events of 11 September 2001.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - NTier
category:
  - Uncategorized
comments: true
share: true
---
Eight years ago this month I gave my first presentation at a conference. It was [DevConnections'](http://devconnections.com/) Fall 2001 show, and it was held in Scottsdale, Arizona at the Princess Resort. The show was delayed a couple of weeks from its originally scheduled dates, and took place Sep 30 to Oct 3rd, as a result of the events of 11 September 2001. I still vividly remember the alarm with which my seatmate on the flight over (an older lady) observed that they had given us all plastic knives with our meals. I reassured her, “It's OK, we all have them.”

As a result of the times and the rescheduling, the resort was a ghost town and the conference attendance was, shall we say, light. I think my 3 sessions pulled in attendance numbers of 6, 10, and 6, which I recall being pretty happy with as not all speakers managed to get double digit attendance. One of my sessions was on N-Tier Development in .NET. You can still [download all of my 2001-2003 talks on my old training web site here](http://aspsmith.com/DesktopDefault.aspx?tabindex=3&tabid=9). The talk which is the topic of this series is this one:

[N-Tier Development in .NET](http://aspsmith.com/DesktopModules/ViewDocument.aspx?DocumentID=17)(rename it to NTier.zip or something similar)



**Lessons Learned**

When I gave this talk, it was based on personal experience and a lot of industry best practices that I had picked up from other software professionals and from Microsoft itself. These included things like the IBuySpy samples and FMStocks samples, which in their time were*amazing*and wonderful and helped a ton of developers build effective and no doubt profitable applications using ASP.NET.

However, now I'm 8 years older and wiser, and there are things I certainly would change about how I recommended architecting applications in .NET in 2001. I know that millions of developers learned these same best practices, and that probably millions of developers continue to believe these remain best practices for building applications today. I've learned otherwise, and I am hoping to show through this series both why I've changed the way I do things and how to go about changing a .NET Solution from what I'll refer to as “traditional n-tier” architecture to a more domain-driven or [onion architecture](http://jeffreypalermo.com/blog/the-onion-architecture-part-1).

## The Original Presentation

Unzip the file into a folder and you should see something like this:

![n-tier sample folder](/img/ntier-sample-folder.png)

If you look at the slide deck (which I would totally redo today, naturally), you'll see Slide 9 shows this diagram:

![msdn ntier graphic](/img/msdn-ntier-graphic.gif)

This was always one of my favorite slides in this talk. I believe I got this diagram from MSDN – I know I didn't create it myself (slide 10 shows the extent of my diagram creation skills at the time). N-tier architecture was actually kind of novel back in 2001. there were plenty of developers in the audience who weren't familiar with the concept or hadn't bought into it yet. Today, it seems like most developers I talk to are certainly familiar with this separation into layers, and I would say that most mainstream .NET developers in the last few years are following a Two- or Three- tier architecture. However, only a minority of them create their solutions in such a way that the Data Access Layer assembly is not referenced directly by the Business Logic assembly, which in turn is referenced directly by the Presentation Layer. This is an [anti-pattern (Data Driven Architecture)](/principles-patterns-and-practices-of-mediocre-programming), and is one of the lessons learned that I will cover in the next part of this series.

I'll also include a download of a slightly cleaned up version of the sample code, updated to use a VS2008 solution file and including the schema needed for the User table, to save anyone wishing to follow along in the code the tedium of such things. But I wanted to point to the actual, original file so that you could see it in all its glory, warts and all, and see how far we've come in the last 8 years.
