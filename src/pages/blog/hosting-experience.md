---
templateKey: blog-post
title: Hosting Experience
path: blog-post
date: 2008-02-04T13:57:13.257Z
description: "I've recently completed a fairly major database server move
  involving about a dozen production databases running on a single server, along
  with a rather old Lyris installation that handles all of the mailing lists on
  AspAdvice.com. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Hosting
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I've recently completed a fairly major database server move involving about a dozen production databases running on a single server, along with a rather old [Lyris](http://lyris.com/) installation that handles all of the [mailing lists on AspAdvice.com](http://ardalis.com/lists). Both the old and new database servers are hosted at [ORCSWeb](http://orcsweb.com/), where pretty much all of my sites are hosted (with one exception noted below). I've been hosting with ORCSWeb for a long time – forever in Internet time, since we're talking back into the 90s. [Brad](http://blogs.orcsweb.com/brad/default.aspx) and [Scott](http://weblogs.asp.net/owscott) and [Steve](http://weblogs.asp.net/steveschofield) and the rest of the team have always been great to work with, and I recommend them without qualification. Here's how hosting should work (and does with OrcsWeb):

* You can reach them any time by phone, IM, or email and expect a response within minutes.
* You know your support team by name and they know you.
* When things break, the support team knows it (and often fixes it) before you do.
* If you're going to exceed limits, you're notified in advance and given the chance to increase your quota (of bandwidth, storage, etc).
* When they screw up (which, in my case, has been exceptionally rare), they are quick to take responsibility and fix things as best they can.

I'm hosting some pretty big sites and applications with Orcsweb. ASPAlliance.com is running on their [shared web farm](http://www.orcsweb.com/hosting/webfarmplan.aspx) ($399/mo for a web farm is a steal) and has about 5-10M page views per month. [Lake Quincy's](http://lakequincy.com/) Ad Server also runs on the shared web farm, and serves over 100M ad impressions per month. If you have a medium-traffic site (between 5 and 100M requests/month) then a shared web farm might provide you with the right mix of reliability and scalability (as it does me).

Now, let's contrast this with another hosting provider, albeit one that I'm not paying nearly as much. I recently thought I'd try [1and1.com's](http://1and1.com/) hosting for some images and potentially some of the ASPAlliance videos in order to try and save a bit on bandwidth. They have this [great (sounding) plan](http://order.1and1.com/xml/order/MsHosting;jsessionid=C46EB93264C55FEC6AF32D12CB5ADBFE.TC60b?__frame=_top&__lf=Static) where you can get an ungodly amount of bandwidth per month for like $19 (looks like $10 now with some sale). It comes with 300GB of storage space and 3TB (3000 GB!) of monthly transfer volume. Bandwidth at Orcsweb is not really what I'd call cheap, so $10 for 3000 GB sounded too good to be true. But, being conservative by nature, I didn't run out and move all of my site's files over to 1and1. I moved a couple of logos and icons and maybe a css file over there for ASPAlliance.com, just to see how it would do. One benefit of this is that I used a different top level domain (.info) for these static files, so my pages loaded faster since browsers typically only open 2 or 4 connections to each domain on the page. My initial reaction: cool, this might work!

So like a week into this testing (which was late last year) I started noticing sometimes that the button images would come up as red X's. I checked it out in [FireBug](https://addons.mozilla.org/en-US/firefox/addon/1843) and found that the server was giving me a [503 error](http://www.checkupdown.com/status/E503.html) for the images. I started watching it more closely and found that it was happening with some regularity. So I sent something to support at 1and1, letting them know what I was seeing and wondering if there was something going on at their end. About a day later, they replied that they could not reproduce the problem and could I please send detailed repro steps.

I'm like, WTF? They're static files. They're throwing 503 errors. The web server's log files will show that there are 503 errors. My repro step is try to load the image file and curse when it fails with a 503 error. I explained this to them. I got nowhere.

I got busy with other things, and of course these images weren't mission critical or anything, and they showed up about 80 or 90% of the time so it wasn't life or death, but last week I got a renewal from 1and1 so I sent them another question and a day later got back basically the same "can you repro it" response. Worthless. I replied and explained how log files work and asked if they might check them (middle of last week) but again, no response. Given that the account can't even handle serving up some static images (way, way, WAY less bandwidth than the 3000 GB / month it's alloted) I don't think there's any chance it would host even a lightly trafficked web site effectively.

Compare 1and1 to Orcsweb. 1and1 is dirt cheap and you (apparently) get what you pay for. Their support is clueless or at least unhelpful and certainly not quick to respond. The issue I first reported last year has not been resolved nor, so far as I can tell, even investigated to the extent of examining the server's log files. I've had different people answer each attempt I've made to get support and none of them were any better or more memorable than the others. And they certainly were not proactive about fixing the issue without my having to harass them about it.

If you're hosting a site professionally, stay away from 1and1. If it's important that the site run error-free, and you want to spend your time on other things and let your hosting provider take care of the hosting for you, then trust [ORCSWeb](http://orcsweb.com/).

<!--EndFragment-->