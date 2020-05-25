---
templateKey: blog-post
title: How to Make Git Forget Tracked Files Now In gitignore
path: blog-post
date: 2017-03-28T03:21:00.000Z
description: When you set up a new git repository, if you don’t properly
  configure a .gitignore file at the start, it can bite you later if you’ve
  already committed and pushed files that you really wished you’d kept out of
  the repo.
featuredpost: false
featuredimage: /img/github-gitignore.png
tags:
  - git
  - GitHub
category:
  - Software Development
comments: true
share: true
---
When you set up a new git repository, if you don’t properly configure a .gitignore file at the start, it can bite you later if you’ve already committed and pushed files that you really wished you’d kept out of the repo. If you’re working with GitHub, and you’re starting the repository from GitHub (rather than locally), remember to choose an option from the Add .gitignore dropdown:

![](/img/github-gitignore.png)

If you do forget this step, you can always add a pre-configured .gitignore file from one of the ones found [here](https://github.com/github/gitignore), such as the [Visual Studio .gitignore](https://github.com/github/gitignore/blob/master/VisualStudio.gitignore).

If you don’t do one of these things before you start committing to your repository, and instead you realize it later, you may end up with things being tracked in your repository that you really don’t want to track.

In this case, you don’t want to delete the files, necessarily. These might be files that you need for the project. They just don’t belong in source control. And if they’re generated files, deleting them won’t really help since they’ll probably just keep coming back as you continue to work. What you need is a way to remove them from the repository and get git to ignore them (like your newly added .gitignore file says to do, a little bit too late, right?).

Git features a ‘remove’ command, `git rm`. You can use it to remove files from git’s tracking cache, like so:

`git rm --cached <filename>`

The above command is for a specific file. It will take effect with your next commit. It’s a good idea for you to commit any pending changes you have before you start this process. If you have many files and/or folders (for instance, your /bin and /obj folders in a .NET project) that you need to clean up from your repository, you can use the following commands to remove them from the index (cache):

`git rm -r --cached .`

The `-r` switch makes the command recursive from the current path. Next, add back all of the files you do want to track, using:

`git add .`

Then, commit your changes and your files that would have been ignored if you’d had the right `.gitignore` in place from the start should no longer be tracked. Yay! If you’re interested, or if this approach doesn’t work for you, there are a few variations on how you might achieve the same result listed in [this StackOverflow thread](http://stackoverflow.com/questions/1274057/how-to-make-git-forget-about-a-file-that-was-tracked-but-is-now-in-gitignore).