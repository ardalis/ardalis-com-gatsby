---
templateKey: blog-post
title: Git Graph Visualizes Branches in VS Code for Free
date: 2019-09-04
path: /git-graph-visualizes-branches-in-vs-code-for-free
featuredpost: false
featuredimage: /img/git-graph-visualizes-branches-in-vs-code-for-free.png
tags:
  - Cool Tools
  - extensions
  - git
  - git graph
  - tools
  - visual studio
  - vs code
category:
  - Software Development
comments: true
share: true
---

I recently discovered a very nice VS Code extension to use with git. You can view [my full list of tools and extensions I use here](https://ardalis.com/tools-used) if you're interested. In this case, I was working from a locked down laptop for a financial services company that's a client of mine (talk to me if you'd like help building better software), and I wanted to see a good visualization of the my branch in relation to other branches. Something like this (this is actually from Microsoft's documentation repository):

![](/img/image-git-graph.png)

Git Graph for docs.microsoft.com's repository

I've long been a fan of some client tools to help with this, like SourceTree and [GitKraken](https://www.gitkraken.com/) (my current favorite). But I only use GitKraken's free client for open source projects, and in any case I didn't want to install another full program on this machine. So I figured I'd investigate what VS Code had to offer via extensions and I wasn't disappointed!

There are quite a few git-related extensions available now for VS Code. The one I quickly found was [Git Graph, by mhutchie](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph). I'm also a fan of [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) while you're at it.

Git Graph does just what I want, which is to visualize commits to my git repository in a graph format that lets me easily see which commits and branches are where relative to one another. I find it very useful when I'm working with a repo and I see that, for instance, I'm both 2 commits ahead and 3 commits behind my origin repository. I often want to know what I'm getting into at that point before I start my merge.

Git Graph doesn't have nearly the features that a full GUI git client like GitKraken has, but it does a nice job of being a lightweight tool for visualizing the state of your repository's commits across different branches and repositories. It also supports some additional features like comparing between commits and helping facilitate code reviews (as well as automatically replacing Emoji Shortcodes with the corresponding emoji (or [gitmoji](https://gitmoji.carloscuesta.me/)) in commit messages). You access its graph view (git log) from the built-in git tab in VS Code:

![](/img/image-1-git-graph.png)

Accessing Git Graph from the Source Control/Git tab in VS Code.

You can also access the graph as well as perform other operations from the command palette:

![](/img/image-2-git-graph.png)

Git Graph commands.

I haven't really even used all of Git Graph's features so if you check it out and find some hidden gem I didn't mention, please leave a note in the comments. Hope this helps you be even more productive with VS Code and Git! It's already been a huge help for me.

If you found this useful, consider sharing this tweet:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Git Graph Visualizes Your git log Branches in VS Code for Free<a href="https://t.co/bl9weq6n2q">https://t.co/bl9weq6n2q</a><a href="https://twitter.com/hashtag/git?src=hash&amp;ref_src=twsrc%5Etfw">#git</a> <a href="https://twitter.com/hashtag/github?src=hash&amp;ref_src=twsrc%5Etfw">#github</a> <a href="https://twitter.com/hashtag/programming?src=hash&amp;ref_src=twsrc%5Etfw">#programming</a> <a href="https://twitter.com/hashtag/CodeNewbie?src=hash&amp;ref_src=twsrc%5Etfw">#CodeNewbie</a></p>— Steve "ardalis" Smith (@ardalis) <a href="https://twitter.com/ardalis/status/1169610669286707201?ref_src=twsrc%5Etfw">September 5, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
