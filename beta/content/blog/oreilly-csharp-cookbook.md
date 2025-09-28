---
title: Book Review - O'Reilly C# Cookbook
date: "2004-02-25T00:00:00.0000000"
description: A review of the C# Cookbook from O'Reilly, which uses the format of problem-solution recipes that has been growing in popularity in tech books in the last couple of years. Recommendation - this is a great reference for C# developers.
featuredImage: /img/csharp-cookbook-review.png
---

## Overview

![Cover](/img/csharp-cookbook-cover.jpg)

O'Reilly's *C# Cookbook*, by Stephen Teilhet & Jay Hilyard (not to be confused with the MS Press *C# Programmer's Cookbook* or the SAMS *Visual C#.NET 2003 Developers' Cookbook*), retails for $49.95 and is about 800 pages. It's about $35 from Amazon at the moment.

The book uses the 'cookbook' format that is becoming quite popular as evidenced by the two other C# cookbooks on the market, not to mention the [ASP.NET Developer's Cookbook](http://aspalliance.com/cookbook/) authored by Rob Howard, myself, and AspAlliance.com. This really is an excellent format for technical books that are beyond the tutorial level. They're intended to be used as a reference, just like a real cookbook so that you don't need to commit to memory every common task you might face. As a C# developer, sure, you can probably do a lot of these things without a book, but with the book as a reference, you can ensure that you'll do them **right**, and you'll free up space in your brain for more important details (whatever you might deem those to be).

The other nice thing about this format of book is that it is very easy to get a feel for its usefulness. With most dialog-driven books, you have to read a lot of explanatory text from the author(s) as they guide you through chapter after chapter. With the recipe format, you can simply flip through the book, read the recipe titles, examine the authors' approach to the problem, and read the "Discussion" section only if you're particularly interested. I received this 800-page book yesterday and, because of this format, today I've read enough of it that I feel comfortable reviewing it. As a disclaimer, I will point out that I haven't taken the opportunity to test the authors samples to any extent, so I am placing some faith in their ability to provide tested, best practice code.

## Chapter Breakdown

