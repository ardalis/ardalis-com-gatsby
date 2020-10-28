---
templateKey: blog-post
title: Shift Risk Left
path: blog-post
date: 2020-10-27T23:30:00.000Z
description: Unknowns are inherently risky. Known risks you can plan for; unknown risks you need to learn more about so that you can mitigate them. Shifting risk left means taking actions that allow you to de-risk unknowns now, rather than later in a project or process.
featuredpost: false
featuredimage: /img/shift-risk-left.png
tags:
  - agile
  - estimates
  - planning
  - lean
  - kanban
category:
  - Software Development
comments: true
share: true
---

When planning, whether for a large project or a single feature, there will be risks. Identifying risks and planning appropriate mitigations or countermeasures is an important part of planning. The military does this constantly in its planning, and has many tools for identifying and calculating risks based on likelihood and severity, and requires that mitigations be put in place and proper authorization from higher command any time a high risk training activity is being considered, for example. In business, it's a good idea to keep risk in mind, too, and the principles are the same.

- How likely is this risk to occur?
- If it does occur, how large is the impact?
- What actions can we take now to prevent or mitigate the likelihood or severity of the risk?
- What actions should we take if the risk occurs?

An example. There's a risk to the business that the production database's disk drive could fail.

> How likely is this to occur?

Well the mean-time-between-failure on the disk is 3-5 years so in the next week the risk is small but over the next 5 years it starts looking pretty likely.

> What actions can we take now to prevent or mitigate the risk?

Implement daily backups. Set up mirror replication to another server. Implement a RAID array. Have spare drives on hand, ready to be used.

> What actions should we take if (or when) this occurs?

Restore the backup. Replace the dead drive with a new one from our supply (order another one to replace it). Etc.

## When should you think about risk?

The time to consider risks and risk mitigation (sometimes called "de-risking") is during planning. I know, I know, this is agile, and we don't need no stinking planning.

