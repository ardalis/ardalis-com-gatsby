---
templateKey: blog-post
title: Upgrading TFS from RC to Workgroup Edition
path: blog-post
date: 2006-09-06T02:39:00.326Z
description: Today I came into work and my build/source control server, which I
  thought I remembered installing the RTM of TFS Workgroup Edition, was
  complaining that my license had expired.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Team System
  - TFS
  - VS.NET
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Today I came into work and my build/source control server, which I thought I remembered installing the RTM of TFS Workgroup Edition, was complaining that my license had expired. When this happens, the error message looks something like this:

**“TF30072: The Team Foundation Server trial period has expired or its license is otherwise invalid. Install a licensed edition of Team Foundation Server to continue.”**

I started looking for information, mostly on [Rob Caron’s blog](http://blogs.msdn.com/robcaron), and quickly found a post about Expiring [Team Foundation Server Installations](http://blogs.msdn.com/robcaron/archive/2006/08/08/692314.aspx). Armed with that, I next decided to confirm what version of TFS I really had installed, which [another post covered](http://blogs.msdn.com/robcaron/archive/2006/08/15/701843.aspx). Unfortunately for me, it turned out I was running *8.0.50727.127 = Release Candidate* and not *8.0.50727.147 = RTM* (final shipping release of the product) as I had thought.

No problem, the next step was to figure out what I had to do to get things working. I tried just going into Add/Remove Programs and doing a Repair using the RTM TFS Workgroup Edition media/DVD, but that didn’t work. More searching led me to Rob’s post on [Upgrading to Team Foundation Server (RTM).](http://blogs.msdn.com/robcaron/archive/2006/03/17/554115.aspx) This includes links to a package for upgrading from RC to RTM, which I was able to download, unzip, and run. It also includes a nice RTF document explaining everything you need to do in order to upgrade in 10 (fairly involved but at least for me working as advertised) steps. Following these steps, I was able to upgrade my server in about an hour or so of work.

Switching to the workgroup edition forced me to do one more setup step, which was to add my users to the Team Foundation Server Licensed Users group, as described [here](http://blogs.msdn.com/robcaron/archive/2006/03/16/553121.aspx). For detailed, steps, read [How To: Add Users to Team Foundation Server Workgroup Edition](http://blogs.msdn.com/vstsue/articles/556043.aspx).

One slight issue here – I used the TFSSetup account suggested in the original installation docs to install TFS, and once I was done, this account was one of the members of hte Team System Licensed Users group, which is limited to 5 members. I don’t really want this account to be a member; I want to actually have 5 real users as members, but I’m afraid to remove it for fear it will break something, and Rob isn’t sure it won’t do bad things, so for now I’m stuck with a 4–user limit instead of 5. However, Rob did point out that the TFSSetup account name is really only a suggested name, and that it would have been wiser for me to have used my own machine name for the install, since that was going to end up being one of the users. [**Update:** [Rob blogged about this today](http://blogs.msdn.com/robcaron/archive/2006/09/06/743086.aspx)]Maybe next time, but hopefully this will help some others avoid that pitfall… And, if anybody can tell me for certain that nothing bad will happen if I remove TFSSetup from the group, I’ll give it a shot, but I’d rather let somebody else experiment with that first. For now I have enough accounts with 4.

Lastly, even after all of this drama about which accounts to add, my client machines were unable to connect to the server, seeing the dreaded

**TF31001: Team Foundation cannot retrieve the list of team project from Team Foundation Server. The Team Foundation Server returned the following error: The request failed with HTTP status 403: *DomainUser* is not a licensed user.**

error. Note that in this case I had set up my server with ***SERVERNAME/steve*** as a licensed user, but I was getting this error telling me that ***DOMAINNAME/steve*** was not a licensed user, and there was no prompt for credentials that would let me specify the machine account. Rob saved the day by suggesting that I set up cached user credentials for the TFS server. I’d never done that before – here are the steps:

1. Open Control Panel on the Dev/Client machine\
2. Open User Accounts\
3. Click the Advanced tab.\
4. Click Manage Passwords.\
5. Click Add.\
6. Enter your TFS server name and your credentials (MACHINEusername if you want to use the machine user not the domain user).\
7. Click OK a bunch of times.

Following that process, I was able to fire up VSTS and Team Explorer and connect to my TFS box without even a prompt for credentials (which is what it was doing before the upgrade to workgroup edition).

<!--EndFragment-->