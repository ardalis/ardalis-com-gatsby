---
templateKey: blog-post
title: Plasma v1.0 Release Available
path: blog-post
date: 2007-03-01T16:41:46.170Z
description: "[Plasma] is an ASP.NET in-memory web server emulator that can be
  used for ASP.NET unit testing or automation. Its initial codebase was written
  by Microsoft and its current incarnation is a community project [licensed
  under the Microsoft Permissive License]"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - announcement
  - asp.net
  - ci
  - tdd
  - Team System
  - Test Driven Development
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Plasma](http://www.codeplex.com/plasma) is an ASP.NET in-memory web server emulator that can be used for ASP.NET unit testing or automation. Its initial codebase was written by Microsoft and its current incarnation is a community project [licensed under the Microsoft Permissive License](http://www.codeplex.com/plasma/Project/License.aspx). I’ve been working on the project with several others and have just put the [initial release](http://www.codeplex.com/plasma/Release/ProjectReleases.aspx?ReleaseId=2082) out on the [CodePlex](http://www.codeplex.com/) project site. There are a lot of enhancements that have already been made that are not in this release, but I wanted to get the basic, vanilla implementation out there first, and then (hopefully soon) put out a 1.1 release with some of the many optimizations that we’ve already made. Unfortunately, our existing updates were all done without the benefit of a single source repository, so they need to be merged by hand and that hasn’t happened yet, which is why they’re not in this build.

Anyway, check it out. The release includes the core library along with a test website, an NUnit project that unit tests the website, and an MSTest project that tests the website.

**Screenshots:**

**NUnit**

![](<>)

**MSTest**

![](<>)

<!--EndFragment-->