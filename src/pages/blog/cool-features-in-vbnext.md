---
templateKey: blog-post
title: Cool Features in VBNext
path: blog-post
date: 2005-10-04T13:38:04.928Z
description: "I was a VB developer for several years (VB5/6) before .NET came on
  the scene, and I started doing most of my work in C# (though I still can do VB
  in a pinch, and often need to translate to/from it for articles, etc.). "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - C#
category:
  - Uncategorized
comments: true
share: true
---
I was a VB developer for several years (VB5/6) before .NET came on the scene, and I started doing most of my work in C# (though I still can do VB in a pinch, and often need to translate to/from it for articles, etc.). I’ve been learning all about LINQ this summer at Tech Ed, PDC, MVP Summit, etc. and it’s largely being pushed by Anders and the C# team, which kind of implies that it’s mainly a C# oriented technology (although they do say it will “also” work on VB). Today I saw LINQ once more, but this time presented by a member of the XML team whose language prefernce is VB, and during (and following) the presentation he demonstrated a number of cool things VB is likely to support in its next version.

One thing that is interesting about the LINQ implementation is that VB will use a more SQL-like ordering of statements when performing LINQ operations. So, instead of C#:

**from Customers c**\
**where c.Name=’Steve’**\
**select c.Age**

The VB version might be (from memory – syntax is probably off a bit):\
**Select c.Age**\
**From c In Customers**\
**Where c.Name = ‘Steve’**



This is a fairly simple difference but could likely make it easier for many developers familiar with SQL to move to LINQ.

Some more interesting features that will be specific to VB include native support for XML and a new feature called Dynamic Interfaces. The XML feature means that you can literally drop XML right into your VB program and it is recognized as a type, just like an int or a string. So you could do something like:

\
**Dim Customer = <customer id=4>**\
**<name>Steve</name>**\
**<age>31</age>**\
**</customer>**



Note that there are no stupid _ characters in there. Also note that it doesn’t require any quotes. This can also be easily extended to be dynamic, for instance if the name should be a variable, it might work like this (again, the syntax may not be precise):

\
**Dim _name = “Steve”**\
**Dim Customer = <customer id=4>**\
**<name>(_name)</name>**\
**<age>31</age>**\
**</customer>**

Dynamic Interfaces take advantage of the fact that VB supports late binding. Let’s say you want to bind against a collection of objects that support a particular property, but you do not control these classes. So, for example, I have a Customer object that supports a property Name and I’m using third party provided class that includes a Pet object that also has a property Name. I want to write a method that accepts objects of either type and displays the name. I can create an interface that is applied at runtime, like a view, that allows me to refer to these two classes by their common interface. Like so:

**<Dynamic>**\
**Public Interface IHaveAName**\
**Public Name as String**\
**End Interface**\
\
**Public Sub DisplayName(IHaveAName thingWithName)**\
**Console.WriteLine(thingWithName.Name)**\
**End Sub**

This is pretty cool stuff. The mechanism used here is very similar to Extension Methods that C# will support, but without the need to write the implementation. C# cannot easily support this kind of functionality because at the root this relies on VB’s support for late binding. For the first time in a long time, I’m excited about some new language features that are coming out for the Visual Basic language. I’d really like to see the same kind of support for XML in C# that the next version of VB will have, for example, since working with XML is something virtually every developer needs to do, and many need to do quite often.