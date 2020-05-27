---
templateKey: blog-post
title: Client Side Client Detection
path: blog-post
date: 2008-09-10T02:41:00.000Z
description: I just heard about a new flavor of the top of the line client
  detection component, BrowserHawk, that is being branded as “BrowserHawk To-Go
  (BHTG).” What’s interesting about this (to me) is that it’s following a SaaS
  model and a pay-as-you-go scheme for pricing.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - BHTG
category:
  - Uncategorized
comments: true
share: true
---
I just heard about a new flavor of the top of the line client detection component, [BrowserHawk](http://www.cyscape.com/products/bhawk), that is being branded as [“BrowserHawk To-Go (BHTG).”](http://www.cyscape.com/products/bhtg) What’s interesting about this (to me) is that it’s following a SaaS model and a pay-as-you-go scheme for pricing. This makes the software very affordable for startup sites and simplifies the installation requirements. Implementation in this case is via a client side script include, which is configured to be cached by users for a day, so the actual number of downloads required should be minimal. Billing is done based on the number of times the script runs, and this in turn is set up to work only with the approved domains of the account owner (so someone else can’t just use your script include and have you foot the bill). I’ve been a happy user of BrowserHawk (and CountryHawk, which BHTG also includes) for years, as we need to detect browser and geolocation as part of our [online ad network software from Lake Quincy Medi](http://lakequincy.com/)a. Another nice feature of going with the SaaS model is that updates will happen in real time and without user intervention. Today we receive monthly updates and must apply these to our server(s) ourselves – BHTG would seem to eliminate that requirement. Another benefit would seem to be greater platform independence, as I imagine the SaaS model doesn’t care what kind of server platform the web site is running on.

I haven’t yet used BHTG myself, so I can’t actually endorse it or anything, but it does sound interesting to me. There’s [a comparison on cyScape’s site](http://www.cyscape.com/products/bhtg/bhtg-vs-classic.aspx) for anybody interested in browser detection and/or country detection. If you have used it, please comment on how it worked out for you. I’m also interested in hearing about other products that are shifting from installed components to online services, and how they’re adapting their business model to account for this shift. I think we’ll see more and more offerings head this way, but it’s interesting to see specific examples.