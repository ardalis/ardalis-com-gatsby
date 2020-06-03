---
templateKey: blog-post
title: P3P Trouble with Internet Explorer
path: blog-post
date: 2008-09-12T02:30:00.000Z
description: Recently I've had some customers request that some third party
  scripts Lake Quincy Media provides avoid the evil eye of death that IE6+ likes
  to show if such scripts even think about using cookies.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - P3P
category:
  - Software Development
comments: true
share: true
---
Recently I've had some customers request that some third party scripts [Lake Quincy Media](http://lakequincy.com/) provides avoid the evil eye of death ![IE evil eye](/img/ie-evil-eye.png) that IE6+ likes to show if such scripts even think about using cookies. In our case, we are testing to see if the browser has Flash installed, and save the result in a cookie since it is a relatively expensive operation and we do not want to have to repeat it. The source of this IE feature is [P3P](http://en.wikipedia.org/wiki/P3P), which itself exists because of user concerns about online privacy.

The concern I have is that I'm having difficulty bypassing the IE6+ behavior **even on my own sites**, where I wish to share common scripts between domains. The issue is that along with the evil eye of death, the cookies are actually blocked, which in the case of the Flash detection is a minor issue but in other situations could be more of a problem. So I tried to find a P3P compact policy that would actually PASS IE's restrictive standards.

I came upon several posts suggesting the [minimal P3P compact policy](http://blog.sweetxml.org/2007/10/minimal-p3p-compact-policy-suggestion.html), and tried it. The exact policy is CAO PSA OUR. However, even this did not work. So at this point I'm still stymied and looking for the holy grail of P3P compact policies – the one that IE6+ will actually allow to write cookies without crying about it. I”ll post if I find such a thing.
