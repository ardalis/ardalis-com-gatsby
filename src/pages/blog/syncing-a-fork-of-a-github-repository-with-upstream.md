---
templateKey: blog-post
title: Syncing a Fork of a GitHub Repository with Upstream
date: 2019-06-07
path: /syncing-a-fork-of-a-github-repository-with-upstream
featuredpost: false
featuredimage: /img/syncing-a-fork-of-a-github-repository-with-upstream.png
tags:
  - fork
  - git
  - open source
  - pull request
  - source control
category:
  - Software Development
comments: true
share: true
---

I work on a few GitHub projects, like the [Microsoft Docs](https://docs.microsoft.com/en-us/), where I'm a relatively frequent contributor but I don't have commit rights. This means that I need to make a fork of their repository, do some work in my fork, and then send a pull request from my forked repository to the original one. This is actually a pretty common way of working in open source software, and doing it once is pretty straightforward.

However, GitHub only lets you fork a repository once. And it doesn't offer any way to update that fork from the web interface. So, once you've got a fork, you have a snapshot-in-time of the original repository, but if a few months later you want to make more additions, you'd better update your fork to the latest version of its _upstream repository_ before you start working on your additions.

For this example I'm going to use the [Microsoft .NET Docs GitHub repo](https://github.com/dotnet/docs) as the upstream repo and [my own fork of the docs repo](https://github.com/ardalis/docs-1) as the fork I'm trying to sync.

The first thing you need to do is make sure you have a git remote configured for the upstream (original, source) repository. You can view your current remotes with this command:

$ git remote
origin

To add the repository from which you forked and name it upstream, you would use the `git remote add` command like so:

$ git remote add upstream https://github.com/dotnet/docs.git

You can confirm it worked by running `git remote` again:

$ git remote
origin
upstream

Now you need to sync your local git repo with the upstream version. There are 3 git repositories involved here: upstream, origin, local. You're going to apply changes from upstream to local first, and then push them to origin after that's done. To get the changes from the upstream repo, you need to _fetch_ them (and specify the remote).

$ git fetch upstream

Now check out your master branch and merge the upstream master into it:

$ git checkout master
Switched to branch 'master'

$ git merge upstream/master
Updating  `a422352..5fdff0f` 
...

At this point your local repo is up to date with the upstream repo. The last step is to push your changes up to your fork on GitHub.

$ git push

And you're done! Now you're all set to work on your 2nd (or Nth) pull request for the upstream repository using the same fork you created some time ago.

## Reset to Upstream

What if things are out of whack and you just want to reset your branch to the upstream version, losing anything that may be committed to your fork that you don't intend to pull request upstream? Follow these steps, [originally described here](https://stackoverflow.com/a/42332860/13729):

```
# ensures current branch is master
git checkout master

# pulls all new commits made to upstream/master
git pull upstream master

# this will delete all your local changes to master
git reset --hard upstream/master

# take care, this will delete all your changes on your forked master
git push origin master --force
```

If you found this helpful, consider retweeting this tweet so others can easily find this article as well:

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Syncing a Fork of a GitHub Repository with Upstream <a href="https://t.co/wI6dPjLy6t">https://t.co/wI6dPjLy6t</a> <a href="https://twitter.com/hashtag/git?src=hash&amp;ref_src=twsrc%5Etfw">#git</a> <a href="https://twitter.com/hashtag/github?src=hash&amp;ref_src=twsrc%5Etfw">#github</a> <a href="https://twitter.com/hashtag/codenewbies?src=hash&amp;ref_src=twsrc%5Etfw">#codenewbies</a> <a href="https://twitter.com/hashtag/code?src=hash&amp;ref_src=twsrc%5Etfw">#code</a> <a href="https://twitter.com/hashtag/dev?src=hash&amp;ref_src=twsrc%5Etfw">#dev</a></p>— Steve "ardalis" Smith (@ardalis) <a href="https://twitter.com/ardalis/status/1137009960691359744?ref_src=twsrc%5Etfw">June 7, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

### Additional References

- [GitHub Help Syncing a Fork](https://help.github.com/en/articles/syncing-a-fork)
- [Update Fork without CLI](https://www.sitepoint.com/quick-tip-sync-your-fork-with-the-original-without-the-cli/) (do same thing using a reverse pull request in the browser!)
- [Reset Fork to Upstream](https://stackoverflow.com/questions/42332769/how-do-i-reset-the-git-master-branch-to-the-upstream-branch-in-a-forked-reposito)
