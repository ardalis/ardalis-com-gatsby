---
templateKey: blog-post
title: Probability Puzzle Answered
path: blog-post
date: 2008-09-23T16:00:00.000Z
description: In a recent post, I described a Probability Puzzle that is actually
  known as the Monty Hall Problem. This is a fairly famous problem and has a
  long write-up on Wikipedia that is definitely worth reading to get a good
  understanding of the problem.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Probability
category:
  - Uncategorized
comments: true
share: true
---
In a recent post, I described a [Probability Puzzle that is actually known as the Monty Hall Problem](/probability-puzzle). This is [a fairly famous problem and has a long write-up on Wikipedia](http://en.wikipedia.org/wiki/Monty_Hall_problem) that is definitely worth reading to get a good understanding of the problem. Almost everyone fails to answer this problem correctly the first attempt, because it seems obvious that there is one prize behind one of the remaining two doors, and there is nothing constraining which door we might pick (the 2nd time), so it should be a fresh decision with a 50/50 chance of success.

![](/img/monty_open_door.svg.png)

In fact, the way to look at this problem is in reverse. With the initial choice of one door out of three, the odds of success were clearly 1/3. Said another way, **the likelihood that a wrong choice was made was 2/3**. Still another way to look at this is that the breakdown in odds is 1/3 assigned to the set of doors chosen (1 door) and 2/3 assigned to the set of doors not chosen (2 doors). When it is revealed that one of the unchosen doors is not the winner, **this changes nothing about the likelihood that the door you originally picked is correct**! Your set still only has 1/3 and the unchosen set (which now has only 1 door in it) still has a 2/3 chance of being correct. Thus, you definitely should switch doors, as it doubles the odds of winning the prize!

This result can easily be demonstrated with a bit of code, run a suitable number of times. Pick a number from 0 to 2 to be the door with the prize. Pick a number from 0 to 2 to be the contestant’s selection. Initial chance of success is 1 in 3. Now pick one of the other two doors and reveal it, but only if it is not the prize. You’ll find that it is the prize 1/3 of the time – these get thrown out as the problem has defined that a goat must be revealed. Now look at the number of times the contestant has the right door compared to the number of times the unselected door is correct, and you’ll see quite clearly that it’s twice as likely the unchosen door has the prize.

I have one more post on this subject for tomorrow, which twists this a little bit further. I suggest reading the full [Wikipedia writeup](http://en.wikipedia.org/wiki/Monty_Hall_problem) before diving into that one.