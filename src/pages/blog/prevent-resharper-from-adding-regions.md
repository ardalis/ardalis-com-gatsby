---
templateKey: blog-post
title: Prevent Resharper From Adding Regions
path: blog-post
date: 2010-02-03T10:59:00.000Z
description: "A couple of days ago I was annoyed that Resharper was insisting on
  turning my abstract base NUnit test class with nothing in it but a shared
  [SetUp] method into a one line class with a collapsed Setup / Teardown region
  in it. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - C#
category:
  - Software Development
comments: true
share: true
---
A couple of days ago I was annoyed that Resharper was insisting on turning my abstract base NUnit test class with nothing in it but a shared \[SetUp] method into a one line class with a collapsed Setup / Teardown region in it. While I didn't always feel this way, my experience has taught me that **regions are a smell in your code**. They are a way to hide things you don't want to deal with or look at. **It's kind of like putting makeup over a melanoma instead of having a doctor remove it.** Here's[a pretty good analysis of why regions are a code smell](http://morten.lyhr.dk/2008/07/visual-studio-regions-are-code-smell.html)if you're interested.

So anyway, I'm using Resharper and am in general a huge fan, and I know I can configure this thing every which way, but I look through the options and nothing jumps out at me about how to adjust Region settings for NUnit tests. I manually removed the region and checked in my code and, rather than spending more time and effort researching a solution, griped about it on twitter today. Not long after, Todd Ropog let me know about this:

![todd steve resharper tweets](/img/todd-steve-resharper-tweets.png)

[Prevent Resharper from adding Regions to Interfaces](http://devlicio.us/blogs/christopher_bennage/archive/2008/10/27/prevent-resharper-from-adding-regions-to-interfaces.aspx)

Chris outlines the steps nicely:

* Go to ReSharper | Options
* In the left explorer pane, find Language | C# | Formatting Style | Type Members Layout 
* Uncheck "Use Default Patterns"
* A huge nasty XML document appears. As Kyle mentions, Don't Panic.

This is why I never found what I was looking for – if you don't uncheck the “Use Default Patterns” checkbox, you never even see the XML used. Once you see this:

![resharper options template](resharper-options-templates.png)

you're pretty much there. All you need to do is look for things that say:

```xml
<Group><br />  <Name <span class="attr">Region="Some Region Name"/><br /></Group>
```

and remove them. You can remove the whole <Entry> if you like, but if it's doing other things like <Sort> and you want it to continue doing that, you're better off just removing the <Group> or <Group>'s contents.

So, to sum up:

* Regions can indicate a code smell and should be used sparingly.
* Resharper is a fabulous tool…
* * …but it's so darned flexible that finding how to do some things can be hard.
* Twitter can be a great way to get other people to tell you how to do things you don't know how to do.
* Hopefully this helps a few people Googling/Binging or having their friends Tweet how to remove regions from Resharper code cleanup in the future.
