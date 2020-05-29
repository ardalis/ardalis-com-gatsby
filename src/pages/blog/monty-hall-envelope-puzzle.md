---
templateKey: blog-post
title: Monty Hall Envelope Puzzle
path: blog-post
date: 2008-09-23T15:53:00.000Z
description: So, recently I wrote about my introduction to the Monty Hall
  problem and its solution. However, in the course of thinking about this
  problem, I came up with a related one that is pretty tricky as well, and
  builds on the insight gained from the Monty Hall problem.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - puzzle
category:
  - Uncategorized
comments: true
share: true
---
So, recently I wrote about my [introduction to the Monty Hall problem](/probability-puzzle) and [its solution](/probability-puzzle-answered). However, in the course of thinking about this problem, I came up with a related one that is pretty tricky as well, and builds on the insight gained from the Monty Hall problem. That is, given three random chances to win a prize, if you pick one and another is revealed as a non-winner, you are better off switching with the remaining chance you didn’t originally pick than sticking with the original selection (with 1/3 – 2/3 odds). With this in mind, consider the following problem.

![](/img/monty-hall1.png)

**Steve’s Monty Hall Envelope Puzzle**

I take 3 plain envelopes and put a $100 bill inside one of them, seal them, and give one to you, one to Bob, and one to Carrie, at random. Then I randomly ask one of you to open an envelope – for the sake of argument let’s say I choose Carrie. Carrie opens her envelope to reveal that it is empty. Now I offer you the choice to trade envelopes with Bob – should you trade?

And now I ask Bob the exact same question. Should **he** trade?

**Analysis**

If the logic of the original Monty Hall problem holds, then you had a 1/3 chance of choosing the right envelope to begin with, meaning that the set of Bob/Carrie envelopes had a 2/3 chance, and therefore with Carrie eliminated you should switch with Bob because his envelope now has a 2/3 chance while yours has retained its 1/3 chance. Clear so far, I hope. You naturally want to trade.

However, **Bob sees the exact same odds from his point of view!**

Bob had a 1/3 chance at the outset, and saw you and Carrie as having a combined 2/3 chance, and with Carrie removed, that leaves **you** with a 2/3 chance to his 1/3. Bob definitely wants to trade with you as well!

The question is, how can it be in both of your best interests to trade? How can you both now have a 2/3 chance (relative to the other one)? And what is the actual likelihood that either of you is now holding the $100 in your envelope?