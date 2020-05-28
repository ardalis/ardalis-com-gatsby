---
templateKey: blog-post
title: Delaying Decisions
path: blog-post
date: 2008-09-13T02:20:00.000Z
description: I’ve recently finished reading Mary and Tom Poppendieck’s Lean
  Software Development title, which I’ll write a review of in a later post. One
  of the points they make, devoting a all of the book’s third chapter to it in
  fact, is that there is tremendous business value in delaying decisions.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - decisions
category:
  - Uncategorized
comments: true
share: true
---
I’ve recently finished reading [Mary and Tom Poppendieck’s Lean Software Development](http://www.amazon.com/exec/obidos/ASIN/9780321150783/aspalliancecom) title, which I’ll write a review of in a later post. One of the points they make, devoting a all of the book’s third chapter to it in fact, is that there is tremendous business value in delaying decisions.

> *Lean software development delays freezing all design decisions as long as possible, because it is easier to change a decision that hasn’t been made.*

The consequences of making hard-to-change decisions early is that when new information presents itself, it is difficult (and expensive) to adjust the design. Decisions that are trivial to change in the future can be made as needed – not every decision should be delayed. And delaying commitment on design decisions is not the same as procrastination. The authors go on to discuss the **last responsible moment**:

> *Concurrent development makes it possible to delay commitment until the* last responsible moment*, that is, the moment at which failing to make a decision eliminates an important alternative. If commitments are delayed beyond the last responsible moment, then decisions are made by default, which is generally not a good approach to making decisions.*

The key takeaway from this chapter, for me, is that Big Design Up Front / Waterfall approaches generate waste because they make design decisions early in the process before sufficient knowledge is available (not really news). Further, the authors go on to list a number of best practices for software that really bring this idea down from the level of project manager to the level of application developer. A few of these include:

* Make magic values parameters
* Use interfaces to decouple implementations from the application
* “Make magic capabilities like databases and third-party middleware into parameters. By passing capabilities into modules wrapped in simple interfaces, your dependence on specific implementations is eliminated and testing becomes much easier.”\
  Though they don’t use the term [Dependency Injection](http://en.wikipedia.org/wiki/Dependency_injection), this is what they are describing.
* Don’t build a custom framework; reuse what has worked in the past.[Jeffrey Palermo](http://jeffreypalermo.com/) wrote about this[here](http://jeffreypalermo.com/blog/i-ll-get-to-your-application-in-a-minute-first-we-need-to-build-the-framework).
* Avoid Repetition (aka [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself) and Once And Only Once ([OAOO](http://en.wikipedia.org/wiki/Once_and_only_once)))
* Separate Concerns (aka [SoC](http://en.wikipedia.org/wiki/Separation_of_Concerns) and [SRP](http://en.wikipedia.org/wiki/Single_responsibility_principle))
* Avoid Extra Features (aka [YAGNI](http://en.wikipedia.org/wiki/YAGNI))

Each of these recommendations, and several others, provide mechanisms by which key design decisions for an application can be delayed or easily changed. I believe each difficult (as in, difficult to change later) design decision can be thought of as having the following options:

* **Decide early**. For instance, decide that SQL Server and plain ADO.NET will be used for all data access, and commence writing all code for the project directly against the System.Data.SqlClient objects. Can be perfectly acceptable for small projects.
* **Don’t decide**. For instance, offer no guidance whatsoever, and allow each developer to do what they want. Some create domain objects, others drag DataSets into the code. Some wire up DAL layers, others talk to the database directly from the UI layer. Not recommended.
* **Delay the difficult decision**. For instance, create a Data Access Layer that returns stubbed out data at first, and then once it is clear that SQL Server will be used, write the System.Data.SqlClient code to fill out the Data Access Layer. If a decision has been made in the meantime to use another database, you’ve avoided wasted work and you can now write your DAL logic correctly.
* **Eliminate the finality of the decision**. This last option is different from delaying the decision – in essence it eliminates the need to make a hard decision by keeping options open. For instance, have a Repository class that is responsible for passing back your objects, and pass in an interface to the database to the Repository (e.g. IDataPersister). Within the repository, write all data retrieval/storage code against this interface. This use of Dependency Injection makes it trivial to change databases in the future, as only the concrete implementation of the data persistence interface need be adjusted. Recommended for non-trivial applications.

Keeping your code flexible enough to react quickly to future changes is a key tenet of agile software development.

The slower you respond, the sooner you have to make decisions. If it takes you a day to roll out a feature, you can delay deciding which feature to build until a day before it is needed. If it takes a month, then you’ll have to decide what to build a month before it will ship, and a lot can change during that time.

[![kick it on DotNetKicks.com](https://www.dotnetkicks.com/Services/Images/KickItImageGenerator.ashx?url=http%3a%2f%2fstevesmithblog.com%2fblog%2fdelaying-decisions%2f)](http://www.dotnetkicks.com/kick/?url=http%3a%2f%2fstevesmithblog.com%2fblog%2fdelaying-decisions%2f)