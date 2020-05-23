---
templateKey: blog-post
title: Attacking Technical Debt
date: 2019-09-18
path: /attacking-technical-debt
featuredpost: false
featuredimage: /img/attacking-technical-debt.png
tags:
  - clean code
  - code quality
  - refactoring
  - technical debt
category:
  - Software Development
comments: true
share: true
---

[Technical Debt](https://deviq.com/technical-debt/) is a metaphor for shortcuts and hacks in software that make it more difficult to change and maintain than it could be with an optimal design. Many applications have accumulated a large amount of technical debt, and figuring out how to deal with it is a fairly common challenge for many developers, especially senior developers starting new contracts or jobs at companies that need help with their legacy code and its huge technical debt.

## So, how should you approach paying down technical debt?

In some cases, you shouldn't. It may make sense to rewrite the app. Declare "technical bankruptcy." This should be rare, and it's likely not a decision a developer is going to be making. Let's assume that's not an option (or not the decision that was made) in this scenario. Now what?

## Stop the bleeding

Step one is to stop the bleeding. If you're a doctor and you have a patient who is bleeding profusely, the first thing you need to do is **stop the bleeding**, not perform a bunch of other diagnostics or gather medical history or get a CT scan done. Stopping the bleeding buys you time to assess the situation and correct things without things continuing to get worse.

Going back to the debt metaphor, if you're advising someone on how to get out of debt, and their biggest problem is they're constantly outspending their income using credit cards, the first thing you do is **cut up the credit cards**.

One last metaphor for you. If you're in a deep hole and are wondering how you're going to get out, the first thing to do is to stop **digging yourself deeper into the ground**. You're only making the future problem harder to solve.

What does this look like in terms of your software project? Technical debt increases when you add untested, difficult to test, tightly coupled code (among other things). So, step one is to stop doing that. New code will follow standards. It will be tested. It will be well-factored. Even updates to large legacy codebases can be written using new classes that can be well-designed. [Maintain legacy code by adding new code](https://weeklydevtips.com/episodes/015), not by changing existing code.

## Refactor, while adding value

Getting rid of technical debt is what refactoring is all about. There are many specific techniques you can use and code smells you can identify that contribute to technical debt. I've written three courses on refactoring that you may find useful when you get to this step:

- [Refactoring for C# Developers](https://www.pluralsight.com/courses/refactoring-csharp-developers)
- [Microsoft Azure Developer: Refactoring Code](https://www.pluralsight.com/courses/microsoft-azure-code-refactoring)
- [Refactoring Fundamentals](https://www.pluralsight.com/courses/refactoring-fundamentals)

One thing that's common to all of them is the idea of _when should you refactor_? The approach I recommend is to refactor in the course of making necessary updates to the code - fixing bugs or adding new features. Customers and stakeholders expect development teams to make changes that they can see and appreciate. If you try to just stop delivering value and spend an extended period of time "cleaning up" the code, you're sending a very dangerous message to stakeholders. What's more, you're not necessarily focusing your efforts where they matter most and will have the most immediate return on investment.

When you refactor as you add value, you're making the code that you're already working on better. The benefits of your refactoring efforts are felt immediately. And, typically, the areas of the code that you're working on at any point in time are likely to be worked on again in the near future. Bugs and features tend to affect certain areas of the codebase more than others, not to be evenly distributed. If you take a broad, sweeping approach to your refactoring efforts, odds are good you're going to be cleaning up code that you otherwise were never going to need to touch, which doesn't add much value (it might be a complete waste of time and worse, might break something that would have been fine if you'd let it be).

## Measure and Keep Quality Increasing

Once you decide to stop making things worse and start following the Boy Scout Rule and making the code at least a little bit better with each new pull request, you're on the right track. Now's a good time to monitor the quality of the application using whatever metrics you find valuable. Some metrics I use include:

- [Code Test Coverage](https://ardalis.com/tag/code-coverage) - Keep it trending upward over time
- [Aggregate Complexity](https://ardalis.com/measuring-aggregate-complexity-in-software-applications) - Keep it trending toward zero
- [NDepend](https://www.ndepend.com/) Technical Debt - Keep it trending down

You can also use some of the metrics available in Visual Studio, or [SonarQube](https://www.sonarqube.org). But whatever metrics you pick, you want to be able to look at a trend over time of your code's quality using some kind of metric to give you confidence that you are, in fact, moving things in the right direction.

Other things you may want to track:

- Total passing tests (more is better)
- Frequency of deployments (more often is better)
- Cycle time for new work (faster is better)
- Frequency of bug reports
- Frequency of deployment rollbacks

You don't need to track all of these things, but if you're going to go to the trouble of making a concerted effort to clean up your code, it's worth identifying up front how you're going to measure your progress. What metrics are valuable to your team or your stakeholders? How can you move them in the right direction with your efforts? That's how you'll know if you're on the right track.

## Your turn

Have you gone through a major refactoring effort? What worked and what didn't? Share your thoughts below. What about metrics? How did you know when you were done? Or that it was "better"? Were there certain metrics you used to guide your effort? Please share. Thanks!
