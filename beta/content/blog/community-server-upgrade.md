---
title: Community Server Upgrade
date: "2006-08-21T22:57:28.1960000-04:00"
description: Yesterday we upgraded AspAdvice (and the other Advice Sites) to Community Server 2.1. If you find any bugs or things that don't look right, please contact me and let me know and we'll work on getting them fixed.
featuredImage: img/community-server-upgrade-featured.png
---

Yesterday we upgraded AspAdvice (and the other Advice Sites) to Community Server 2.1. If you find any bugs or things that don't look right, please contact me and let me know and we'll work on getting them fixed. One of the biggest changes from 2.0 to 2.1 is the implementation of tags rather than categories, and the tag clouds that you'll now see in several places on blogs and blog listings on the site.

In addition, since as part of the upgrade our old CAPTCHA control went by the wayside and comment spam was out of control, I finally installed [RDOS](http://angrypets.com/tools/rdos) a few minutes ago (which had been on my TODO list for almost a year). It took about 5 minutes and the site came right back up (after touching the root web.config to install the module). I'll know in a few hours if it's doing its job or not, and we'll probably add some kind of CAPTCHA as well, just because spam sucks and it's better to have defense in depth.

**Update**: A lot of comment spam is not caught by RDOS so it looks like the CAPTCHA is definitely going to be necessary. Hopefully we'll have one reinstalled this evening.