[![Dilbert on Agile](/img/dt071126.gif)](https://dilbert.com/strip/2007-11-26)

But seriously, a little bit of planning can go a long way. No, things aren't going to go exactly the way you envision them in your plan. You've probably heard quotes like:

> No plan survives first contact with the enemy. [Helmuth von Moltke the Elder](https://en.wikiquote.org/wiki/Helmuth_von_Moltke_the_Elder)

and

> Everybody has a plan until they get punched in the mouth. [Mike Tyson](https://en.wikipedia.org/wiki/Mike_Tyson)

Nonetheless, while your beautiful plan itself may not make it out intact, the process of planning can help uncover risks that you can prepare for, rather than being blind-sided by them by charging in with no forethought.

> In preparing for battle, I have always found that plans are useless, but planning is indispensable. [General Dwight D. Eisenhower](https://www.oreilly.com/library/view/the-little-book/9781292148458/html/chapter-079.html)

Let's talk now about software projects. What are generally the biggest risks when you're starting on a project? Usually the thing most people are worried about is, can we build this in a reasonable amount of time for a reasonable cost? The risk, which plenty of failed, late, or over-budget projects attest is very real, is that the project won't go as planned and instead will cost more than the value it's meant to provide to the business.

Making a value assessment is one of the few things software estimates are meant to help with, but we know even in this one area where estimates add value, they're far from free or perfect or without risks themselves. Learn more about the [5 Laws of Software Estimates](/the-5-laws-of-software-estimates/) to learn more about how estimates play into risk and vice versa.

But let's say you've sketched out the scope of the project, you have an experienced team, you have business buy-in. You're ready to get started on the project. What should you be worried about, and what should you do about it?

If this project is just like the last one you built with this team for this company in the same domain with the same technology and tools, congratulations. It just might be a piece of cake.

But if this is the first time this team is working together on a big project, that's a risk. If it's the first time the team is learning about this business, that's a risk. If it's a brand new tech stack or set of tools you'll be using, that's a risk.

Now, let's say everything about this project is well-known, except the UI. Someone has decided that the UI for this project will be the latest new framework all the cool conference speakers are talking about, and despite nobody on the team having experience with it, they're sure it'll be great. Everyone on the team will get a week of training and be all set.

Ok, given this scenario, and a project that's going to take a year or so, which of these two approaches should you take:

Option 1: Build the database. Build the stored procedures and data access layer and whatever backend services you might need. The team already knows how to do all of this and can be productive on day one. Build the front end during the second half of the schedule once there's a firm foundation.

Option 2: Build the front end first. Get training if needed but start building prototypes and throwing out what doesn't work and figuring out what does. Then get the front end actually working and start showing it to stakeholders and customers, even if the backend doesn't exist yet. As the app begins to materialize and stabilize, build out just enough of the backend components to support the front end you've built. Once the basic app is in place, continue iterating by delivering [vertical slices of functionality](https://deviq.com/vertical-slices/).

Option 1 is so tempting, but it's shifting all of the risk later in the schedule. If you think about your process as a timeline or typical [kanban board](https://www.pluralsight.com/courses/kanban-fundamentals), you're shifting the risk to the right, to the future. Instead, you want to front-load risk. **You should shift risk left, to the start of the schedule and earlier in the timeline.** Why? Because early on you still have time on your side. You haven't gone too far down the wrong path. ("No matter how far down the wrong path you've gone, turn back now." - Turkish proverb) You can be flexible with your freshly-made plans. By choosing option 2, you could discover that the front end technology (or whatever the most unknown and risky thing might be) won't work the way you thought it would. Or it'll take way longer than expected. Or you need to hire someone who knows how to use it. Or this other option would actually work much better. And you'll know it before you've made dozens of other decisions and countless hours of work based on what turned out to be a bad choice.

## Shifting risk left in features

Front-loading or shifting risk left isn't just something for big projects and military planning. It applies in the small, too. Say you have a feature you're building, and there are a few tasks involved. The feature is all-or-nothing, so if any of these tasks don't work, you can't ship the feature. Now, imagine that there are six tasks that need to be accomplished to complete the feature. Three of them you've done many times and know just how to do. Two of them you haven't done as much, but you know there's existing code in the app you can look at or borrow that's close to what you should need. One task you've never done, and it's never been done in this app or by anyone on your team, either. It's possible that it just can't be done the way the feature's been designed.

Given all of the above, you figure you can get this feature done in a few days; a week at the most.

Where should you begin?

I ran a poll on twitter asking essentially this very question, which you can view here:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">You have a feature to implement. It includes 6 tasks. 3 of them you&#39;ve done before many times; 2 you have other code that does something similar; 1 is totally new and will require research (and might not work at all).<br><br>Where do you start? RT for reach.</p>&mdash; Steve &quot;ardalis&quot; Smith (@ardalis) <a href="https://twitter.com/ardalis/status/1319334321161969672?ref_src=twsrc%5Etfw">October 22, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

With about 700 votes, 60% of developers said they'd tackle the high risk task first, while about 36% said they'd knock out the easy, known tasks, essentially putting off the risk until later. If you've read this far, I hope the problem with this strategy is apparent. There's a very real risk that [unknown unknowns](https://ardalis.com/the-more-you-know-the-more-you-realize-you-dont-know/) in the risky task will impact other tasks, the whole feature, the schedule, or all of the above. Putting off risks until later just means you'll have more work that needs undone if the risk requires a change in your plans, and you'll have less time left in the schedule to accommodate such changes.

Now, you can argue that this doesn't really matter for something as small as one feature in a large project, but of course, **how we spend our days is how we spend our lives**. Those small decisions and features are how the project is built, and dictate whether it's on schedule or on life support. Don't discount the impact of a hundred small decisions made every day or week or sprint, when compounded over time.

## Summary

Shifting risks left means tackling unknowns first. By eliminating what the unknown you reduce or eliminate many risks associated with a given task. Doing this sooner rather than later ensures you'll have time and resources with which to change course if you do uncover obstacles. And if you don't, it means you'll be able to keep to your schedule because the latter portion of the work is made up of low-risk activities.

If you found this helpful, consider sharing it with a friend or on social media. Thanks!
