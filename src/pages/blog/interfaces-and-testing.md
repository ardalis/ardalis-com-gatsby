---
templateKey: blog-post
title: Interfaces and Testing
path: blog-post
date: 2008-09-12T02:27:00.000Z
description: Chris Brandsma posted his thoughts on a discussion he had about
  interfaces as a requirement for TDD (or unit testing in general, I would say).
  I added a brief comment there but wanted to expand on my thoughts here, as I
  only fairly recently came to believe my current stance.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - interfaces
category:
  - Uncategorized
comments: true
share: true
---
[Chris Brandsma posted his thoughts on a discussion he had about interfaces as a requirement for TDD](http://elegantcode.com/2008/09/11/are-net-interfaces-required) (or unit testing in general, I would say). I added a brief comment there but wanted to expand on my thoughts here, as I only fairly recently came to believe my current stance. See, I’ve heard that interfaces were a “good thing” for years and as Chris points out, plenty of authoritative Software Development books extol the virtues of programming to interfaces as a means of providing loose coupling and other benefits.

**Program to Interfaces = Good**

**Program to Implementation = Bad**

I read this in these Design Pattern and similar books, and nodded (in my head, not really while I was reading) in agreement that the explanation made sense. And then I would go write code for my own apps, apps which traditionally did not require a plug-in architecture or support for more than one database. And I would struggle to find the value in adding interfaces anywhere when really I just **knew** that my data access layer was only ever going to talk to SQL Server and if that ever changed well it really wasn’t all that difficult to Find+Replace SqlConnection with OracleConnection, for example.

At some point, though, I started to really buy into unit testing. I decided I would take the plunge, and while I don’t always to Test-First Development, I do try very hard to at least do Test-Right-After Development, with some Test-First sprinkled in (especially when pair programming, when it seems easier to maintain the discipline). For a while I avoided mock objects because “they don’t really test that the code really works” and I wrote unit tests that most people (including me, today) would call integration tests that actually hit the database as part of their execution. These worked great at first, and gave me a very good feeling that my code was actually working all the way down the stack, as the DB schema and sample data were repopulated with every test. But after we reached about 100 tests, the whole suite was taking about 5 minutes to run, and we really started to feel the slowdown.

At that point, I started to buy into the whole mocking idea, and having read [Working Effectively with Legacy Code](http://aspadvice.com/blogs/ssmith/archive/2008/05/13/Book_3A00_-Working-Effectively-With-Legacy-Code.aspx), I started to realize that unit tests need to be fast and need to avoid dependencies on files, databases, web services, and anything but raw code. I came to the conclusion that Dependency Injection was the key to loosely coupled classes and fast unit tests, and Mocks go very nicely with DI. And IoC containers make the whole switch from production implementations to test implementations a snap (though I’m still very much a novice in the IoC world).

I started creating interfaces for things like the File System so that I could inject these into my classes that depended on file I/O and test them (via mocks) without the dependence on the actual file system. I created more interfaces for my data access (of course – and for these there were many existing interfaces I just hadn’t needed before), and other dependencies. Eventually I had an epiphany that justified all of these interfaces, even for classes that were only used by one other class:

**If your tests reference a class, and so do other classes in your production code, then the class really is being used by more than one class (and therefore, an interface may make a lot of sense).**

This is no doubt obvious to many folks (and to me, after the fact 🙂 ), but it’s a combination of two things that I’d learned but hadn’t put together:

* Use Interfaces so that you can decouple multiple classes’ references to another class (separate the interface from the implementation)
* Treat tests like production code

If you don’t treat your tests like production code, it’s very easy to think that adding an interface to a class that is only called by one other class in your application is a waste of time – it’s only used in one place so no need. However, if you do consider tests to be “real” code, and you have to test that class, then it now has multiple classes accessing it and may therefore benefit from decoupling its interface from its implementation. In addition to being more testable, if done correctly the resulting code have less coupling, should be easier to understand, and should have finer-grained objects that better follow the Single Responsibility Principle.