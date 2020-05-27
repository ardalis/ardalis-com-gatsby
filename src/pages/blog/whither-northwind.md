---
templateKey: blog-post
title: Whither NorthWind?
path: blog-post
date: 2008-06-02T01:56:53.494Z
description: "[The Ha] recently wrote about his desire to [get away from
  NorthWind] and perhaps start some community driven effort to come up with
  [something else] mainly, it seemed to me, for the sake of being*something
  else*."
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - speaking
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[The Ha](http://www.hanselman.com/blog) recently wrote about his desire to [get away from NorthWind](http://www.hanselman.com/blog/CommunityCallToActionNOTNorthwind.aspx) and perhaps start some community driven effort to come up with [something else](http://www.codeplex.com/notnorthwind), mainly, it seemed to me, for the sake of being*something else*. I must humbly disagree with this, but feel free to correct me if I’m wrong here.

The first stated requirement for NotNorthWind is this:

* Complex enough to be called Real World but simple enough that someone could “get it” in 5-10 minutes

That alone is enough for me, as a presenter, to suggest that perhaps this is not a good idea. I’m a big fan of packing as much content into my presentations as possible. I like to move quickly and fill up the audience’s brain as much as possible with all the great and wonderful things I know. Or, perhaps more likely, there’s a good chance that a lot of what I think is cool does not apply to an individual audience member, so I’m blasting them with enough stuff that surely **something** will stick. That’s my story, anyway.

In the course of such presentations, which usually have 75 minutes or so allocated to them and very little tolerance for going over, I don’t have an extra 5-10 minutes *per presentation* to stop everything and explain what the heck I’m using as my data for this thing. Now, realistically, I simply wouldn’t – I’d just plow right through the fact that nobody has any idea what the app is supposed to do or what the data is supposed to represent, but neither of those is critical to whatever the demo is showing so they’ll get over it. But I know, as an audience member, it would distract me not to understand. I’d be wondering “why is it called that” or “what is that supposed to be doing” instead of paying attention to the actual demo.

Enter NorthWind, the HTTP standard of databases, understood by virtually all Microsoft developers without need for preamble. It just works. With the words, “I’m using Northwind for my database.” I now have the complete understanding of 95% of the people in the room – we’re all on the same page – and I can continue with the actual point of the presentation or demo, which is not, has not, and probably will never be, “why this database isn’t Northwind.”

Now, if you think it would be worthwhile to write a script that updates all the dates in Northwind to some offset of the current date, I think that would be useful and would keep the data fresh (for apps that show the dates, etc). But beyond that, I think this would only make it harder to demo things since the database would need explaining. Why do you think AdventureWorks lags so seriously behind Northwind? Even when there are several flavors of it? Because Northwind is the standard, and in this case, standards are a good thing.

<!--EndFragment-->