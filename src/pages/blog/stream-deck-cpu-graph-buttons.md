---
templateKey: blog-post
title: Stream Deck CPU Graph Buttons
date: 2020-05-26
path: /stream-deck-cpu-graph-buttons
featuredpost: false
featuredimage: /img/stream-deck-cpu-buttons.png
tags:
  - stream-deck
category:
  - Software Development
comments: true
share: true
---

I've been using a [Stream Deck (affiliate link)](https://amzn.to/2X5LZpp) for a while now and I keep finding more and more uses for the device. Recently, I started looking for more active buttons to display common utilities like CPU, Graphics Processor, and Network I/O graphs. It's easy to configure a button to just show the current CPU percentage, but I wanted an actual CPU graph in a Stream Deck button, and that wasn't quite as obvious.

Turns out, there's a simple way to get it, though, using the [HWINFO plug-in and application](https://www.hwinfo.com/download/). Here are some of the buttons using the tool (bottom row):

![stream deck cpu network graph buttons](/img/stream-deck-hwinfo-buttons.jpeg)

## Install the Extension

There are two steps to getting this working on a Windows machine, at least. First, you should open the Stream Deck configuration app and click the "More Actions..." button at the bottom. Search for "hwinfo" and you should find the extension. Install it.

![stream deck hwinfo extension](/img/stream-deck-hwinfo-extension.jpg)

## Install the HWiNFO Diagnostic Software

You can't use the buttons in the Stream Deck without also running the HWiNFO diagnostics software. You can [download it from hwinfo.com](https://www.hwinfo.com/download/). The extension author recommends using the installer, not the portable version.

Once installed, run the software in "Sensors-only" mode and you should be able to configure buttons on your Stream Deck. The software includes a large number of different sensors - here's a listing from my current system: 

![hwinfo sensor status](/img/hwinfo64-sensor-status.png)

The HWiNFO software is free and looks to have a ton of features beyond my modest needs of it so far. If you don't have a Stream Deck the software supports System Tray icons, Alerts, and an HWiNFO Gadget (not sure yet what that is). It includes more sensors for your system than I could fit in a screenshot, so odds are it will cover your needs there for your system.

## More Tools

This is just the most recent addition to my set of tools for streaming. You'll find a more complete [list of my tools used here](/tools), including both software and hardware.

Thanks! If you have a Stream Deck button you want to share please leave it in a comment!

