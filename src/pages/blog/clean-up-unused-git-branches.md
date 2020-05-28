---
templateKey: blog-post
title: Clean up unused git branches
path: blog-post
date: 2017-02-22T03:39:00.000Z
description: If you’re using git and creating branches, then making pull
  requests, and ultimately merging them back into your main/master branch, you
  may end up with unused branches cluttering your repository.
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
If you’re using git and creating branches, then making pull requests, and ultimately merging them back into your main/master branch, you may end up with unused branches cluttering your repository. They don’t really hurt anything, but they can add some clutter and make it more difficult to find the branches that are actually in use. Wouldn’t it be nice if you could easily identify which ones were active and which had already been merged in? Fortunately, there is!

## Find all remote git branches

I’ll assume you can manage your local branches easily enough; it’s the remote ones that everybody on the team shares that are more important to keep under control. If you want to get a list of them from the command line, you should first run

`git fetch -p`

which will fetch tags and branches from your remote repo, and will remove remote-tracking branches from your local repo that are no longer on the remote. This will cut down on false positives for the next command:

`git branch -a`

This command will list all of the branches, both locally and on the remote (use -r for just remote). Here’s an example of the output:

![](/img/gitbrancha.png)

Now, what would be really nice would be to **see a list of branches that were already merged**. Fortunately, git doesn’t disappoint:

`git branch -a --merged`\
``\
Here’s the output for the same repo shown above, with this command:

![](/img/gitbrancha-merged.png)

With that, you should easily be able to identify your long-running branches and branches that you can probably remove (e.g. remove-wrench and tdykstra-patch-1 in the above list). To actually delete remote branches, you can use:

`git push origin --delete <branch_name>`

What if you want to [prune every time you do a pull or fetch](https://stackoverflow.com/a/18718936)? No problem. Just set your configuration to remote.origin.prune to true:

`git config remote.origin.prune true`

## List Branches On GitHub

If your repository is hosted on GitHub, you can also view remote branches on GitHub.com. Just click on the “N branches” link on the repository home page:

![](/img/github-branches-link.png)

From there you will see branches, organized by default to show which ones GitHub considers to be active or stale, and which are yours. You can also view all branches.

![](/img/github-branches.png)

From here, you should be able to easily identify any branches that can be deleted, which you can then do by clicking the trashcan icon. Branches that have already been merged can typically be safely deleted, and in any case remember that a branch is just a pointer to a difference set. Deleting the branch doesn’t delete the commit it’s referencing.

**Tip**: You can also use this page to find a branch for which you’re looking to create a pull request!

*Want a new tip like this every Wednesday?* Sign up for my [Weekly Dev Tips](https://ardalis.com/tips).