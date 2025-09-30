---
title: Better Faster Demos with Screencast Videos
date: "2021-10-06T00:00:00.0000000"
description: Do you ever need to demo your app to users, customers, or stakeholders? Is it part of your regular software delivery process? What about when you want to describe to a coworker how a new feature should work, or what the repro of a bug looks like? If pictures are worth 1000 words, videos are worth millions.
featuredImage: /img/better-faster-demos-with-screencast-videos.png
---

Do you ever need to demo your app to users, customers, or stakeholders? Is it part of your regular software delivery process? What about when you want to describe to a coworker how a new feature should work, or what the repro of a bug looks like? If pictures are worth 1000 words, videos are worth millions. Let's explore some scenarios in which video could be useful and usually far more efficient, and then briefly look at some tools that make creating such videos easy.

## A Brief Story of Demo Day

I work with a lot of teams at large financial institutions, most of which are using some variation of Scrum or another "agile" approach. In many cases, the end of a sprint or iteration often includes a (mandatory) demo of the work that's been accomplished during that iteration. The goals of these demos are laudable. They give stakeholders information about the progress the team is making and they give the team regular, valuable feedback about the direction they're going. There are some things I would change with the process, being a proponent of lean and kanban and continuous delivery vs. batching, but overall it's better to demo every couple of weeks than every quarter.

So in a particular case I recall, demo day involved about half a dozen"scrum teams" in a large training room. There were at least 50 people present, and because there were so many teams and thus so many demos and of course time for discussion, the room and meetings were booked for the day, with lunch catered in. Along with the developers and their PMs and coaches and such were various managers and representatives from marketing and other stakeholders. As the teams went through their demos, there were of course problems as you would expect. This laptop couldn't connect to the projector. That developer's local environment wasn't configured correctly to run the app. A new version of the code had already been started and the database updated for another team, so their demo didn't quite work right. There seemed to be nearly as much time spent trying to get demos to work or fighting with the process of being able to demo the app as there was actually showing showing working features.

**The cost involved here should be obvious, and obviously staggering.**

With a two week sprint cycle (at best 10 business days), devoting a day or even half a day to demonstrating progress with all hands on deck has a base cost to the dev team of 10% (5% for half day). Never mind the cost of everyone else in the room."But Steve!" you say."Isn't it valuable for the team to get feedback from stakeholders, and for other teams to see what one another are working on so they can better coordinate?"

Of course there is. I'm not arguing that there's no value, I'm arguing that the implementation details of how this value is achieved are far more costly than they should be. Every value comes with a cost, and the return on investment (ROI) for this investment of time and resources is far lower than it could be (and should be).

## How could the value have been achieved with less effort?

Without changing the overall process (meaning, demos are delayed and batched up for the end of the iteration), one thing that would have dramatically streamlined the whole affair would have been to have all demos recorded and ready to play from a single location. Ideally these would be made available prior to the actual live meeting, so that stakeholders could view the ones they were most interested in and be prepared to discuss them during the meeting. Or, in many cases, they might see them and decide quickly that the team is on track and that they don't have any feedback to offer beyond"looks good, keep at it" at which point maybe they opt not to attend the meeting as they have other (more valuable to the organization) ways to spend their time.

