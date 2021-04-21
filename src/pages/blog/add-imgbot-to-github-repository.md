---
templateKey: blog-post
title: Add ImgBot to your GitHub Repository
date: 2021-04-21
description: Spend less time worrying about optimizing your images for your blog, README, etc. and leave it to this simple but helpful bot. Free for open source.
path: blog-post
featuredpost: false
featuredimage: /img/add-imgbot-github-repository.png
tags:
  - programming
  - blogging
  - GitHub
  - ImgBot
category:
  - Software Development
comments: true
share: true
---

My blog is hosted on GitHub using GatsbyJS and Netlify. One nice thing about this setup is that I have complete control over my content, and it's all version controlled and backed up both on GitHub and on various machines where I've cloned the repo.

Along with the text content, almost all of the images associated with my content are in the same repository. Sometimes they're hi-res screenshots. Sometimes they're pulled from [tools like Pablo that I use to create title images](/using-pablo-to-create-title-images/). In any case, I try to optimize my blog authoring for speed, and I'm not very fast when it comes to image optimization.

## Enter ImgBot

[ImgBot](https://imgbot.net/) is a handy bot that you can add to your GitHub repository. It's free for open source projects, such as this blog's source. It's job is to compress images so they're optmized for rendering online (so your 8MB ultrawide screenshot that's showing in the blog at 600x200 doesn't require *quite* so much bandwidth).

Any time you commit to your main repository, ImgBot acts like another CI process and checks to see if there are any images it can help with. If there are, it will submit a pull request with optimizations, like this one (from last week's article on [xunit testing exceptions](/testing-exceptions-with-xunit-and-actions/)):

![imgbot pull request](/img/imgbot-pull-request.png)

That's it! The PRs are small and focused (as all pull requests should be), so you can usually just approve them from your phone and go about your day. No need to fire up a photo editing tool as part of your authoring workflow!

## Set it up

You [add ImgBot to your GitHub repo by going to GitHub's marketplace](https://github.com/marketplace/imgbot) and setting up a (free for open source projects) plan. Once you give ImgBot access to your repository, it will start scanning it and sending you pull requests. That's it! It uses lossless compression by default, so don't worry that it's going to ruin all of your beautiful images.

## But can I configure it

You may be thinking, "This sounds great, Steve, but *my* special case has special needs..."

ImgBot has you covered. The bot supports [optional configuration](https://imgbot.net/docs/#configuration) by adding a `.imgbotconfig` file to your repository. There you can specify things like when or how often the bot runs, files and folders it should ignore, how aggressive it should be about its compression, and more.

## But at what cost

Like I said above, it's free for open source, which is how I've mainly used it. However, if you do have a closed source project you'd like to use it on, [check out ImgBot's pricing](https://github.com/marketplace/imgbot#pricing-and-setup). At the time of my writing this, it's $10/mo for an individual license for personal projects, and $30/mo for an organization's project.
