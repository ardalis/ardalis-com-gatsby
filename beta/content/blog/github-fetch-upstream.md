---
title: GitHub Fetch Upstream Branch
date: "2021-05-11T00:00:00.0000000"
description: A key feature of GitHub is the ability to work repositories in order to contribute back to them. Until recently, there was no built-in way to keep a fork up to date with its upstream source repository. Now, there's support for it built into the GitHub web app.
featuredImage: /img/github-fetch-upstream-title.png
---

A couple of years ago, I wrote an article on [how to use the git command line to sync a fork with its upstream branch](/syncing-a-fork-of-a-github-repository-with-upstream/). Now, you should need those instructions much less frequently, because GitHub has added support for it to its web application. You'll find it in the image below:

![GitHub Fetch Upstream](/img/github-fetch-upstream.png)

Once you click on the 'Fetch Upstream' button, there's a dialog to confirm:

![GitHub Fetch Upstream confirm](/img/github-fetch-upstream2.png)

Click the button and assuming no major conflicts, you should have your fork updated to the upstream branch, with a dialog at the top of your browser confirming as much:

![GitHub Fetch Upstream confirm](/img/github-fetch-upstream3.png)

Considering that doing this locally requires a bunch of git CLI commands that I typically have to look up every time, this is definitely a welcome addition to GitHub's web site.

### Additional References

- [Sync Fork of GitHub Repo with Upstream](/syncing-a-fork-of-a-github-repository-with-upstream/)
- [GitHub Help Syncing a Fork](https://help.github.com/en/articles/syncing-a-fork)
- [Update Fork without CLI](https://www.sitepoint.com/quick-tip-sync-your-fork-with-the-original-without-the-cli/) (do same thing using a reverse pull request in the browser!)
- [Reset Fork to Upstream](https://stackoverflow.com/questions/42332769/how-do-i-reset-the-git-master-branch-to-the-upstream-branch-in-a-forked-reposito)

