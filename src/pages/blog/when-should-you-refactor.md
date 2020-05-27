---
templateKey: blog-post
title: When Should You Refactor
path: blog-post
date: 2014-01-03T17:20:00.000Z
description: A common question teams face is, when should we take the time to
  refactor our code? Refactoring is defined as improving the design or quality
  of code, without changing its external functionality.
featuredpost: false
featuredimage: /img/restaurant-638x360.jpg
tags:
  - clean code
  - quality
  - refactoring
  - software craftsmanship
category:
  - Software Development
comments: true
share: true
---
[](http://commons.wikimedia.org/wiki/File:Eternal_clock.jpg)A common question teams face is, when should we take the time to refactor our code? Refactoring is defined as improving the design or quality of code, without changing its external functionality. Most teams face constant pressure to release features and/or fix bugs as quickly as possible, so it’s not uncommon for problems discovered in the codebase to be put on the back burner to be fixed “later.” But unfortunately, a great deal of the time later never comes. As a result, the codebase continues to degrade, accumulating more and more[technical debt](http://deviq.com/technical-debt), making it more and more expensive for changes to be made to the system.

## Big Bang Refactoring

Sometimes, the politics involved in cleaning up the codebase go something like this:

**Developers:** We could get more done if you’d let us spend some time doing some much-needed maintenance on the code.

**Project Manager:** OK, maybe after next month’s release we’ll make some time for that.

*(next month)*

**Project Manager:** Great release! Now we have these critical bugs that need to be fixed, and we need to get started on these features for the next release!

**Developers:** What about… ?

**Project Manager:** Oh, maybe after the next release.

Of course, if this goes on long enough, and working with the codebase gets painful enough, the powers-that-be may eventually relent, and let the development team clean up the code for a while. **Big Bang Refactoring refers to the practice of** **allowing the developers to deliver no value for some period of time while they clean up their mess**.

![](/img/restaurant-638x360.jpg)

[](/img/restaurant-638x360.jpg)I like to compare this approach to a restaurant. Every day, the restaurant’s means of delivering value to its customers is in the form of preparing food to order. The food is prepared back in the kitchen, where customers generally don’t see it – they only see the result on their plate. In this way, it is similar to programming, in that users of software don’t generally see how the software has been prepared (either the development team, or the source code responsible for generating the user interface with which they interact).

Now, imagine that you want to grab a bite to eat at your favorite restaurant, but when you get there, you find it’s closed. A sign on the door explains they have decided to close for a week so that they can do some long overdue and much needed cleaning of the kitchen, because the mess had gotten so out of hand that they weren’t able to effectively prepare food any longer. I imagine you might think twice before eating at this establishment again, given they’re willing to let their kitchen fall into such a state that it requires them to close their doors for a week just to get it back into a usable state. This is the same message Big Bang Refactoring sends to your stakeholders.

## Incremental Refactoring

Rather than treating code cleanliness as something that must be scheduled and only done when customers finally “let” us do so, it should be a requisite part of every commit. Dentists aren’t suggesting that people declare December “finally brush and floss – you’ve been putting it off all year” month. Restaurants need to keep their kitchens clean constantly, and especially as they start and end their shifts, not once a month. And of course it can be expensive to only worry about changing your car’s oil when the engine finally dies due to lack of preventive maintenance. Just because you can deliver a feature or fix a bug without attending to the hygiene of your code doesn’t mean you should, or that it should be socially acceptable for you to do so. Instead, you should follow the [Boy Scout Rule](http://deviq.com/boy-scout-rule), leaving your code better with every commit.

**You don’t need permission to use basic hygiene when you write software.**

<blockquote class="twitter-tweet" data-lang="en">
<p lang="en" dir="ltr">You don't need permission to practice basic hygiene when you write software.<a href="https://twitter.com/hashtag/programming?src=hash">#programming</a></p>
— Steve Smith (@ardalis) <a href="https://twitter.com/ardalis/status/783673694061199365">October 5, 2016</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8" async=""></script>

Rather, that’s just a part of being a professional and taking pride in your work. Nobody goes to a doctor and says “I can’t afford all this extra hygiene stuff; let’s skip the sterile environment, masks, and hand-washing so I can get this operation done less expensively.” No principled surgeon would consider such an offer. But software developers make these same tradeoffs every day. Nobody’s life is on the line when we deliver crappy code, we might argue, but even that isn’t necessarily the case. [Buggy software does in fact kill people](http://en.wikipedia.org/wiki/List_of_software_bugs). As professional software developers, we need to take responsibility for what we deliver, as we deliver it, and not beg for permission to do our jobs correctly instead of shoddily.

Setting realistic expectations is key. If you’re delivering quality software on a consistent basis to your customers, which you’re taking the necessary care to maintain as you go, **you’ll never need to ask for permission to stop delivering value so that you can clean up your mess**. Creating a deeper and deeper technical debt hole as you go, without communicating this to your customers, is also disingenuous. Imagine if your home builder built your house as quickly as possible, but chose to do so by never actually laying a foundation, so when the house is done, it starts sinking into the ground. Now you’re left with a sinking house that you need to do something to salvage. Had the builder been up front with you that this might be an issue, you might have been OK with accepting delivery of the completed house a few weeks later. At the very least, if you aren’t going to keep your codebase clean as you go, make sure this isn’t going to come as a shock to your stakeholders. Make sure their expectations are set, and they’re willful participants in the decision.

## No Refactoring

I think I made the case pretty strongly above for writing quality code as you go. So when does it make sense to do no refactoring at all? There are certainly cases in which low-quality-but-working code is sufficient. Various kinds of throwaway applications fit this bill. You need a customized demo application for a trade show, that you’re never going to use after the show is over? Throwaway code; no need to spend a lot of time trying to ensure it’s of high quality. If you can trade technical debt for speed, it’s probably a good investment (though if you can produce quality code faster than poor quality code, that’s [obviously even better from an economic standpoint](http://ardalis.com/economics-of-software-quality)). There are other times where it just doesn’t make sense to invest significant time in refactoring, but generally these are exceptions to the rule that you leave your code better than you’ve found it with each commit.

## How Do You Know What to Refactor

It can certainly help when you’re learning how to write quality code to be able to recognize symptoms in your code that point to quality problems. These are commonly referred to as “bad smells in code” or simply code smells. I spend about half of my [Refactoring Fundamentals class](http://bit.ly/1hYc5xR) categorizing and describing a wide variety of code smells, along with identifying refactoring techniques that are commonly used to address the issues. Sometimes, code smells can be ignored – the technique that’s often a cause for concern is in this case being used appropriately. This, too, is worth knowing and recognizing, and I try to identify these as well in the course.

Once you can recognize and identify code smells, and you know the techniques to apply to correct them, you’ll find that cleaning up code as you go is the only way you’ll want to work. I’ve worked on many different software projects, some rife with technical debt, and some well-designed and clean. The latter are orders of magnitude more enjoyable to work on, although the former can be fun to analyze and improve as an advisor or consultant. If you need to work with your code every day, why shouldn’t you work to ensure it’s clean and something you can be proud of, that you enjoy maintaining and extending? Life is too short to spend it fighting with (or producing) crappy work.

**Recommended Courses**

If you want to help yourself or your team become more proficient at building software, I recommend these online courses:

* [SOLID Principles of Object Oriented Design](http://bit.ly/1g3yU1D)
* [Refactoring Fundamentals](http://bit.ly/1hYc5xR)
* [Creating N-Tier Applications in C# Part 1](http://bit.ly/1ddFoYD)
* [Creating N-Tier Applications in C# Part 2](http://bit.ly/1coxWMz)
* [Refactoring for C# Developers](https://www.pluralsight.com/courses/refactoring-csharp-developers) (2019)
* [Microsoft Azure Developer: Refactoring Code](https://www.pluralsight.com/courses/microsoft-azure-code-refactoring) (2018)

You can see [my complete catalog of training resources here](http://ardalis.com/training-classes) as well.