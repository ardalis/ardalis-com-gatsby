---
templateKey: blog-post
title: What are you working on? (What Test Are You Trying To Make Pass)
path: blog-post
date: 2011-02-16T03:26:00.000Z
description: If you ask a newly-hired developer this question while they are
  busy coding away on something, you’ll usually get an answer like “the Acme
  project.”
featuredpost: false
featuredimage: /img/test-13394.jpg
tags:
  - tdd
  - testing
  - tips
  - xp
category:
  - Software Development
comments: true
share: true
---
If you ask a newly-hired developer this question while they are busy coding away on something, you’ll usually get an answer like “the Acme project.” If that’s too obvious (after all, maybe that’s the only project this dev works on), then the answer might be “the new xyz feature” or “that abc bug.” All of these are more-or-less valid responses, and depending on the scope of the response, they might be sufficiently clear to narrow down exactly how far along the dev is in getting the overall feature, story, or bug complete. However, what if you come back in a few hours, or the next day, and ask the same question, and you get the exact same answer? How do you know what progress, if any, has been made? How can you offer to assist? The information, while somewhat accurate, is useless in this regard. It reminds me of a joke:

> *A helicopter pilot was flying outside of Seattle on a very foggy day. As he approached an office building, the co-pilot held up a sign to the window for the people in the office building to see, which read “Where are we?” The people in the office building grabbed a piece of paper and wrote, “In a helicopter.” When the pilot saw the note, he immediately navigated over to a landing pad nearby. The co-pilot asked, “How did you know where you were based on their response?” The pilot said, “When I saw that the message was accurate but useless, I knew we were at Microsoft.”*

**Test Driven Development Provides Incremental Progress**

Wherever possible, I try and write tests for my code. I’m not always able to do it, but especially for new features and for projects that I’ve been building up from day one using tests, it’s a practice I tend to follow. One nice thing about TDD, especially if you do it right and take very small steps with each test, is that you make incremental progress toward whatever the larger goal might be. Within an hour you might write half a dozen tests. Certainly you shouldn’t be working on a single test for a 24-hour period, assuming that’s all you’re working on. Also, each test represents a micro-feature – a tiny component of the overall story, feature, or bug being addressed, and one that is getting you a little bit closer to being ***done***.

**When I ask “What are you working on” what I mean is “What test are you trying to make pass?”**

Let’s assume that your organization is at least clued in enough to realize that writing tests isn’t a waste of time and energy. One way to reinforce this viewpoint is to assume that your developers are in fact writing tests. And since they are, then it follows that they can drive their development efforts with these tests a good deal of the time (UI design and various other activities excepted for the time being). Thus, you can change your question, or simply make clear what you mean when you ask it, so that when you want to know “what are you working on” the answer that you are expecting is “I’m trying to get this test to pass” with an explanation of what that test is testing.

Now, if you come back in an hour, and ask how things are going, you should really expect the developer to be working on a different test. If they’re not, then they are almost certainly stuck and can use some assistance. In either case, you’re getting some much more valuable feedback from your question, and the developer might be helped past a hurdle that much sooner as a result.