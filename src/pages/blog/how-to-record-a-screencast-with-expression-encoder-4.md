---
templateKey: blog-post
title: How to Record a Screencast with Expression Encoder 4
date: 2011-02-16
path: /how-to-record-a-screencast-with-expression-encoder-4
featuredpost: false
featuredimage:
tags:
  - screencast
category:
  - Productivity
comments: true
share: true
---

I’m a huge fan of [TechSmith Camtasia](http://www.techsmith.com/camtasia) and use it for pretty much all of my screencasts.  However, I’m currently recording some presentations for the [Code Project Agile Virtual Tech Summit](http://www.virtualtechsummits.com/Register.aspx?eventID=7) that’s taking place next week, and the preferred capture program for the platform is [Expression Encoder 4](http://www.microsoft.com/downloads/details.aspx?displaylang=en&FamilyID=75402be0-c603-4998-a79c-becdd197aa79).  So, I figured while I’m learning how to do it, I might as well share how it works and how I find it compares with Camtasia.

To get started, you should [download and install Expression Encoder 4](http://www.microsoft.com/downloads/details.aspx?displaylang=en&FamilyID=75402be0-c603-4998-a79c-becdd197aa79).  It’s a free product with the features needed to record your screen (and audio).

Next, set your screen resolution to whatever you want to use for the recording.  Typically, to keep the file sizes down, most screencasts that are going to be streamed over the Internet are recorded at 1024x768, which is pretty much the smallest size at which Visual Studio is still usable.  Depending on what you’re doing, there are all kinds of tips and tricks and settings that you’ll want to tweak to optimize the experience, but I’ll leave those for another post ([ScottHa has some useful tips based on real user feedback](http://www.hanselman.com/blog/YourOpinionMattersScreencastTechniquesSurveyRESULTS.aspx)).

Once your screen size is set, go ahead and launch Microsoft Expression Encoder 4 Screen Capture.  This is a separate program from Expression Encoder 4, so don’t launch that one.  You’ll find the screen capture program under Start | Programs | Microsoft Expression | Microsoft Expression Encoder 4 Screen Capture.  It looks like this:

![image](/img/image_3.png "image")

We’ll call it **_MEE4SC_** for short.  Next, if you actually want to record audio, click the microphone icon.  It should turn red, and when you test your microphone, you should see the colored meter next to it move.

![image](/img/image_6.png "image")

You can also click on the webcam icon to set that up – I’m skipping that.

Next, click on the Options button to configure various settings like video framerate, which microphone to use, hotkeys for starting/stopping and zooming, and whether or not to highlight the mouse pointer.

![image](/img/image_9.png "image")

Now you should be ready to record a test.  Click on the Record icon (the red circle on the right), and choose your recording size and region.  The easiest way to select the full 1024x768 screen (especially if you have more than one monitor) is to move the MEE4SC program window onto the screen you’ll be recording and select the Current Screen option from the Select Region dialog.  After making that selection, you can of course drag the MEE4SC program window to the other monitor so it’s out of the way and not being recorded.

![image](/img/image_14.png "image")

Finally, click the Record button one more time and you should see a countdown and then your recording will commence.  When you’re done, you can click the stop button and you’ll be back to the original MEE4SC, but now you should see the file that was just recording, with options to play, delete, or send to Encoder:

![image](/img/image_17.png "image")

Delete does what you would expect.  Play will play the file in a preview window.  Send to Encoder, naturally, will launch Encoder and let you work with your recording further.  In terms of size, a 10-second test recording at 1024x768 with nothing changing on the screen resulted in an 833KB .xesc file.  I haven’t worked with MEE4SC enough to know how much of this is overhead and what a reasonable per-minute size value might be, but remember that most likely you’ll be encoding this into a smaller, compressed video format in any case.  Here’s what my 10-second test recording looks like, opened up in Encoder:

![SNAGHTML1e201e00](/img/SNAGHTML1e201e00_1.png "SNAGHTML1e201e00")

So, that’s it.  In terms of recording, it’s actually very similar to working with Camtasia Recording.  I expect the major differences will be in the editing and producing stages.  Camtasia Studio is a tool I’ve used quite a bit and know my way around – I’ll need to become a bit more familiar with Encoder before I can really provide an honest and informed review of how it compares.  For now, hopefully this helps demonstrate how easy it is to get started with screen recording using Microsoft Expression Encoder 4 Screen Capture (MEE4SC).  Who says Microsoft’s product names are too long?  It could have been worse, it might have been Microsoft Expression Encoder 4 Ultimate Screen Capture Edition For Windows…
