---
templateKey: blog-post
title: Upgrading HP MediaSmart ex470 to 2GB of RAM
path: blog-post
date: 2009-06-07T06:19:00.000Z
description: After the horrible experience of trying to restore some files from
  my Windows Home Server while it was continuously thrashing due to insufficient
  memory, I picked up a 2GB stick of RAM
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - RAM
  - Home Server
category:
  - Productivity
comments: true
share: true
---
After the horrible experience of trying to restore some files from my Windows Home Server while it was continuously thrashing due to insufficient memory, I picked up a 2GB stick of RAM (which arrived a couple of days ago) and am in the process of doing the upgrade with the help of [this step-by-step guide](http://www.homeserverhacks.com/2007/12/upgrade-memory-in-your-hp-ex470.html) which was the first result in my [Bing Search](http://www.bing.com/search?q=hp+mediasmart+memory+upgrade&go=&form=QBLH). So far it’s smooth sailing, though as you can see I have my computer pretty much 75% disassembled at this point and I still haven’t gotten to the part where I can access the RAM.

I have to say that so far the tutorial is quite good. No gotchas thus far (as of step 9).

![home server disassembled](/img/home-server-disassembled.jpg)

Pulling out the motherboard.

![home server motherboard](/img/home-server-motherboard.jpg)

Getting access to the single RAM slot.

And, done. Worked without a hitch. After plugging in the unit, it comes up with 4 red hard drive lights, which is a bit scary, but once it settles down everything is once again good to go, only this time it has 4x as much RAM so it doesn’t actually CRAWL like it did before. I also set the page file to be system managed (since it should be much larger than the default it had before) as suggested by the article.

Now I get to repeat the process on my other WHS that I keep at the office…
