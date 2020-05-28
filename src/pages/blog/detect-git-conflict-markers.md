---
templateKey: blog-post
title: Detect git Conflict Markers
path: blog-post
date: 2017-01-04T04:28:00.000Z
description: "If you’re using git, you’ve probably run into a problem at some
  point where you’ve had to perform a merge, and a merge conflict resulted. "
featuredpost: false
featuredimage: /img/git-logo.svg_.png
tags:
  - GIT
category:
  - Software Development
comments: true
share: true
---
This is post 2 of 2 in the series *“Developer Tips”*

1. [Check In Often](https://ardalis.com/check-in-often)
2. Detect git Conflict Markers

Tips for developers, archived from [Dev Tips Weekly](http://ardalis.com/tips) emails.

If you’re using git, you’ve probably run into a problem at some point where you’ve had to perform a merge, and a merge conflict resulted. This happens when two different commits changed the same line in a file, and git can’t tell which commit should be kept (or if perhaps both should be). In this case, git will reward you with a message like this one:

`CONFLICT (content): Merge conflict in demo.txt `\
`Automatic merge failed; fix conflicts and then commit the result.`

At this point you need to resolve the conflict, typically by editing the file(s) with a text editor or a diff tool and deciding which commit should “win”. To help you with this, git adds some markers to the file that show the two conflicting choices and which branch they’re coming from:

```
A text file.

<<<<<<< HEAD
Baz.
=======
Bar.
>>>>>>> master
```

In this case, you would decide if the 3rd line of the file should be ‘Baz.’ or ‘Bar.’. Then you would delete the one you don’t want, along with all the three line markers (‘<<<‘, ‘===’, and ‘>>>’).

Sometimes, though, you may think you found all of the conflicts, but actually you missed some. So you end up accidentally committing files that still have these marker lines in them. This is bad and will cause you headaches later. If only there were a way to detect this before committing!

Fortunately, git offers such a tool:

`git diff --check`

If I run this on the file shown above, the result is:

![](/img/git-diff-check.png)

Hopefully this will help you find these markers when you’re not sure you’ve gotten them all, before committing (or after, when you’re trying to clean up a mess). [Follow @ohshitgit](https://twitter.com/ohshitgit) for more great tips like this one.