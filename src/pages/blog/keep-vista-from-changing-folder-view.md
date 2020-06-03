---
templateKey: blog-post
title: Keep Vista from Changing Folder View
path: blog-post
date: 2008-09-01T02:45:00.000Z
description: I've been running Windows Vista since it came out in November 2006.
  By and large I'm happy with it and wouldn't go back to XP, which I'm still
  running on some other PCs. However, once annoyance that I've finally gotten
  fed up enough with to track down the fix is the constantly changing folder
  view issue.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - vista
category:
  - Uncategorized
comments: true
share: true
---
I've been running Windows Vista since it came out in November 2006. By and large I'm happy with it and wouldn't go back to XP, which I'm still running on some other PCs. However, once annoyance that I've finally gotten fed up enough with to track down the fix is the [constantly changing folder view](http://www.tweakguides.com/VA_4.html) issue. For instance, say you're a developer, which probably isn't a stretch since you're reading my blog. And further, say you're a *web* developer, and your web application has a bunch of files in it, some of which are likely images. Now let's say that one of your cohorts was working on said files, and you quickly want to see which file(s) were most recently touched. Well, usually you just open up Windows Explorer and sort by Date Modified, but no, if Vista finds that somebody has added an image to the folder, suddenly it wants to show you thumbnails and let you tag all of our .cs files. After about the 10th time of seeing this kind of asinine behavior (or maybe you really just want to sort your *pictures* by their last modified date so you can archive them – another thing that's more difficult than it need be), you start getting frustrated and hating your computer.

There is a fix, and it's not terribly difficult. Simply [follow these steps](http://www.tweakguides.com/VA_4.html), which when complete should leave you with a registry looking like this:

![vista registry fix](/img/registry-fix-vista)

I just did it and everything seems to be working as expected now. When you do legitimately want to change the folder view, you still can. And to save the settings you can go to Folder and Search Options, View tab, and click Apply to Folders. Without this fix, copying a file into a folder would prompt Vista to change its view – now that control is in your hands and won't happen automagically.
