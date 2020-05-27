---
templateKey: blog-post
title: Get Started With dnx-watch
path: blog-post
date: 2015-10-16T14:06:00.000Z
description: "With the release of ASP.NET 5 / DNX Beta 8, there is now a new
  command line tool, dnx-watch, that can be used to automatically re-run dnx
  commands in response to file changes. "
featuredpost: false
featuredimage: /img/dnvm-760x360.jpg
tags:
  - asp.net core
  - dnx
  - dotnet
category:
  - Software Development
comments: true
share: true
---
With the release of ASP.NET 5 / DNX Beta 8, there is now a new command line tool, dnx-watch, that can be used to automatically re-run dnx commands in response to file changes. This can be useful when making quick updates to a web application or while practicing [Test Driven Development](http://deviq.com/test-driven-development/).

To get started, open a command prompt and first make sure you have dnvm, the .NET Version Manager utility, installed. Just type

dnvm

and you should see something like this:

![](/img/dnvm-760x360.jpg)

Note the version. You can always be sure you’re running the latest version of dnvm by running

dnvm update-self

Next, verify you’re running the version of DNX you want. At the time I’m writing this, beta 8 has just shipped, so I want to make sure I have the latest framework installed. Do this by running

dnvm upgrade

and then

dnvm list

You should see something like this (with the latest version Active and highlighted):

![](/img/dnvm-list.jpg)

Now you’re ready to install dnx-watch. Be careful to install the correct version by specifying it after the name (and note the name is Watcher not Watch):

dnu commands install Microsoft.Dnx.Watcher 1.0.0-beta8

If you don’t include the version, it will install the latest version, which might be (and at the moment is) a different version than your installed version. The installer downloads and installs a lot of packages (took about 85 seconds), but when it’s done, you should be able to run dnx-watch anywhere you would normally run dnx commands.

If you’re unit testing and want to auto-run the tests every time you save, just run

dnx-watch test

and you’ll see the tests re-execute each time you save a file or build your solution.

If you’re working with ASP.NET and want to be able to make quick updates to the site without having re-launch the web application every time, just run

dnx-watch web

and you’ll be able to simply save a change to a file and then refresh in your browser to see the change.

These are probably the two most common scenarios for dnx-watch. Let me know in the comments if you have other ways you find the command useful, or if you have trouble getting it set up based on the instructions above. You can also follow me on [twitter (@ardalis)](https://twitter.com/ardalis) if you’d prefer to interact there.