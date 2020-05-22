---
templateKey: blog-post
title: Keep master and origin branches working if possible
path: blog-post
date: 2017-11-22T20:25:00.000Z
description: >
  Here are two tips that teams I work with have found useful when working with
  git for larger projects with many team members that I thought I would share:
featuredpost: false
featuredimage: /img/git-logo.svg_.png
tags:
  - git
  - GitHub
  - tip
category:
  - Software Development
comments: true
share: true
---
Here are two tips that teams I work with have found useful when working with git for larger projects with many team members that I thought I would share:

## Only merge into master if code is working

The first tip is that you should only merge (or commit, but that should be rare) into master if your code is working. That is, it compiles and all of its tests run, and not just on your own machine, but ideally on a build server. This is important because, if followed, it means that at any time, any team member can jump back to any commit in the master branch and they can expect to be in a known good state for the application. When a bug is reported, it can be useful to try and discover when the bug was introduced. In performing this detective work, it’s much easier if you’re only looking for the previously undiscovered bug in the past code commits. If you’re also having to work around and trip over a bunch of broken code, it makes the process much more difficult and time consuming.

GitHub offers some features to make it pretty easy to enforce this kind of rule. You can mark some branches, like master, as protected, making them resistant to deletion. You can further specify that users cannot directly commit to these protected branches, but instead must merge a pull request. This can be configured globally, or just for non-admin users. Finally, you can specify that pull requests cannot be merged until certain conditions, like a passing build, are met. With these in place, you can help guide your team members toward respecting the rule that the master branch should always be in a known good state.

## Only push to origin if code is working

The second tip is lower priority than the first one, but suggests that you shouldn’t even push your commits to origin (GitHub, BitBucket, VSTS, whatever your remote source of truth is) if your code isn’t in a working state. Of course, if you follow this tip, you’ll (mostly) get the first tip as a result. I say mostly because until you push to origin, you probably won’t trigger a build server to build and test your code, which means there could be settings local to your environment that allow your code to work on your machine, but not elsewhere. This tip mostly works for developers who work at a single machine. If you frequently jump between home and work machines or desktop and laptop machines and you need to keep working on in-progress work across machines, then you may need to push in-progress code to your private branch from time to time. If you do, it’s a good idea to mark your commit with “**WIP**: ” (work in progress) or something similar, so it’s clear to other developers (and future you!) that this particular commit is known to not be working. If you need to be more clear, you can use “**DON’T MERGE**“.

There are a few reasons why this is a useful tip. First, if you’re using a shared build server and you’ve configured it to build pull requests (so you know they build and pass all tests before you merge them), it’s a waste of resources to have the build server build commits you know aren’t working. This generally only applies to commits being made to a branch that’s part of a build request, but in some teams the build server is a bottleneck and this tip helps mitigate the issue. It’s also a good practice to work in small, incremental steps, ensuring that the system is still working after each step. This tip helps promote this behavior, since developers should be pushing code to origin frequently (if nothing else, to avoid lost work in the event of a local machine failure). If you’re pushing to origin frequently, but only if the code is working, you will of necessity be working in small, incremental steps with working code after each step.

## Summary

Keep your master branch clean and working – future you thanks you. Avoid pushing broken code to origin at all if you can help it, and if you must do so, make it clear whenever you push code you know to be broken or incomplete. Work in small steps, with frequent commits and pushes to origin, and avoid spending too much time with the system in a broken state. These are tips, not rules, but teams I work with have found them to be valuable. If you have any related tips you’d like to share, please do so below.

Check out my podcast, [Weekly Dev Tips](http://www.weeklydevtips.com/), to hear a new developer productivity tip every week. You can also [join my mailing list](https://ardalis.com/tips) for similar (but different!) tips in your inbox every Wednesday!