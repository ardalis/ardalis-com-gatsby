---
title: "Solved: Unsupported audio format set the audio output to pulse code modulation PCM"
date: "2022-08-02T00:00:00.0000000"
description: Solved! My dell monitor had started showing an annoying error every 30 seconds or so saying 'Unsupported audio format. Set the audio output to pulse code modulation PCM'. I solved it with a quick change to my video card settings.
featuredImage: /img/unsupported-audio-format-set-audio-output-pcm.png
---

 Solved! My dell monitor had started showing an annoying error every 30 seconds or so saying 'Unsupported audio format. Set the audio output to pulse code modulation PCM'. I solved it with a quick change to my video card settings.

I'm sharing this here for future me when this happens again (probably with a new video card or a driver update), but hopefully it helps some of you as well.

My monitor is a Dell U3011 but my understanding is that this issue can affect just about any HDMI-supporting monitor.

## Problem

After updating my NVIDIA display driver, I started getting a periodic message on my Dell U3011 monitor saying:

```cmd
Unsupported audio format. Set the audio output to pulse code modulation PCM.
```

The message would appear every few seconds and stay for a few seconds. It was incredibly annoying, which is why I resolved to find a solution.

## Solution

After searching for a bit, [this Reddit thread](https://www.reddit.com/r/buildapc/comments/f52k8r/please_for_the_love_of_god_someone_answer_this/) led me to the correct solution.

I opened my NVIDIA Control Panel and navigated to Display - Set up digital audio. There I found things were set up as follows:

![NVIDIA Control Panel initially](/img/nvidia-control-panel-hdmi-setting-1.png)

The solution is to simply turn off audio on the HDMI connection:

![NVIDIA Control Panel turn off audio](/img/nvidia-control-panel-hdmi-setting-2.png)

With that change, the message disappeared immediately (no need to save, reboot, etc.).

## Summary

If you're having an annoying message appear on your monitor, especially if you recently installed a new graphics card or updated your drivers, this may help you. If it helped you, please leave a comment and/or share this post on social media so that it's more easily discovered by others. Thanks!

