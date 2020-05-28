---
templateKey: blog-post
title: Stories Too Big – Vertical Slices
path: blog-post
date: 2012-02-02T04:39:00.000Z
description: I have a client who lists as one of the key challenges with
  implementing agile practices with their teams as managing to define user
  stories that are valuable but not too big.
featuredpost: false
featuredimage: /img/apparchitecture-horizontalstories_thumb.png
tags:
  - agile
  - kanban
  - lean
  - vertical slices
category:
  - Software Development
comments: true
share: true
---
I have a client who lists as one of the key challenges with implementing agile practices with their teams as managing to define user stories that are ***valuable but not too big.***This is actually a very common challenge, and one that we run into frequently ourselves at [Lake Quincy Media](http://lakequincy.com/) and with other clients of [NimblePros](http://nimblepros.com/).

Naturally there are many books available on the subjects of extreme programming, agile software development, user stories, etc. and these are certainly worth reading. Additionally, [an agile boot camp like HeadSpring’s](http://www.headspringsystems.com/services/training) can be an excellent way to fully immerse yourself in how things should be done, without the daily distractions of regular work. My first word of advice is that you read what the experts suggest, and consider attending a class from a well-respected trainer if you can do so.

That said, here is some simple, practical advice I’ve collected (from others) on the subject of writing useful stories. First, there’s an acronym that you can use as a test to measure how effective a particular user story is. This is taken from Bill Wake’s [eXtreme Programming Explored](http://www.amazon.com/exec/obidos/ASIN/0201733978/aspalliancecom) book. He suggests that you [INVEST in good user stories](http://www.agile-software-development.com/2008/03/invest-in-good-user-stories_11.html).

**Good User Stories should be:**

> **Independent\
> Negotiable\
> Valuable\
> Estimatable (or Estimable)\
> Small ([more on small user stories](http://www.agile-software-development.com/2008/04/user-stories-should-be-small.html))\
> Testable**

I would further suggest that these attributes are most important only when the time comes to plan for the story in an iteration. That is, once it comes time to estimate the story and prioritize it as part of an iteration, it needs to exhibit the INVEST qualities. Prior to that point, it’s perfectly acceptable as a placeholder even if it’s big and vague – it can be broken down further when it’s closer to actually being done. This exemplifies the lean principle of putting off decisions until the last responsible moment. If you’re not going to get to the story next week, there’s no sense wasting time trying to estimate it or otherwise make it perfect. **Things will change** before you start work on it, which will make at least some of your work **waste**.

Large, vague user stories are known as [Epics](http://kw-agiledevelopment.blogspot.com/2008/01/thats-not-user-story-thats-epic.html). It’s fine (even efficient) to have Epic stories in the backlog – it stops being fine once you begin an iteration. That’s when the rubber meets the road and the actual stories need to be extracted from the larger epic.

**How Do You Break Up an Epic into Stories?**

There are a lot of different ways one could attack this problem – and certainly more than one “right” way. If we take the “epic / story” metaphor too far, we could say that every story arc has an introduction, a climax, and a prologue and that in between there are many chapters and character development, etc. However, this viewpoint naturally imposes a serial constraint on the stories we develop, and would tend to lead to Story 1 which is required for Story 2 which is required for Story 3. This violates the first attribute in our INVEST acronym, which is that the stories should be Independent.

**Bad Example**

A real world example of this serial approach that delivers nothing until everything is in place would be to create stories based on logical tiers in the software. For instance, if you have a data-driven application consisting of UI, business tier, data access layer, and database (quite common), and for the sake of argument you have a hard dependency on each layer from the one above it (bad design, but quite common), then you might opt to write stories like this:

![](/img/apparchitecture-horizontalstories_thumb.png)

Story 1: Create the new DB Table\
Story 2: Create the stored procedures\
Story 3: Create the DAL to access the sprocs\
Story 4: Create the business layer code that references the DAL\
Story 5: Write the UI screen

You can think of each of these stories as addressing a *horizontal* layer in the application architecture. The problem with this is that it’s very difficult to start Stories 2-4 without the previous story being done. About the only parallelization you can easily achieve here would be the UI, and with strong coupling it would also be very difficult to test things along the way.

**An Alternate Approach – Vertical Slices**

An alternate approach is to break down the epic into stories that very small yet still valuable bits of *vertical* functionality. For instance, let’s say the initial story is for a user registration page that collects a lot of different data. There’s name data. There’s room for multiple addresses. There’s email and phone info. There’s some validation logic. Using the horizontal approach, someone might have generated the Registration Page user interface, and from there a data model, tables, sprocs, etc. If at any point someone got stuck, nothing would be ready to deliver and so none of the stories would be providing value until all of them were produced. Using vertical slices, this might break down like so:

[](/img/apparchitecture-verticalstories_thumb.png)

![](/img/apparchitecture-verticalstories_thumb.png)

 

Story 1: User can register and provide username and password.\
Story 2: User can provide name data.\
Story 3: User can provide an address.\
Story 4: User can manage multiple addresses.\
Story 5: User can add additional contact fields (phone, email, etc).

All of the stories most likely still depend on the first one in this case, and you’ll rarely be able to completely eliminate all dependencies between stories in an epic. But now it would be possible to develop all 5 stories independently. They might even be written using some kind of control (web, WPF, AJAX, doesn’t matter what UI technology) such that they would be simple to stitch together on a single UI page or kept separated to form some kind Registration Wizard multi-step process. And if the iteration ends and only Stories 1 and 2 are done? **You ship it** (or at least demo it to the customer) and **get feedback earlier** than you otherwise would have, which helps ensure that what you’re driving toward really is the correct solution.

**Summary**

As I mentioned, there are many ways to split epics into individual stories. The details of your application and other variables will influence what technique is best for the given situation. However, if you remember the key attributes of good user stories and focus on being able to deliver *something*, however small, of value to the customer as quickly as possible, you’ll very likely end up with stories that are about the right size.

See also: [Vertical Slices on DevIQ.](https://deviq.com/vertical-slices/)