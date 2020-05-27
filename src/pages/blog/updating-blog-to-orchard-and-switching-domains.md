---
templateKey: blog-post
title: Updating Blog to Orchard and Switching Domains
date: 2012-01-26
path: /updating-blog-to-orchard-and-switching-domains
featuredpost: false
featuredimage: /img/image_thumb_orchard.png
tags:
  - blog
  - cms
  - graffiti
  - orchard
category:
  - Productivity
comments: true
share: true
---

[![image](/img/image_thumb_orchard.png "image")](/img/image_thumb_orchard.png) So, yesterday I posted [a review of the new Asus Ultrabook](http://ardalis.com/Asus-Zen-Ultrabook-First-Impressions) and, as has become rather predictable lately, the virtual web server hosting my Graffiti-powered blog started having 100% CPU for quite a while after the post went live. Now, I don’t get \*that\* much traffic, but apparently something with my configuration of Graffiti, the server, and the traffic that I do get is enough for it to bring that server to its knees. And Graffiti, great though it was years ago, just had to go.

I opted to go with [Orchard](http://www.orchardproject.net) for several reasons. I’d been on the fence between Orchard and WordPress, but after using WordPress for some other one-off projects over the last 18 months, I’ve grown disenchanted with it. While I did find that it was very cheap to find hosting for WordPress, I also found that these cheaper hosts were (shockingly) not as responsive as I was used to, and also since WordPress is to blogging as Windows has been to PCs, it also is the target of loads of automated hacks, and it didn’t take long before the WordPress accounts I had set up on these shared hosts were compromised. After cleaning them up multiple times only to have the problems recur, I decided I’d just avoid the whole problem by using Orchard (the blogging equivalent of buying a Mac). I’m hosting my new blog with [Cytanium.com](http://cytanium.com), which is run by the same awesome folks who run [ORCSWEB](http://orcsweb.com) hosting, but is set up better for a personal site like this.

Orchard is incredibly easy to get set up, has loads of extensions, and also happens to use the platform, language, and design approach that I prefer (in this case, .NET, C#, and MVC). There’s [a great introductory course on Pluralsight (intro module is free)](http://www.pluralsight-training.net/microsoft/players/PSODPlayer?author=kevin-kuebler&name=introduction-to-orchard&mode=live&clip=0&course=orchard-fundamentals) by my fellow NimblePros employee Kevin Kuebler, too, if you’d like some help getting started. Migrating to Orchard was fairly straightforward. I used [John Papa’s blog series on migrating from Graffiti to Orchard](http://johnpapa.net/orchardpart1) as my primary guide, and it was a huge help. The data migration involved pulling the data out of Graffiti into BlogML, and then sucking in the BlogML back into Orchard. I [cleaned up the code for doing this a bit](https://bitbucket.org/jonsagara/graffititoblogml/pull-request/1/pull-please), though the comments are still all wrapped in <p>…</p>, so use [John’s script](http://johnpapa.net/orchardpart2) to fix that. The latest version of the [GraffitiToBlogML code should be here](https://bitbucket.org/jonsagara/graffititoblogml/overview).

I’m hoping to get Disqus set up for my comments soon (using [this tool to import from BlogML to WXR](http://ithoughthecamewithyou.com/post/Convert-BlogML-comments-to-XWR-for-Disqus.aspx)), as well as to migrate my old blog data from AspAdvice.com, ArmyAdvice.com, and asp.net/blogs, so that all of my blogging for the last decade can all live here. And hopefully this new account will perform better than the old one – I know I was losing visitors who came to my old site and found it unresponsive and left. If you’re reading this, thanks for sticking with me! :)
