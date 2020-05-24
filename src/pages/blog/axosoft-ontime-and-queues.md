---
templateKey: blog-post
title: Axosoft OnTime and Queues
path: blog-post
date: 2010-01-20T18:10:00.000Z
description: At CodeProject we’ve recently adopted Axosoft OnTime for our task,
  feature, and bug tracking needs. We had tried a number of different solutions,
  and there was even some discussion of building our own (naturally), but in the
  end we’ve settled on OnTime, at least for the time being.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Axosoft
category:
  - Uncategorized
comments: true
share: true
---
At [CodeProject](http://codeproject.com/) we’ve recently adopted [Axosoft OnTime](http://axosoft.com/ontime) for our task, feature, and bug tracking needs. We had tried a number of different solutions, and there was even some discussion of building our own (naturally), but in the end we’ve settled on OnTime, at least for the time being.

OnTime breaks up items into Defects, Tasks, and Features by default, and you can establish fairly rich workflow rules for each of these that tie into actions (for example, there is a status for ‘Complete’ but also a workflow of ‘Complete’. If you choose to use the workflow feature, you can make it so that when the item moves into the Complete state, various other things occur, like re-assigning it back to the original requestor so they can Close the item. If you just update the status, you’re just updating a field and nothing else happens).

OnTime supports many different projects and sub-projects, and your view into the system is typically filtered by where you are in the hierarchy. So if you go to Project A which has subprojects 1, 2, and 3 you will see everything related to A, 1, 2, and 3. If you move to subproject 1, you will only see its items. For managers (and developers oftentimes) who move between many different projects, this can make it easy to limit the scope of what’s being displayed. And of course there are many customizations you can make in terms of filters to control exactly what is displayed and how in any given view.

I’m using the windows desktop client as well as the VS2008 plug-in. There’s also a web-based front-end and apparently an iPhone app, though I personally haven’t yet broken down and bought an iPhone (mainly because I like Verizon). The performance has generally been acceptable but not what I would call stellar. I definitely could see room for improvement here.

**Queues in OnTime**

At [NimblePros](http://nimblepros.com/), we used a variety of systems for tracking user stories, and the one we still use because of its ease-of-use and simplicity is [Zen](http://agilezen.com/). Zen is ultra-simple and acts as a virtual kanban board. It does this task very well. One thing it forces you to do is to order all tasks in a queue. There’s no notion of priorities (although you could use tagging or color coding for such if you really wanted to) – instead the queue defines the order. This is invaluable and saves so much time.

Yesterday at The Code Project we had a status meeting and discussed a variety of items that were in OnTime with various priorities. At the time, I had about 4 High priority items, one Immediate priority item that I was In Progress on, and maybe 10 Medium priority items, some of which had been there since last month. In going through the meeting, a bunch of these Medium priority items were seen as needing to just get done, so their priority was increased to High. Of course, none of my High priority items went away, and my Immediate priority item remained in its place at the head of the queue. So what was the net effect? Now “everything is top priority.” Of course I made it clear that this was the case and we did in fact establish an ordering of the items, but it wasn’t something we could do in OnTime.

In Zen, if I want to change the sequence of a set of stories, I just drag the story card to its new location in the queue. It’s very simple. In OnTime, I have to try and come up with some kind of priority and/or voting or rating combination such that via some sorting routing the item happens to fall into the order that I want it to be in. What I’d really like to be able to do is replace Priority in OnTime with a Queue order. Then within a project I would be able to arrange all of the items in a Queue (and ideally this Queue would span Defects/Features/Tasks, or at least could do so). Then, in my rollup view of all of my action items (across many projects), I could arrange my tasks in any order I want. I would also want to be able to do this via drag-and-drop.

I mentioned some of these ideas a while ago on twitter (I’m[@ardalis](http://twitter.com/ardalis)), and[@hamids](http://twitter.com/hamids) and [@axosoft](http://twitter.com/axosoft) were quick to respond, so I know they’re aware of this request. I don’t know if it’s something they’ve heard from other customers or not, but I do know [they are adding support for a Kanban view](http://shipsoftwareontime.com/2010/01/19/the-ultimate-scrum-planning-board) that might just do what I want, so I’m eager to see the beta in February. I’ll be sure to write more about it once I’ve had a chance to play with it.