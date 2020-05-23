---
templateKey: blog-post
title: Economics of Software Quality
path: blog-post
date: 2012-06-01T02:07:00.000Z
description: "When we talk about the quality of software, we must refine the
  discussion to make it clear whether we are talking about internal or external
  quality. "
featuredpost: false
featuredimage: /img/code-quality.png
tags:
  - clean code
  - economics
  - quality
  - software craftsmanship
  - tdd
category:
  - Software Development
comments: true
share: true
---
When we talk about the quality of software, we must refine the discussion to make it clear whether we are talking about internal or external quality. External quality refers to the software’s presentation and behavior from a user or customer’s perspective. Internal quality refers to how the software was constructed, and how easy it might be to maintain or extend.

External quality is often under the control of the project’s stakeholders, whether they are technical or not. If the system has bugs, stakeholders can report them and request they be fixed. If the UI is ugly, then can request updates to it. If the system is counterintuitive to use and lacks validation of inputs, again these can all be seen and therefore corrected by the project’s stakeholders.

Internal quality, however, is frequently undetectable by a project’s stakeholders directly. If the source code is a tangled mess of bad practices and [spaghetti code](http://deviq.com/spaghetti-code), the non-technical project stakeholder has no idea. If new features are hacked in via [copy paste programming](http://deviq.com/copy-paste-programming) instead of proper design, again this is invisible to most stakeholders. In some cases, the internal quality of the code is of little importance to the stakeholder, as in the case of a throwaway trade show demo. But in most cases, the internal quality of the software will have an impact on its long term cost to grow and maintain, and so assessing this quality should be a part of the due diligence done by project stakeholders for any significantly scoped project. Low internal quality can result in software that must be rewritten, or which fails when you need it to stretch beyond its typical usage patterns (see [Nasdaq’s failure during the Facebook IPO](http://www.bloomberg.com/news/2012-05-20/nasdaq-ceo-says-poor-design-in-ipo-software-delayed-facebook.html), for example).

## Why So Much Poor Quality Software?

I’m going to assert here publicly that I believe virtually all software that is created today is of relatively poor internal quality. I’m afraid I have no scientific evidence to back this up, only my own industry experience, which includes conducting software quality assessments for a variety of clients. Feel free to disagree, but hopefully you will at least grant that poor quality software is common enough to warrant discussion. Given that we as an industry [produce loads of crap quality software](http://cleancoder.posterous.com/software-craftsmanship-things-wars-commandmen), the obvious next question is ***why***? We can brainstorm a number of possible reasons for why poor quality is produce, such as:

The individual developer or development team

* does not know the code quality is poor or how to make it better
* does not value internal code quality
* needs more time to write good quality code

In the first case, the current capabilities of the developer (team) limit the level of quality that can be produced. The only way to address this is to train the existing developer (team) or replace them with one more skilled.

In the second case, the developer (team) simply does not believe that the internal quality of the software they produce matters, or at least it is not a high priority. This value system may be intrinsic to the devs themselves, or it may be imposed upon them by their larger organization or the project stakeholders. Frequently this lack of emphasis on code quality is a result of a decision at some higher level based on the [iron triangle](http://en.wikipedia.org/wiki/Project_triangle), where a decision has been made to sacrifice *Good* in favor of *Fast* and *Cheap*.

The third case is related to the second. The developer (team) is under time pressure, and while they know how to write better quality code, doing so would slow down their pace of delivering features/scope. Thus, the developers choose (or ask the project stakeholder to choose) to sacrifice quality in order to maximize speed.

In each of the second two cases, a decision is being made about the quality of software to produce. In both cases, it is based on an assumption about the rate at which software features can be delivered. That assumption is embodied Figure 1.

**Figure 1 – Software Delivery Rate by Quality**

![](/img/economics-1.png)

Figure 1 shows two axes, Time and Features/Scope. The former should be self-explanatory; the latter is the productivity of the team as viewed by the project stakeholder. The red line, **QLow**, represents the output rate of low internal quality software. The green line, **QHigh**, represents the output rate of high internal quality software. The assumption in this figure, which I think is valid for many teams, is that the rate of production of low quality software is higher than the rate of production of high quality software. This makes intuitive sense, and corresponds nicely with the whole notion of Fast, Good, Cheap – choose two.

But what if software development teams were able to produce high quality software just as quickly as low quality software, or even faster?

## Why does writing high quality code take longer (for some)?

Does it always take longer, for everybody, to write high quality code than to write low quality code? I would argue that this is not the case. In fact, Robert “Uncle Bob” Martin contends that he can write high quality code, the “right” way, faster than he can write poor quality code, every time. In [Flipping the Bit](http://blog.8thlight.com/uncle-bob/2012/01/11/Flipping-the-Bit.html), Martin writes:

> *I want you to believe that **Test Driven Development saves time in every case and every situation without exception amen**.*

In this particular article, Uncle Bob is specifically referring to TDD, but I think we can generalize this to encompass a number of practices that produce higher quality software, but which individual developers and teams must invest time to learn. In the case of a master craftsman like Uncle Bob, it’s possible for the delivery rate of high quality software to exceed that of low quality software, as shown in Figure 2.

**Figure 2 – Uncle Bob Software Delivery Rates**

![](/img/economics-2.png)

Uncle Bob goes on to say, *Well, I might not use TDD if I needed the task to take a really long time to finish, and have lots of bugs.*In Figure 2, the rate of producing high quality code via TDD is shown in green, with the rate of producing lower quality code without TDD is shown in red. If a developer or team exhibited the behavior shown in this model, they would be able to produce high quality code faster than low quality code. They would response to time pressure by writing high quality code, since they can deliver more quickly when writing high quality code.

But what kind of fantasy land is this? How can mere mortal developers achieve this seemingly impossible state of being both Fast and Good? The answer is **investment**. In the case of Uncle Bob, he was able to conclude that writing good quality code was faster, for him, after investing a month in learning and using a particular practice (TDD):

> *I used TDD for a month or so… That’s all it took for me – just doing it. Maybe that’ll be enough for you.*

## Choose What to Invest In

If we want to improve ourselves and our teams, we can invest time into training (or hiring those with the skills we value). Over time and with practice, we can increase the rate at which we are able to deliver high quality software until that rate equals or exceeds the rate at which we produce poor quality software. When that happens, the virtuous cycle kicks in, and we respond to pressure by working better, not by cutting corners, because we are confident that our production rate is fastest when we write high quality code. Figure 3 shows the change in the slope of the green curve that we are after.

**Figure 3 – Increasing High Quality Production Rate Through Training**

![](/img/economics-3.png)

Our challenge, as an industry, is to increase the slope of the **QHigh** curve until it exceeds that of the **QLow** curve, as shown in Figure 3. If your organization isn’t helping you to do this yourself, and you value your career, then you can try to change your organization or you can change your organization. That is, you can lobby for your company to change its behavior, or you can vote with your feet and join an organization with values that match your own.

Investing in our developer and team capabilities has benefits that mirror those of capital investment and [technical progress in macroeconomics](http://homepage.newschool.edu/~het/essays/growth/neoclass/solowtech.htm#progress). As we increase the training and expertise level of our teams, our capital/effective labor ratio increases, which shifts us to a higher production curve. The gains in productivity suffer diminishing returns, which means we get the largest boost in productivity when we invest in those workers with the least amount of capital.

## Diminishing Returns and the Catch-Up Effect

The least-experienced, least-well-trained teams and developers stand to gain the most from training and investments in better processes. Once teams and developers are capable of writing quality software as productively as they were once able to produce poor quality software, additional investment yields diminished returns. If you’re fortunate enough to reach this point, additional training in emerging technologies would probably be a better investment than in code quality fundamentals and processes.

## Informed Decision-Making for Software Stakeholders

Software stakeholders are responsible for the software produced by individual software developers or teams. They frequently are not software developers themselves and are not intimately involved in the actual coding of the solution. However, they are frequently responsible for making short- and long- term decisions related to the project and/or the developers working on the project. These decisions should ideally be made based on actual facts rather than assumptions.

In the short term, with each new feature request, the stakeholder can decide whether the development team should be on the **QHigh** or **QLow** path. They can make this decision implicitly by emphasizing rapid delivery above all else (or quality above all else), or explicitly by monitoring internal software quality and tying feature acceptance to certain quality requirements, for instance. In order for this to be an informed decision, the stakeholder needs to know what the relative slopes of the **QHigh**and **QLow** paths are for their developers. It may be that **the current development team is incapable of delivering software of the required quality**, no matter how much time they are given, because they simply lack the necessary skillset. Or it may simply be that the developers require more time to produce high quality than is economically practical for the project at hand. At that point, the stakeholder can make an informed decision to move ahead with the existing team and a low quality vector, or to replace the team.

In the long term, software stakeholders can make decisions about whether or not to invest in their teams. Again, this requires knowledge of the team’s current **QHigh**and **QLow** paths. Making investments to improve the team’s **QHigh**production rate, either through training or hiring, will yield benefits on all future projects that can take advantage of this path. Ideally, the team’s skillset and processes should allow them to produce high quality software faster than low quality software, but achieving this level of intellectual capital may require significant investment.

## Summary

The productivity rate of software developers and teams can vary based on the level of quality of code they are producing. Typically, developers are capable of producing code in a range of qualities, from low to high. It is unreasonable to expect developers to deliver software of higher quality than is within their current range of capabilities, though over time these capabilities can be improved. In many cases, teams produce low quality software because they can do so more rapidly than they can produce high quality software. However, sufficiently skilled teams can reach the point where their production rate of high quality software exceeds their rate of producing low quality software, at which point there is no longer any incentive to produce low quality code. Software project stakeholders need to assess the internal quality of the software they are responsible for, and the teams who are delivering it, in order to make informed decisions about level of quality to expect from their team and the investments they should be making in their team’s capabilities.