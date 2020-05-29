---
templateKey: blog-post
title: Windows Auto Sign On In Locked Mode
path: blog-post
date: 2009-09-03T22:41:00.000Z
description: Earlier this week, after enduring yet another windows update, I
  came up with a feature request for Windows that would make me a much happier
  user. We’ve all heard about requests for speeding up boot times and there has
  been some progress on this
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Windows
category:
  - Uncategorized
comments: true
share: true
---
Earlier this week, after enduring yet another windows update, I came up with a feature request for Windows that would make me a much happier user. We’ve all heard about requests for speeding up boot times and there has been some progress on this (and of course there are hardware solutions like SSDs that can help here). What I’m looking for is related, but not quite the same.



**Background**

I had just turned on my computer, after shutting it down at the end of the day and letting it install updates. That took a few minutes, but not too bad, but then it wanted to finish installing 3 updates as it started up. Ok, fine, so I went and did something else for a while. Then I returned to find it was finally ready and I signed in, but of course then I had to wait for windows to come up, and then my usual auto-start programs to come up, and then my non-auto-start-but-I-manually-start-them-every-time programs to come up, and 10 minutes later my computer was finally at a point where I could compose an email.

Why must I repeatedly wait on my computer when what I really want is to be able to sign in as needed and immediately have the system in the state where I’m productive with it?

A gentle note to commenters: Please don’t tell me to just leave my system on and use Sleep/Hibernate to avoid this issue. I do that. Unfortunately, that isn’t an option when Windows Updates are involved, as my scenario above makes clear. Thank you.



**Request: Automatically Sign In (with Locked Screen)**

I would love it if, when I turned on my computer, it automatically logged me into my account, auto-started all my startup programs, etc., but did so in the background behind the login screen (which in this case could be the “Locked” screen). What I want is a boot-to-locked-account mode. I want to go into an account and say “Automatically boot into this account (locked)” as a checkbox. With this, I could let my computer start up and I can be doing other things and when I come back to it, **it’s actually ready for me to use it, not just at another roadblock that requires my intervention and results in my having to wait again**.

Microsoft of late has done a great job at removing needless UI intervention in various installers and combining installers into one (the [Web Platform Installer is awesome](http://www.microsoft.com/web/Downloads/platform.aspx) this way, for example). I’ve also suggested in the past they provide a way to [automate installation of multiple applications from MSDN](/msdn-subscription-installer). This would be another area in which they could make the task of starting up the computer less painful by requiring less user intervention.



**Hacking It**

There is a way you can do this today, but it’s not easy, is a hack, and introduces some security holes into your system. Having been so warned that these instructions might cause your computer to explode or kill your kittens, the responsibility for your actions should you choose to follow them rests solely on your shoulders.

If you want [automatic logon, you can follow these instructions which should fork for XP/Vista/7](http://www.mydigitallife.info/2008/06/15/how-to-enable-auto-logon-to-windows-xp-and-vista-joined-as-domain-member). That gets you a system that logs into a particular user account automatically, but of course then anyone walking up to it can start using it. If you want it to be locked, you can [follow these instructions for locking windows from the command prompt](http://windowsitpro.com/article/articleid/14925/how-can-i-lock-a-workstation-from-the-command-line.html) and then run these from a .bat file in your Startup folder. The Win2000 instructions should work fine on Win7. That’s it.

Thanks to [Brian Keller](http://blogs.msdn.com/briankel) for the tip on how to get this to work currently.