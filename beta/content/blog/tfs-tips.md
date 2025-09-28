---
title: TFS Tips
date: "2008-01-16T09:17:06.7910000-05:00"
description: I'm just wrapping up a long article on Team System 2008 and its new
featuredImage: img/tfs-tips-featured.png
---

I'm just wrapping up a long article on Team System 2008 and its new capabilities, especially its continuous integration support and build server improvements. In the course of researching for this article, I found a couple of tips that didn't really fit into the scope of the article, but I wanted to call attention to them. The first one addresses a pain point of mine, which is the default action when you associate a work item with a check-in. By default, the default check-in action for such work items is Resolve, when it probably should default to Associate.

95% of the time I want it to be Associate. 5% of the time I might want it to be Resolve (but really I don't because I never resolve anything I re-assign ownership to the project lead and let them resolve/close the items). But it's a hassle to touch the check-in action every time, and sometimes I forget. So, the first tip is [how to remove the Resolve Check-In Action from a Work Item](http://www.woodwardweb.com/vsts/000230.html), from Martin Woodward. I haven't implemented this tip yet myself, and it doesn't change the default, it just removes the Resolve option, but it still looks like something I will probably implement.

The second item is also from Martin Woodward, and provides some advice for setting up a folder structure in TFS version control. I'm always interested in how others set up their project folder structures, since I tend to work on small teams and on web projects that do not have definitive version drops. I like to see what works for other teams who need to branch and version, and [Martin's post on Folder Structure in Team Foundation Server Version Control](http://www.woodwardweb.com/vsts/000224.html) is good for that, and includes a few good comments as well.

