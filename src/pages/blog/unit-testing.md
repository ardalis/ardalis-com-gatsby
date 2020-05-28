---
templateKey: blog-post
title: Unit Testing
path: blog-post
date: 2003-03-17T01:16:00.000Z
description: I’m really getting more and more into unit testing and testing
  frameworks. At the moment I’m using NUnit 2.0 for my test purposes as I
  redesign [ASPAlliance.com] content management system for integration into the
  Microsoft Codewise Community standard specification for Federated Search.
featuredpost: false
featuredimage: /img/unit-testing-1.jpg
tags:
  - DAL code test cases
  - Federated Search
  - Microsoft Codewise Community
  - NUnit 2.0
  - unit testing
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

I’m really getting more and more into unit testing and testing frameworks. At the moment I’m using NUnit 2.0 for my test purposes as I redesign [ASPAlliance.com](http://aspalliance.com/)‘s content management system for integration into the Microsoft Codewise Community standard specification for Federated Search. I’m working with a friend and fellow columnist, Jonathan Cogley, who suggested a this resource on [Unit Testing Database Code](http://www.dallaway.com/acad/dbunit.html).

I’ve developed my own set of DAL code test cases that I’ve been using for the last few months, but this article offers a fresh perspective on how to set up the testing environment for such components. One recommendation that the author makes is to have as many as 4 separate databases for an application, including a production database and a local developer database, as well as a central development db with realistic amounts of data and a deployment database with a copy of the production database for final testing. For my own development purposes, I think this would probably be overkill. However, I do like his idea of having test cases go against a database that is used solely for testing, and which the tests are responsible for populating with data and cleaning up. I plan to write an article of my own showing the standard NUnit test fixtures I’ve come up with for my DAL layer as soon as I have a content management system completed so that I can write the content!

That’s all for today. Hopefully some day soon I’ll be out from under the gun to produce books and/or application code and I’ll be able to crank out some of the many articles and book reviews that I now have on hold.

<!--EndFragment-->