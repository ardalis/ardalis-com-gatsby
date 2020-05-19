---
templateKey: blog-post
title: Tracking Tasks in Visual Studio
path: blog-post
date: 2017-09-12T21:08:00.000Z
description: I was recently mentoring a client remotely who was using Visual
  Studio. They were demonstrating some of the work they had done and design
  decisions they had made, and I was listening and asking questions.
featuredpost: false
featuredimage: /img/vstasklist.png
tags:
  - tip
  - visual studio
category:
  - Software Development
comments: true
share: true
---
I was recently mentoring a client remotely who was using Visual Studio. They were demonstrating some of the work they had done and design decisions they had made, and I was listening and asking questions. Occasionally I would make a suggestion. They would stop to take notes somewhere (I don’t recall if it was paper or in another app). I quickly asked if they were familiar with the built-in Task List in Visual Studio, and how it worked. They weren’t, so I showed them, and that one little thing **totally made their day**. So, I thought I’d share it here as well, so a few more of you can benefit from it.

![](/img/vstasklist.png)

If you’re unaware, you can simply put TODO (or HACK) in a comment, and Visual Studio will add that to a task list for you. This makes it very easy for you to track simple little things you want to come back to in your code without having to use a separate app (that lacks the context of \*where\* the change needs to happen), without having to do it \*right now\* (distracting from whatever you were focusing on), and without you having to mentally juggle one more thing in your head. The list of tasks is pulled directly from your source code, so you don’t need to use a separate tool to manage or view them, and they’re stored in source control along with your code. You should use these for small things you want to get back to, ideally soon, or (in the case of HACK) things that you recognize as being hacks (incurring [technical debt](http://deviq.com/technical-debt/)) that you want to mark as such so you can come back and clean them up later. Or at least let your teammates know “Yes, I know this isn’t the right way to do it, but it works for now and we have to ship today…” (add in some sighing as appropriate).

For bigger tasks, or for customer-facing work, I recommend using something like GitHub issues rather than Visual Studio TODOs. It’s a matter of preference and perhaps something your team should for which your team should standardize, if there are major differences of opinion about when to use a TODO vs. when to use an issue (or bug/task in your issue tracker of choice).

### Customizing the Task List

You can customize how the task list works, too. Just go to the Options menu to see the list of tokens that are configured. You’ll notice there are actually a couple more by default than just the oft-used TODO and HACK tokens:

![](/img/vstasklistoptions.png)

You can even add your own tokens:

![](/img/vscustomtasks.png)

Note that in this case I added two high priority tokens, FIX (which works as expected) and TODO! (which results in duplicates).

In practice I don’t add additional tokens beyond the defaults. For one thing, they’re not persisted with the project, so other team members (or me at different machines) won’t necessarily see the changes. I typically only actually use the TODO token. But these options exist so I thought I’d share them.

One minor UX quibble I found while looking at this. Open the Task List options and then click on one of the tokens in the list. Now try to add a new token. You can’t, because the button is only enabled when you specify a name, while no token is selected, and there is no way to unselect a token. The only way to use the add functionality of this menu is when you first load it, before you click on any of the tokens. Otherwise, you simply need to click on another options menu and then return to the Task List menu to add a new token. This would be a candidate for a (bad) example to show in [The Science of Great UI](https://app.deviq.com/courses/the-science-of-great-ui) course… Don’t design your menus like this, please.