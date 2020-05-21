---
templateKey: blog-post
title: CodeMash 2012 Sessions
path: blog-post
date: 2012-01-16T05:27:00.000Z
description: Last week I presented two half-day workshops at CodeMash’s
  PreCompiler on Wednesday (with Brendan Enrick), and a session on ASP.NET MVC 4
  on Thursday.
featuredpost: false
featuredimage: /img/software-craftmanship.jpg
tags:
  - asp.net mvc
  - community
  - conferences
  - software craftsmanship
  - speaking
category:
  - Software Development
comments: true
share: true
---
[](http://codemash.org/)Last week I presented two half-day workshops at [CodeMash’s](http://codemash.org/) PreCompiler on Wednesday (with Brendan Enrick), and a session on ASP.NET MVC 4 on Thursday. CodeMash 2012 was an amazing conference and I’d like to personally thank the organizers as well as the attendees of my own events for making it such a great event. I’ll post a separate write-up with my experiences shortly – for now I just need to get my slides and demos posted for folks who want them.

## Beginning Software Craftsmanship

The morning PreCompiler was on Beginning Software Craftsmanship, and included some presentations on software craftsmanship, deliberate practice, testing, and pairing. We had about 25 people in attendance, which was just about perfect for the room we had. Unfortunately, we had a tiny little 6’ screen to present on, but we made it work and thankfully most of this workshop involves hands-on coding, not watching slides. The group worked through the [Prime Factors kata](http://nimblepros.com/katas) several times, and then the [String Calculator kata](http://nimblepros.com/katas). You can [download the Beginning Software Craftsmanship slides, katas, and the FizzBuzz demo that Brendan and I worked through here](http://ssmith-presentations.s3.amazonaws.com/CodeMash2012BeginningSoftwareCraftsmanship.zip).

## Intermediate Software Craftsmanship

In the afternoon PreCompiler, we continued delving into software craftsmanship and practice, with an emphasis on writing quality code. There was a quick repeat presentation on why software craftsmanship and practice are important, which was good since the afternoon session was standing room only with over 50 people in it at one point, so there were many new faces in addition to folks from the morning session. Brendan and I presented one lecture on refactoring and SOLID principles to set up the next kata, the [Gilded Rose refactoring kata](http://nimblepros.com/katas). This kata starts with some existing working code, which we provided in several different languages from online sources:

* <http://github.com/professor/GildedRose> Ruby
* <http://github.com/NotMyself/GildedRose> C#
* <http://github.com/wouterla/GildedRose> Java

The intent of this kata is to practice your refactoring skills, and also to practice working with legacy code that has no test coverage and is in fact very difficult to get under test. Working in pairs, the teams sought to implement the new feature requested in the kata while following the constraints and attempting to improve the overall design of the code (by, for instance, making it more [DRY](http://deviq.com/don-t-repeat-yourself) and applying the [SOLID principles](http://deviq.com/solid)).

Following the Gilded Rose kata, we worked through the Greed kata, which implements the rules of a simple dice game. Included in the download below are several implementations of this kata in C#, including one that uses a rules engine that allows new rules to be added while following the [Open/Closed Principle](http://deviq.com/open-closed-principle) (no changes need to be made to the scoring logic classes).

[Download the Intermediate Software Craftsmanship slides, katas, and demos here](http://ssmith-presentations.s3.amazonaws.com/CodeMash2012IntermediateSoftwareCraftsmanship.zip).

## A Lap Around ASP.NET MVC 4

On Thursday I gave a morning session on ASP.NET MVC 4. Unfortunately, I wasn’t able to talk about some of the new features that were under development due to NDA restrictions. However, that kind of changed about 30 minutes before my talk when Scott Hanselman announced several of the previously private features that were coming to MVC 4, namely integration of Web API directly into MVC and a few new project templates, including a single-page application template. Look for more info on these topics on [Scott’s blog](http://hanselman.com/) and/or from [the Gu himself](http://weblogs.asp.net/scottgu), soon.

My session focused on the new mobile features, recipes, and async features of MVC 4. You can find my [Lap Around ASP.NET MVC 4 slides and demos here](http://ssmith-presentations.s3.amazonaws.com/CodeMash2012LapAroundASPNETMVC4.zip).

Hope you enjoyed [CodeMash](http://codemash.org/) and I look forward to seeing you again soon. Feel free to follow me on [twitter (@ardalis)](http://twitter.com/ardalis) to join the conversation!