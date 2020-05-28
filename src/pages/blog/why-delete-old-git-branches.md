---
templateKey: blog-post
title: Why Delete Old Git Branches?
path: blog-post
date: 2017-06-20T01:39:00.000Z
description: It’s a common housekeeping practice to delete git branches once
  they’re no longer used, but this practice isn’t necessarily universal, or
  universally understood.
featuredpost: false
featuredimage: /img/git-logo.svg_.png
tags:
  - git
  - GitHub
category:
  - Software Development
comments: true
share: true
---
It’s a common housekeeping practice to delete git branches once they’re no longer used, but this practice isn’t necessarily universal, or universally understood. Why should you delete old branches from your git repositories? There are two main reasons:

* They’re unnecessary. In most cases, branches, especially branches that were related to a pull request that has since been accepted, serve no purpose.
* They’re clutter. They don’t add any significant technical overhead, but they make it more difficult for humans to work with lists of branches in the repository.

Branches can be safely removed without risk of losing any changes. Consider a scenario in which a branch patch-1 is about to be merged with the master branch through a pull request. Before the merge, master and patch-1 both point to separate commits in git’s commit history. After the merge (assuming a new merge commit is added), both master and patch-1 point to a new merge commit. At this point, the pull request is complete, and future commits should only be made on master, not patch-1.

#### Warning

Reusing the patch-1 branch (after its original PR has been merged and closed) is a good way to cause problems in your git repository. You can create another branch, and even give it the same name, but don’t recycle branches you’ve already associated with a pull request for use with any other work.

What if you want to keep the branch around so you can always go back and see when it was merged? We’ll get to that at the end of this post. If you’re new to using pull requests and just want to see what steps you should follow, here’s my [git pull request checklist](http://ardalis.com/github-pull-request-checklist) which you may find helpful.

## How to Delete git Branches

You can delete branches locally by executing:

```
git branch -d branchname
```

Deleting the remote branch can be done in one of several ways. If you’re using GitHub, it will ask if you want to delete the branch when you accept a pull request. You can also go to the branches tab ([example](https://github.com/ardalis/CleanArchitecture/branches)) and manage or delete branches there. Of course, you can also delete remote branches from the command line interface:

```
git push origin --delete branchname
```

Another nice feature of GitHub when using pull requests is that even after you delete the branch associated with a PR, you can always go back and view the PR, including all of its comments and commit history.

## Listing git Branches

To see if you have a lot of branches (or not), run this command:

```
git branch -a
```

This will list both local and remote branches, but you may need to run **git fetch**first to load the list of remote branches into your local repo. If you want to see which remote branches have already been merged (so you know which ones you can likely delete), run:

```
git branch --merged
```

## Keeping a Historical Record

The only compelling reason for keeping branches around once they have served their purpose and been merged back into the main trunk of the repository is to provide some historic context. Fortunately, git provides another feature for this precise purchase: tags. Any time you find that you want a bookmark or reference to a particular commit, such as to mark the commit that was used for a deployment, you can add a tag for this purpose. You could even create a simple command to combine deleting unused branches and adding tags with the same name as the branch if you were so inclined (and really did want to track every branch).

To add a tag to the current branch and commit, just execute:

```
git tag tagname
```

This will only add the tag locally. To sync your change remotely, use:

```
git push --tags
```

Microsoft uses tags to good effect in the [ASP.NET Core repositories](https://github.com/aspnet), where you can see the which code was used for a given release. For example, [this is the 1.1 version of ASP.NET Core MVC](https://github.com/aspnet/Mvc/tree/rel/1.1.0).

## Disadvantages of Deleting Branches

One disadvantage is that you will break any hyperlinks to the branch’s location (in GitHub, etc.). Personally I very rarely have an permanent links to non-primary branches, and if I did want to link to some work on a given branch, I would most likely do so after it had been made into a pull request (in which case I would link to the PR). That said, this is a potential downside to deleting branches.

## Pruning

You can also quickly remove unused branches using git prune. [This article](http://railsware.com/blog/2014/08/11/git-housekeeping-tutorial-clean-up-outdated-branches-in-local-and-remote-repositories/) has some great tips related to cleaning up branches, including how to use prune, so check it out to learn more.