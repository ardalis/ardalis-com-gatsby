---
templateKey: blog-post
title: Review - eXtreme.NET by Dr. Neil Roodyn
date: 2008-03-06
path: blog-post
description: In this article, Steve gives his feedback on Dr. Neil's book on applying Extreme Programming (XP) principles to .NET development.
featuredpost: false
featuredimage: /img/xtreme-dotnet.png
tags:
  - xp
  - extreme programming
  - reviews
  - book
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Review

*eXtreme .NET* by Dr. Neil Roodyn provides a good introduction to Extreme Programming (XP) to .NET developers.  The book's examples are in C# and include common XP tasks such as refactoring and writing unit tests.  The book also includes exercises for the reader, which provide opportunities to gain practical experience, and which also may make the book appropriate for use in a classroom setting.

Extreme Programming is a fairly large topic with a good bit of history behind it at this point, having been first developed and popularized in the 90s.  The XP practices that are covered in *eXtreme .NET* include:

- Whole Team (a.k.a. On-Site Customer)
- Planning Game
- Pair Programming
- Test-Driven Development
- Constant Refactoring
- Spiking
- Continuous Integration
- Stand-Up Meetings

I'd read most of the [Extreme Programming books by Beck](http://www.amazon.com/exec/obidos/ASIN/0321278658/aspalliancecom) and friends before reading this book.  Most of the titles in the Extreme Programming series spend a lot of time on historical anecdotes and explanations of why XP can work.  eXtreme .NET sort of assumes that we're at the point now where we realize that XP can and often does work very well, and so it takes the more practical approach of actually showing just how to implement its practices using .NET.

Dr. Neil uses a number of open source tools to implement tests and continuous builds.  For testing, the book uses [NUnit](http://nunit.org/), which is probably the most popular unit testing framework for .NET.  For continuous builds, he starts with the simplest thing that will work, which in this case is a batch file that runs continuously.  However, he also introduces [NAnt](http://nant.sourceforge.net/), an open source tool that can define various tasks, dependencies and variations in managing software builds.  Personally I use [MSTest](http://msdn2.microsoft.com/en-us/library/ms182489(VS.80).aspx) for my unit testing and [Cruise Control](http://ccnet.thoughtworks.com/) for my continuous integration (and [MSBuild](http://msdn2.microsoft.com/en-us/library/0k6kkbsd.aspx) instead of NAnt), but I've used NUnit/NAnt in the past and the differences between these systems are not great.

There were a couple of chapters I personally found to be very interesting.  The first one was Chapter 6, Spiking.  The goal of spiking is to learn as much as possible in a short period of time about a previously unknown part of a software project, to make estimation of the real work more accurate.  The term doesn't really appeal to me, but the idea makes sense, and this chapter did a great job of showing how it might work with a practical scenario and example.

The second chapter that I thought stood out was Chapter 8, More Testing.  This chapter boldly faced the challenge to unit testing that is user interface testing, and demonstrated that it can be done.  In this case, the user interface in question was a .NET windows forms application, so if you've been struggling with how to apply unit tests to your windows applications, this chapter alone might make the book worth your time.  It also discusses writing tests for third party libraries and frameworks (as well as when and why you should do so).

There were a few things I found lacking in the book, not because it suggested it would cover them but simply because they are areas of testing and XP that I'm still trying to learn better myself.  These include somewhat advanced topics of mocking objects as well as testing of web applications.  If you're looking for coverage of these topics, you will need to look elsewhere, as they are not covered in this book.

## Summary

Overall, I enjoyed this book and would recommend it to .NET developers looking to learn more about XP and its practices.  It's a light, fairly quick read that manages to cover a lot of practical concepts very well.  I didn't find it boring or dry, and it didn't overwhelm me with huge amounts of code, while at the same time the examples didn't seem overly simplistic.  Aside from a few advanced topics I wish it had included, I have nothing but good things to say about it.

## About the Book

| Title       | eXtreme .NET    |
|-------------|-----------------|
| Author      | Dr. Neil Roodyn |
| Publisher   | Addison Wesley  |
| Edition     | First           |
| Pages       | 300             |
| Price       | US $39.99       |
| Rating      | ****            |
| Related URL | Amazon.com      |

Originally published on [ASPAlliance.com](http://aspalliance.com/1609_Review_eXtremeNET_by_Dr_Neil_Roodyn)
