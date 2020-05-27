---
templateKey: blog-post
title: Configure Sounds for Builds in Visual Studio
date: 2018-10-15
path: blog-post
featuredpost: false
featuredimage: /img/windows-sounds.png
tags:
  - builds
  - sounds
  - visual studio
category:
  - Software Development
comments: true
share: true
---

Recently [Jeff Fritz tweeted about setting up a sound for his twitch stream and Immo Landwerth suggested using it with Visual Studio](https://twitter.com/csharpfritz/status/1051867245574586369). I thought this was a great idea and set it up myself in just a few minutes. Here's what you need to do in a few simple steps.

## Find Sounds

There are plenty of sounds built into Windows that you can use, or you can search for free sounds online. I ended up using these two for Build Success and Build Failure:

[Wilhelm Scream](https://bigsoundbank.com/detail-0477-wilhelm-scream.html)

[Yes!](http://www.pacdv.com/sounds/voices/yes-1.wav)

Save these files somewhere on you machine. I put them in a folder in Dropbox so I can access them from any machine I use.

## Configure in Windows

Click on the Sound icon in your toolbar and choose 'Sounds'. Scroll down to Microsoft Visual Studio (note, you can also configure sounds for SQL Server if you like):

[![windows-sounds](/img/windows-sounds.png)](/img/windows-sounds.png)

Browse to your sounds you chose and set them up for Build Failed and Build Succeeded (and any others you care to configure).

## Launch Visual Studio

The sounds don't take effect until you launch a new instance of Visual Studio. Once you do, you should hear the sounds the next time you build successfully (or not!).

Cheers!
