---
templateKey: blog-post
title: Using CCTray with JetBrains TeamCity
path: blog-post
date: 2010-08-23T12:54:00.000Z
description: "[TeamCity]  is a great build server tool from [JetBrains] (makers
  of the awesome Visual Studio add-in, [ReSharper]. The user-interface and
  features of the TeamCity web front-end are wonderful and are leaps and bounds
  easier to use for new users than my previous favorite, CruiseControl.Net,
  which required much XMLness to configure."
featuredpost: false
featuredimage: /img/vscode-760x360.png
tags:
  - ci
  - continuous integration
  - devops
  - teamcity
category:
  - Software Development
comments: true
share: true
---
[TeamCity](http://www.jetbrains.com/teamcity) is a great build server tool from [JetBrains](http://www.jetbrains.com/) (makers of the awesome Visual Studio add-in, [ReSharper](http://www.jetbrains.com/resharper)). The user-interface and features of the TeamCity web front-end are wonderful and are leaps and bounds easier to use for new users than my previous favorite, CruiseControl.Net, which required much XMLness to configure. However, one of my favorite tools from CruiseControl, [CCTray](http://sourceforge.net/projects/ccnet/files), still has no equal among competitors like TeamCity and even the Visual Studio tray watcher for Team Build.

**Why CCTray Is Awesome**

CCTray has one job and it does it extremely well. That job is to let anybody interested in any software projects (that support CCTray) know whenever something happens with the build status of one of these projects. It’s a lightweight, easy to configure tray application that more-or-less instantly provides feedback on build status via one or more of the following notification options:

* Balloon window
* Custom sound
* Synthesized Speech

Additionally, it shows at-a-glance status of all watched projects instantly (no need to wait for it to talk back to the server), and double-clicking on a given project will load its project page with details about the most recent build in the browser. Custom sounds in the dev team area are a great way to ensure that all devs immediately know whenever a build fails. I recommend having the team agree on standard sounds, and having at least one machine in the team room with speakers on and CCTray installed with these sounds. When the red alert klaxon or similar “bad” sound starts playing, everyone should immediately be focused on getting the build fixed.

CCTray supports unique sounds for successful builds, broken builds, fixed builds (first success after fails), and still failing (subsequent fails after first fail) builds.

![CCTray sounds](<> "CCTray sounds")

Here are [some sample sounds you can get started with for CCTray](http://gordonjl.com/node/38) build events.

**Why JetBrains’ Tray App Is Less Awesome**

The built-in TeamCity build monitor is lacking in sounds and is also very slow to respond. When you click on its icon, it needs to talk back to the server to get the latest status updates. While this perhaps ensures the most up-to-date information, I’m looking for real-time responsiveness from my tray application – I know I can go hit a web page if I want the latest and greatest detail. For a while there you couldn’t use more than one build server with the TC build monitor, too, but I believe this is now possible in the latest version. Speediness and sounds are my main reasons for preferring CCTray at the moment, though.



**Using CCTray with JetBrains TeamCity**

A couple of weeks ago, Yegor Yarko posted [a plug-in for TeamCity that makes it possible to use TeamCity with CCTray](http://youtrack.jetbrains.net/issue/TW-11295?query=project%3A+TeamCity). He includes the instructions with the post – basically you just need to drop his add-in file into the .BuildServer/plugins folder and then restart TeamCity.

![image](<> "image")

You also need to make sure TeamCity is set up to have guest access enabled, which is done from the Administration – Server Configuration page.

![TeamCity Configuration](<> "TeamCity Configuration")

Finally, open up CCTray and point it at your TeamCity server’s URL with the following path:

**/guestAuth/app/cctray-standalone/cctray/projects.xml**

![TeamCity URL](<> "TeamCity URL")

Voila! You should now be able to view your projects via CCTray! Install it on all of your team’s machines (and any project managers or customers who might care to watch the project’s progress) and keep the build GREEN.