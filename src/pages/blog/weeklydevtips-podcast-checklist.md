---
templateKey: blog-post
title: WeeklyDevTips Podcast Checklist
date: 2018-04-15
path: /weekly-dev-tips-podcast
featuredpost: false
featuredimage: /img/WeeklyDevTips_600x591-600x360.png
tags:
  - audacity
  - audio
  - checklist
  - podcast
  - tips
category:
  - Productivity
  - Software Development
comments: true
share: true
---

I've been doing a podcast for a little over six months now, called Weekly Dev Tips. The episodes are just 5-10 minutes long and don't have a lot of extra fluff - they're just straight and to the point, describing a particular tip that some developers will find helpful. The idea is that you can binge on back episodes (ideally start at the beginning) and get a ton of actionable tips in the time you'd normally spend listening to one long-form 60+ minute show. And once you're caught up, the short episodes fit in easily between your other shows. If you're a listener, please leave a comment and let me know what you think, what your favorite tip has been, and any requests you have for topics you'd like to see me cover in the future.

Since I'm pretty new to podcasting, and also since I'm just a fan of checklists as a way to avoid dumb errors, I've created a checklist that I follow every time I record and produce an episode of the podcast. I recently had someone express an interest in my checklist, so I'm sharing it here. Hopefully this will help others - I expect it will also help me since I'll probably end up just referring to this post in the future instead of the text file I'd been using. This checklist doesn't include the tools I use to record the show - you'll find those listed on [my tools used page](https://ardalis.com/tools-used).

## Podcasting Checklist

1. **Have transcript ready.** I script out each show and then use that as the show notes. I don't follow the transcript 100%, but usually pretty close to it and in any case it prevents a lot of stumbling for words during recording.
2. **Open Audacity. Set to record Mono. (LAME is in DropBox/Podcast folder)** I use [Audacity](https://www.audacityteam.org/download/). It requires [LAME](https://manual.audacityteam.org/man/faq_installing_the_lame_mp3_encoder.html) separately to produce MP3 output. I record from multiple machines, so I put the LAME DLLs in DropBox.
3. **Test the mic.** Tap the mic and make sure the one you think is recording is the one actually recording in Audacity.
4. **Record the show. Leave 3 seconds of silence at the start.** Hit record. Talk. Hit stop. Really this is the easy part.
5. _(optional)_ **Import Intro.mp3 track. Use time shift to line it up with start of show.** I used to have a stock intro file I would splice in, but now I just record the intro every time. It's short and makes for a less repetitive show.
6. _(optional)_ **Mix and render into one track.** Only necessary if you have multiple tracks (i.e. show + intro).
7. **Find 3+ seconds of dead air. Use it for _Noise Reduction_ for the whole show.** Audacity uses a noise profile to do noise reduction. This is why we left silence in step 3 above.
8. **_Normalize_ the entire clip.** This will ensure the sound isn't too quiet/loud in certain parts of the episode.
9. **_Amplify_ the entire clip.** This simply boosts the baseline volume for the whole episode. I just use the defaults, resulting in a small change.
10. **Edit to remove gaps, ums, etc.** This takes some time but isn't too bad for 5-10 min long episodes.
11. **Save the project.** This isn't the same as saving the MP3; it saves the Audacity project. Name it {XX - title}.aup where XX is the episode number.
12. **Export audio.**
    1. Save it to the numbered episode folder.
    2. Use options: MP3, Medium, Fast, Force Mono.
    3. Name the file XXX-{title}.mp3.
    4. Metadata Title: EpXX: {title}.
    5. Metadata Comments: Episode N: Title. Summary.
    6. Metadata Album: Weekly Dev Tips | Software | Programming
    7. Metadata Artist: Steve Smith | @ardalis | Software Developer
    8. Metadata Author URL: http://www.weeklydevtips.com
13. **Copy MP3 to Episodes folder** This is where I put all of the episode masters, which are what I upload to my host.
14. **Upload to Simplecast**
    1. Update show notes and summary.
    2. Set publish date to next upcoming Monday at 2am Eastern Time.
15. **Update tips spreadsheet** Note the title and date of the tip in tips spreadsheet. I keep a list of all the tips I've published to avoid repeating tips (and even then I sometimes still repeat things, at least in the tips emails...).

That's it! Hopefully some of you will find this useful and/or tell me why there are better ways to do what I'm doing.
