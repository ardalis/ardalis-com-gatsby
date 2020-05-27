---
templateKey: blog-post
title: dev up Conference 2018 (and a small speaking hitch)
date: 2018-10-12
path: blog-post
featuredpost: false
featuredimage: /img/primary-brand.png
tags:
  - conference
  - speaking
  - story
category:
  - Software Development
comments: true
share: true
---

This week I was in St. Louis presenting at [dev up](https://devupconf.org/), a "new" conference that's actually no so new, as it was previously the St. Louis Day(s) of .NET, which has been a thing for over a decade, I think. This was my first time at any of the St. Louis events, in any case. I got in Sunday pretty early and spent some time working and meeting up with a few friends. I had an all day workshop the next day starting at 8am, so it wasn't a late night. Monday I was happy to have a pretty good turnout for my workshop on Building ASP.NET Core Applications with Domain-Driven Design. The room was pretty much at capacity with almost 60 people. Overall I thought it went well and we actually got through more of the hands-on labs than I'd expected we would, so kudos to you attendees for being so productive! If you couldn't make it, my [online ASP.NET Core Quick Start](http://aspnetcorequickstart.com/) has a lot of overlap, especially when combined with my [DDD Fundamentals course](https://www.pluralsight.com/courses/domain-driven-design-fundamentals).

On Tuesday I had two presentations. The first in the morning was on [Clean Architecture with ASP.NET Core](https://www.slideshare.net/SamNasr2/clean-architecture-with-aspnet-core). This talk went well, though I would have liked to have had a bit more time to walk through my [Clean Architecture solution template on GitHub](https://github.com/ardalis/cleanarchitecture). Since Visual Studio doesn't offer solution templates, I make this available to those of you who are interested in getting a project set up properly to support clean architecture (onion architecture, hexagonal architecture, ports and adapters) with a domain-centric approach. It follows the [Dependency Inversion Principle](https://deviq.com/dependency-inversion-principle/) and helps ensure your domain model and business rules don't depend on infrastructure concerns and implementation details.

My second talk is also one I've given many times in the past, [Improving the Design of Existing Software](https://www.slideshare.net/ardalis/improving-the-design-of-existing-software-81246420). It covers a lot of content in a short period of time, touching on [SOLID principles](https://www.pluralsight.com/courses/principles-oo-design), [refactoring](https://www.pluralsight.com/courses/refactoring-fundamentals), [technical debt](https://deviq.com/technical-debt/), and more in the course of 60 minutes. This presentation didn't get off to a good start, however.

## Dealing with the unexpected

As usual, I got to my room about fifteen minutes before I was to speak, waited for the previous speaker to wrap up, and then got myself set up. I connected my laptop, made sure it still worked with the projector (I was in the same room as I'd been a few hours earlier for my first talk), and wired up my wireless microphone. With that in place, I set my phone out so I could use the [SpeakerAlert](https://ardalis.com/speaker-alert) app to give me a heads-up on where I was on time during the talk. SpeakerAlert is a simple iOS app that shows a timer and changes color when you're getting close to the end of your allotted time. I plugged my phone into my laptop since it was low on charge, so it wouldn't be dead when I was done. All of this was done 5-10 minutes before I was set up to start, and attendees were still trickling into the room. I started chatting with them, asking questions, finding out what other sessions they most enjoyed, what they'd learned, if they had any questions about my topic before I got started. I kept an eye on the clock so I could get started on time, since I knew I had a lot of content to cover.

_At literally one minute before I was supposed to start my presentation, the screen changed and my title slide disappeared._

I typically present with PowerPoint running on Windows. My [current laptop is a MacBook Pro](https://ardalis.com/tools-used), so I run Windows in Parallels. This setup lets me develop on both Mac and Windows, which has been useful many times in the years since I've owned this machine. I sat down to try and quickly sort out the issue, and discovered that Parallels had shut down my VM because it didn't have enough disk space. Ok, not sure how that could suddenly be a problem \*right now\* but I figured it couldn't be that much space that was the issue, so I deleted some things from my Downloads folder and tried to start the VM again. It informed me it needed me to clear 8GB of space in order to start the VM. About this time I realized I'm still projecting everything I'm doing on the big screen for the 100 or so people in the room to watch.

Well, I wasn't going to be able to free up 8GB of space easily in the time available (which is to say, no time, since I was already eating into my session), so I figured I'd try running the presentation using Keynote from the Mac side of things. I navigated to my Dropbox folder with the PPTX file and tried to open it with Keynote. Keynote responded that it "couldn't be opened at this time." I tried a few times, with the same response each time. Keynote did not inform me of when would be a more convenient time for it to open my document, so I had to come up with another option.

I briefly considered contacting the conference staff for assistance and perhaps a spare machine, but I knew that would take way too long, so instead I crowd-sourced the problem with the audience.

_**"Does anybody here have a laptop I can borrow?"**_

_silence_

_**"I'm serious."**_

_One hand goes up in the back of the room._

_**"Thank you!"**_

He quickly comes up to the stage, logs in. His machine has an HDMI connector. I open a browser and go to my Dropbox account and open the presentation. Now it wants to open with Office 365 (which I haven't used for presentations before), and at first it won't present. After a couple of tries, another audience member points out that the browser is blocking pop-ups. I authorize the pop-ups and tell it to present one more time and...

_it works._

At this point, I'm slightly frazzled but hopefully not so much that the audience notices. The whole thing from start of the problem to getting back up and running took maybe 6 minutes, so I was about 5 minutes behind starting the talk. I was able to present it without further issue, though, and I thought it went pretty well. I zipped through the last few slides, but otherwise covered everything I'd planned to. Afterward, I [posted a quick summary to twitter](https://twitter.com/ardalis/status/1049839872620417025).

## Post mortem

So, what the heck happened? I figured out after the talk what the issue was, which is important because I obviously don't want a repeat occurrence. Typically when I use my phone as a timer for talks, I don't plug it in. Or if I need to charge it, I'll use a separate battery I carry, not the laptop. In fact, I mostly only use the laptop when I'm traveling, since I have nicer desktop setups to work from normally. When I did plug in my phone, what I didn't realize is that it decided to sync content from the phone to the laptop's Dropbox installation. This is something it hadn't done in a very long time, and naturally I'd taken a few photos and videos of kids and such over the past many months that amounted to several GB of space. In that 5 minutes or so that I was chatting with the audience, the phone was silently filling up my laptop's remaining SSD space with this content until it reached a point where (for who knows what reason) Parallels just decided to give up and die.

Once I knew what the issue was, it was a simple matter to clear out the Camera Uploads folder from Dropbox, so that now the laptop has 50+ GB of space available. Next time, I'll either be sure I've disabled that sync feature or I'll make sure not to plug the phone into the laptop.

## Wrapping Up dev up

Overall I had a fun and met a lot of great people. The [readydev.one retro console game](https://www.readydev.one/console) by [ArchitectNow](https://twitter.com/architectnow) was a lot of fun. I got to see a 16-rod (per side) foosball table at the attendee party. There was a Back to the Future Delorean on display Tuesday that was used as part of Richard Campbell's keynote presentation. I had to leave early on Wednesday to head home, so I missed most of the 2nd day of the conference. I ended up getting up earlier than expected because someone apparently thought it would be funny to pull the hotel fire alarm at 0315 in the morning. While it was pouring down rain outside. But other than that earlier-than-expected start to the day, I had a good trip back to Ohio.

If you get a chance to attend or speak at dev up, I would recommend it. Great venue, great organizers. Hope to be back next year.
