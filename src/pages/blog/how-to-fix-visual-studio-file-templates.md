---
templateKey: blog-post
title: How To Fix Visual Studio File Templates
path: blog-post
date: 2011-03-25T02:12:00.000Z
description: When you create a new project in Visual Studio, it will usually
  include some files as part of the project. Most of the time, these are pretty
  useless, but if it’s your first time working with said template, they may help
  you get going.
featuredpost: false
featuredimage: /img/fix.png
tags:
  - visual studio
category:
  - Software Development
comments: true
share: true
---
When you create a new project in Visual Studio, it will usually include some files as part of the project. Most of the time, these are pretty useless, but if it’s your first time working with said template, they may help you get going. In VS2010, the Test Project, for example, has been improved over prior versions by eliminating a useless text file describing tests and a useless Manual Test file that I never once used. It still includes a unit test file, which I think is fine, with the name that will never be correct, **UnitTest1.cs** (though I understand it would be a tough problem to guess a name that *might* be correct). Let’s look at the default file created:

![image](<> "image")

I do appreciate that there is a file created here for me, and that it has the requisite attributes on the class and method, and even uses my project’s namespace. However, I’ve circled all of the bits that are useless and are immediately deleted by me the first time I open this file. Resharper does a good job of highlighting unused code by making it light grey (lines 1-4 and line 15 for instance). The TestContext I never use. And the region full of additional test attributes falls into the category of “good to know if this was my first time” but really a comment listing the 4 attributes I need would be more useful to me. Here’s what that section looks like expanded:

![image](<> "image")

Since regions are pretty much evil because they provide places for bad code to hide, I delete this as a matter of course as well. If I were in charge of this template, I would probably replace this whole section with a comment like this one:

![image](<> "image")

That cuts the number of lines of code used by these comments in half. And honestly I’m not sure I’d include it at all, but I do occasionally find it useful and I’m sure it’s helpful to users new to testing with MS Test.

Once I’m ready to actually start writing a test, though, my file looks like this (from 71 lines of code to 14):

![image](<> "image")

Honestly, if this is what I had to start with, it would save me a non-insignificant amount of time and frustration whenever I create a new test. So, rather than complaining about it to Microsoft (who does listen sometimes – note the existence now of an Empty option when creating new ASP.NET MVC web applications), I can make this change myself – and so can you. Here’s what you need to do to customize your Visual Studio project templates.

**Customizing Visual Studio Project Templates – Create Your Own**

The simplest way to achieve this is to simply create a new project template and then use that in the future. You can do this by following the [instructions on Creating a Template](http://msdn.microsoft.com/en-US/library/ccd9ychb(v=VS.80).aspx) which are (after you have the project how you want it):

1. Go to File – Export Template

2. Choose a template type (I’m doing Project but you could also do this for individual file items)

![SNAGHTML5b9ae7a](<> "SNAGHTML5b9ae7a")

3. Provide a Name and Description and any icons or preview images you’d like to use. By default the project will automatically be imported for you (but only on this machine, of course).

![SNAGHTML5ba717c](<> "SNAGHTML5ba717c")

4. Click Finish. You can most easily locate your new template when you select New Project by using the search box. In my case it was listed under Installed Templates – C# but not within any of the sub-areas under this heading:

![SNAGHTML5bcb7b3](<> "SNAGHTML5bcb7b3")

If you look at what was actually installed into your folder, you’ll find this:

![image](<> "image")

Ok, so what if you really do want to change the actual C# Test Project template (specifically, the UnitTest1.cs file within it)? That’s a bit trickier, and unfortunately I’m out of time for this post and it’s gotten long so I’ll see if I can add that as a future article.