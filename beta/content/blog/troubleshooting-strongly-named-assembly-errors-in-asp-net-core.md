---
title: Troubleshooting Strongly Named Assembly Errors in ASP.NET Core
date: "2015-11-08T08:57:00.0000000-05:00"
description: Last week I tried to work with the latest (beta 8) version of the
featuredImage: /img/musicstore-beta8-issues-300x179.png
---

Last week I tried to work with the latest (beta 8) version of the [Music Store sample](https://github.com/aspnet/musicstore)for ASP.NET 5 (now ASP.NET Core). After pulling down the code via Git, I tried to build the solution the first time, and got a bunch of weird errors. I tried to troubleshoot the problem by rebuilding, cleaning, forcing Nuget to do an update, and trying to run the package restore and build from the command line, all without success. The main error I was getting was "A strongly named assembly is required." as you can see in this screenshot (click to enlarge):

![](/img/musicstore-beta8-issues-300x179.png)

Another thing to try, is deleting project.lock.json. Sometimes if this file is checked into source control, it will reference projects that are out of date (or if it's not checked in, it will reference different projects than the last successful build of the project used). In my case, this didn't work, but keep it in your list of things to try when troubleshooting build errors in ASP.NET 5 / Core projects.

What finally did work was this suggestion from Kiran Challa on the ASP.NET team:\"could you please try deleting the packages under.dnx folder (ex: C:\Users\\.dnx\packages) and try the previous steps again."

The previous steps were, doing a full package restore and rebuild of the project. This solved the problem for me, so I thought it was worth sharing. Please leave a comment if one of these suggestions works for you, and note what version of Visual Studio and ASP.NET you're currently working with. Thanks!

