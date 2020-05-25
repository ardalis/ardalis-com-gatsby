---
templateKey: blog-post
title: Source Control Structure
path: blog-post
date: 2006-09-25T02:13:53.653Z
description: How do you like to set up your source control for a project? My
  personal preference is sort of a work in progress, and I do not have a great
  deal of experience with branching and versioning, so my design doesn’t take
  this into account, but I would like to hear what approaches work well for
  others.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - VS.NET
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

How do you like to set up your source control for a project? My personal preference is sort of a work in progress, and I do not have a great deal of experience with branching and versioning, so my design doesn’t take this into account, but I would like to hear what approaches work well for others. Here is a very simple example:

$/\
$/Project\
$/Project/Libraries/\
$/Project/References/\
$/Project/Websites/

Sometimes I’ll include other folders for services, windows applications, etc. Sometimes I’ll just have an Applications folder. Either way, all external references used by the project are kept in /References (as DLLs or whatever), all source code is kept in the appropriate folder (library, website, application, etc, depending on what it is).

In past discussions with folks who know about versioning and branching, I’ve seen a design like this suggested:

$/\
$/Project/\
$/Project/Sources/\
$/Project/Documents/\
$/Project/Tools/\
$/Project/v1.0/Sources/\
$/Project/v1.0/Documents/\
$/Project/v1.0/Tools/\
$/Project/v1.5/Sources/\
$/Project/v1.5/Documents/\
$/Project/v1.5/Tools\
$/Documents/\
$/Tools/

All source code goes into Sources, and is copied into the appropriate version specific branch when a version is finalized, along with documents and tools specific to that version. General non-version-specific documents and tools remain in the root (or at least outside of the branched portion of the project folder).

How is source control organized in your organization? What works, what doesn’t?

<!--EndFragment-->