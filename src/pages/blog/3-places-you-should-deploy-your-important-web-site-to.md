---
templateKey: blog-post
title: 3 Places You Should Deploy Your Important Web Site To
path: blog-post
date: 2013-09-25T16:42:00.000Z
description: You’ve got a web site, and you think it’s important. Or your boss
  does. Or your customers do. In any case, someone will notice when that thing
  goes down.
featuredpost: false
featuredimage: /img/deployment.jpg
tags:
  - cd
  - ci
  - deployment
  - devops
  - programming
  - web development
  - web servers
category:
  - Software Development
comments: true
share: true
---
You’ve got a web site, and you think it’s important. Or your boss does. Or your customers do. In any case, someone will notice when that thing goes down. So it’d be nice if that didn’t happen too often, especially during relatively mundane activities like deploying a simple update to the site. Let’s talk about the three places you should be deploying your site to in order to achieve this simple goal.

## Test Environment

The first place you should deploy to is a test environment. The test environment, as the name implies, is where testing can take place. Your testers and QA staff can hammer on this site with impunity. You can do crazy things here, and it won’t affect your end users or your production system. The test environment should live somewhere other than your development machine, unless you are your entire staff of dev/QA/IT, but it should live completely separately from your live environment. If your test site does something crazy, like nuking the file system or pegging the CPU at 100%, it should have zero impact on your production system.

When things look pretty good in the test environment, you’re ready to deploy something to the next location, *Stage*.

## Stage Environment

A staging environment is a relatively safe place for you to make sure everything is ready for production. Ideally, this environment will become the production environment as part of your deployment process, but short of this, it should mirror the production environment as closely as possible. The stage environment should show production data, and should allow final sanity checks of the system just prior to a production deployment. If your application requires some period of warm-up or cache population, this can all be done in the stage environment prior to the environment being promoted to production.

One simple way to achieve a stage and production environment in which as much as possible is mirrored between the two environments is to have both as web sites on the same web server. Assuming you’re using IIS, this can be achieved by having two folders, let’s call them SiteA and SiteB. If SiteA is currently the live, production location, then its IIS host headers or mappings will match the production site (let’s say [www.example.com](http://www.example.com/)). SiteB, at this point, is the stage location, and is mapped to host headers **stage.example.com**. Deployments are made to SiteB’s folder, and are final tests and warmup scripts are performed on stage.example.com. Finally, a script is run that simply swaps the host headers for the two location. After the script runs, SiteB is the live, production site mapped to [www.example.com](http://www.example.com/), and SiteA is the new stage site (which currently is running a backup of the production site, 1 deployment in the past). It’s a good idea to keep SiteA as-is for a short while, or even to copy it to a third folder, SiteC, that serves as the backup of the current live implementation. If something was missed during testing, the site can easily be restored to its previous state by mapping host headers back to SiteA (or, if that’s already being used as a new stage location, then SiteC, the backup of the last deployment, which is never written to except as part of the script that swaps stage and production).

## Production Environment

Assuming your site is actually used by real people, wherever that is, that’s your production environment. You should avoid making any changes to this environment directly, but rather always make updates to stage, and then swap stage and production. Barring that, you should have a highly automated, repeatable, and trusted process for migrating changes from stage to production. And of course, ideally, you should never update a production site while it is live. You should make the updates to stage and then swap (I know, I’m harping on that), or if that’s impossible, you should have at least 2 production sites in a web farm, and you should be able to pull them out of your farm one-by-one to update them, so that real users hitting the site never encounter slowness or downtime as a result of a deployment.

## Summary

Obviously, things can get a little more complicated than this, especially if you have a significant amount of shared infrastructure between your applications (databases, message queues, etc.). However, if you currently only have a production environment, you should look at adding a Stage and Test environment to your process. If you have recommendations for scripts or tools that make this process easier, feel free to note them in the comments. It’s worth mentioning that Windows Azure considers this process to be a standard, such that the default deployment process is to deploy to a stage server and then click a “swap” button to push to production, with a second “swap” effectively undoing the deployment. This isn’t a radical idea, it’s basic deployment hygiene, and if your site is important, I encourage you to implement it or ask your IT team to do so.