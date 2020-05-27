---
templateKey: blog-post
title: unexpected error creating debug information
path: blog-post
date: 2003-08-11T22:46:00.000Z
description: I keep running into this issue in my multi-project VS.NET
  solutions. For some reason, something is locking the dll(s) in the /obj/
  folder of library components.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - unexpected error
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

I keep running into this issue in my multi-project VS.NET solutions. For some reason, something is locking the dll(s) in the /obj/ folder of library components. The fix that I have at the moment is as follows:

1. Shut down VS.NET
2. Browse to the project in windows explorer
3. Delete the /obj/ folder.
4. Delete the project outputs (.dll and .pdb) from /bin (not sure this step is necessary)
5. (can’t hurt, might help) — delete the project outputs from any other project /bin folders in the solution that is having issues.
6. Restart VS.NET
7. Rebuild
8. Laugh the next time you hear that DLL Hell is no more in .NET…

Update: Just deleting /obj/ after closing VS.NET does it. [Ambrose](http://aspalliance.com/ambrose)pointed me to [prcview.exe](http://www.prcview.com/)and that demonstrated that it is in fact devenv.exe locking the file, so it’s VS.NET’s own fault, not Index Server or anything else that is to blame.

Listening to: Disturbed – Remember

<!--EndFragment-->