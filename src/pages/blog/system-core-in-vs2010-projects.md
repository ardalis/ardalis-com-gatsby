---
templateKey: blog-post
title: System.Core in VS2010 Projects
path: blog-post
date: 2010-08-24T12:53:00.000Z
description: I just ran into an odd issue with a VS2010 project.  In my case it
  was an MVC 2 application I was upgrading from VS2008.
featuredpost: false
featuredimage: /img/vslogo-760x360.png
tags:
  - visual studio
category:
  - Software Development
comments: true
share: true
---
I just ran into an odd issue with a VS2010 project. In my case it was an MVC 2 application I was upgrading from VS2008. One of the built-in controllers (ProfileController) was failing to compile because it could not resolve the Linq extension method symbols Single() and Matches(). These are located in the System.Core assembly. I checked my project references in Solution Explorer, and System.Core was not listed. So I tried Add Reference, and System.Core was listed as included and gave me the option of to Remove it.

![SNAGHTML4f275de](<> "SNAGHTML4f275de")

After some searching, I found this blog post, aptly named [Do NOT remove the reference to System.Core from your VS2010 Project](http://geekswithblogs.net/leesblog/archive/2010/04/23/do-not-remove-the-reference-to-system.core-from-your-vs2010.aspx). It pointed out that this file is “special” and that if you remove it (or it gets lost somehow) you need to re-add it manually to your project using this syntax:

> <ItemGroup>\
> <Reference Include="System.Core" />\
> </ItemGroup>

There is also a connect issue describing this bug (which is currently marked as Postponed), [Cannot remove System.Core.dll reference from a VS2010 project](http://connect.microsoft.com/VisualStudio/feedback/details/525663/cannot-remove-system-core-dll-reference-from-a-vs2010-project).

In my case this appears to have been an upgrade issue, as the project worked fine in VS2008 before I ran the upgrade wizard to VS2010, and then in the course of trying to get it to compile for the first time, I ran into this issue. Adding the assembly to the project file by hand (via Notepad) solved the problem in my case.