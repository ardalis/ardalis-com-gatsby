---
templateKey: blog-post
title: DotNetNuke 4 Experience
path: blog-post
date: 2007-01-16T17:49:44.100Z
description: I want to create a quick, simple club website for a club I’m in.
  It’s been on my TODO list for a couple of years now and tonight I thought I’d
  just grab the latest DNN starter kit, set a few properties, add/remove a few
  modules, and throw it out there.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - dotnetnuke
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I want to create a quick, simple club website for a club I’m in. It’s been on my TODO list for a couple of years now and tonight I thought I’d just grab the latest DNN starter kit, set a few properties, add/remove a few modules, and throw it out there. Here’s a recap of my experience thus far (quitting for tonight):

1) Downloading DNN. There’s 5 different things you can download (after registering) and unfortunately no information at all on the download page as to what is or is not included in the Starter Kit. I ended up pinging Shaun Walker directly and he was quite helpful in letting me know that the Starter Kit should work for what I wanted to do. During later searching I also ran across [this forum thread](http://www.dotnetnuke.com/Community/ForumsDotNetNuke/tabid/795/forumid/107/threadid/45348/scope/posts/Default.aspx) that would’ve helped if it had been on the download page.

2) Installing DNN from the starter kit was simple. A README file in the zip file would’ve been a nice touch, since it unzips into this:

[![DNN Starter Kit Files](<>)](http://aspadvice.com/images/dnnfiles.gif)

and my first inclination is to keep on unzipping things because it doesn’t seem like it’s done (and unlike other starter kits, there is no .vsi file). However, before I went into unzip mode I double clicked on the DotNetNuke.vscontent file which of course did the install.

3) Sadly going and looking for the starter kit under Create – New Web Site didn’t work the first try. Then I remembered DNN was VB-only.

4) Once I found the Starter Kit and installed it as a web site, everything went smoothly for a while. I liked the installer. I went with the default settings. Things were looking good. I reset my admin password, played with the site settings, added a title, etc. At some point I went back to the Welcome.html page and noticed under advanced settings there was an option to Choose a Site Template. One of them is “Club” and I thought “Oh, maybe I wanted that”. However, when I tried clicking on the Configuring the Install Template link all I got was a mainly empty page (at TemplateConfig.html in the starter kit). Oh well, I’ll live.

5) Still playing around with the site. I managed to click Preview and lost all ability to configure my modules. I hadn’t quite figured out how to re-enable them (I was still logged in, but nothing seemed to bring the Configure icon back), when I stumbled on a pop-up menu off of Home > Admin. This menu included a Site Wizard. That sounded promising. So I ran that and it asked me to pick themes and skins and such and then said it had completed successfully. Woot. So I decided to go back to the home page and was met with this:

![DNN Site Error](<>)

So I googled a bit and came up with nothing useful, and decided it was time to go watch 24. DotNetNuke isn’t quite there yet, or I’m just not willing to put in enough time. I remember the IBuySpy Portal pretty much just worked every time I ever played with it, so it’s frustrating that DNN does not (for me, tonight). But I’m sure some DNN experts will let me know what I’m screwing up, and then hopefully life will be good again, at least for a short while.

\[categories: dotnetnuke, error, asp.net]

<!--EndFragment-->