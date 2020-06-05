---
templateKey: blog-post
title: Keeping a Work Journal
date: 2019-01-23
path: /keeping-a-work-journal
featuredpost: false
featuredimage: /img/keeping-a-work-journal.png
tags:
  - journaling
  - Productivity
  - tools
category:
  - Productivity
comments: true
share: true
---

Not long ago I saw a tweet from Brian Hogan describing a tool he uses for journaling while at work. I've kept notes in a variety of formats throughout my career but have never really kept a _journal_ per se, so I thought I'd give it a try.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">I keep a work journal. I start a fresh one each year.<br><br>A work journal lets you record highs, lows, accomplishments, and issues. Reflection is good, and it’s good to have a log for self assessments.<br><br>I’ve used many tools but <a href="https://t.co/PtYt03p54t">https://t.co/PtYt03p54t</a> is great. You should try it.</p>— Brian P. Hogan (@bphogan) <a href="https://twitter.com/bphogan/status/1080586407041794048?ref_src=twsrc%5Etfw">January 2, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

He recommended trying [jrnl.sh](http://jrnl.sh/), a simple command line tool, so I did. Here's a quick overview and getting started guide.

## Getting jrnl.sh

Head over to the [installation instructions for jrnl.sh](http://jrnl.sh/installation.html) and you'll see options for installing on several platforms. I've installed it on my Windows machines as well as my MacBook Pro (using 'brew install jrnl'). For Windows, assuming you've already installed python, you can just run 'pip install jrnl'. In which case you should see something like this (apparently I'm a couple of versions behind on pip but it still works):

[![pip-install-jrnl](/img/pip-install-jrnl.png)](/img/pip-install-jrnl.png)

pip install jrnl

Once it's installed, just run 'jrnl' from the command line. The first time you run it, it will ask you iave you want to store the file somewhere in particular. In my case I want to access the same journal from several machines, including my MBP and my Windows desktop machines, so I specified a text file in my DropBox folder. This is actually working without any issues thus far.

At its simplest, you can just type the heading for the entry followed by a period and then the contents of the entry. You can then list the last _n_ entries with jrnl -n 2 for instance. You can see some basic commands and the results below:

[![](/img/jrnl-setup.png)](/img/jrnl-setup.png)

jrnl setup and basic usage

## What's the Point?

There are a variety of reasons to keep a simple work journal. Here are a few:

- Organize your thoughts
    - Today I need to do x, y, and z.
    - (later) I got x and y done but z is much harder than it looked. Currently researching options.
- Keep a record of whatever you're working on
    - Starting work on issue 123 for \[repository\]
    - Just spent 45 minutes on the phone with \[customer\] - here are my notes
- Capture anything that's concerning you in your workplace (consider some of the encryption options in this case)
    - \[person 1\] made an inappropriate joke again this morning. Getting really tired of this.
    - My supervisor just told me to ignore the huge security hole I reported this morning, citing the need for us to ship urgently. I've emailed her to let her know I disagree and why. In other news, it appears my resume is out of date...
- A private searchable history of virtually anything.
    - Wow, how did I not know about the Weekly Dev Tips podcast? That thing is gold! I wish he would actually record on like a weekly schedule, though.
    - I should check out this journaling tool some time, at jrnl.sh.

You get the idea. For some people, a paper notebook, or OneNote, or even twitter may serve this purpose. Or you may not need it at all, or you may have some app on your phone you like. I'm not sure whether I'm totally sold on it and will keep using it, but it's only been a couple of weeks since I started and a lot of that was spent doing full-day workshops on Clean Architecture, ASP.NET Core, Security, and Domain-Driven Design with clients, so there wasn't much opportunity to do much journaling.

## Additional Features

The jrnl tool has some additional features that make it cool. I'm not really taking full advantage of them yet, but I intend to do so.

First, you can star an entry to make it easier to find later. All you need to do is include a \* with the entry. Then you can list starred entries with

jrnl -starred

You can also use tags by prefixing words with an @ sign. This can be used to tag individuals, locations, projects, topics, you-name-it. If you're working on several projects or with certain coworkers, you can use @ to reference them:

jrnl Working on a @blog post about @jrnl.

Then list entries with a specific tag using

jrnl @blog

[![](/img/jrnl-tags.png)](/img/jrnl-tags.png)

Finally, jrnl supports a bunch of searching and date-related entry-adding capabilities. Want to see entries from the start of last year? Try

jrnl -from "last year" -until march

Want to add an entry at a particular time? Try

jrnl yesterday at 3pm: something cool happened.

There is also a [configuration file](http://jrnl.sh/advanced.html) you can use to modify any of the default behaviors if you prefer.

## Other Tools or Techniques?

Ok, dear reader, what do you recommend in this topic area? Do you take notes? Are they searchable later? Can you get to them from anywhere? Is your current solution geared toward long form notes and documents (Word, OneNote) or something tiny like this? I'm curious to hear what others use for this sort of thing. And of course, journaling is a separate activity and skill than simply note-taking. I'm kind of conflating the two, I realize, but currently I take a lot of notes but I'm not a huge journaler (thought I'm looking at doing more of it), so that's just where my background lies coming to this. Please leave a comment and share this post so others participate in the conversation. Thanks!
