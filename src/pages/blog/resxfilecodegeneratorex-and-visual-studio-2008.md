---
templateKey: blog-post
title: ResXFileCodeGeneratorEx and Visual Studio 2008
path: blog-post
date: 2008-01-28T14:08:13.390Z
description: A couple of months ago I found a great Extended Strongly Typed
  Resource Generator that would let me use Resource files in shared libraries
  (Brendan blogged about it and set it up).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - VS2008
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

A couple of months ago I found a great [Extended Strongly Typed Resource Generator](http://dmytro.kryvko.googlepages.com/) that would let me use Resource files in shared libraries ([Brendan blogged about it and set it up](http://aspadvice.com/blogs/name/archive/2007/10/16/Public-Strongly-Typed-Resource-Generator.aspx)). The default resource generator in Visual Studio generates code that is marked with the internal keyword, making it difficult to share the resources between assemblies or projects. The Extended Strongly Typed Resource Generator avoids the problem and adds some other enhancements that make it a great tool. However, at present it doesn’t work with Visual Studio 2008.

There’s a fix that will get you partway there. I found it in a comment on the [CodeProject version of the code](http://www.codeproject.com/KB/dotnet/ResXFileCodeGeneratorEx.aspx), and I’ve included it below:

> we need to change the path from\
> @”SOFTWAREMicrosoftVisualStudio**8.0**Generators{0}{1}”\
> to\
> @”SOFTWAREMicrosoftVisualStudio**9.0**Generators{0}{1}”\
> inside method “registryKeyPathBuilder” in registryKeyPathBuilder.cs file and all working fine

Make this change to the source project, and you’ll at least be using the right path for VS2008. However, then you’ll run into a nasty VS2008 bug:

**“The assembly ‘Microsoft.VisualStudio.Shell.Interop, Version=7.1.40304.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a’ is not registered for COM Interop. Please register it with regasm.exe /tlb.”**

This is described in [this forum thread,](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=2528155&SiteID=1) and apparently it’s a known issue that will be fixed in SP1, and in the meantime you can get a hotfix if you contact [Ed Dore of Microsoft](http://forums.microsoft.com/MSDN/User/Profile.aspx?UserID=973&SiteID=1). I’m sending him an email now and hope to have a fix soon, but in the meantime I’m keeping VS2005 around so that I can compile my resource files using this tool.

<!--EndFragment-->