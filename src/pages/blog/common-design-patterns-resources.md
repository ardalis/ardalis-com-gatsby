---
templateKey: blog-post
title: Common Design Patterns Resources
path: blog-post
date: 2011-07-13T12:30:00.000Z
description: Last night I gave a presentation at the [Cleveland .NET
  SIG](http://twitter.com/#!/banetsig) on Common Design Patterns. The turnout
  was great, so much so that the group ran out of pizza and chairs, so thanks to
  everyone for taking the time to come out!
featuredpost: false
featuredimage: /img/background-2462434_1280.jpg
tags:
  - design patterns
category:
  - Software Development
comments: true
share: true
---
Last night I gave a presentation at the [Cleveland .NET SIG](http://twitter.com/#!/banetsig) on Common Design Patterns. The turnout was great, so much so that the group ran out of pizza and chairs, so thanks to everyone for taking the time to come out! Thankfully the A/C held up pretty well (in years’ past, it’s been an issue there), and I hope everybody enjoyed the topic and discussion. I promised that I would post the slides and demos here, so I am, along with a few links to other resources.

* [Download my Common Design Patterns slides and sample code](http://ssmith-presentations.s3.amazonaws.com/CommonDesignPatterns_20110712.zip). You can also [view my sample code directly on CodePlex as it’s checked into its own fork of the MVC Music Store there](http://mvcmusicstore.codeplex.com/SourceControl/network/Forks/ssmith/MvcMusicStoreRepositoryPattern).
* [Learn more about Design Patterns](http://www.pluralsight-training.net/microsoft/courses/TableOfContents?courseName=patterns-library) using PluralSight’s Patterns Library (to which I’ve contributed a few patterns)
* [Learn more about OOP principles like Single Responsibility, Open/Closed, DRY](http://www.pluralsight-training.net/microsoft/courses/TableOfContents?courseName=principles-oo-design), etc. from my PluralSight Principles of OO Design course
* I link to a few good patterns books in my slides, but here’s a quick summary:
* * [Design Patterns](http://amzn.to/95q9ux) (the reference)
  * [Design Patterns Explained](http://amzn.to/cr8Vxb)
  * [Design Patterns in C#](http://amzn.to/bqJgdU)
  * [Head First Design Patterns](http://amzn.to/aA4RS6) (my [review here](/head-first-design-patterns))
  * [Domain Driven Design](http://t.co/dF66TPQ) – includes the Repository pattern, among others
  * [Applying Domain-Driven Design and Patterns](http://t.co/k1OhQfn) – shows how to put everything together
* If you’re interested in anti-patterns, as well as patterns, you should read [Principles, Patterns, and Practices of Mediocre Programming](/principles-patterns-and-practices-of-mediocre-programming)
* I discuss the [Four Stages of Learning Design Patterns here](/the-4-stages-of-learning-design-patterns)
* You can learn more about the [CachedRepository pattern (using Proxy + Repository) in this post](/introducing-the-cachedrepository-pattern)
* I mentioned that I’ve done a few [dnrTV episodes](http://www.dnrtv.com/) lately on design patterns as well:
* * [Commonly Used Design Patterns (Part One)](http://www.dnrtv.com/default.aspx?showNum=194) – Mostly the same material as the talk in Cleveland last night.
  * [Design Patterns in .NET (Part Two)](http://www.dnrtv.com/default.aspx?showNum=196) – Demonstrates some more hands-on demos and refactorings, walking through applying some of the patterns covered in Part 1
  * [Design Patterns in .NET (Part Three)](http://www.dnrtv.com/default.aspx?showNum=201) – Shows an evolving design that eventually benefits from the State and Null Object patterns

I mentioned a [poll I ran, asking “In the last six months, how have you used these design patterns?”](http://twtpoll.com/r/t7jzrx) with options ranging from “What’s That?” to “Daily”. Here are the results:

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Common-Design-Patterns-Talk-in-Cleveland_8CB2/image_5.png)

You can gauge which ones are most popular by looking at the Orange/Blue/Red values on the right. The least used and/or least well-known patterns have the widest Dark Red, Blue, and Green bands. I apologize that this isn’t the best visualization possible, but it’s what TwtPoll gives us. Basically, though, if you look at where Green and Orange meet, that’s a reasonable first order estimate of the pattern’s real-world usage, according to about 300 respondents. The further to the left that point is, the more popular the pattern is. Thus, the Factory and Repository patterns would be the most popular ones listed here. Singleton, Adapter, Iterator, and Observer would be next in line. Looking at the Red-Daily numbers, you can see that Repository and Iterator are used *all the time* by a large percentage of respondents. I didn’t talk about the Iterator pattern, but these days it’s baked into our frameworks so we don’t even notice that we’re using it when we use foreach, IEnumerable, LINQ, etc. I suspect more people use it than said so in the poll, without even realizing it. Bridge and Memento are the winners (losers) in the least-used and least-known patterns (of those listed) category.

My dnrTV talk where I show how to implement the Null Object pattern, that I mentioned last night, went live yesterday and is linked above ([Part Three](http://www.dnrtv.com/default.aspx?showNum=201)). If you saw my quick demo of Null Objects and want to learn more about how and when to use them, check out that show. For a more detailed explanation of these and other patterns, if you prefer screencasts and code to books, I highly recommend the [Pluralsight Design Pattern Library](http://www.pluralsight-training.net/microsoft/courses/TableOfContents?courseName=patterns-library). There’s a bunch of good stuff in there and I’ve learned a lot about how to implement many of these patterns by watching others’ videos on PluralSight.

Toward the end of my talk last night, one of the attendees asked (paraphrasing) “Is it ever the case that patterns are used too much, resulting in too much abstraction and complexity?” Yes! In fact, that’s a stage I think virtually everybody goes through as they move through the [stages of learning design patterns](/the-4-stages-of-learning-design-patterns). The best way to apply patterns is via refactoring, once you feel some pain and you recognize that this particular pain can be alleviated by a design pattern. Be very careful, unless you’re very experienced with the pattern in question, about building systems from scratch that rely on many design patterns before you have gained knowledge actually building the system (that is, beware [Big Design Up Front](http://en.wikipedia.org/wiki/Big_Design_Up_Front) and prefer [YAGNI](http://en.wikipedia.org/wiki/YAGNI)).