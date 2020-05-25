---
templateKey: blog-post
title: MS Passport – What are they thinking?
path: blog-post
date: 2003-07-24T23:46:00.000Z
description: "Note – this is a rant I’ve had for a long time, not a response to
  anything new. You can learn more about the Passport. To get right to the
  chase, here’s the part I think is ludicrous and detrimental to Passport ever
  getting any market share:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - MS Passport
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

Note – this is a rant I’ve had for a long time, not a response to anything new. You can learn more about Passport [here](http://www.passport.net/) and [here](http://www.microsoft.com/net/services/passport/business.asp). To get right to the chase, here’s the part I think is ludicrous and detrimental to Passport ever getting any market share:

*There are two fees for licensing .NET Passport: a periodic compliance testing fee of US$1,500 per URL and a yearly provisioning fee of US$10,000 per company. The provisioning fee is charged on a per-company basis and can be applied to multiple URLs. For example, if your company uses .NET Passport on three distinct URLs, you would pay one yearly fee plus the periodic compliance testing fee for each of the three URLs. This entitles your company to unlimited volume use of the .NET Passport service at those URLs.*

This pricing model is absurd. Microsoft has been totally unsuccessful at getting businesses to adopt and use Passport for a variety of reasons, not the least of which is its spotty security record and the fairly hefty amount of work required to implement the system. They’ve done a great job of getting end users signed up, but without some businesses using it outside of Microsoft, it’s not terribly worthwhile.

I am in love with the idea of Passport. I hate the fact that every site I go to requires a different format of username and password. I’d love to be able to just click “sign in” and use a single-signon service like Passport to securely allow me access. I’d love to not have to type in my street address when I buy something if I’ve said it’s ok to share the information. These are all good things from the end-user perspective.

As a website developer, I love the idea of Passport. I have a bunch of different sites with separate back end databases and user stores. I’d love to be able to use a Passport ID to uniquely identify users regardless of which site they’re in, and to allow them to bounce between sites and/or applications within a site (e.g. the ASP.NET Forums which use a totally separate authentication scheme from what most sites have) without having to sign in more than once.

Here’s the rub – nobody is going to pay $10k/year + $1500/URL for a login control. They’re just not that hard to build yourself. If anybody wants one in .NET, I have a complete N-Tier implementation of user registration/login/logout as a sample application [here](http://aspsmith.com/DesktopDefault.aspx?tabindex=3&tabid=9) (bottom of page, “NTier Sample App w/Unit Tests”.

Large organizations like banks and such already have authentication systems in place at this point – they’ve had to build them by now, so it’s not like Passport is saving them any work. The benefits are marginal and far outweighed by the security concerns that plague Passport. They’re not going to jump on Passport for $12k/year, unless it’s MS paying them $12k, not the other way around.

Small shops who are building new applications and sites would benefit from a packaged, ready-to-go authentication system. Passport would be a good fit here, but again, the price is totally insane. I’m talking about sites that pay less than $100/month for shared hosting, of which there are thousands. The developer resources for these organizations are usually stretched to the limit already, as are their budgets for IT. A cheap version of Passport would probably be welcomed and would provide MS with a lot of market share, but the current price scheme will never see that happen.

I’ve talked about this with many different Microsoft employees, none of whom are on the Passport team. Nobody I’ve spoken to thinks the current price scheme makes any sense. On the off chance somebody from that team sees this, I’d love to hear their side of things. Maybe I’m wrong and Passport is flying off the shelves and making MS millions, but I don’t see it at any of the sites I go to unless MS owns them.

<!--EndFragment-->