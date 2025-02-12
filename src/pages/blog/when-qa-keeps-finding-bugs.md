---
templateKey: blog-post
title: When QA Keeps Finding Bugs
date: 2025-02-12
description: This post explores how teams can reduce the number of defects reaching QA without discouraging testers from doing their job. It emphasizes the importance of building quality into the development process through clear acceptance criteria, automated testing, code reviews, and a well-defined "Definition of Done."
path: blog-post
featuredpost: false
featuredimage: /img/when-qa-keeps-finding-bugs.png
tags:
  - programming
  - c#
  - qa
  - lean
  - csharp
  - agile
  - scrum
  - quality
category:
  - Software Development
comments: true
share: true
---

A developer manager recently reached out with a concern: their new QA team member was finding too many bugs, leading to frustration among developers. Overall velocity of the dev team (in terms of features being shipped) was rapidly falling. The question was, how can they reduce the number of issues being kicked back from QA without discouraging the testers from doing their job well?

## QA Isn't the Problem

First and foremost, if QA is finding bugs, that means they're doing their job well. The goal shouldn't be to stop QA from finding bugs. The goal should be to reduce the number of bugs that reach QA *in the first place*. The real issue likely lies upstream in the development process.

## Where Are the Bugs Coming From?

The first question to ask is: **Are these bugs in new features, or are they defects in existing functionality?**

- **New Features**: If the majority of bugs are coming from newly developed features, that's a sign your developers are shipping poor-quality code. The solution isn't to rush fixes—it's to improve the development process so that fewer defects are introduced in the first place.
- **Existing Features**: If QA is uncovering longstanding issues that aren't directly tied to recent work, these should be triaged and added to the backlog based on priority.

If the bugs are coming from new work, developers need to adopt better quality practices. Yes, this might slow them down in the short term, but fixing defects after the fact is always more expensive than preventing them upfront. If you continuously produce poor quality code, you're just going to face an increasing load of technical debt as well as user support tickets and you'll end up in constant fire-fighting mode and your velocity will drop to zero. I've seen this time and time again.

## Build Quality In

A core principle of lean software development is **"Build Quality In"**. What this means is that quality shouldn't be something you check at the end, but something that is part of the entire development process. There's a quote I like that drives this home: 

> "If you have a process that produces defects, then you have a defective process."

If developers are getting frustrated by the fact that work keeps getting kicked back to them, they need to understand that fixing issues earlier in the process will ultimately save them time and frustration. Here's how they can do that.

## Practical Steps to Improve Quality

### 1. Define "Done"

Have a **Definition of Done** that includes basic quality checks. This can be a simple checklist that ensures:

- All acceptance criteria are met.
- The code passes automated tests.
- The feature has been reviewed by at least one other developer.

### 2. Write Tests

Testing should be a core part of development, not an afterthought. Use [Test-Driven Development (TDD)](https://deviq.com/practices/test-driven-development) where it makes sense, but at the very least, ensure that the most important paths in the application are covered by automated tests.

### 3. Use Code Reviews and Pair Programming

Code reviews should be more than a formality—they should catch defects **before** they reach QA. If your team's review process consistently lets bugs through, then clearly your reviews are not as effective as they should be. Caution reviewers against quickly signing off on pull requests with "Looks good to me" without properly looking over the code. [Pair programming](https://deviq.com/practices/pair-programming) can also help catch issues early by getting another set of eyes on the code as it's written. Teams using pair programming are also more likely to hold one another to a higher standard of quality, ensuring that code is written with maintainability in mind.

### 4. Have Clear Acceptance Criteria

Developers can't deliver high-quality features if the requirements are vague. Acceptance criteria should be **explicit** and, ideally, **testable**. If something isn't clear, push for clarification before development starts.

### 5. Use Static Analysis Tools

Static analysis tools can catch common issues like null reference exceptions, unused variables, and more. Tools like [Roslynator](https://marketplace.visualstudio.com/items?itemName=josefpihrt.Roslynator) can be integrated into your build process to catch these issues before they reach QA.

### 6. Metrics

Identify metrics that can help you guide the process and inform both developers and QA teams about the quality of the code. For example, you might track the number of defects found in QA, the number of defects found in production, the number of defects found in code reviews, and the number of defects found in automated tests. Use these metrics to identify trends and areas for improvement. Other metrics like cyclomatic complexity, code coverage, and code churn can also be useful.

Be careful that your metrics don't become targets, as this can lead to incentivizing the wrong behavior. Keep [Goodhart's Law](https://deviq.com/laws/goodharts-law) in mind: "When a measure becomes a target, it ceases to be a good measure." Remember, not everything easily measured is important, and not everything that's important is easily measured.

## Handling Incoming Bugs

Even with improved quality, some bugs will still slip through. If QA is constantly uncovering small defects, consider:

- **Triage and Prioritization**: Not all bugs are equal. If they aren't showstoppers, add them to the backlog and prioritize them alongside feature work.
- **Bug Rotation**: Assign a developer (or rotate responsibility) to handle bug fixes during a given sprint/week.
- **Separate Bug Swimlane**: Use a separate board or swimlane for bug fixing to prevent it from derailing feature development.

## Summary

The key takeaway is that **QA finding bugs isn't a problem—shipping too many bugs is**. If defects are being caught late, you likely have a development process issue. Focus on improving quality **before** features reach QA through better requirements, testing, and reviews. In the long run, this will make everyone's lives easier—including the developers who are currently frustrated.

If you've implemented changes like these, I'd love to hear how they worked for you. Leave your experience and favorits tips in the comments below, or in a post on [LinkedIn](https://www.linkedin.com/in/stevenandrewsmith/) or [BlueSky](https://bsky.app/profile/ardalis.com)!
