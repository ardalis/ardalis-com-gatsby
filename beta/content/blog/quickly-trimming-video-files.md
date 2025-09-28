---
title: Quickly Trimming Video Files
date: "2022-06-07T00:00:00.0000000"
description: I do a fair bit of video editing as part of producing content for Pluralsight, clients, and YouTube. Recently I took on the task of editing 48 videos from the Stir Trek 2022 conference, each of which mostly just needed time trimmed from the start and end of the presentation. I tried my usual tools, but then I found a new tool that works much better!
featuredImage: /img/quickly-trimming-video-files.png
---

I do a fair bit of video editing as part of producing content for Pluralsight, clients, and YouTube. Recently I took on the task of editing 48 videos from the Stir Trek 2022 conference, each of which mostly just needed time trimmed from the start and end of the presentation. I tried my usual tools, but then I found a new tool that works much better!

## TechSmith Camtasia

I've been using [TechSmith Camtasia](https://www.techsmith.com/video-editor.html) for many years - at least since 2008 or so, I think. Maybe earlier. It's a great tool for doing screen capture videos with callouts, transitions, zoom-and-pan, etc. with audio voiceover and optional webcam support. I once visited their office in Michigan, and they've always been supportive of Microsoft MVPs by providing NFR licenses.

My first approach was to use Camtasia for the task of trimming content from about 48 raw video files which were in MP4 format. It was straightforward to create a new Camtasia project, add the MP4 video to it, find where I wanted to trim the beginning and end of the video, and produce the new video. Unfortunately, since these were fairly high resolution videos and even trimmed they were 45-60 minutes long, the rendering time was pretty substantial (20+ mintues or so) even on my beefy dev machine. What's more, I couldn't trim the next video while the first one was rendering. You can't use Camtasia as an editor while it's busy rendering a video.

I found a workaround for this: batch processing. First create a preset with the settings you want to use for all of the videos. Then edit the videos individually and save the project files. Finally, go to File - Batch production.

![Camtasia Batch Production](/img/camtasia-batch-production.png)

Choose all of your project files and the preset you want to use and run the batch. They'll still take as long as they would have before, but now you can kick it off before you walk away from your computer, instead of having to keep stopping your work every 15-30 minutes to edit and process the next video.

## Adobe Premiere

Adobe has some great video editing software, too. My daughter [Ilyana](https://ilyana.dev/) helped with some of the videos. Her software of choice is [Adobe Premiere Pro](https://www.adobe.com/products/premiere.html). I think she found it to be a little bit faster to work with than what I was reporting with Camtasia, but she also used batch processing to make the process smoother. Still, the process required re-rendering the new video.

## Just Trim The Ends

Both Camtasia and PremierePro have a ton of great video editing features, but what if all you actually need is to make a couple of simple cuts to existing videos? They're both overkill and the required re-rendering sucks up a ton of time!

Fortunately, I discovered another tool, [Lossless Cut](https://github.com/mifi/lossless-cut), that is designed to do just the thing I needed to do. Rather than taking many minutes and a lot of processing power to render the resulting video, it was constrained only by disk I/O speed. Better still, it's a free and open source tool (though you can also buy it in the store if you prefer). Trimming a few minutes from the start and end of a 2GB 60 minute MP4 took about 30 seconds with this tool, which if you watch you can see is just disk I/O:

![Lossless Cut Trimming a Video File](/img/losslesscut-example.png)

Ilyana and I did the first 15 or so videos using our preferred video editing tools, but then I knocked out the rest with Lossless Cut in no time. I'm sharing this so that hopefully others who need a tool to simply trim video from the start and end of an MP4 video file will find it. I expect I will probably end up searching for this video trimming tool in the future, too.

## Summary

There are some great video editing software packages available. They're certainly capable of trimming the start and/or end of video files, but often they require re-rendering the entire remainder of the video in order to produce output. I found a free tool, Lossless Cut, that is able to do this work in a tiny fraction of the time, and is a much better fit if all you need to do is trim the start or end of an MP4 or other video file. Keep your full-featured editing software for when you really need it, but keep Lossless Cut in mind if you're just trimming some parts out of a video.

