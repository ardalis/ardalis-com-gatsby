---
templateKey: blog-post
title: Life Hack - Listen Faster
date: 2017-05-24
path: /life-hack-listen-faster
featuredpost: false
featuredimage: /img/Screenshot-2017-05-23-19.46.14-760x360.png
tags:
  - Productivity
  - tip
category:
  - Productivity
comments: true
share: true
---

I've been doing some traveling lately, which is when I tend to have time to catch up on listening to podcasts. I'm a fan of [DotNetRocks](http://dotnetrocks.com/), [Hanselminutes](https://hanselminutes.com/), and Radiolab, among others. Unfortunately (or to be honest, fortunately), my daily commute with kids usually consists of only 10-15 minutes, and isn't amenable to podcast listening. But when traveling I often have hours at a time to listen and learn. Most podcast apps and video training sites like [DevIQ](http://app.deviq.com/) and [Pluralsight](https://www.pluralsight.com/authors/steve-smith) support multiple playback speeds. You can even set up YouTube to play back at faster than 1x, so if you listen to the [ASP.NET Community Standup](http://live.asp.net) you can squeeze it into 2/3 of the time by watching it at 1.5x speed. Even catching up with the latest late night comics' jokes of the day on YouTube can be done at higher speed if watching alone (or with others who share your desire to consume content from a firehose).

If you're not familiar with YouTube's speed controls, here's a quick walkthrough. First, click the gear icon as shown.

[![YouTube Settings](/img/Screenshot-2017-05-23-19.46.14-1024x633.png)](https://www.youtube.com/watch?v=HVZ3-s4l0e0)

Next, click the Speed option and choose a speed that works for the content you're listening to and your mood/tolerance for the increased speed. You need to pay more attention to technical content when it's accelerated, but if the content is in your native language you'll probably find you can listen at faster than 1x without too much difficulty. At that point it's just a matter of deciding how far past 1x you're willing to go.

[![YouTube Speeds](/img/Screenshot-2017-05-23-19.49.38-1024x633.png)](https://www.youtube.com/watch?v=HVZ3-s4l0e0)

For podcasts, most web players don't appear to support faster playback, but if you listen on an iOS device you can easily adjust the speed there. In the bottom left you'll notice the 1 1/2 x option:

[![DotNetRocks iOS Podcast](/img/DotNetRocks-iOS.png)](/img/DotNetRocks-iOS.png)

Hope this tip helps you learn and use your time a little bit better. And yes, there are things that are worth listening to at their natural pace, or when you want to relax. But when you're just trying to keep up in the world of tech, and a lot of the material is not particularly technical, this trick can help you make the most of your limited time.

If you're listening on a podcast website using built-in HTML5 audio players (like on dotnetrocks.com, for instance), you can use this script to control playback. Just open up the developer tools, then the console, and then set the playbackRate to whatever value you want. I've tested this for values between 1.1 and 4.0 (beyond 4.0 the audio just goes silent). Thanks to Ivan in the comments for this tip!

document.getElementsByTagName('audio')\[0\].playbackRate = 1.50
