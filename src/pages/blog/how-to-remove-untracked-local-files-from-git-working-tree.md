---
templateKey: blog-post
title: How to remove untracked local files from git working tree?
path: blog-post
date: 2017-05-31T02:16:00.000Z
description: There are two ways to get rid of untracked files from your git
  working tree. The first one, which many of us have done, is to simply go to a
  new folder (or delete the current one) and perform a fresh git clone
  operation.
featuredpost: false
featuredimage: /img/git-logo.svg_.png
tags:
  - git
  - tip
category:
  - Software Development
comments: true
share: true
---
There are two ways to get rid of untracked files from your git working tree. The first one, which many of us have done, is to simply go to a new folder (or delete the current one) and perform a fresh git clone operation. This “burn it to the ground and start from scratch” approach works, but there is a more elegant solution: git clean.

To use git clean, it’s a good idea to first run it with the -n option, which will display the files that will be removed:

`git clean -n`

Once you’re sure you want to remove them, you can proceed. **This step will delete the files permanently** (they’re not in git so you can’t recover them from there).

`git clean -f`

This command can also be used to remove files that are otherwise ignored. This is done with the -X switch:

`git clean -fX`

To remove folders/directories, use the -d switch:

`git clean -fd`

Finally, to remove files regardless of whether they are ignored, use the -x (lowercase) switch:

`git clean -fx`

You can read the [official docs on git clean](https://git-scm.com/docs/git-clean)to see more of its capabilities, including the interactive mode (launched with git clean -i) that will let you choose whether or not to delete each file or folder. Also note that by default you should run these commands from the root of your repo, but if you don’t wish to do so you can pass the “:/” argument to run it as if it were run from the root:

`git clean -fd :/`

(which reminds me of an emoticon, and might be the face you make if you accidentally delete files you wanted to keep, so **use caution!**)

Of course, if you’ve already committed files and now you want git to forget them, I wrote a [tip on how to get git to forget files that are now ignored (but it’s currently tracking)](http://ardalis.com/how-to-make-git-forget-tracked-files-in-gitignore).

Note: this is often related to the question of how to revert to a specific commit, which you do using **git reset –hard HEAD** (or a commit). Read more about this approach on [StackOverflow](https://stackoverflow.com/questions/9529078/how-do-i-use-git-reset-hard-head-to-revert-to-a-previous-commit).