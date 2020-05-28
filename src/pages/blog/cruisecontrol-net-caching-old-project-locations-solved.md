---
templateKey: blog-post
title: CruiseControl.NET Caching Old Project Locations SOLVED
path: blog-post
date: 2008-04-04T01:22:37.429Z
description: As I mentioned in [my previous post] we’re just wrapping up a
  continuous integration solution for a client (and if you’re not using this for
  your team, you should be
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - CC.NET
  - ci
  - Software Development
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

As I mentioned in [my previous post](http://aspadvice.com/blogs/ssmith/archive/2008/04/04/Not-Working-for-Microsoft.aspx), we’re just wrapping up a continuous integration solution for a client (and if you’re not using this for your team, you should be. If you don’t have time to do it, [contact us](http://aspadvice.com/blogs/ssmith/contact.aspx) to do it for you. You’ll thank me later.) and one of the last requirements changes was an update to where on the build server’s hard drive the project files should reside once they’re checked out from source control. After making this change in the cc.net.config file for the various ccnet projects, and also making the change in the source control provider’s working folder association for the build account username, I figured things would just work. I forgot about one thing, and it caused me frustration for the better part of a day. That thing was the CCNET state files.

After making my changes from ***d:buildserversource*** to the new location in the ccnet.config file (and doing a find and replace to be sure I hadn’t missed it anywhere), I started looking for places the source control client may have been caching the old working folder associations. I went down this road for a while, and did find a bunch of places where the client was storing settings, but nothing with this location. And my builds were all failing because this folder no longer existed, so the attempts to perform a get from source control were failing. I searched the registry – nothing. I searched the entire file system (all disks!) – nothing. Unfortunately this was not my server and it had the default configuration on it of not searching all files ([Scott Forsyth](http://weblogs.asp.net/owscott) at [Orcsweb](http://orcsweb.com/) has [the registry hack to correct this, detailed here](http://weblogs.asp.net/owscott/archive/2008/04/04/enabling-xp-and-windows-server-2003-to-search-all-files-types.aspx)). In an act of desperation, I had the client restart the server for me. Still no good.

At this point I grabbed the CCNET source and started going through it to try and find where it was getting that path from. Being open source is great for this, but of course it’s not like I can search the source for the folder name I’m looking for, and CCNET deals with a bunch of different folders (both in source control and on disk) so it’s a bit tough to follow if you’re unfamiliar with the code exactly which variables refer to which paths in the build process. As I was getting close to finding the problem in the source, I noticed something in my CCNET /server folder – a bunch of \[PROJECTNAME].state files. This was one of those combination “ah-ha!” and “oh, man, was it really that easy” moments.

Yes, it turns out that if you open up these state files, they include, among other things, the location on disk for the project. If you’re going to search the file system for a particular string in a file, be sure you’re searching all file extensions since various vendors will make up all kinds of extensions and put text into them. If you update ccnet.config to use a new workingDirectory *it won’t care because it’s going to look at what is in the state file instead*. You can configure the state file location in your ccnet.exe.config or ccservice.config – by default you’ll find them co-located with these EXEs. Just remember to look for them.

The state files include the following elements – if you see any of these being cached by Cruise Control, go delete the state files and it should stop caching them.

* ProjectName
* ProjectUrl
* BuildCondition
* Label
* WorkingDirectory
* ArtifactDirectory
* Status
* StartTime
* EndTime
* LastIntegrationStatus
* LastSuccessfulIntegrationLabel

<!--EndFragment-->