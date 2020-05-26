---
templateKey: blog-post
title: Visual Studio Could not write to output file annoyance
path: blog-post
date: 2005-03-21T02:12:50.570Z
description: "Every now and then my VS.NET solutions will fail to build because
  of an error like: Could not write to outputfile (filepath in /obj/ folder)."
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Every now and then my VS.NET solutions will fail to build because of an error like:

Could not write to outputfile (filepath in /obj/ folder). The file is being used by another process.

There is a KB article describing this bug:

[BUG: Could Not Copy Temporary Files to the Output Directory](http://support.microsoft.com/kb/313512/EN-US)

But to be honest, that has never helped me one bit. In my case, I’m not using a shared output folder, I am using Copy Local, and the project with the issues is only being referenced by Project References. So that KB is worthless, but it’s the only one I’ve found thus far.

Sometimes I get things to work by switching from Debug to Release mode, or vice versa. This usually works for one or two builds, sometimes more, but usually it ends up failing as well, at which point both the /obj/debug/assembly.dll and /obj/release/assembly.dll are being locked by VS.NET Intellisense and it’s game over.

Sometimes restarting VS.NET will help. Often not. Or, often only for one build.

What I’ve found worked for me most recently, and which I’m posting here as much for my own future reference as for anybody else, is this:

1) Find all the projects that reference the project whose assembly is causing the problem.\
2) Remove all references to said project.\
3) Build just that project. If it works, you’re good to go.\
4) Re-add Project References to the project (for the ones you deleted).\
5) Send Steve $1 for saving you hours of headache (optional).

Anyway, those steps worked for me – hopefully they’ll help someone else as well. **Can’t wait for Whidbey!!!**

<!--EndFragment-->