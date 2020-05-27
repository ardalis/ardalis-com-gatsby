---
templateKey: blog-post
title: Refactoring with SOLID at FalafelCon
path: blog-post
date: 2013-06-11T16:49:00.000Z
description: Yesterday I presented at the first ever FalafelCon conference in
  Mountain View, California. My session Refactoring with SOLID Principles is now
  available on SlideShare. I was a little pressed for time, so I had to cover
  some of the material quickly.
featuredpost: false
featuredimage: /img/conference.jpg
tags:
  - clean code
  - conference
  - presentation
  - refactoring
  - solid
  - speaking
category:
  - Software Development
comments: true
share: true
---
[](http://www.falafel.com/falafel-con-2013)Yesterday I presented at the first ever [FalafelCon conference](http://www.falafel.com/falafel-con-2013) in Mountain View, California. My session [Refactoring with SOLID Principles is now available on SlideShare](https://www.slideshare.net/ardalis/refactoring-withsolid). I was a little pressed for time, so I had to cover some of the material quickly. For more information, I encourage you to check out my [SOLID Principles of Object Oriented Design](https://pluralsight.com/training/Courses/TableOfContents/principles-oo-design) course. There were a couple of questions from the audience about regions and XML comments, and I’ve written previously about my thoughts on these ([Regional Differences](/regional-differences), [When to Comment Your Code](/when-to-comment-your-code)). If you’re looking for the simple demo site I showed along with the presentation, you can find my [Guest Book application here](https://bitbucket.org/ardalis/guestbook). In it I demonstrate how to test an application that uses infrastructure, like sending emails, without having to actually send emails or set up a fake email server (like [smtp4dev](http://smtp4dev.codeplex.com/), which is a great tool, but not for automated unit tests).

Another question I had after this particular talk was, had I comingled the Dependency Inversion Principle with Dependency Injection? I’m sure I must have, to some extent, since I see them as closely related. The DI principle can be used as the basis for reversing dependencies; then dependency injection, which I usually do by following the Strategy design pattern, can be used to allow the formerly tightly coupled code to work in a loosely coupled fashion. Check out the [Strategy Design Pattern in the Pattern Library on Pluralsight](http://pluralsight.com/training/Courses/TableOfContents/patterns-library) to learn more.

I’m currently working on a Refactoring Fundamentals course for Pluralsight, which will go into more detail on the specific steps to take to refactor code, as well as covering a wide range of code smells that may be indicators that refactoring is warranted. Look for it to be published in summer 2013.