---
templateKey: blog-post
title: Improve Performance through Advance Preparation
date: 2018-03-07
path: blog-post
featuredpost: false
featuredimage: /img/improve-performance-through-advance-preparation.png
tags:
  - architecture
  - performance
  - tip
category:
  - Software Development
comments: true
share: true
---

When looking at tuning application performance, a common principle to follow is this one:

Maximize the amount of work not done.

It's hard to make _doing something_ faster than _doing nothing_, so do nothing whenever you can. A common way to do very little is to queue up work (in the form of a Command, typically) so that some other process can actually perform the work later. However, you can also achieve the same thing by doing the work _in advance_.

For example, perhaps creating a new record in the system takes a fair bit of time (perhaps a few seconds). This might be for any number of reasons. A common one might be that there are several related systems involved, each of which needs to create some data and perhaps associated IDs all of which must be reconciled together. This kind of scenario is increasingly common as more distributed systems that leverage patterns like microservices are created. The end result can be a series of requests that cross multiple process boundaries resulting in sluggish performance.

When looking for ways to optimize this scenario, there are few things you can do that will have a dramatic impact. You can look at parallelizing the calls to the disparate services. You can optimize each individual operation. You can ensure the latency between each call is minimized. Once you've done these three things (which may require non-trivial effort), if the user experience is still suboptimal the next step is typically to help the user tolerate the slow behavior. This can take the form of adding progress bars or telling the user to look for an email letting them know the operation has completed. Essentially, you've given up on actually improving the perf and are just looking to help the user come to terms with it.

However, an alternative to these options is to front-load the work. Instead of waiting until a user request comes in to create all of the various resources and link them all together with their IDs, your system could have done this before the user request came in. In this case, responding to the user request is simply a matter of associating the already-created record(s) with the user's ID, which should be a much quicker operation than performing all of the actual work of record creation. This kind of advance preparation for work maximizes the amount of work not done during the **critical path**, which is the user's command to create the record. It's the difference between starting to make the french fries and burgers only when a customer orders one at the drive-thru versus keeping a basket full of fries and some sandwiches ready to go in anticipation of demand. The latter is obviously going to be much faster than the former.

Don't wait for a customer to order before starting to make the fries!

![fries-heater - src www.acitydiscount.com/restaurant_equipment/product_pics.cfm?InvID=132513](/img/fries-heater.jpg)

There are several strategies you can follow when it comes to performing advance preparation as a performance enhancement. But first, avoid doing this prematurely! Premature optimization is just going to add complexity to your system which may not be justified. So remember, the first step in doing this optimization is don't. The second step is don't, yet. Measure and verify that you have a problem before trying to fix it. And then, of course, measure after you've implemented your proposed solution so you can verify that you have, in fact, fixed it.

Once you've decided that you want to use advance preparation to minimize the work you need to perform during a request, the next decision you need to make is when will you perform the preparatory work. If you have a pretty standard workflow that users follow, such as they load a web page with a form, fill out the form, and then submit the form, then you might perform the preparatory work when the form is first loaded. Then, as long as you can get the work done in the time it takes the user to complete the form, you'll be ready to go when they submit the form. Another approach is to simply specify a pool size of pre-done work that you're going to maintain, and replenish this pool any time it drops below a certain threshold. Obviously the advance preparation work should be done in a separate process from the user request handling work, otherwise you'll likely negatively impact other parts of the user experience.

Please [email me](/contact-us) if you're Looking for help tuning your ASP.NET (Core) application. Thanks!
