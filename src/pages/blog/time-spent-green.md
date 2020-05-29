---
templateKey: blog-post
title: Time Spent Green
path: blog-post
date: 2010-10-29T11:22:00.000Z
description: I’ve been a fan of continuous integration for what seems like
  forever. It’s an amazing way to boost the quality of your code and ensure that
  what gets checked into your repository is working code.
featuredpost: false
featuredimage: /img/run-and-build.png
tags:
  - devops
  - quality
  - tdd
  - testing
category:
  - Software Development
comments: true
share: true
---
I’ve been a fan of continuous integration for what seems like forever. It’s an amazing way to boost the quality of your code and ensure that what gets checked into your repository is working code. It also does a great job of eliminating the “it works on my machine” syndrome that is so common without such a tool. If nothing else, having a separate machine run your build directly from what’s in source control, even without any testing involved, will tell you if what you’ve checked in actually sufficient.

Of course, once you have a build, the goal is to keep it green. You should [follow the check-in dance to minimize the chance of build breakage](/the-check-in-dance). When the build breaks, it should be a BIG DEAL. If you broke it, hang your head in shame – but only briefly. You have a build to fix. If you broke it on your way out the door, like this guy, apologize to your team:

<iframe width="560" height="315" src="https://www.youtube.com/embed/fuPFz5deXOw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

**Measuring Adherence to Good Build Practices**

So you have a build server, and you try to keep the builds green, but how do you know how well you’re doing? Certainly it’s true that the more green builds than red builds, the better. Tools like Cruise Control / CCNET will tell you a % of your builds that are green, which is somewhat useful. However, that doesn’t really describe how long a failing build was allowed to stay red. I think that the actual Time Spent Green should be the metric. Here’s an example of the build history, as displayed in [TeamCity](http://www.jetbrains.com/teamcity/download/index.html):

![image](<> "image")

Unfortunately, TC doesn’t support a TimeSpentGreen metric like I’m describing. What it would be is simply the total time the build was green for a given period of time. I think the last 30 days would be good. For the build above, assuming there were no broken builds in the list recently, TSG would be 100%. The total TimeSpentRed would be the time when each red build occurred until the next green build ended (TeamCity and other build servers know how long builds take so this is easily calculated). And of course, you could calculate it across several periods, like so:

> ***Time Spent Green***\
> Today: 100%\
> Last 7 Days: 100%\
> Last 30 Days: 98%\
> Lifetime: 97%

Again, I’m not away of a build server that produces this metric automatically, but it’s definitely one I would like to see, since by glancing at a project you would know how seriously the dev team took the build process.

What do you think? Is this a worthwhile thing to measure? Do you know of a tool or add-in that already does this? Does anybody want to volunteer to do an add-in for TeamCity for me?