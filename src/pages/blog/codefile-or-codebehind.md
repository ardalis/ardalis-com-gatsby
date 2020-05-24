---
templateKey: blog-post
title: CodeFile or CodeBehind
path: blog-post
date: 2007-01-24T17:25:38.455Z
description: "I just fixed a problem on a coworker’s machine that was quite odd
  in that the fix involved simply changing CodeFile to CodeBehind in a user
  control (.ascx) file. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - vs2005
  - WAP
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I just fixed a problem on a coworker’s machine that was quite odd in that the fix involved simply changing CodeFile to CodeBehind in a user control (.ascx) file. The issue was that in the ASPX page I was doing a FindControl within a Repeater’s ItemDataBound event, and casting the resulting control to the type of the codebehind of the user control. So for example if the user control was foo.ascx then in foo.ascx.cs I might have had a type Acme.Web.Foo. The Inherits= attribute in the @Control directive was set correctly to Acme.Web.Foo, but the type cast was failing in the ASPX page. When I debugged it, I found that the type of the thing I was getting back from FindControl was the JIT compiled ASCX’s type, which was ASP.Folder_Foo_ascx. The strange thing was that this was uncastable to its base class, Acme.Web.Foo, as long as the ASCX contained CodeFile=”foo.ascx.cs”. I changed this to CodeBehind=”foo.ascx.cs” and suddenly everything worked.

I think this is related to my [upgrade from a website to a Web Application Project](http://aspadvice.com/blogs/ssmith/archive/2007/01/23/Web-Application-Project-Conversion-Tips.aspx), described in a post yesterday. I don’t have time at the moment to investigate why the inheritance tree for my ASCX page would be broken by this change, but if anybody would care to comment I certainly interested.

Incidentally, this is my first post with the new [BlogJet](http://blogjet.com/) 2.0. So far it looks much nicer than the previous version, although it hasn’t actually posted as I’m typing this…

Tags: [vs2005](http://technorati.com/tag/vs2005), [WAP](http://technorati.com/tag/WAP)

<!--EndFragment-->