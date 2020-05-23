---
templateKey: blog-post
title: Growing Object-Oriented Software Guided By Tests Book Review
path: blog-post
date: 2012-09-12T22:05:00.000Z
description: I finished this book a while back and just haven’t had a chance to
  write about it until now. Growing Object-Oriented Software, Guided by Tests is
  a bit of a mouthful of a title, but it does describe the subject matter of the
  book pretty well.
featuredpost: false
featuredimage: /img/phone-1052023_1280.jpg
tags:
  - book
  - oop
  - review
  - tdd
category:
  - Software Development
comments: true
share: true
---
[](http://amzn.to/PtMIrE)I finished this book a while back and just haven’t had a chance to write about it until now. [Growing Object-Oriented Software, Guided by Tests](http://amzn.to/PtMIrE) is a bit of a mouthful of a title, but it does describe the subject matter of the book pretty well. I noted a few points of interest as I read the book, as I tend to do, that I’d like to share here along with my overall thoughts.

I’ve read quite a few books on unit testing and writing quality software, so many of the concepts here were not necessarily new to me. However, I do find that it’s valuable to see such topics presented from a variety of viewpoints, and since I also present and teach these subjects, I’m always looking for new ways to help others learn these concepts. This book does a great job of introducing testing and TDD while building up a real world application, which is something many other books on this subject avoid. That alone I think makes the book worth checking out if you’d like to learn or reinforce your grasp of these concepts.

The authors are also active and receptive to questions on [the book’s mailing list (Google Group).](https://groups.google.com/forum/?fromgroups#!forum/growing-object-oriented-software)

The book’s samples all use Java and various frameworks available on the Java platform. Since I’m mainly a Microsoft/C# developer, I was able to follow the samples effectively, but there were some areas where I was left wondering if I would have done things the same way (mainly in areas like C# generic support, LINQ, and lambda expressions). I don’t think this detracted overly much from the book, though, so I have no problem recommending it to other C# developers.

Early on in the book, the authors (Steve Freeman and Nat Pryce) discuss quality. In particular, they call out the difference between external and internal quality, and they further identify how different kinds of tests provide feedback on different kinds of quality. To sum up, external quality is the quality of a system from a user’s perspective, and cares nothing for how nicely structured the underlying code might be. On the other hand, internal quality describes how well the system meets the needs of its developers and administrators, regardless of how well it achieves its business purpose. Unit tests tend to be most useful at providing feedback on internal quality, while end-to-end tests end to provide the most feedback on external quality. These days, it’s common practice for people to overuse the term “unit test” for any sort of test at all, and having this distinction of how different kinds of tests provide different kinds of feedback on a system might help reduce some of this ambiguity.

A bit later in the book, the authors make a statement that they themselves note might have been right at home in the Agile Manifesto. To wit, “We value code that is easy to maintain over code that is easy to write.” Spot on, is all I can say.

Getting more into the practical side of things, I liked the idea of Defect Exceptions the authors describe. I’ve done something similar once or twice, but never given it such a good description as they do here:

> *In most systems we build, we end up writing a runtime exception called something like **Defect** (or perhaps **StupidProgrammerMistakeException**). We throw this when the code reaches a condition that could only be caused by a programming error, rather than a failure in the runtime environment.*

These kinds of exceptions are similar to the use of Asserts within your production code, and can save you some time debugging something that might otherwise appear to be a runtime problem.

In chapter 22, the authors introduce the concept of Test Data Builders, which they use to build up the necessary data for their tests in very succinct, but clear ways. This is a great idea for unit and integration tests that really boosts the readability and maintainability of the test code, and it’s definitely something I intend to put into practice in the future.

I made one note where I have to disagree with the authors. On page 297 they note their preference “not to name classes or interfaces after patterns” using terms like “Repository.” Their argument is that “the clients of \[a class] do not care what patterns it uses.” Here I respectfully disagree, since frequently the use of a pattern name in the name of a class makes its intent and how one expects to use it much more clear. Repository is a perfect example of a pattern name that I absolutely expect to be in the name of classes that follow the pattern. Command and Factory are two more patterns that frequently are useful to see in the names of classes that follow these patterns, and when someone sees these classes’ names, the inclusion of the pattern name provides a great deal of additional information into how these classes are used.

It’s worth noting that this book does an excellent job of introducing mock objects, albeit not using any of the various .NET mocking frameworks or tools. Many of the older books on TDD and unit testing spend most of their time on state-based test patterns rather than behavior-based tests that utilize mock objects. If you’d like to improve your understanding of mock objects as they apply to unit testing, I would recommend this book to you as well.