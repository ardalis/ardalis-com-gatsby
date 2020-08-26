---
templateKey: blog-post
title: Conway's Law, DDD, and Microservices
path: blog-post
date: 2020-08-26T12:44:53.681Z
description: Conway's Law states that any organization that designs a system
  will produce a design whose structure is a copy of the organization's
  communication structure. This has significant impacts on how software is
  built, especially if microservices and/or Domain-Driven Design are adopted.
featuredpost: false
featuredimage: false
tags:
  - ddd
  - laws
  - microservices
category:
  - Software Development
comments: true
share: true
---
[Conway's Law](https://www.melconway.com/Home/Conways_Law.html) states that "any organization that designs a system will produce a design whose structure is a copy of the organization's communication structure." This has significant impacts on how software is built, especially if microservices and/or Domain-Driven Design are adopted.

Mel Conway observed that separate organizational units or teams within a larger organization, when working together on a larger system, would of necessity break that system up into parts that each of them could work on as independently as possible. They would then figure out how the two systems would communicate with one another through some channel, such that the end result looked something like this:

![Two Teams Building Two Modules](/img/two-teams-conways-law.png)

In smaller organizations, this may be less of a problem. When you only have a single-digit number of people working on the system, you don't need separate teams and communication paths, and you can build a system using whatever decomposition methods make sense for the system and its architecture. But once you scale up beyond that, you're going to find it's very inefficient to have team boundaries that overlap with module boundaries, and the amount of additional communication overhead involved grows rapidly.

In Domain-Driven Design, the idea of a bounded context (which I talk about more [here](https://ardalis.com/encapsulation-in-objects-and-applications/)) is used to provide a level of encapsulation to a system. Within that context, a certain set of assumptions, ubiquitous language, and a particular model all apply. Outside of it, other assumptions may be in place. For obvious reasons, it's recommended that there be a correlation between teams and bounded contexts, since otherwise it's very easy to break the encapsulation and apply the wrong assumptions, language, or model to a given context.

Microservices are focused, independently deployable units of functionality within an organization or system. They map very well to bounded contexts, which is one reason why DDD is frequently applied to them. In order to be truly independent from other parts of the system, a microservice should have its own build pipeline, its own data storage infrastructure, etc. In many organizations, a given microservice has a dedicated team responsible it (and frequently others as well). It would be unusual, and probably inefficient, to have a microservice that any number of different teams all share responsibility for maintaining and deploying.

## Large software companies ship their org charts

What this all means if you're a larger organization is that your org chart has a significant impact on the architecture of the distributed systems you build and deliver. You can't expect your CTO or Lead Architect to go sit down in a room with your top tech people, design the system on a whiteboard, and then have your existing organization just carve up the work and knock it out. Most likely, the design of the system will (or should) influence the organization of the teams themselves, and to some extent vice versa.

There are man problems in software that aren't necessarily software problems. A lot of the problems with shipping large, complex systems are communication problems. People problems. Management and leadership problems. In too many cases, there is a career track separation between technologists and people managers, and this leads to a disconnect between how the system should be designed from a technical perspective and how the organization is structured from a team and reporting structure perspective. Correcting this alignment can make a bigger difference to the success of the system than many other technical architecture or coding practice decisions.

[This classic comic](https://bonkersworld.net/organizational-charts) illustrates some large software companies and their (perceived) org chart problems:

![Manu Cornet Organizational Charts Comic](/img/2011.06.27_organizational_charts.png)

## Summary

Understanding Conway's Law and its impacts on large system design is important if you're going to recognize problems stemming from team organization. How you decompose and attach a large problem comes down to how you organize multiple teams of people, and if these teams aren't aligned with the software modules you're building and shipping, you're going to have problems. The sooner these problems are recognized and corrected, the better the chance of overall success for the system and, ultimately, the organization.
