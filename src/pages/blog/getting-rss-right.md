---
templateKey: blog-post
title: Getting RSS Right
path: blog-post
date: 2008-07-08T02:30:57.723Z
description: Just made some updates to the aggregate RSS feed on [DevMavens.com]
  so that it’s more correct. We weren’t displaying the author correctly before
  (and we’re still not complying with the RFC that wants <author /> to contain
  an email address, but I see no reason to increase the spam these folks get as
  it is).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - RSS
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

Just made some updates to the aggregate RSS feed on [DevMavens.com](http://devmavens.com/) so that it’s more correct. We weren’t displaying the author correctly before (and we’re still not complying with the RFC that wants <author /> to contain an email address, but I see no reason to increase the spam these folks get as it is). I also noticed that our dates weren’t formatted correctly, though I had thought originally they were. Here’s the code we had:

**<pubDate><%= rssItem.DatePublished.ToUniversalTime() %></pubDate>**

Can you spot the problem?

Turns out that even after converting to UniversalTime you still need to [format it correctly](http://msdn.microsoft.com/en-us/library/8tfzyc64.aspx), which in this case means using the “R” format string:

**<pubDate><%= rssItem.DatePublished.ToUniversalTime().ToString(“R”) %></pubDate>**

And with that, the feed appears to be working correctly. Hopefully FeedBurner will pick it up soon. Related to this, I’ve been looking at replacing my existing RSS library with the [Argotic syndication project](http://codeplex.com/Argotic), but it is lacking a few features that I need. I’m talking with the project coordinator now and we’ll see if the things I need can easily be added. My primary need is the ability to merge several feeds into one, purging any duplicates and truncating the result while maintaining sort order by pubDate. I have routines that do all of these things (with tests!) that I’ll gladly add to the Argotic project. Then I think the only other thing that I use now (which I could easily add via subclassing if necessary) is a property on RssItem called ***AssociatedObjectKey*** that allows me to link individual RssItems with their author, owner, blog, etc. in a strongly typed fashion. I might be able to use the Enclosure support in Argotic to achieve this – I haven’t had a chance to check that out yet.

In terms of ease of use, the simple case of consuming and displaying a single feed with Argotic is pretty straightforward. Something like this works great:

<!--EndFragment-->

```
RssFeed feed = RssFeed.Create(<span style="color: #0000ff">new</span> Uri(http:<span style="color: #008000">//feeds.SteveSmithBlog.com/StevenSmith));</span>

Console.WriteLine(feed.Channel.Description);

<span style="color: #0000ff">foreach</span> (RssItem item <span style="color: #0000ff">in</span> feed.Channel.Items)

{

  Console.WriteLine(item.Author + <span style="color: #006080">" wrote "</span> + item.Title);

}
```

<!--StartFragment-->

The nice thing about this is that it doesn’t matter what format or extensions are in use by the feed (as long as it’s one of the [many supported formats](http://www.codeplex.com/Argotic/Wiki/View.aspx?title=Overview%20of%20the%20features%20provided%20by%20the%20framework&referringTitle=Home)), so whether it’s RSS or ATOM or even BlogML, it should work.

<!--EndFragment-->