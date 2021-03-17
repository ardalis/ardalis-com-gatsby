---
templateKey: blog-post
title: Hardware Hides Many Sins
date: 2021-03-17
description: A lesson I learned early in my career - you don't need to micro-optimize as long as you have fast enough hardware.
path: blog-post
featuredpost: false
featuredimage: /img/hardware-hides-many-sins.png
tags:
  - programming
  - hardware
  - performance
category:
  - Software Development
comments: true
share: true
---

Early in my career I was taught this lesson by one of my clients. We were building an application for internal use at the company which would run on a dedicated server sitting in a server room in the same building as its users. I had concerns that some approach we were taking was inefficient. My client (and mentor at the time) explained:

> Hardware hides many sins.

What he meant was, it didn't matter if a particular operation or algorithm wasn't perfectly efficient in our context. The company had already bought very capable servers which as yet were sitting idle while we were busy building the app that would eventually run on them. The system we were building would save the company money and potentially help them make more money, every day, but only once we released it. What's more, the company was paying internal staff as well as two hourly consultants (me and another developer) to build the system. How long would it take to recoup the cost of optimizing for a more efficient approach, in terms of our hours billed?

From a business perspective, his advice made perfect sense. This was well before "the cloud" and utility-priced computing. The servers were a sunk cost and had capacity to spare. The scarce resource was our time. Identifying the scarce resource and optimizing its use is key to building effective systems - both human and technical. Our compute cost was effectively free **until it reached the limits of the server** at which point, yes, we might be inclined to optimize. Or we might just *buy another server* (assuming we architected the system to allow for horizontal scaling) which could be a lot cheaper (typically when optimizing for performance there is "low hanging fruit" that gets you big gains, and then things get a lot tougher and more expensive as you strive for each little bit more).

I didn't know the term at the time, but the "hardware hides many sins" aphorism is closely related to [YAGNI](https://deviq.com/principles/yagni). And obviously it's yet another caution against premature optimization.

Does this mean you should never worry about algorithms, big O notation, performance or efficiency in your code? Of course not. But you need to consider the context in which your code and application will run, and make decisions that optimize for the right things. At the end of the day, you're trying to solve the customer's problems, and if compute resources aren't scarce, any time you spend getting the app's performance [beyond good enough is waste](https://ardalis.com/beyond-good-enough-is-waste/). When solving a particular problem, ["Make it work, make it right, make it fast"](https://www.youtube.com/watch?v=QE_Byb2R55k) and only do the last step if you have evidence it's necessary.
