---
templateKey: blog-post
title: Why not Classic (Legacy) ASP?
path: blog-post
date: 2009-10-07T21:02:00.000Z
description: Yesterday I got the following email, which I thought raised some
  good points that I thought were worth addressing here in my blog in addition
  to the reply I sent directly.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP
category:
  - Uncategorized
comments: true
share: true
---
Yesterday I got the following email, which I thought raised some good points that I thought were worth addressing here in my blog in addition to the reply I sent directly.

> Hi Steve,\
> I’ve been following your blog (as well as Rob C. and Scott H.) as I look into dipping my toes into MVC. I just read you "[How I Got Started in Software Development](/how-i-got-started-in-software-development)" and your description of the joys of lightweight ASP development really hit home. So I have a perfect question for you.\
> I’ve been in the MIS/IS/IT/ICT field for, well, as long as it’s taken me to collect all those acronyms. I’ve been doing lightweight webapp development since the late 90s, starting first in CDML, then ColdFusion, then classic ASP.\
> For the past few years, I’ve been developing some first-rate classic ASP webapps using a heavy does of AJAX (jQuery) for the UI interactivity. The problem is, nobody takes these webapps seriously, and I’m constantly taking flack for not moving to a "real" framework. And yet as I look at many of these frameworks, they seem like overkill in all the wrong ways. ASP.NET WebForms, in particular, makes me want to run out of the building screaming.\
> And yet, many clearly smart and experienced people like yourself are rallying behind these frameworks. What’s up? What am I missing? What’s the draw? And please don’t spin that old "spaghetti code" yarn; as Rob writes, "Spaghetti is as spaghetti does".\
> Here’s my thinking: HTTP is stateless. All you need the framework to do is talk to your database and render clean HTML. That’s it. All UI interactivity should be handled on the browser in JavaScript, and all design should be handled in CSS. Classic ASP (with the help of jQuery) makes all this SO EASY. And there is nothing to prevent a good developer from writing clean spaghetti-free code with proper abstraction and separation of concerns.\
> I don’t want to pretend that I’m a VS programmer working on a stateful desktop app. I want clean and efficient HTML, CSS, and JavaScript rendered to the browser. All these frameworks seem to get in the way of that while providing minimal benefit. So in five bullet points: WHAT AM I MISSING?\
> Thanks for taking the time to read this, and hopefully even to answer.\
> Sincerely,\
> another confused old-school ASP guy,

Here’s my emailed response:

> Hi XXX,
>
> Read these three books when you get a chance:
>
> 1) Working Effectively with Legacy Code by Michael Feathers
>
> 2) Agile Principles, Patterns, and Practices of Software Development in C# by Robert Martin and Micah Martin
>
> 3) Clean Code by Robert Martin
>
> Now, to properly answer your question. The big reason why I won’t wish to return to ASP is the lack of ability to reuse and properly test code. As applications grow in size and complexity these two things are critical to retaining the ability to make major changes to the site’s design. Include files are a poor substitute for OO patterns of reuse. Also ASP uses COM which is a PITA in its own right, lacking xcopy deployment and forcing you into DLL hell that I don’t wish to return to (for instance, you can’t have two versions of a given component on the same machine, requiring separate instances of the OS just to run side-by-side versions of an app). Plus, talking to databases is something that should be done via an ORM tool if at all possible, and certainly not with lots of hand-written ADO plumbing code. Perhaps the ORM landscape has changed since I last did ASP 9 years ago but and there are numerous effective options, but if not, that alone will ham-string your productivity.
>
> If you liked the clean separation that ASP afforded, you should like MVC views which will let you do your jQuery + Services approach easily but will also let your services run in .NET where they can take advantage of ORM tools, better performance, unit testing, and inheritance/polymorphism as well as new language features like LINQ and built-in platform features like caching that ASP lacked. Give it 3 months’ time on a real project and email me back and let me know what you think.
>
> Thanks,
>
> Steve

I’d also recommend some of the other books listed on my [Favorite Developer Books](/favorite-developer-books) post, which I’ll need to update soon to include the two Martin books I referenced in my response. Yes, you can write well-structured web applications in ASP. Yes, writing them with jQuery and a clean separation between UI and data and business logic is a good way to avoid spaghetti code. However, as the reader has found, support for this technology stack is all but gone, and there are many benefits to be had from moving to a modern stack like .NET (which itself is getting somewhat long in tooth, nearing 10 years of age). If he’s very enamored with the dynamic nature of ASP, Ruby is likely a good choice for him to check out as an alternative. But if he likes the Microsoft toolset and stack, then I’ll stick with my recommendation that he go to ASP.NET MVC, and avoid the VB6-like ASP.NET Web Forms model.

Another benefit I neglected to mention in using .NET over ASP is the ability to debug the code. Honestly I don’t use the debugger that often (tests > debugger usually) but when I do need it it’s extremely valuable. And I can say that on the rare occasions when I’ve had to work with ASP code in the last 9 years or so, both my own and clients, it’s been universally unpleasant compared to ASP.NET MVC, which has been a joy across the board. However, I wouldn’t say that any of the ASP apps were written as well as the author of the email writes his.

How many other readers are still using ASP for new applications today? Are you trying to incorporate modern advances like ORM tools, jQuery, web services, etc. or do you build them the same way people built them 10 years ago? What are the biggest pain points you face?