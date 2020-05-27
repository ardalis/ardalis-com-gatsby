---
templateKey: blog-post
title: Custom Software Craftsmanship Workshop
path: blog-post
date: 2016-02-26T13:20:00.000Z
description: Last month I was invited to put on a customized workshop for one of
  my mentoring clients. The group included developers, testers, and technical
  management team members, totaling about a dozen people.
featuredpost: false
featuredimage: /img/steve-microsoft-2015-11-970x450.jpg
tags:
  - software craftsmanship
  - workshop
category:
  - Software Development
comments: true
share: true
---
Last month I was invited to put on a customized workshop for one of my mentoring clients. The group included developers, testers, and technical management team members, totaling about a dozen people. I thought others might find some of what we discussed useful, so I’m posting some notes about the workshop here. If you think I could help your team or application improve, through remote mentoring or an on-site workshop, please [contact me](https://ardalis.com/contact-us).

**Company / Product Overview**

I’ve been working with members of this company’s development team for over a year now, but it was still helpful to many in the room for the senior manager to provide some background on the company and its product line. This history was helpful, since the bulk of the team’s efforts were not new applications, but extensions to an existing suite of products. This discussion also covered many of the plans and goals the company had had in the past, which helped explain many of the decisions that had gone into the existing architecture and design of the system.

This discussion moved from high level and long time frame to more tactical and immediate, as the technical team discussed their current set of goals. The team was using Scrum with 2-week sprints, and were effectively deploying to production at the end of virtually every sprint. They were hoping to get more efficient at these deployments, as well as their time spent on sprint planning. We briefly touched on some ideas that might help that were already on the agenda, including [continuous integration](http://deviq.com/continuous-integration/), branching strategies, and [kanban](https://www.pluralsight.com/courses/kanban-fundamentals).

**Overview of Domain-Driven Design / Discussion**

I’ve been helping the team apply [Domain-Driven Design Fundamentals](https://www.pluralsight.com/courses/domain-driven-design-fundamentals) for the past year, so this was a fairly quick overview and review of some of the principles and patterns involved in DDD. The main product the team works on is architected in a data-centric manner, rather then using [a domain-centric n-tier architecture](https://www.pluralsight.com/courses/n-tier-apps-part1). The presents challenges when trying to shift toward a more domain-centric approach. During this session, we discussed bounded contexts, aggregates, anti-corruption layers, and domain events (and how these differ from inter-application events). Some of the questions we discussed included:

* Who “owns” the data (for a concept that occurs in multiple bounded contexts)?
* How does reporting fit in?
* For what scenarios is this approach “overarchitecture”?
* What maintenance concerns are related to this approach (framework, other dependencies, etc.)?

Obviously the details of these discussions aren’t necessarily relevant generally, but the discussion was very helpful for the team and organization.

**Code Reviews**

As part of their effort to continuously improve, the team wanted help with conducting code reviews to maximize their benefit. The team understood code reviews to be “a good thing”, but the realities of shipping software often meant they didn’t happen, or they didn’t happen effectively. One technique they were using with some success was bringing the whole team in and have one developer share something they’d done that they thought was interesting. Another was to have (most of) the team work with me during our weekly mentoring session to review recent check-ins.

After some discussion, the team revisited a coding standards document they had authored previously and agreed to use it when conducting reviews. We talked about the GitHub style of using branches and pull requests to create conversations around individual updates to the codebase, and considered ways in which this approach could be applied using the team’s current toolset. We also talked about the pair programming as a code reviewing tool, for which we would do a hands-on exercise later.

**Pairing, Testing, Refactoring**

Next I presented some material on pair programming and unit testing (as well as other forms of testing). I gave some instruction on [when and how to refactor code](https://www.pluralsight.com/courses/refactoring-fundamentals). And then we broke up into 4 groups to do a hands-on exercise. All four teams were given the same problem to solve, as a series of steps, with each future step hidden until the preceding step had been completed. This prevented the teams from planning too far ahead, and forced them to revise their design in response to new requirements, just like in real application development. This hands-on exercise was, I thought, one of the highlights of the 3-day workshop, and took a little over two hours. Each team worked in the workspace of one of its members, with the remaining team members crowded around the space (think L-shaped cubicles, for the most part). Every 30 minutes or so, I would have the team members who weren’t at their own workspace rotate, so that by the end of the exercise the roaming team members had been to each stationary workstation. Then we returned to the training room to review what had been learned.

This wasn’t a team that had a great deal of experience with pair programming. The exercise drove home some of the points I’d made in my lecture about the importance of designing a workspace for effective pairing. Overall they found the experience to be very enjoyable, but things like poor furniture layouts and unfamiliar keyboards were obstacles. They also found it very interesting to see how different the four designs ended up being, and how some team members had effectively spread knowledge picked up from one team member to another, cross-pollinating ideas and helping to reduce the knowledge silos and the project’s [bus factor](http://deviq.com/bus-factor/).

**Isolated Environments and Automated Builds**

One challenge the team has currently is the size of their database. Since there is one database used for all applications, and currently it includes all data from the beginning of time (for the application), it’s not currently amenable to local use. Thus, the team uses a small number of shared databases for their development and testing efforts. This results in frequent bottlenecks and collisions because of this constraint. We talked about some techniques for alleviating this issue, including getting the database schema into source control (using Visual Studio database projects or something similar) and scripting the schema and minimal data set required to run the basic version of the application. The team discussed their own plans for reducing the size of their primary database, too.

Related to this effort, I showed [how to use a custom MSBuild script to automate building the project locally](http://ardalis.com/build-automation-for-your-application-using-msbuild), and how this can be used with [the check-in dance](http://ardalis.com/the-check-in-dance) to help ensure code is working before it is checked into a shared source control branch. I demonstrated using [Jetbrains TeamCity](https://www.jetbrains.com/teamcity/download/) to configure automated builds that use the same MSBuild scripts as are run on individual developer/tester workstations, eliminating cases of “it works on my machine”. We talked about how to configure TeamCity to automatically deploy certain branches to staging environments if all tests pass, allowing earlier testing of releasable code than their current process of waiting to cut a release until near the end of a sprint.

**Git, GitHub, Branching, and Kanban**

[![GitHub_Logo](/img/GitHub_Logo-300x123.png)](http://github.com/)

For the most part, the team was unfamiliar with git and distributed version control systems. I taught them the basics of git, and went through some of [GitHub’s](http://github.com/) collaboration tools and compared them with the team’s existing toolset. I explained a basic branch-per-feature branching strategy using a dev branch for work in progress and a master branch for release-ready code. I gave a brief explanation of [kanban](https://www.pluralsight.com/courses/kanban-fundamentals), including the importance of limiting work-in-progress and helping get downstream work items to done before starting new work. Related to this, I showed the team how [Huboard](https://huboard.com/) can be used with any GitHub project to create an instant kanban-style view of the project’s work items.

After this, we were ready to give these new tools a try with another hands-on exercise. This time we did some product planning as a team, creating a new GitHub repository and Huboard, and adding items to the product backlog. We split up into two teams, with one responsible for the UI and configuration of automated builds and TeamCity, and the other responsible for the domain layer and the exercise’s primary service features. The two groups continued to do pair programming (or at this point, more [mob programming](https://en.wikipedia.org/wiki/Mob_programming)), but this time they also used git branches for each issue/work item they added. The teams then created pull requests rather than simply committing to the master branch, and required the other team review and approve their changes before they could merge them in.

The two teams learned a lot about the workflow involved in using GitHub’s tools for reviewing and discussing pull requests, and how to configure and work with Huboard to visualize and prioritize work. One team also became familiar with setting up TeamCity builds and MSBuild automation scripts on their own, something they planned to add to each of their projects going forward.

**Domain Modeling for Real**

The workshop wrapped up with some domain modeling of an upcoming feature the team was preparing to build. The feature was currently mocked up in a PDF document showing how the UI might appear. We talked through some of the scenarios the screens depicted, and discovered some business rules that were implied. I walked through how these rules could be embedded in the domain model, and tested with unit tests, without any consideration of how the data might be persisted (now or in the future). At the end of the domain modeling exercise, we had a simple set of classes that were small and easy to understand. These classes were testable and unit tested, and we were able to isolate knowledge of the existing data schema to a small set of infrastructure classes dedicated to data access.

It was at this point that a lot of what had been discussed previously really started to make sense to some of the team members. Several of them expressed excitement about how they were looking forward to applying some of these techniques immediately or in the near future. Working more collaboratively, breaking up large shared dependencies by establishing boundaries and APIs between applications, and modeling complexity in code rather than data were some of the main themes.

One of the team leads left me this feedback:

> *“Steve’s knowledge in all areas from development to workflow has been a great help to our organization and delivery team. That knowledge combined with his presentation and teaching style promote discussion, enthusiasm within the team, and cleaner more maintainable code.*
>
> *Thanks for a great workshop”*

**Summary**

I had a lot of fun working with this team and I look forward to continuing assisting them. We covered a lot of ground in just three days, and it was helpful to spend time on-site with the team. I really enjoy helping developers learn how to build more maintainable software. It’s also great to help companies see how this enables them to deliver value to their customers faster and without becoming bogged down by [technical debt](http://deviq.com/technical-debt/) and legacy code. If you found this interesting and have any questions, please leave a comment or reach out to me on [twitter](https://twitter.com/ardalis). If you think can help your software team deliver value faster, check out some of [my courses on Pluralsight](https://ardalis.com/ps-stevesmith), and [contact me for some remote mentoring or an application assessment](https://ardalis.com/contact-us).