Basically, I skimmed through the book looking for recipes of interest to me. These won't necessarily be the ones that are of interest to you, but if you really just wanted a copy of the table of contents, you'd read it on [O'Reilly's website](http://www.oreilly.com/catalog/csharpckbk/toc.html), right?

1."Numbers" - pretty basic, but good place to find common tasks like radians to degrees and numeric conversions. Devoted ten pages to"Safely Performing a Narrowing Numeric Cast." Impressive, but not something I do all that often, if ever.
2."Strings and Characters" - a lot of common task stuff and some things I don't do often enough to keep in memory like"Encoding/Decoding Binary Data as Base64" and"Passing a String to a Method that Accepts Only a Byte []."
3."Classes and Structures" - good coverage of all the ToString() overloads one should modify if going that route (as opposed to just using the method without parameters). Good coverage of polymorphism and inheritance--implementation and interfaces--with examples and when to use. I'll definitely refer to the IComparable and IComparer implementations to make a"Type Sortable or Searchable." 3.14 describes how to know when to use type casting, the"as" operator, or the"is" operator, which is helpful. Good concrete examples of some patterns like"Singleton," "Facade," and"Memento." 3.23 is a nice reusable class for parsing command line parameters."Creating Your Own Object Cache." "Serialization." "Allowing an Object to Rollback Changes."
4. Enums - Discusses how to convert enumerations and how and when to test that Enum-typed parameters have valid values being passed in.
5. Exception Handling - unlike most chapters, devotes several pages to general discussion of syntax and technique. The seventeen recipes covered pretty much everything I know about exceptions and quite a bit more (not that I'm an expert, but I know how to use try-catch-finally and how to write my own exceptions).
6. Diagnostics - Includes information on tracing, event logging, and perfomance counters. Good references, based on a quick browse of the chapter.
7. Delegates and Events - One of the more advanced features of C#, there is no hand-holding here. The first recipe is pretty advanced to me (e.g.,"Controlling When and If a Delegate Fires Within a Multicast Delegate"), and the only coverage of how and when to use delegates is a few paragraphs and a reference to read the MSDN docs. This isn't a bad thing--this is not a beginner's book. This chapter goes on to cover a variety of advanced topics related to"Multicast Delegates," "Async vs. Sync Delegates," and of course"Events." Several concrete examples of the"Observer" design pattern are also included here.
8. Regular Expressions - Covers the use of System.Text.RegularExpressions namespace objects, including searching, replacing, groups, tokenizing, and a bunch of common patterns. Failed to mention the best place to find common patterns, [regexlib](http://regexlib.com/), but did mention the best book on regular expressions: *Friedl's Mastering Regular Expressions, Second Edition*, also by O'Reilly.
9. Collections - This chapter gives a quick overview of the System.Collections classes (and.Specialized) and then includes a bunch of useful recipes for working with collections, e.g., swap elements, reverse order, count occurrances, strongly-typed collections, and persisting collections. Unfortunately, since this is a.NET 1.1 book, there is no mention of generics here, or the built-in generic collections that will ship with 2.0. This is fine, since 2.0 is not even in beta yet, but just the same, look to see an update of this book in a year or so.
10. Data Structures and Algorithms - Includes some data structures and algorithms that are not found in the Framework Class Library such as creating hash codes, implementing priority queues, Multimap collection, binary trees, sets, and more. Pretty much all of this is outside the norm for my work and definitely not what I would call"common tasks," but it's a great reference for when you need some of these features.
11. File System I/O - Includes the common task stuff like create/copy/move/delete files and folders, as well as a lot of the hard-to-remember things like how to parse and append paths together the right way. Also covers the FileSystemWatcher, which can be great when coupled with a caching system to minimize disk reads.
12. Reflection - Reflection is a very powerful feature in.NET but not one that a lot of developers are familiar with. This chapter makes it very easy to do some common reflection tasks by providing all of the code needed. Listing of assemblies, types, methods, etc. is covered. Searching for members within assemblies or interfaces is covered. Also demonstrates how to control code using attributes and how to dynamically call members at runtime (late binding).
13. Networking - Covers DNS lookups, URI parsing, web requests, TCP clients and servers, and named pipes (for about 15 pages).
14. Security - Demonstrates the"Proxy" design pattern, encryption/decryption of strings and files, and code access security. Also deals with protecting assemblies from modification and attack.
15. Threading - Demonstrates the right way to deal with thread-safe static members, locking, using async delegates, using the Threading.Timer, and a few more tasks.
16. Unsafe Code - Everything I used to know about pointers but have gladly forgotten with.NET appears to be in here.
17. XML - Covers common tasks from the System.Xml namespace. The only thing I'd say it neglects is to show the 'easy way' to create simple Xml documents by using the ADO.NET DataSet. Apart from that, though, it shows the basics of working with XML documents.

## Summary

I would definitely recommend this book. I haven't looked at the other C# cookbooks out there, but I have looked at many of the beginner and comprehensive books out there, like *Professional C#* and *Inside C#*. *Inside C#* is still my pick for a beginner's introduction to C#--a beginner with C#, not a beginner to programming. However, for reference, once you've been using C# for six months or a year, I would definitely recommend O'Reilly's *C# Cookbook*. And I'm pretty sure in 12-18 months I'll be picking up a v2 edition that includes coverage of all the cool new stuff coming, like generics, shared classes, anonymous methods, etc.

If you would like to share your opinion of this book or any other reviews with other ASP.NET developers, sign up for the [reviews list on AspAdvice.com](http://aspadvice.com/SignUp/list.aspx?l=70&c=16).

Originally published on [ASPAlliance.com](http://aspalliance.com/381_Book_Review_OReilly_C_Cookbook).

