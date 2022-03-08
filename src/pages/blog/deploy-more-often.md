---
templateKey: blog-post
title: Deploy More Often
path: blog-post
date: 2022-03-08
description: If you're not already practicing continuous deployment, odds are your team and company would benefit from more frequent deployments.
featuredpost: false
featuredimage: /img/deploy-more-often.png
tags:
  - agile
  - devops
  - quality
  - productivity
category:
  - Software Development
comments: true
share: true
---

If you're not already practicing continuous deployment, odds are your team and company would benefit from more frequent deployments. Let's look at why this is true.

## Deploying Software

Deploying software is the process of moving it from your development team's tools into a production (or sometimes other) environment. *Deploying* software is not necessarily the same as *releasing* it, though for many developers these go hand-in-hand. Ideally, you should be able to deploy your software frequently, while only releasing new features or versions to customers when it makes business sense to do so.

If you don't currently differentiate between deploying and releasing your software, this is a good topic to investigate. Do you find that deployments are stressful, painful, and require team members to work during non-typical business hours? What if you could eliminate that by deploying whenever you wanted, but only releasing the software when it was convenient for your team and/or your users?

A key enabler of splitting the ideas of deployments from releases is feature flags (also called feature toggles). You can deploy code that isn't ready yet and "hide" it behind a feature flag. Once it's done, and the business determines the time is right to release it (to all or just some users), the flag can be toggled and the feature becomes live. Even this process can be scheduled, so nobody needs to actually do anything at 3am in order for a feature to go live at that time.

## How often do you deploy today

A client I've worked with for a long time used to deploy their software every 6-8 weeks or so. It was a product management decision to schedule a deployment - there was no fixed schedule or cadence. Since their customers would be in the office and expecting to use the system by 8am, the team would begin deployments at 3am. Deployments almost never went as planned the first time, so although the initial deployment only took 10-15 minutes, the rest of the time was needed for testing, fixing bugs, and redeploying as many times as needed in order to (hopefully) have the system working by 8am.

The team did **not** look forward to deployments. These were rough days for the team members, and their families. Deployments were also high stress because if things remained broken at 8am, the team had to push through to get it working or worse, roll back and schedule another deployment for another day that week.

If you deploy infrequently, you're almost certainly deploying changes to production that were completed weeks or months ago. If something goes wrong with that code, the developer who wrote it has probably forgotten about it by the time it's deployed. In some cases, that developer might have left the team they were on or even the whole organization! Whereas if you deploy more frequently, all of the changes going out are fresh in the minds of the team, and so identifying and fixing any issues tends to be much easier.

## Gather Data

The first thing I asked the team to do is to start collecting metrics about their deployments and their success rate.

> A successful deployment is one that does not need to be rolled back, nor does it require an immediate bug fix deployment.

The other critical metric I had them capture was the number of days since the last deployment.

I had the team collect data for about 8 months, which was enough time to document 4-5 deployments (but actually more, when you count the bugfix deployments).

We analyzed the data.

We found that any time a deployment was made after at least 7 days had passed since the previous deployment, there was a 0% change of success. Zero!

We found that for deployments made within a day of the last deployment, there was about a 50% change of a successful deployment.

We could easily see an inverse relationship between the time between deployments and their chance of success.

## Do It More Often

["If it hurts, do it more often."](https://weeklydevtips.com/episodes/040)

Based on the data, my proposal to the team was that they deploy more frequently.

You can imagine the looks I got from the team as I suggested this. **Nobody** liked deployment days. These were high stress, sleep-deprived days that threw a wrench into people's work and personal lives and schedules.

And I wanted them to do more of that.

I asked them, "Are the initial deployments high stress and full of uncertainty?" and of course they said yes.

"Ok," I said. "But what about the 2nd or 3rd bugfix deployment? The one you're deploying with just one change in it. Obviously you're hoping that one will work so you can call it a day, but is it as stressful as the first one?"

No, of course not. Only a tiny bit has changed.

"So, why not just keep doing that?"

The team decided to try an experiment. After the next "big" deployment (on a Tuesday), they would deploy whatever additional work was tested and ready to go on that Thursday. And then again the following Tuesday, and every Tuesday and Thursday going forward.

They had been deploying less than 10 times per year; they set a goal of 50 times per year (thinking they wouldn't be able to keep the twice per week schedule going). They surprised themselves and easily exceeded 100 deployments per year, and their deployment success rate was over 90%.

This was some years ago, and the teams are still deploying twice a week today. They know they could probably move to daily deployments if they wanted, but thus far they don't see the gains from that to be worth the additional changes they'd need to make in their process. And that's fine.

It's been a long time since anyone had to do a 3am stressful deployment. And yes, this is a real company, not some fairy tale.

## Summary

Your software delivery process is an important part of your team's (and company's) success (or not). There are a host of reasons why you should be delivering value sooner and more often (time value of money, etc); in this article I focus on just the pain of deployments for the team itself. By following the adage "if it hurts, do it more often", the pain that increases disproportionately with the size of the deployment is kept in check. The cost of testing software and fixing bugs doesn't grow linearly with time, but exponentially, so by deploying more frequently, you reduce the time to discover large classes of problems. This in turn, makes them easier to detect and correct, bit by bit, rather than as a huge problem that's been left to multiply for months.
