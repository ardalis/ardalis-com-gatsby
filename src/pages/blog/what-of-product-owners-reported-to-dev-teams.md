---
templateKey: blog-post
title: What If Product Owners Reported to Dev Teams?
date: 2021-06-01
path: /what-if-product-owners-reported-to-dev-teams
featuredpost: false
featuredimage: /img/what-if-product-owners-reported-to-dev-teams.png
description: In most organizations, if there's a Product Owner, the dev team is generally subservient to it and charged with building whatever the Product Owner comes up with. That's not to say they aren't often "on the same team", but the flow of responsibility is usually the PO pushes new requirements and the developers respond to them. What if this weren't so?
tags:
  - agile
  - extreme programming
  - teamwork
category:
  - Software Development
comments: true
share: true
---

In most organizations, if there's a Product Owner, the dev team is generally subservient to it and charged with building whatever the Product Owner comes up with. That's not to say they aren't often "on the same team", but the flow of responsibility is usually the PO pushes new requirements and the developers respond to them. Sometimes this relationship, even if only implied, has ramifications for the developers.

## The "Typical" Power Dynamic

(These are broad generalizations - every team and org is unique. If you want to comment that your org or role isn't like this, feel free, but just know that I already assume as much.)

The business needs to build out a product for its customers. There's constant pressure to deliver faster. The sales team is out selling whatever they can to get another customer. Marketing is pushing out campaigns trying to drive more inbound leads and to keep the product top-of-mind. Somewhere the business needs to interface with its software developers and communicate to them what they expect to be built. Usually, this is where the Product Owner role comes into play.

The Product Owner knows the business. Sometimes they have a technical background, sometimes not, but to be effective in their role they need to have a good understanding of the product and its customers (and potential customers). They need to know what Sales is selling and what Marketing is marketing. They probably have a good idea of when the next product launch date is and what some of the expected features are for that launch. In short, they're more a part of the business side of things than the IT or developer side of things, typically.

The development team, of which the Product Owner is often ostensibly a part, are well-versed in the technical challenges required to be anticipated and overcome in order to deliver the product to market. They're under constant pressure to deliver new features and fix outstanding bugs faster. In many cases, their only interactions with any sort of "customer" is through the Product Owner or members of their own QA team, since many organizations are averse to putting their developers in direct communication with real customers.

This approach works for many, many organizations. I would say for larger orgs (non-Startups) it's kind of the "standard" approach.

## Consequences of this Organizational Structure

Bigger orgs that use these org structures often follow things like [SAFe](https://www.scaledagile.com/enterprise-solutions/what-is-safe/) (and maybe this is more the issue than what I'm discussing in this article, but that's for another time). Under SAFe, there are large-scale integrations called Program Increments(PIs), which span some fixed period of time and within which smaller iterations occur. At the start of each PI, there's a planning phase, during which "the work" for the PI is planned, and then during the PI the teams work to deliver on this plan.

In my experience, it's not unusual for major changes to occur in the direction of a PI at nearly any point in its lifetime (and sometimes even before). I'm aware of PI planning periods that have gone forward even when the architects and product owners knew before it started that "things had changed" and they weren't actually going to be doing the work they were about to start planning. But the new work wasn't ready to plan, yet, and so "the process" had to be followed.

So, when things like this happen, generally the product owner (who usually isn't the one directly responsible for the changes, mind you) has to tell the developers that their direction needs to shift. The PI plan is no longer valid. Here's the new plan. By the way, the release date hasn't changed. Nor has scope. And why aren't we on track to hit our deadline for this sprint?

The end result is that the development team frequently bears the brunt of management's disappointment when, ultimately, deadlines slip or features need to be cut. Dev and architect leaders field accusatory emails or endure fraught meetings with execs. Performance reviews, raises, and promotions all hang in the balance. Developer team stress spikes as a result. They're the end of the line, and have nowhere else to pass the buck.

## What if this were reversed?

Are the developers to blame when the above scenario occurs, as it so often does? I would argue generally not (to the extent that anyone is "to blame" - probably there were good reasons for the shift in priorities and the real issue is that management's expections after making changes were unrealistic). All the same, imagine if the org chart were inverted somewhat.

At the top of course is the CEO and whatever executive is in charge of the overall product. Maybe there's a Director of Product Development, etc. Now, instead of that person having some middle managers and then product manangers/product owners reporting to them, they have the developer leadership as their direct reports.

Senior management communicates to the developers what the end goal is for the product's next release is. It's up to the development leaders to gather the necessary requirements. They still need all of the things that the Product Owners do in the typical org chart, so they have Product Owners who report to them. The product owners are responsible for providing the development teams with well thought out requirements based on their subject matter expertise. Under this structure, the developers will hear about any need for new direction from management, directly, and can ask the product owners to provide updated requirements accordingly. If product owners needlessly change up requirements (not to say they do this now), they're the ones who risk nasty emails from their bosses, whom they've disappointed, not the developers.

## The Real Issue

The real problem here in so many cases is that organizations "adopt" agile but then it runs head-on into [Conway's Law](https://ardalis.com/conways-law-ddd-and-microservices) and the way decisions are made within the organization.

Is the issue that the requirements changed?

No, presumably the requirements changed because the organization gained better insight into what was needed to delight customers (or in some cases, to meet regulatory requirements or other reasons). Assuming the requirements changed for an objectively good reason, from the perspective of the organization, then it only makes sense to adapt to these changes.

> No matter how far down the wrong path you've gone, turn back now. -- Turkish Proverb

Agile is all about embracing change.

Is the issue that the change is communicated to developers through product owners?

Not really. That might delay how quickly the message gets through, but assuming that's negligible (and not the fault of the PO in any case), blaming the PO is just shooting the messenger.

Is the issue that changes sometimes come in out-of-sync with agile ceremonies (looking at you, SAFe PIs)?

That certainly doesn't help. It's hardly "agile" to build an agile process around a rigid set of ceremonies that don't respond well to change without producing an immense amount of wasted effort. Not reacting swiftly to incoming changes results in teams "building the wrong thing" which is generally much worse than "building the thing wrong".

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">As software developers, we fail in 2 ways: we build the thing wrong, or we build the wrong thing. <a href="https://twitter.com/hashtag/DevReach?src=hash&amp;ref_src=twsrc%5Etfw">#DevReach</a></p>&mdash; Steve &quot;ardalis&quot; Smith (@ardalis) <a href="https://twitter.com/ardalis/status/385401251862945792?ref_src=twsrc%5Etfw">October 2, 2013</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Is the issue that management ultimately holds development teams responsible when they change direction and compress timetables but don't shift scope or deadline?

Absolutely. Without question. Look, **the best way to get a project done faster is to start sooner** (no, [adding more people isn't usually going to help](https://amzn.to/3uI00ar)). If management delays starting on building the right thing for whatever the reason, that doesn't suddenly change a 6-month project into a 4-month project. Management needs to weigh the cost of delay with the cost of shifting direction. Failing to account for the cost of changing direction, and the delay that obviously necessites, and expecting heroics from the dev team, is unreasonable at best. The members of the development team in an organization, like so many other team members, are very expensive to replace. Expecting heroics from them and throwing them under the bus when deadlines are missed through no fault of their own is a great way to lose them, and a great way to develop a reputation as an org that does that sort of thing. Free tip: you probably don't want that reputatation.


