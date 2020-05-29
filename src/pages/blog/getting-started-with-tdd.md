---
templateKey: blog-post
title: Getting Started with TDD
path: blog-post
date: 2008-07-14T08:54:00.000Z
description: On our next project I really want to nail unit testing and possibly
  even test driven development. My issue however is none of our team has any
  experience of either so we will be starting totally green.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - TDD
category:
  - Software Development
comments: true
share: true
---
Recently*DannyT*wrote on the [altdotnet](http://tech.groups.yahoo.com/group/altdotnet) list:

> *On our next project I really want to nail unit testing and possibly even test driven development. My issue however is none of our team has any experience of either so we will be starting totally green.*
>
> *…*
>
> *My question however is, with a goal of wanting to adopt TDD eventually, are we better off starting this next project by writing **some** unit tests and getting a feel for it and leaving TDD til next time or would it be more advantageous to go balls out and try and hit the ground running with TDD?*

I think this is a pretty common question, and I answered it on the list with what I hope was a useful response, but I want to reiterate and elaborate on it here. I wrote:

> *Start small. Take one small piece of your application and commit to doing it 100% TDD. It might be really, really small. Let’s say you have an authentication part of the site (e.g. login page). Somewhere in your code you need to be able to determine if a given user + password = valid or not. Write the tests for that and get it working. Do this as a team (pair programming, at least, but maybe even as a training exercise with a projector in a conf room with whole team) and then get feedback.*
>
> *This builds confidence. It teaches concepts. It makes forward progress on the application. Adjust fire and take on another small task and do it again. If your confidence is high, split up into pairs (if you weren’t doing that already) and tackle a few small tasks separately, then come back to the conf room and talk about what you did and how. Repeat until everybody can do TDD confidently on their own, and don’t commit to more than a small feature at a time until you’re confident in your process.*
>
> *If you have trouble picking where to start, pick the most important part of the application – the essence of what it does. If you run out of time because learning TDD is slowing you down and you need to ship something, at least you’ll have a solid understanding (and hopefully some good tests) of the most important part of the app.*

Something I try and emphasize is forward progress. It’s ok if you’re making slow progress sometimes, while you’re learning, but if you have to spend time learning something you might as well do it working on something applicable to the application or problem space you’re involved in. Another key point to consider is that the likelihood of failure is not zero. TDD may not work out the first time, either because your team isn’t ready or your organization isn’t ready or any number of other variables, so plan for that possibility. I think TDD is great and I still lack the discipline to enforce it 100% of the time in my own organization. I’m guessing here that I’m not the only one. But I definitely recognize its value and that the quality of the code produced is higher, so what I recommend is that you make sure that if you’re going to use TDD in an experimental fashion, do so on the code that absolutely needs to be right. Do it with the essence of what your application needs to do, so that if you don’t or can’t stick with TDD for this project, at least you have that part covered by tests.

Although this question pertained to a green field project, another frequent question is how to start using TDD in a longstanding legacy application that is mainly in maintenance mode? The ideal solution here is to verify all bug fixes with tests. If you can enforce it, require that all bugs have a failing test before they get attention from the dev team (obviously customers aren’t writing these tests, but whomever triages the bugs can do so to verify them before submitting them into the queue for developers to work on them). This way, you start getting tests of the parts of the system that have the most bugs, you’re sure the bugs are fixed because you can run tests at any time to confirm it, and you’ll have fewer regressions because you’re testing all of your previously known bugs to verify they are not recurring.

[![kick it on DotNetKicks.com](https://www.dotnetkicks.com/Services/Images/KickItImageGenerator.ashx?url=http%3a%2f%2fstevesmithblog.com%2fblog%2fgetting-started-with-tdd%2f)](http://www.dotnetkicks.com/kick/?url=http%3a%2f%2fstevesmithblog.com%2fblog%2fgetting-started-with-tdd%2f)