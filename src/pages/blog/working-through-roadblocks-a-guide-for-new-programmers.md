---
templateKey: blog-post
title: Working Through Roadblocks - A Guide for New Programmers
date: 2017-09-06
path: /working-through-roadblocks-a-guide-for-new-programmers
featuredpost: false
featuredimage: /img/NotSureIfGoodProgrammer.jpg
tags:
  - software craftsmanship
  - Software Development
  - tip
category:
  - Productivity
  - Software Development
comments: true
share: true
---

This is advice that I have given to many novice developers, and that I would like to have been able to give to myself when I just getting started (though some of the advice refers to resources that didn't exist then - alas). If you find it useful, please consider sharing it with someone you know who might also benefit from it.

## Roadblocks

As a programmer or software developer, from time to time it's likely you'll be trying to solve a problem, and things just don't go your way. You're in the zone, coding away, getting stuff done, and feeling good. And then something doesn't work. "No problem," you think to yourself, "I'll just try this slightly different approach..." And that doesn't work, either. Or the next thing. Or the next. And soon, you may find yourself growing frustrated. This is such a common occurrence for programmers that it has its own popular meme:

[![Two States of Every Programmer](/img/TwoStatesEveryProgrammer.png)](/img/TwoStatesEveryProgrammer.png)

Take heart: facing a blocking issue that's difficult for you to diagnose is something that happens to every programmer (please comment if it's never happened to you). Hopefully this fact will help you avoid some natural imposter syndrome as you consider what to do (and may help if you're wondering if programming is really what you want to be doing). When you're stuck, when you're spinning your wheels, here are some things you can do to help get you back on track as quickly as possible. Remember, programmer time tends to be expensive, and your time is the most valuable asset you have. Don't waste it, or your company or customer's money! Get back to a productive (and happier!) state as quickly as possible.

### Breadcrumbs (or Thread)

The story of [Hansel and Gretel](https://en.wikipedia.org/wiki/Hansel_and_Gretel) describes how two children became lost in the woods because they left a trail of breadcrumbs, but this trail was eaten by birds, and so they couldn't find their way home. Sadly, although this story demonstrates that breadcrumbs are a terrible way to find your way back to a safe location, this term continues to be used to describe exactly this feature. A much better literary analog would be [Ariadne's Thread](https://en.wikipedia.org/wiki/Ariadne), but this is much less well-known. In any case, the first thing you should think about when you find yourself running into problems is make certain that you have a means of returning to a Known Good StateTM (KGS). Obviously, the best way to do this is through the use of source control. Ideally, you committed (at least locally) the last time you found yourself in a KGS. If you're following TDD, try to also follow [Red-Green-Refactor-Commit (or even RGCRC)](https://ardalis.com/rgrc-is-the-new-red-green-refactor-for-test-first-development) as you do so. Even if you're not writing tests, [Check In Often](http://www.weeklydevtips.com/episodes/ebe28760/002-check-in-often). This will save you. Make it a habit. And if you're stuck, before you start ripping everything you're working on apart or throwing things at the wall to see what sticks, make sure you have a copy of the code in a working (or very nearly working, if that ship has sailed) state. At the very least (if you're still not convinced by now to use source control), apply the [Copy Folder Versioning anti-pattern](http://deviq.com/copy-folder-versioning/) and make yourself a backup copy (or ZIP) of the folder you're working on.

### Timeboxing

The next technique to keep in mind is called _timeboxing_. If you're not familiar with this term, it simply refers to the idea of setting a maximum amount of time, up front, that you will spend on a particular activity. In the case of troubleshooting a problem, it may help to assign yourself 10 or 15 minutes, max, to figure it out. Set a timer, and stick to it. If you're able to solve the problem with time to spare, that's great! Give yourself a pat on the back, reward yourself with a snack, do whatever you do to help get yourself back in the zone, and get back to work (and don't forget to check in). If your timer goes off and you're still stuck, then move on to one of the next techniques.

### Searching for Answers

It's hard to imagine, but there was a time when people had to write software without access to Google or Stack Overflow, or even instant messenger programs and Slack (or IRC). Thankfully, this is not that time. You live in the 21st century. You have access to the sum of the world's knowledge at your fingertips. If you're stuck for more than a few minutes, you should stop spinning your wheels or banging your head against the wall or whatever metaphor seems most appropriate, and start searching for answers using the clues you have at hand.

[![NotSureIfGoodProgrammer](/img/NotSureIfGoodProgrammer.jpg)](/img/NotSureIfGoodProgrammer.jpg)

Start by Googling (or you can google with Bing) the error message. There's a reason this, too, has inspired humorous memes and book covers - it works a great deal of the time.

[![GooglingTheErrorMessage](/img/GooglingTheErrorMessage.jpg)](/img/GooglingTheErrorMessage.jpg)

Add in a few keywords related to the technology stack you're using. You'd be amazed how quickly someone with a bit of experience searching can find answers (Note: _these are not answers they themselves knew_). This is a skill you should develop, and one great way to improve at it is to do it. You're already stuck, you've given it your best shot for a few minutes, there's no shame in seeing if someone else has run into this problem before and learning from their experience.

Of course, there are diminishing returns to searching for answers, too. You should _timebox_ this phase of your troubleshooting as well. I recommend limiting this to another 10 or 15 minutes. Remember, there's only one of you, and you can only apply one approach to solving your problem at a time. If you've spent 30 minutes now completely blocked and you're still no closer to figuring out why things aren't working, it's time to get some help.

### Leverage Others' Experience

If you haven't already done so, search StackOverflow (or an appropriate Stack Exchange site) specifically for your problem (as opposed to relying on Google picking up answers from the site). Assuming this doesn't yield a solution, take a moment and compose a question for StackOverflow (SO) yourself. Don't jump to this step before spending some time trying to resolve the problem yourself. Show respect for others by demonstrating the effort you've applied, and you're more likely to get a good response than if you're asking for help every 5 minutes and obviously haven't put much effort into the problem yourself.

Once you've posted your question to SO, **the rest of the world is now helping you to solve your problem in parallel with your own efforts!** This is huge, but you can help out further if necessary (again don't do this too often or you're use up others' good will toward you) by soliciting answers to your question through a variety of means. Post a brief synopsis of your problem and the steps you've taken to solve it, and link to the SO question using any of these communities that you're a part of and seem appropriate:

