---
templateKey: blog-post
title: Annoying Visual Studio Add Existing Project Behavior Solved
path: blog-post
date: 2006-03-15T12:53:58.248Z
description: "Using Visual Studio 2005, I set up a new solution the other day
  with a bunch of projects. "
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

Using Visual Studio 2005, I set up a new solution the other day with a bunch of projects. The folder structure looks something like this:

/Solution\
/Solution/Project1\
/Solution/Project2\
/Solution/Project3

However, one of the projects was originally in another folder under My Documents/Other Projects/Project4 let’s say. I don’t recall if I originally added it from this location and then removed it, moved it, and re-added it, or if I simply added it from /Solution/Project4 to begin with, but every time I would exit and resume Visual Studio 2005, it would using the old location for the project (e.g. My Documents/Other Projects/Project4/Project4.csproj).

I tried everything to get this to stop. I hand edited the .sln file, where there were some references to /Other Projects/. The behavior remained. I renamed /Other Projects/Project4 to something else, and all that did for me was generate errors like:

“The project file ‘\[oldpath]’ has been moved, renamed, or is not on your computer.”

I figured out I could get the newpath version (/Solution/Project4/Project4.csproj) to work if I renamed it to something else (Project4a.csproj), added it to the solution, and then I could rename it back. Then I’d be good to go. Until I quit VS. Upon reloading, the project would come up gray and unavailable and the same error message:

“The project file ‘\[oldpath]’ has been moved, renamed, or is not on your computer.”

would be back.

I searched all files below /Solution for any reference to the path /Other Projects/ and found none that were anywhere outside of code source files. The one file I couldn’t view easily because it wasn’t plain text was the Solution.suo file. Finally I decided it just had to be the .suo file, so I renamed it to .suo.bak and tried opening my solution again.

It worked no problem. Close VS. A new .suo file is created (which stores the state you left the solution in, when it’s not trying to outguess which project files you actually want in your solution). Re-open VS, it still works. Conclusion – the old .suo file got hosed up somewhere along the line. Hopefully this will help somebody else who encounters this issue, since Google was basically zero help for me.

<!--EndFragment-->