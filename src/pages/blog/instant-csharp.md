---
templateKey: blog-post
title: Review - Instant C# and Instant VB Code Conversion Utilities
date: 2007-01-15
path: blog-post
description: In this review, Steve goes over the features of Instant C# and Instant VB from Tangible Software Solutions, two code conversion products which translate from VB to C#, and vice versa.
featuredpost: false
featuredimage: /img/instant-csharp.png
tags:
  - reviews
category:
  - Software Development
comments: true
share: true
---

## Introduction

Since the introduction of .NET, the Common Language Runtime, and C#, developers with a preference for C# or Visual Basic have been faced with the task of converting source code written in one language to the other.  Whether to get an online sample working, to integrate some code developed by another team, or just to try and learn the ins and outs of the other language, converting from C# to VB and vice versa has been a common, often tedious task for many developers in the last few years.  For authors, trainers, and presenters, the task is even more common (and arduous), as samples developed in one language must often be converted to the other in order to maximize the reach of the training, article, book, or presentation.  Utilities that can automate this work have been few and far between (one popular one can be found online [at ASPAlliance.com](http://authors.aspalliance.com/aldotnet/examples/translate.aspx), though it is far from perfect and has no support for .NET 2.0).  [Tangible Software](http://www.tangiblesoftwaresolutions.com/)'s Instant C# and Instant VB packages provide the tools required to perform code conversions between C# and VB, whether for simple snippets or for complete projects.

## Source Code Conversion

This review covers two products, Instant C# and Instant VB.  I will switch between the two, and as you will see they are nearly mirror images of one another.

Instant C# is fairly intuitive to use.  It supports converting complete VB projects (1.x or 2.0) to C#.  A simple way to test this feature is to open up one of the [ASP.NET Starter Kits](http://www.asp.net/downloads/starterkits/default.aspx?tabid=62) in VB (or [VB Starter Kits](http://msdn2.microsoft.com/en-us/vbasic/ms789080.aspx)) and convert it to C#.  I tested the product using several different starter kits and found that it did a good job overall, but there were some things it was unable to convert without some developer interaction.  For instance, Resource files required some manual work to get working in C# after converting from VB.  On the whole, however, the projects were converted about 99% of the way and, of the ones I tested, compiled on the first try.

After converting a project, the tool displays the number of lines of code converted, how long it took (14 seconds for the VB Card Game Starter Kit on my machine), and a list of warnings and errors.  Comments are inserted into the converted code showing warnings and TODO items, with a summary report provided to make it easy to find and correct anything that needs to be manually converted (which is to be expected in any significant, real world project).

In addition to full project support, the tool also supports conversions at the snippet level, which is its most useful feature to me, personally.  When writing a demo for an article or presentation, I typically prefer to write it in C# first, and then convert if dictated by the audience.  I am capable of doing the conversion manually, but it is a time-consuming, tedious process.  Instant VB lets me take my C# code samples and immediately convert them into VB code, complete with support for 2.0 constructs like Generics.  As an example, consider this article on [Generics in C#](http://aspalliance.com/1100_using_generics_in_c).  Its Listing 5 shows an example of a Stack class that uses Generics, which is implemented in C#.  To convert this into VB for use in a VB library, simply cut-and-paste the code into Instant VB's Snippet Converter.

The result is VB code that works immediately, saving me a few minutes' worth of conversion and (quite likely) some errors on my part in the conversion process.  These minutes add up quickly when you add up all of the demos in a presentation, article, or book, not to mention the times when a solution found on the Internet is not in one's language of choice and needs to be converted.

The Folder Converter utility simply accepts a source folder and a target folder, and will convert all C# (or VB) files in the source folder into VB (or C#) and place the results in the target folder.  This is useful if you wish to convert a bunch of files that are not part of a project, or if you wish to convert a large project one folder at a time.  Since non-WAP web sites in Visual Studio 2005 are simply folders, the Folder Converter is the tool of choice to convert ASP.NET web sites.  It will convert all ASP.NET pages, App_Code files, etc. in the process.

The last tab, ASP.NET Snippets, supports converting ASPX pages which include inline VB (or C#) code in them.  This would have been quite useful to me a few years ago when I wrote the [ASP.NET Developer Cookbook](http://aspalliance.com/cookbook/) with other ASPAlliance authors.  All of its examples used inline ASPX pages to avoid the need for readers to have Visual Studio (since the popular Web Matrix tool did not use code-behind files).  Since all examples were offered in both VB and C#, a lot of manual conversion went into the effort.  With Instant VB, a [recipe like 0307 in C#](http://aspalliance.com/cookbook/ViewSource.aspx?Filename=Recipe0307cs.aspx&RecipeType=ASPX) could be converted to VB in a couple of seconds.

One general note about code conversion - it will be rare in a real world application that any tool will successfully convert a large real world application from one language to another without any developer intervention.  This is because the VB and C# teams are both trying to differentiate their languages and add value to their languages, often in ways that have no equivalent in the other language.  A good example of this is the yield keyword in C#, which does not exist in VB.  In order to write similar code in VB, one must rewrite not just the method where yield is found, but also the callers of that method, resulting in complexities that may be best left to real programmers to convert.  With that said, I have found the Instant C# and Instant VB products to be very robust, easy to use, and effective in my own use of these products.  The authors of these products share some of their insights into the [Art of Conversion Between VB.NET and C#](http://www.tangiblesoftwaresolutions.com/Conversion_Tips.htm) on their website.

## About the Product

I found [Tangible Software Solutions](http://www.tangiblesoftwaresolutions.com/index.htm) to be very easy to work with.  In the course of my review I had several questions and found one bug.  All of the questions were answered quickly and the bug was fixed the same day (a Saturday!) I reported it, with new versions of the applications immediately posted to the web site for download.  I was quite impressed with the level of support and responsiveness I received.

I also learned in the course of working with TSS that they heavily test the products using both private test suites as well as publicly available examples such as the [101 Samples available on MSDN](http://msdn2.microsoft.com/en-us/vstudio/aa718334.aspx) (in both VB and C#).

| Title     | [Instant C#](http://www.tangiblesoftwaresolutions.com/Product_Details/Instant_CSharp/Instant_CSharp.htm)  [Instant VB](http://www.tangiblesoftwaresolutions.com/Product_Details/Instant_VB/Instant_VB.htm)              |
|-----------|---------------------------------------|
| Publisher | Tangible Software Solutions           |
| Edition   | Instant C# 2.7.0.0 Instant VB 1.8.0.0 |
| Price     | US 179 each; $299 for both            |
| Rating    | ****                                  |

## Resources

[Code Conversion Tips](http://www.tangiblesoftwaresolutions.com/Conversion_Tips.htm)

[101 VB / C# Samples](http://msdn2.microsoft.com/en-us/vstudio/aa718334.aspx)

## Summary

I have been using Tangible's Instant C# and Instant VB for several months now, and have found that both have saved me many hours' worth of manual code conversion time.  They quickly pay for themselves, and the quality of the product and the support from the company have both greatly impressed me.  I highly recommend this product to anyone who finds him or her self converting code from VB to C#, or vice versa.  This is the best tool I am aware of for source code conversion.

Originally published on [ASPAlliance.com](http://aspalliance.com/1120_Review_Instant_C_and_Instant_VB_Code_Conversion_Utilities)
