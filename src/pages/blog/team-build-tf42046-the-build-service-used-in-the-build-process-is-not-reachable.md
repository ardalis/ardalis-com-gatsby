---
templateKey: blog-post
title: "Team Build TF42046: The Build Service used in the build process is not
  reachable"
path: blog-post
date: 2006-10-20T01:33:22.096Z
description: Ran into this error today trying to kick off a team build. Found
  that I’m using to try and troubleshoot. One note so far is that the Team Build
  install is now found in the “build” folder, not the “BB” folder, on the Team
  Foundation Server installation CD.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - team build
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Ran into this error today trying to kick off a team build. Found [this link](http://geekswithblogs.net/mskoolaid/archive/2005/12/15/63276.aspx)that I’m using to try and troubleshoot. One note so far is that the Team Build install is now found in the “build” folder, not the “BB” folder, on the Team Foundation Server installation CD.

I think that when I rebuilt the machine, I neglected to reinstall the build service, which is why it hasn’t been running for a while. Unfortunately, when I’m trying to install it, I’m running into an error trying to install as a domain user. I have a domain, but the TFS box is running in Workgroup mode. I found [a thread describing this frustrating issue](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=803501&SiteID=1), but so far it’s not working out for me – no matter what domain account I specify it can’t find it.

Trying a reboot after noticing the server had been attached to a domain (not by me). Nope.

I just keep getting “The account name is not valid or does not exist, or the password is not valid for the account name specified.”

**Ah-ha**. I tried *machinename*/username one last time out of desperation. Prior to the reboot, that complianed that this was a local account and that a domain user was required, but this time it let me through. I guess because the server is no longer in a domain (it’s now in a workgroup). **Sweet**.

<!--EndFragment-->