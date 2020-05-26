---
templateKey: blog-post
title: Craftsmanship, Quality, Dogma, and Pragmatism
path: blog-post
date: 2009-02-23T00:16:00.000Z
description: In the last year or so, there has been an increasing amount of
  discussion on software craftsmanship, and what it means and whether or not
  it’s a good thing.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Craftsmanship Pragmatism
category:
  - Uncategorized
comments: true
share: true
---
**Craftsmanship**

In the last year or so, there has been an increasing amount of discussion on software craftsmanship, and what it means and whether or not it’s a good thing. There’s an online [email list](http://groups.google.com/group/software_craftsmanship), a [conference with the same name](http://parlezuml.com/softwarecraftsmanship), and [at least one user group](http://groups.softwarecraftsmanship.org/) devoted to the subject (in related news, I’m helping to organize a similar group in Hudson, Ohio). There is some good discussion going on in this sphere about what it means to be a craftsman, but there are other discussions (mostly happening elsewhere) that question the value of craftsmanship with equally valid reasoning. I’ve heard from several successful business owners that they don’t want to hire artists and craftsmen devoted to making beautiful and elegant code, they want programmers who can get the job done with a minimum of fuss so they can move on to the next task. At issue here is the notion that some of the values held by those who believe quality is of great import don’t always fit in with the business needs of the day.

**Quality**

Recently,[Bob Martin took issue with some remarks](http://blog.objectmentor.com/articles/2009/02/06/on-open-letter-to-joel-spolsky-and-jeff-atwood) by the [StackOverflow team on their podcast](http://blog.stackoverflow.com/2009/01/podcast-38). In it, the SO guys stated that quality “isn’t that important” which, taken completely out of context like I’m doing here, sounds like blasphemy, especially to those who prize the quality of their work (as I try to), like Robert Martin ([they later mostly made nice](http://blog.stackoverflow.com/2009/02/podcast-41)). However, as a business owner myself, I also realize that sometimes quality can be sacrificed in order to meet business needs today. And, on a related note, some “best practices” for building quality enterprise software present unnecessary overhead for small and/or one-off applications, either in terms of time necessary or due to the skillset required. We frequently employ college interns to help with our software development work, and if need be we can task them with simple projects that don’t require a deep understanding of complex business problems. The amount of rigor that we apply to this code is proportional to its importance to the business, and we accept that if we do need to revisit this code it will have technical debt that we’ll need to pay if we want to maintain it and build upon it. This is an acceptable trade off and one that we are able to make knowingly.

**Dogma**

I also overheard recently in the context of the current economic climate that the first developers to go during a layoff should be the ones who eschewed simply getting the job done in favor of using their latest favorite developer methodology (insert a TLA here). The implication being that their unwillingness to cave on their principles was costing their employer money in the form of extra time and complexity added to projects that simply didn’t require any additional formality or structure. Related to this is the common theme on twitter or various mailing lists for experts to describe the “right” way to do things, often with some degree of condescension for those who would do things another way. This is where dogma comes into the discussion, and is rightly seen as getting in the way of solving business problems.

**Pragmatism**

Personally, I think craftsmanship implies quality, but a craftsman is also one who can provide the right amount of quality to meet the customer’s needs. As a very real example, I’m getting some work done on a building to which (hopefully soon) we’ll be relocating our offices. I got a quote from a contractor whom I was referred to because they do very good work, to do some pretty simple remodeling of a tenant’s space. It was a bit higher than I expected and after further discussion, I (just today, in fact) got a quote that was about 35% lower with, among other things, the following bullet point describing the difference:

> *Savings from a relaxed “degree of finish”*

What does that mean? It means less quality, but at lower cost. It means I might have to get the space remodeled again sooner than if I were willing to spend a little more, or it might not look quite as nice, but it will cost a little less. As the customer, I appreciate having this as an option. The contractor is showing that he understands his job is to meet my needs, not to necessarily maximize the value of the job or perform the best work of his career (building architects, in particular, like to make designs they can be proud of and show off to other clients, so you need to be extra careful with how much you let them expand upon what is functional).

A software craftsman takes pride in his work, but more than that they should take pride in delivering value to the customer. If a particular piece of code is not written using their favorite framework or methodology, but it got the job done and the customer is happy, then they should be pleased with themselves. It’s important to be aware of how to overcome complexity and avoid future technical debt using appropriate patterns and practices, but it’s just as important to be able to objectively describe to the customer what the costs are (both short and long term) of implementing these practices so they can decide whether or not they are worthwhile for a given project. In many cases, as Bob Martin says, building quality software makes everything go ***faster,*** so trading quality for speed makes no sense. However, in my experience this is only true if the team already has all of the necessary skill to do so. If some or all of the team requires training, and worse, if they are resistant to changing their typical modes of writing code, then trying to deliver higher quality is likely to require significant investment in time and energy. The customer should be the one who gets to choose if this is a worthwhile investment for the project at hand.