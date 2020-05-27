---
templateKey: blog-post
title: Spam Countermeasures
path: blog-post
date: 2007-02-27T16:43:34.516Z
description: Spam is an increasingly annoying and expensive part of our lives as
  computer users. In the last week, I’ve been forced to take measures to deal
  with spam on several of my web properties.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - spam
  - captcha
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Spam is an increasingly annoying and expensive part of our lives as computer users. In the last week, I’ve been forced to take measures to deal with spam on several of my web properties. On [RegExLib.com](http://regexlib.com/), an online library of regular expressions, it was brought to my attention that a large amount of comment spam was being added to expressions. After some analysis, I ended up cleaning out over 35,000 spam comments spanning the last 18 months or so. Among these were also a few cross-site scripting attack attempts made possible by a lack of HTML encoding in the comments. I corrected these issues and emplaced a [CAPTCHA](http://www.codeproject.com/aspnet/CaptchaNET_2.asp), as well as changing the IDs of the textboxes and buttons involved in the comments form. These changes have eliminated 100% of the spam on that site. However, the image-based CAPTCHA is annoying and difficult for humans to figure out the first time.

[ASPAlliance](http://aspalliance.com/) was suffering from similar abuses, though our moderation of all comments was keeping the spam comments from persisting on the site for more than a few hours. Since I didn’t want anything as intrusive as the image CAPTCHA I used for RegExLib, I decided to experiment with an [Invisible Captcha from Phil Haack](http://haacked.com/archive/2006/09/26/Lightweight_Invisible_CAPTCHA_Validator_Control.aspx). It was simple to implement and seems to be effective, though it has only been in place for a short time. If it proves effective long-term, I’ll likely use it in place of the image-based CAPTCHA for RegExLib as well.

One annoying issue with the ASPAlliance spammers is that we already were requiring user registration for some of our submission forms, such as our [submit a proposal page](http://aspalliance.com/writeforus.aspx), so one enterprising spammer was registering many junk user accounts as part of the attack. I added the CAPTCHA to the register page in addition to the comments form to prevent this attack as well.

All told, I’ve spent close to 30 hours in the last week combating spam. That’s time I’d much rather have spent writing articles or adding useful features to my sites. That’s a big waste, and it’s being felt by others like me all over the world, including every one of you who had to spend any time in the last week deleting spam messages from your inbox or junk email box. The solution, I believe, is to have better communication and, specifically, authentication techniques for the Internet. If and when digital signatures become accepted, and all emails’ sources can be verified reliably, email spam will drop significantly. Once reliable and ubiquitous single sign on technologies like [Cardspace](http://cardspace.netfx3.com/) allow many web sites to authenticate users via a trusted authority, comment spam can be eliminated or greatly reduced. We’re not there yet, but hopefully in the next five years we’ll make some progress.

\[categories: captcha;spam]

Tags: [spam](http://technorati.com/tag/spam), [captcha](http://technorati.com/tag/captcha)

<!--EndFragment-->