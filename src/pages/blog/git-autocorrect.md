---
templateKey: blog-post
title: Git Autocorrect
path: /git-autocorrect
date: 2020-02-12
featuredpost: false
featuredimage: /img/git-autocorrect-still-760x360.png
tags:
  - git
  - tip
category:
  - Productivity
  - Software Development
comments: true
share: true
---
I don’t know how I didn’t know about this before now, but apparently you can turn on autocorrect for your git command line, and it will accept (after a short delay in which you can cancel) commands that are *close to* but not exactly correct.

Example:

```
git chckout master
```

You probably meant:

```
git checkout master
```



And it will go ahead and do that for you.

## Setting it up

You can set this up in your git config, either globally or per repo. I don’t know why you’d only want it for some repos so here’s how to do it globally:

```
git config --global help.autocorrect 20
```

Ok, so what’s the 20 at the end? This sounded like a true/false kinda thing, right? Well that’s how long it will wait before reissuing what it thinks is the right command, in tenths of seconds (weird choice, I know). So 20 is 2 seconds. Let’s give it a try:

![](/img/git-autocorrect-1536x770.gif)

Turn on and use git autocorrect (animated gif).

(for some reason this isn’t animating for me in Chrome but it works everywhere else)

Here’s a still capture of the end result. Note that 2 seconds passed before it issued the corrected pull command:

![](/img/git-autocorrect-still-1536x764.png)

Using git autocorrect

## Summary

That’s it! Turn it on and enjoy! I don’t know how I’m just learning about this since it’s been around for some time according to [this Twitter search](https://twitter.com/search?q=git%20autocorrect&src=typed_query). [Andy Carter also had a nice write-up](https://andy-carter.com/blog/auto-correct-git-commands). If you found this useful or have a related tip please leave a comment!