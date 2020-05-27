---
templateKey: blog-post
title: Getting Started with Architecture Decision Records
date: 2020-03-11
path: /getting-started-with-architecture-decision-records
featuredpost: false
featuredimage: /img/getting-started-with-architecture-decision-records.png
tags:
  - adr
  - architecture decision record
  - communication
  - documentation
  - GitHugitb
category:
  - Software Development
comments: true
share: true
---

Have you ever been on a software team for a while, and then someone new joins the team and starts asking the usual questions about why this or that technology or pattern is being used on the project? And then a few months later, someone else joins and all the same questions come up again? Or maybe some team member, whether new or not, constantly wants to relitigate every choice, potentially to the detriment of actually delivering working software with the decisions that are already in place?

If any of this sounds familiar, read on for one technique you can start to apply that may help.

On any software project, there are going to be a lot of decisions made about how to build and deliver the application. Some of these you may not even think about because they're just "how you do things" but nonetheless they're decisions.

Examples include:

- What kind of app are we building (web, desktop, mobile, embedded, etc.)
- What framework(s) will we use?
- What programming language(s) will we write code in?
- What operating system(s) will the application run on?
- What OSes will our developers use?
- What tools will we use to build and test the software?
- How will we store data?
- How will different parts of our system communicate with one another?
- Where will we host the application?
- How will we deliver the application to our users or its server?
- What patterns will we use for persistence?
- What kinds of testing will we perform on the system?
- How will we validate user inputs?
- What is our logging strategy and what tools will we use for logging?

Not all of these necessarily "architecture" decisions but they're all examples of the kinds of decisions that need to be made as an application is going from idea to delivered product. Some decisions are made based on who is building the software: "We're a .NET Core shop so we're building this with C# on Windows (and Mac/Linux if some developers want)." Other decisions may require weighing requirements and having meetings to identify and choose the best solution. It's the latter where documenting the decision and the thought that went into it is most useful.

## A Simple Decision Record

An [Architecture Decision Record](https://en.wikipedia.org/wiki/Architectural_decision#Decision_documentation) is a tool for documenting a decisions that has been made (or is under discussion) related to the architecture of a particular system or application. You'll find many templates available to help you get started but in general when you find that a decision needs to be made you should think about documenting the following:

- What is the issue you are deciding (brief and clear)
- What decision did you make (if any, yet)
- Current status (Under Discussion, Decided, etc.)
- Who was involved in the decision/discussion
- When did the decision occur
- What options were considered
- What were the pros and cons of the various options
- Why was the decision made as it was
- What are the consequences of the decision

There are examples and links to many templates at [Joel Parker Henderson's Architecture Decision Record GitHub repo](https://github.com/joelparkerhenderson/architecture_decision_record). There's a lot of great information there and I encourage you to check it out. There are complete examples in a variety of formats for decisions like:

- [Monorepo or Multirepo](https://github.com/joelparkerhenderson/architecture_decision_record/blob/master/examples/monorepo-vs-multirepo.md)
- [Programming Language](https://github.com/joelparkerhenderson/architecture_decision_record/blob/master/examples/programming-languages.md)
- [Timestamp format](https://github.com/joelparkerhenderson/architecture_decision_record/blob/master/examples/timestamp-format.md)

Note that these are examples of decisions other teams might have made given their unique circumstances, and not the authority for how you should choose to solve these same problems on your team or for your application.

## When should I bother writing ADRs?

If you looked at some of the resources I linked to above and immediately thought it was way too much work, let's talk about when it makes sense to write them up. If you don't expect the issue to ever come up again in the future, you probably don't need to write an ADR. If no explicit decision was made, no discussion was had, you just are following your team or company's unwritten SOP (Standard Operating Procedure), then you probably don't need an ADR for that, either.

On the other hand, if you have multiple lengthy email threads interspersed with meetings and calls to talk through all of the options with various factions pushing for their preferred approach, ultimately resulting in a decision (that some involved may only grudgingly have accepted), then documenting that process is likely to be valuable. If it was worth the time and energy to make the decision, it'll be worth documenting what went into the decision so you can leverage that time again in the future.

## Where to Store Architecture Decision Records?

Most commonly architecture decision records are stored wherever other documentation for the team or project is kept. This is likely to be a wiki or perhaps some kind of documentation system. It's a good idea to use a system that natively supports versioning. If you don't have a better solution you can use a git repo and simply store the records as text files (I recommend markdown). Then any changes will be apparent in the version history and new changes can be requested as pull requests so any appropriate discussion can happen before the changes are applied. Remember that once a decision has been made, that record should ideally be kept immutable. If a new decision needs to made later on the same topic, link to the original decision but begin the new discussion in its own file.

## Summary

**The most important thing to document in these design records is not what you decided to do, it's what you considered and decided not to do.** You want there to be a record of the other options that were considered, what their perceived pros and cons were, and ultimately why they weren't chosen. This is something you and others can review later and if the circumstances haven't changed substantially, the decision should probably stand. If new information has surfaced that renders the original decision obsolete, it should be obvious based on the information in the record.
