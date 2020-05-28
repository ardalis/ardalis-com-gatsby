---
templateKey: blog-post
title: Check In Often
path: blog-post
date: 2016-07-12T06:15:00.000Z
description: "It doesn’t matter if you’re using Team Foundation Server, Git,
  Subversion, or another form of source control, you should be sure to check in
  your code frequently. "
featuredpost: false
featuredimage: /img/copyfolderversioning.jpg
tags:
  - git
  - source control
  - tip
category:
  - Software Development
comments: true
share: true
---
> **This is post 1 of 2 in the series *“Developer Tips”***
>
> Tips for developers, archived from [Dev Tips Weekly](http://ardalis.com/tips) emails.

**Check in your code. Often.**\
It doesn’t matter if you’re using Team Foundation Server, Git, Subversion, or another form of source control, you should be sure to check in your code frequently. Right now, do you have code that you’re working on (or were working on) and which isn’t checked in? How long ago did you check it out? If the answer is more than a couple of hours, it’s too long.

The more frequently you commit your code, the faster integration issues will be detected, especially if you’re using [continuous integration](http://deviq.com/continuous-integration/). Also, if you find that you’ve coded yourself into a corner (or dead end), you can always roll back to a previous commit. You might even need to go back a few commits. The more often you commit your code to your source control repository, the better off you’ll be when the time comes to roll back.

Avoid the urge to use [Copy Folder Versioning](http://deviq.com/copy-folder-versioning/). Use source control, and then, *use* source control. If you’re following [Test Driven Development](http://deviq.com/test-driven-development/), consider upgrading the Red-Green-Refactor process with [Red-Green-Refactor-Commit](http://ardalis.com/rgrc-is-the-new-red-green-refactor-for-test-first-development), and see if it doesn’t lead you to write better, more maintainable code.

From [Weekly Dev Tips](http://ardalis.com/tips). Get a new developer tip in your inbox every Wednesday, and[subscribe to the podcast](https://www.weeklydevtips.com/).