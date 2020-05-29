---
templateKey: blog-post
title: Don’t Repeat Yourself
path: blog-post
date: 2009-10-09T20:45:00.000Z
description: Of all the principles of programming, Don’t Repeat Yourself (DRY)
  is perhaps one of the most fundamental. The principle was formulated by Andy
  Hunt and Dave Thomas in The Pragmatic Programmer, and underlies many other
  well-known software development best practices and design patterns.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - DRY
category:
  - Uncategorized
comments: true
share: true
---
### *(this is a submission I made to the upcoming [97 Things Every Programmer Should Know](http://programmer.97things.oreilly.com/wiki/index.php/97_Things_Every_Programmer_Should_Know) book)*

Of all the principles of programming, Don’t Repeat Yourself (DRY) is perhaps one of the most fundamental. The principle was formulated by Andy Hunt and Dave Thomas in *The Pragmatic Programmer*, and underlies many other well-known software development best practices and design patterns. The developer who learns to recognize duplication, and understands how to eliminate it through appropriate practice and proper abstraction, can produce much cleaner code than one who continuously infects the application with unnecessary repetition.

**Duplication is waste**

Every line of code that goes into an application must be maintained, and is a potential source of future bugs. Duplication needlessly bloats the codebase, resulting in more opportunities for bugs and adding accidental complexity to the system. The bloat that duplication adds to the system also makes it more difficult for developers working with the system to fully understand the entire system, or to be certain that changes made in one location do not also need to be made in other places that duplicate the logic they are working on. DRY requires that "Every piece of knowledge must have a single, unambiguous, authoritative representation within a system."

**Repetition in process calls for automation**

Many processes in software development are repetitive and easily automated. The DRY principle applies in these contexts as well as in the source code of the application. Manual testing is slow, error-prone, and difficult to repeat, so automated test suites should be used, if possible. Integrating software can be time consuming and error-prone if done manually, so a build process should be run as frequently as possible, ideally with every check-in. Wherever painful manual processes exist that can be automated, they should be automated and standardized. The goal is to ensure there is only one way of accomplishing the task, and it is as painless as possible.

**Repetition in logic calls for abstraction**

Repetition in logic can take many forms. Copy-and-paste*if-then*or*switch-case*logic is among the easiest to detect and correct. Many design patterns have the explicit goal of reducing or eliminating duplication in logic within an application. If an object typically requires several things to happen before it can be used, this can be accomplished with an Abstract Factory or a Factory Method. If an object has many possible variations in its behavior, these behaviors can be injected using the Strategy pattern rather than large*if-then*structures. In fact, the formulation of design patterns themselves is an attempt to reduce the duplication of effort required to solve common problems and discuss such solutions. In addition, DRY can be applied to structures, such as database schema, resulting in normalization.

**A Matter of principle**

Other software principles are also related to DRY. The Once and Only Once principle, which applies only to the functional behavior of code, can be thought of as a subset of DRY. The Open/Closed Principle, which states that "software entities should be open for extension, but closed for modification," only works in practice when DRY is followed. Likewise, the well-known Single Responsibility Principle requires that a class have "only one reason to change," and relies on DRY.

When followed with regard to structure, logic, process, and function, the DRY principle provides fundamental guidance to software developers and aids the creation of simpler, more maintainable, higher-quality applications. While there are scenarios where repetition can be necessary to meet performance or other requirements (e.g., data denormalization in a database), it should be used only where it directly addresses an actual rather than an imagined problem.

(see also:[Don’t Repeat Yourself motivational poster](https://deviq.com/don-t-repeat-yourself/))

I expand on this principle in a 3-part video series as part of the [Principles of OO Design course available from Pluralsight](http://www.pluralsight-training.net/microsoft/olt/course/toc.aspx?n=principles-oo-design). This principle is also featured in the [Software Craftsmanship Calendar](http://nimblepros.com/products/software-craftsmanship-2011-calendar.aspx).