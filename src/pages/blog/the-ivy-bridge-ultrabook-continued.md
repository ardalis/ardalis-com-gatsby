---
templateKey: blog-post
title: The Ivy Bridge Ultrabook Continued
path: /the-ivy-bridge-ultrabook-continued
date: 2012-10-19
featuredpost: false
featuredimage: 
tags:
  - review
  - ultrabook
category:
  - Productivity
comments: true
share: true
---

I’ve now had the new Intel Ivy Bridge Ultrabook machine for about six weeks, and have been carrying it as my primary machine for much of that time. You can read about [my initial impressions of the Ultrabook](http://ardalis.com/unboxing-and-first-impressions-of-new-intel-ultrabook) here. The short version, for those who don’t like to click on links, is that this is a pre-release hardware clamshell Ultrabook with a touch screen and a slew of sensors that you can code against, with Windows 8 installed on it. It was provided to me for free in order to solicit my honest opinions on the device, which I disclose to you here in accordance with the [Federal Trade Commission’s 16 CFR, Part 255: “Guides Concerning the Use of Endorsements and Testimonials in Advertising.](http://www.access.gpo.gov/nara/cfr/waisidx_03/16cfr255_03.html)

## General Use

I’m an Ultrabook fan, having used “desktop replacement” laptops in the past, with their 17” screens and dual-stacked hard drives and massive power supplies and fans. Really, though, since I’m not playing games on the machine, I don’t need a huge video card, and since most of the performance of Visual Studio and Office is dictated by RAM and HDD, having an SSD makes the performance of thin, light laptops more than adequate for my needs. Sure, I have a big tower computer with two big monitors on my desk, but when I’m not at my desk, I’m quite content to use an Ultrabook.

This particular Ultrabook is quite nice. I actually find the keyboard to be much nicer than my Asus Zen, which tends to miss characters when I’m typing quickly, and the touchpad is rather sensitive so sometimes that results in the mouse pointer jumping. In contrast, the Intel Ultrabook is quick to type on and doesn’t frequently require me to retype due to its failings (though I still have my own mistakes to deal with, all too often). I would prefer if it had actual home/end buttons, instead of overloads on the arrow keys, but that’s a minor quibble.

In terms of presenting, the lack of a VGA outlet can be a concern, especially if you’re presenting at customer or conference locations. Even HDMI is a slight challenge because the port on the machine is a mini-HDMI, so you need an adapter or your own cable. I picked up an [A to C Type HDMI to Mini-HDMI Cable](http://amzn.to/OOD57e) for this purpose. If you want VGA, you can pick up a [Mini HDMI to VGA M/F Active Adapter](http://amzn.to/OODiHO).

I continue to find it very natural to use the touch screen, rather than the touchpad or mouse. When reading long articles/emails, it’s often easier to simply scroll the screen with a thumb or finger, especially when no mouse is available (to use the scroll wheel).

## Development

Visual Studio 2012 runs great on the device. As has been mentioned, it only has 4 GB of RAM, but honestly I haven’t found that to be a problem. I think VS2012 is, in general, faster and more lightweight than its predecessor, and so even if I’m running more than one instance of Visual Studio, I haven’t noticed any slowdown. Now, to be fair I’m mostly running smaller solutions, not massive solutions with 100 projects in them, but if your solution has that many projects I think you have bigger problems than your machine’s memory resources can address.

[Scott wrote up some nice stuff on the Windows 8 SDK and the sensors in the machine](http://www.hanselman.com/blog/IntelUltrabookHardwarePrototypeWindows8AndTheSensorPlatform.aspx). The SDK actually does make working with the sensors pretty straightforward. The [Geolocation Sample](http://code.msdn.microsoft.com/windowsapps/Geolocation-2483de66) Scott references is very easy to just download and run on a Win8 machine, and lets you easily play with the GPS. Other sensors are also easily accessed via the SDK:

[![WnidowsDevices](/img/WnidowsDevices_thumb.png "WnidowsDevices")](/img/WnidowsDevices_thumb.png)

## Apps

Of course, the Ultrabook’s running Windows 8, so in addition to all the usual desktop/dev stuff, there’s the Windows Store and all that it holds. I’m not using a ton of apps yet, but I’ve played with a few. MetroTwit is OK, though I think I prefer HootSuite still. The Weather app continues to be a favorite of mine. Mail is OK, but Outlook is still way better (or Google Apps), IMHO. The Win8 eBay app is actually very nice, so I would encourage you to check it out. And the new Microsoft Solitaire Collection is pretty cool; my 10yo daughter really enjoyed playing a bunch of those games (as did I).

## Summary

So far I don’t have much negative to report on the machine. I use it for email and some software development, though it’s not my main dev machine. I’ve used it for presenting. It’s light, fast, and fun to use and hasn’t let me down yet for any of these activities. The touch screen combined with Windows 8 is nice, especially when you’re lying down or in a cramped space (flying economy, for instance). And I suspect the small things that would improve it (more RAM, more compact power supply) will be there when production models ship.

Do you have questions I can answer about the machine? Post them here and I'll try to answer them.