At the live meeting, interested stakeholders and team leads and maybe a representative or two are present. In today's remote-friendly world, the meeting would probably take place over Zoom or Teams and thus could easily be recorded, even if some members were present in person on site. Thus, team members and stakeholders who couldn't attend would still be able to review any important dicussion that took place. The meeting would consist of one person queuing up the pre-recorded video demonstrations, probably just screencasts, showing the progress the teams had been making. Being pre-recorded, there would be no issues with getting the demo to work (if it didn't work when you tried to record it, you'd troubleshoot until you got it working and then record it again, or you wouldn't include it). Anyone would be able to request the video be paused at any point in order to ask a question or get clarification, but most videos would be only a minute or two in length so this would rarely be necessary. After each video, discussion and Q&A would take place, after which the next screencast video demo would take place.

## Fully asynchronous feedback cycles

Of course, if you get away from rigid processes with fixed ceremonies at on certain calendar dates, you can take this even further. Make the creation of a short screencast video demo a part of your"definition of done" for every work item your team completes. Stakeholders (and anyone else interested) would of course be subscribed to and watching work items and projects of interest, and would receive automatic notification of the publication of the video, at which time they could quickly review it and offer nearly immediate feedback. For work items completed on day one of a two-week sprint, this feedback would be arriving a full two weeks earlier than if it were delayed due to batching for the sake of following a rigid process. The process could further require sign-off by one or more stakeholders or downstream teams, if desired, to ensure they were involved in the process and didn't shirk their responsibility to review progress (ideally not necessary but I know some will ask how to enforce the process without having people in a big meeting room).

## Other Common Uses of Short Demo Videos

In addition to demonstrating progress, short screencasts are commonly used by bug reporting tools and QA teams to demonstrate to developers the undesirable behavior being observed. This dramatically improves the value of such communications, since otherwise many bug reports or QA feedback might just say something like"Submit button didn't work" and then require a bunch of back and forth as the developer (often days or weeks later) tries to figure out what, exactly,"didn't work" about the button.

As teams move to remote-friendly, remote-first, or even remote-only configurations, short video screenscasts provide a quick and easy way to communicate about the system that is easily shared via messaging apps, email, or even attached to work items or documentation. As much as I love using screenshots to tell a story in docs, a short video can be much more effective and require a lot less text to try and connect the steps between each screenshot.

## Recording Short Screencast Videos

So, how do you get started, if you've never recorded a screencast video? There are a lot of different tools available to make this easy. Some of them will automatically host the videos you produce"in the cloud" and others just run on your computer and produce a file you can then distribute however you like. Obviously if you're going to get the most value out of using screencast videos to communicate on your software development team or your organization, it will help if you have a single, secure, easy-to-access place to use for sharing such videos. There are currently too many options available to list them all, but one option many teams are using is Microsoft Teams (or SharePoint). I don't have a strong opinion about where or how to host them, just that you consider using the technique. The rest of this article will focus on how to actually record a quick screencast.

### OBS

[OBS](https://obsproject.com/) is a free tool used by many streamers on Twitch and YouTube. It's extremely configurable and can record video from multiple sources (including your webcam, etc.) and produces local video files quickly and easily. If I need to quickly record my screen and produce a file I can share, OBS (and SnagIt, below) is my current favorite. If I need to edit the file, then I'll look at something like Camtasia.

### TechSmith Camtasia

[Camtasia](https://www.techsmith.com/video-editor.html) is a full-featured desktop video recording and editing tool available from TechSmith. I've used it extensively to author many Pluralsight courses, as have many other authors. It's great for more polished videos but by default the recorder produces raw files that must be edited and produced by its editor, so it's less ideal for quick demo screencasts.

### TechSmith SnagIt

[SnagIt](https://www.techsmith.com/screen-capture.html) is a small screen capture tool that I use every day. It can be used to record short videos in addition to capturing and annotating screenshots.

### TechSmith Capture (formerly Jing)

[Capture](https://www.techsmith.com/jing-tool.html), formerly known as Jing, is a free screen capture service offered by TechSmith that lets you record, upload, and share screenshots and screencasts quickly and easily. I haven't used Capture, but I've used its predecessor Jing and found it to be very easy to use.

### Microsoft Stream

[Microsoft Stream](https://docs.microsoft.com/en-us/stream/portal-create-screen-recording) looks to be an enterprise-friendly way to quickly record screencasts and upload them to make them available within your organization. I haven't used it myself at the time of writing this article.

### Zoom

You can use Zoom to record videos. Just start a meeting, share your screen (or an app), hit record and record your demo (with or without your webcam). When you're done, stop recording, and grab the file. I've tried this approach and it works.

### Microsoft Teams

Like Zoom, Teams meetings support recording. I haven't tried launching and recording a single-person Teams meeting, so I need someone to verify this works, but worst case scenario you might need to loop in one of your coworkers so you have two people in the meeting.

### Loom

[Loom is another good option for quick screencast videos and demos](https://www.loom.com/). It offers cross-platform (even mobile) screen recording and has a free plan that probably works for a lot of people at least in the short term and for most demo use cases (video length limit of 5 minutes). Then of course there are more full-featured business plans for a monthly subscription.

## Slack

[Slack launched video clip messages](https://www.theverge.com/2021/9/21/22685576/slack-clips-video-messages-feature) in late 2021. These clips support screen recording in addition to video. As such, they can provide a great way to quickly share recordings with your team.

### More Options

There are many options to choose from. Here's one article reviewing the [8 different free and paid screen recorders for Windows 10](https://atomisystems.com/screencasting/record-screen-windows-10/). Find one that works for you.

## Summary

Meetings are expensive. Streamline them by eliminating demo failures and A/V problems. Pre-record your demos using free and easy screencast software and distribute them to interested stakeholders and other teams. Ideally, don't wait until the end of your process's iteration to share and get feedback on work you've completed. Let me know which screen recording solutions you prefer in the comments below. Thanks!

