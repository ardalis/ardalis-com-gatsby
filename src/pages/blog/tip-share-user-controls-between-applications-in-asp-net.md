---
templateKey: blog-post
title: "Tip: Share User Controls Between Applications in ASP.NET"
path: blog-post
date: 2006-10-05T01:45:01.184Z
description: This recently came up on an email list I’m on. There basically
  three ways to share user controls in ASP.NET (1.x or 2.0). Note that since
  Master Pages are User Controls, these techniques apply to them as well (and,
  in case you were unaware, you can’t share user controls or master pages
  between appdomains by default).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

This recently came up on an email list I’m on. There basically three ways to share user controls in ASP.NET (1.x or 2.0). Note that since Master Pages are User Controls, these techniques apply to them as well (and, in case you were unaware, you can’t share user controls or master pages between appdomains by default).

**Workaround 1: XCOPY**

Basically, copy the .ascx and/or .master files to whatever apps you want to use them. This isn’t really sharing, but it gets the job done.

**Workaround 2: Virtual Folder**

Set up a virtual folder in IIS pointing to a physical folder somewhere on the machine. Set up identical virtual folders in multiple websites. For instance, create virtual folder called ‘shared’ that points to c:shared in each of website1 and website2. Now you can put your shared files in this folder, with no duplication, and have them exist in both apps.

The disadvantage to this technique is you have to have IIS access (not good for shared hosting accounts and many corporate servers) and it doesn’t work with Cassini / ASP.NET Development Web Server. So you’re stuck doing your dev on IIS if you weren’t already.

**Workaround 3: Compile Them**

You can always compile the user controls and/or master pages into DLLs and then share them like any class library, including storing them in the GAC. The big down side to this is that it’s now much more difficult to modify the files, so if they change frequently this may not be a good approach.

The easiest way to compile these controls into their own DLL is to use the [aspnet_compiler.exe](http://msdn2.microsoft.com/en-us/library/ms229863.aspx) tool which ships with .NET 2.0.

<!--EndFragment-->