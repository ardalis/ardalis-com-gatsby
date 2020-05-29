---
templateKey: blog-post
title: INVESTing in User Stories
path: blog-post
date: 2009-06-22T00:17:00.000Z
description: User Stories describe features from the standpoint of the user, and
  should identify small units of work that can reasonably achieved within a
  short (1 or 2 week) iteration by a programming pair. A useful acronym for
  remembering how to write good user stories is INVEST (more elsewhere and
  here).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - user
category:
  - Uncategorized
comments: true
share: true
---
User Stories describe features from the standpoint of the user, and should identify small units of work that can reasonably achieved within a short (1 or 2 week) iteration by a programming pair. A useful acronym for remembering how to write good user stories is INVEST (more [elsewhere](http://agilesoftwaredevelopment.com/blog/vaibhav/good-user-story-invest) and [here](http://www.bing.com/search?q=user+stories+invest)). A “good” user story is one that serves the needs of all of the stakeholders in the software development project, including the customer, the team lead (or PM), and the developer(s). Ideally the story is recorded in short form on an index card (or electronic equivalent) and is a placeholder for a longer conversation that has taken place between the customer and the developer team. Also ideally, it includes Acceptance Test criteria, which developers must ensure have been met before they consider the story complete.



**The INVEST acronym for User Stories**

User stories should be…

**Independent**– In order to be estimated and planned effectively, user stories should be independent of one another. Combining or splitting stories, and also working on [vertical slices](/stories-too-big-ndash-vertical-slices), are good ways to achieve this.

**Negotiable**– The precise details of the story are open to further discussion and clarification. Having too much detail in the story can limit options. Developers should be encouraged to fill in necessary details with customer conversations (of course this works best with a local customer or customer proxy).

**Valuable**– Every story needs to add business value to the customer. Ideally, customers are the ones writing the user stories, to ensure they are deciding what is most valuable to work on. A user story should contribute to a minimal marketable feature (MMF), either in itself or [in combination with several other related stories.](http://joearnold.com/2008/03/the-minimal-marketable-feature-mmf)

**Estimable**– The story needs to be small enough and well enough understood that developers can estimate the resources required to achieve it. The larger and less well-understood the story, the more difficult it will be to accurately estimate. Achieving this is usually done by discussing the problem further with the customer (increase domain knowledge), performing a spike (increase technical knowledge), breaking up the story into smaller pieces (small stories are easier to estimate), or some combination of these three tactics.

**Small**– Large stories are difficult to estimate and tend to include dependencies and hidden subtasks that can quickly scope creep them into massive *epics*. Stories should be small. They should be achievable by a pair within an iteration with lots of time to spare. If your iteration is one week, your maximum story size should be a few days’ work at most. If it’s two weeks, you might accept a story that would take a pair a week to perform.

**Testable**– In order for developers to know they’re done with a story, it should have a test (or tests) that prove it works. This test should be written by the customer (if only in English, if not using a tool like [Fit](http://fit.c2.com/)). Stories should have definite criteria for success. “Improve performance” or “make the UI intuitive” are impossible to nail down with numbers. “Performs 20 request/sec under load with product database loaded and 100 concurrent users” is much easier to write a test for.

Following the INVEST acronym should result in stories which are much easier to use in your agile estimating and planning. During the iteration retrospective, pay particular attention to stories that didn’t get done during the iteration, and identify any deficiencies they have from an INVEST point of view. If you’re consistently seeing the same kinds of problems with your failing stories, you’ve identified a problem with your process that you should address. From a lean software development perspective, you’ll want to perform*root cause analysis* and correct the problem, rather than working around it.