---
templateKey: blog-post
title: Microsoft Account Azure Login Problem Resolved
date: 2022-12-15
description: In November 2022, I started having problems logging into the Azure portal with my Microsoft Account that I've had for years, and which worked elsewhere. I managed to resolve the issue finally with the help of a Microsoft support ticket. Read on if you're having a similar problem.
path: blog-post
featuredpost: false
featuredimage: /img/scaling-redis.png
tags:
  - azure
  - microsoft account
  - live id
  - security
category:
  - Software Development
comments: true
share: true
---

In November 2022, I started having problems logging into the Azure portal with my Microsoft Account that I've had for years, and which worked elsewhere. I managed to resolve the issue finally with the help of a Microsoft support ticket. Read on if you're having a similar problem.

## The Problem

When logging into the [Azure Portal (portal.azure.com)](https://portal.azure.com), with my Microsoft Account (which is not a "Work or School Account"), the login would fail with one of several errors or behaviors. After intermittently trying to resolve the issue for several weeks, I started getting frustrated and posting to Twitter and emailing my Microsoft contacts.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Here&#39;s another example when I try to sign into <a href="https://twitter.com/hashtag/Azure?src=hash&amp;ref_src=twsrc%5Etfw">#Azure</a> directly...<br><br>At the bottom it says &quot;If you plan on getting help for this problem...&quot;<br><br>I mean, I&#39;d *hoped* to get help but apparently there&#39;s no actual way to do that. That text should have been a link to said help. <a href="https://t.co/KWXvNk07Mt">pic.twitter.com/KWXvNk07Mt</a></p>&mdash; Steve &quot;ardalis&quot; Smith (@ardalis) <a href="https://twitter.com/ardalis/status/1602682177262592000?ref_src=twsrc%5Etfw">December 13, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Sometimes logging in would result in a dialog like this one:

![more information required azure login](/img/azure-login-more-information-required0.png)

Of course, it doesn't say anything about **what** additional information is required, and if you click the 'Next' button, it just slightly animates and hangs forever:

![more information required azure login animated marching ants](/img/azure-login-more-information-required.png)

This screenshot isn't animated, but some dots would move along the top and inspecting in dev tools reveals that this is a "marching ants" animation. But it's 100% useless if you're experiencing this problem, and no network requests are visible in dev tools when you click 'Next', which doesn't help with troubleshooting.

If you try logging in with another account, you may get this error:

![azure microsoft account login invalid STS](/img/azure-login-invalid-sts.png)

This looks like it might provide helpful information. There's mention of "getting help" and reference GUIDs for things like 'Request Id' and 'Correlation Id'. When I finally was able to talk to a Microsoft support engineer, there were no diagnostics available to them related to these IDs, unfortunately (even when I clicked "Enable Flagging" and reproduced the problem on a Teams call with them). So, while it was nice to see an actual error message instead of an endless animation, it didn't actually help me resolve the problem, either.

Note that one of my Azure-hosted web apps was experiencing issues that I could only diagnose and fix easily from the portal, so not being able to log in was becoming increasingly annoying not just to me but also my customers.

## Things I Tried That Did Not Work

If you start searching for help on problems with logging in using Microsoft accounts, you'll find no end of folks sharing your frustrations. Microsoft definitely doesn't make this the best user experience possible, nor do they seem to have any proactive support contacting customers having problems or fixing root causes behind the scenes. This is unfortunate since Microsoft Accounts and authentication are required for Microsoft's biggest products. It's an obvious single point of failure that the company should recognize and prioritize accordingly with more resources, but that's a story for another day.

Unfortunately, because there are so many issues with the experience, there's an overwhelming number of possible solutions and workarounds online, 99% of which will not apply to your case. This article will just be one more of them, but hopefully it's the right one for some of you (in which case, leave a comment!).

The basic troubleshooting things you should do when you're having problems logging in include (retrying after each):

- Reload your browser
- Clear your cookies
- Use an incognito/inprivate window
- Open developer tools, clear cache and hard refresh (aka **really f-ing reload**)
- Use a different browser entirely (Edge, Chrome, Safari, etc.)
- Reboot your computer
- Try a different computer entirely

If it's a multi-site login like Microsoft Account, you can also try:

- Log in to account.microsoft.com
- Log in to xbox.microsoft.com
- Try resetting your password (and repeat above steps)

If you don't have your [Microsoft Account associated with your GitHub account](https://support.microsoft.com/en-us/account-billing/link-your-github-account-and-microsoft-account-c9b04f45-8978-448e-bb90-0503d22d7ea1), you can do that and try again.

- Log in with GitHub

At the end of the day, none of these resolved my problem.

## Getting Help from Microsoft

- Try to open support
- Most things try to send you to Azure which doesn't work since you can't log in
- There is not support option for "Microsoft Account" or "Azure Login"

## Solution

- Use a different Microsoft Account (or create a new one)
- Go to the (link) and create a support ticket. Just guess at what sounds close - I used Azure AD Authentication or something like that
- After reproducing the issue with the support engineer, they were going to send me to another team, but then we tried "one more thing" and it turned out to be the fix!

- Associate your Microsoft Account with the Authenticator app.


## References



