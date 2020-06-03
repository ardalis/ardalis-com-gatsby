---
templateKey: blog-post
title: Tagging Releases in Source Control
path: blog-post
date: 2010-06-22T14:50:00.000Z
description: A best practice when you're using source control is to tag your
  releases. What does this mean, exactly?
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Source Control
  - svn
category:
  - Software Development
comments: true
share: true
---
A best practice when you're using source control is to tag your releases. What does this mean, exactly? If you're following the relatively standard non-distributed source control repository folder structure of having root folders for:

branches\
tags\
trunk

then it means simply making a copy of the current state of the system when you did your release. Here's how to do it using Subversion (SVN) and the TortoiseSVN client, both popular free tools for source control management.

## Step 1: Test and Deploy Your Application

Do whatever it is you do to deploy your application. Maybe you create an EXE package. Maybe you FTP a web site to production. Whatever it is, get your source code into the final state it needs to be in, and then do your deployment.

If the deployment doesn't work, don't go past this step.

## Step 2: Tag Your Current Trunk

Assuming that you re deploying from the trunk of your source control repository, and that it's your working copy (both relatively standard assumptions but certainly not 100% true for all shops) then the following steps should work for you.

First, go to the root of your working copy and select Branch/tag from the TortoiseSVN menu in Windows Explorer. See Figure 1.

**Figure 1 – Select Branch/tag…**

![TortoiseSVN Menu](/img/svn-branch-tag.png)

Next, you want to fill in the dialog like in Figure 2 below. You're copying from the trunk, which should be the default for the first URL (From WC at URL:). Your To URL you will need to set. It's a good idea to use a date time that will sort alphanumerically, like **YYYYMMDDSomething**. Since we might use tags for things other than deployments, I use **YYMMDDDeploy**. If you end up having more than one deployment on a given date, you can always add an 01, 02, 03 or something to the end of the string. This is basically just a folder name – you can do whatever you want with it but it's good to have a standard and stick to it. "Release" is also common.

If your working copy is what you just deployed, it's best to select that for the Create copy in the repository from: option. However, if you've just checked in or done an update and you know your working copy is the same as the latest in the trunk, you could select HEAD revision in the repository. Just be careful if you do this and you work on a team – if someone else does a checkin before you're done with your tagging operation, you could end up with stuff in your tagged version of the code that didn't really go into the deployment. Working copy is safer.

**Figure 2 – Copy (Branch / Tag) window**

![Copy Branch/Tag Window](/img/copy-branch-tag.png)

If you do end up with a different version in your working copy than what was deployed, you can always use the Specific revision in repository option to select the actual revision number that corresponded to the deployment.

You want to be sure to leave the Switch working copy to new branch/tag checkbox unchecked. Generally tags are meant to be snapshots, not something that you commit work to. If you end up needing to modify stuff in a tag, you should copy it into a branch and do the work there, then merge it into the trunk, then deploy it, and tag the new deployment.

Once you're ready, click OK and you should see something like this:

![Tortoise SVN Copy Window](/img/copy-finished.png)

## Summary

Adding tags is valuable because it lets you identify the exact version of your software that corresponds with a given release or deployment. If bugs occur, you can review the tagged copy of your source to identify the bug, then create a branch in which to fix it (or just fix it in the trunk if it's simple). Without tags, if any significant work is done between releases, it can be difficult to recreate an environment that corresponds to the one a customer is using when bugs are found.
