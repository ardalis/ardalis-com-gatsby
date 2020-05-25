---
templateKey: blog-post
title: Keynote Notes For Developers
path: blog-post
date: 2006-06-12T04:17:36.388Z
description: In the latter half of the keynote there was one small piece for
  developers, showing off Expression Interactive Designer (which integrates
  nicely with ASP.NET and VS.NET) and the new [Visual Studio 2005 Team System
  For Database Professionals], which they have about 4,000 cds with the first
  CTP bits on them that will be handed out later today.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Cool Tools
  - VS.NET
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

In the latter half of the keynote there was one small piece for developers, showing off Expression Interactive Designer (which integrates nicely with ASP.NET and VS.NET) and the new [Visual Studio 2005 Team System For Database Professionals](http://msdn.microsoft.com/vstudio/teamsystem/products/dbpro), which they have about 4,000 cds with the first CTP bits on them that will be handed out later today. The v1 story for VSTO:DB is going to include SchemaCompare, DataCompare, Unit Testing, an improved SQL Editor for Visual Studio, and Database Source Control. It will not include Intellisense, but I’ve grown to like [SqlPrompt](http://red-gate.com/products/SQL_Prompt/index.htm) from [Red Gate](http://red-gate.com/) (and you can’t beat the price – it’s free for a limited time). Another tool that \*will\* be included with [VS2K5TS4DB](http://msdn.microsoft.com/vstudio/teamsystem/products/dbpro) is a data generator that will generate “production-like” data for test cases.

For that matter, users looking for SQL Compare and Data Compare applications today should really check out Red Gate’s offerings. You can’t beat the functionality for the price from anything I’ve seen today.

Some things I would like to see in the DB tools space for a later version of [VS2K5TS4DB](http://msdn.microsoft.com/vstudio/teamsystem/products/dbpro) include:

* Static Analysis to enforce best practices
* Templates for Tables — allowing new tables to be created from a base template.
* Intellisense – a la SQLPrompt

This morning the RDs had a discussion with Matt Nunn, a PM for the new DB tool, and one of the things he shared that I thought was helpful is that the way most people work on databases today is a lot like how most people worked on websites 10 years ago. Ten years ago, websites were typically shared applications that were edited in production more often than not. There was little use of or support for version and source control. This is true today of many databases, although there are plenty of roll-your-own database version control implementations I’ve worked with. But to date there hasn’t been any tools support for source control for databases. In addition to providing these tools, the hope is that the process for how databases are managed will be changed. Just as most significant web applications have a process for building them locally and on staging servers, so too will database changes be managed more commonly in this fashion (and to be sure, many people are doing this today, but now they’ll have a tool that will hopefully make their lives easier).

Look for RTM for [VS2K5TS4DB](http://msdn.microsoft.com/vstudio/teamsystem/products/dbpro) late this year (November/December I would say).

<!--EndFragment-->