- Coworkers and Internal Help Mailing Lists
- Slack - Public communities or your company's private slack
- Twitter - use appropriate hash tags
- Other online communities and mailing lists

Many times, you won't even get so far as to posting the question, because just formulating the question often helps you to solve it. This is referred to as [Rubber Duck Debugging](http://deviq.com/rubber-duck-debugging/). Try explaining your problem to a rubber duck before you ask your coworker, and a good portion of the time just asking the question (out loud, ideally) will help you to identify the answer.

[![Rubber Duck Debugging](/img/RubberDuckDebugging-400x400-300x300.png)](http://deviq.com/rubber-duck-debugging/)

<blockquote class="twitter-tweet" data-lang="en"><p dir="ltr" lang="en">This is a great list! I'd add demonstrating the problem to someone else has been helpful to me. They might ask a really good question.</p>— Lanette Creamer (@lanettecream) <a href="https://twitter.com/lanettecream/status/905638706521899008">September 7, 2017</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

### Take a Break

If you've done all of the above and you still haven't found the answer, take a break. Depending on circumstances, this might mean going to bed, going to lunch, grabbing a snack, or even just checking email or doing other work activities. At this point, though, the rest of the world is helping you solve this problem, so even if you take a break, you're still (potentially) getting closer to an answer. And your subconscious is still going strong, too. When you return to the problem, you may notice something that you'd overlooked or taken for granted before, which solves the whole problem (or helps you realize you were actually solving the wrong problem, which happens quite a bit, too).

### Apply the Scientific Method

When you're and you're not sure what the underlying cause is, after spending a short period of time just trying thing to see what works, it helps to regroup and become more methodical. Apply the scientific method to your approach to the problem. Make a theory about what the root cause might be. Determine a way to prove (or disprove!) that your theory is the right one. This is an experiment. Run your experiment and capture the results. Hopefully the result help you determine whether or not your theory explained the behavior you were seeing. If not, continue reducing the possible sources of the problem through repetition. Make sure as you follow this process that you are only changing one thing at a time. This is another time when good source control can really help you. It can also be a good time to think about automating some of the experiments you're conducting, if possible. Writing some code that asserts that part of your application behaves in a certain way under certain conditions - that sounds an awful lot like a unit or integration test to me. If you think it might be valuable to be able to run that same test in the future (perhaps via a build server with every push to your source control), consider codifying your experiment as a test. Or better yet, write as many of those experiments as you can as tests in the first place, which leads us to...

### Use Automation

Use tests, build scripts, build servers, and other automation techniques to maximize how quickly you're able to diagnose when you have solved the problem, and to ensure your "fix" hasn't introduced new problems. The value of an automated test isn't in telling you how your code behaves when you write it - it's in telling you that your code still behaves that way at some point in the future. What's even more valuable is when a test is able to tell you that your code no longer does what it did after you just introduced a change **that you had no idea would even impact the code the test was covering**. If the only value you place on your tests is in validating that your code does what you think it does today, you're missing most of the point of having such tests. When you do find yourself blocked, your tests can be a great help in showing you all of the things that aren't broken. And if any of them are broken, they might help you become unblocked by showing you the source of the problem.

## Summary

You're going to get stuck. It's frustrating, but it happens to everybody. Make sure you approach it in a positive fashion, and you apply tactics that will minimize the time you spend stuck. As developers, we're constantly trying to build things nobody has ever built before on top of software that didn't even exist until a couple of years ago at most. The fact that any of it works as often as it does is amazing. The fact that what you think should be a relatively simple and straightforward task sometimes results in hours spent trying to figure out WHY. IT. JUST. DOESN'T. WORK. is just a part of this line of work. It's not your fault and it's not just you. Minimize how much time you allow yourself to spend on trying to get unblocked by applying the ideas above, and if you have any of your own to share please post them in the comments below.

 

_If you found this useful, consider sharing it with a peer and joining my_ [_weekly dev tips newsletter_](https://ardalis.com/tips) _or_ [_podcast_](http://weeklydevtips.com/)_._
