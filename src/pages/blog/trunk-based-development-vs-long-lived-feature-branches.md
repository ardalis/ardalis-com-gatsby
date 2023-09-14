---
templateKey: blog-post
title: "Trunk-Based Development vs. Long-Lived Feature Branches: Which One is Right for Your Software Team?"
date: 2023-09-14
description: "Uncover the pros and cons of Trunk-Based Development and Long-Lived Feature Branches to make an informed decision for your software development strategy."
path: blog-post
featuredpost: false
featuredimage: /img/trunk-based-development-vs-long-lived-feature-branches.png
tags:
  - git
  - Software Development
  - Source Control
  - Trunk-Based Development
  - Feature Branches
  - Version Control
  - Continuous Integration
  - Continuous Deployment
  - Continuous Delivery
  - DevOps
category:
  - Software Development
comments: true
share: true
---

When it comes to effective software development strategies, two distinct approaches often lock horns: Trunk-Based Development and Long-Lived Feature Branches. Each has its unique merits and challenges, and knowing which one to adopt can significantly influence your project's success. In this post, we'll delve deep into the pros and cons of both approaches and even show you a C# example demonstrating how to safely integrate work-in-progress code into the mainline.

## What is Trunk-Based Development?

Trunk-Based Development is a software development approach where developers frequently integrate their code changes into a single shared branch, known as the 'trunk' or 'mainline'. The goal is to perform small, incremental updates to minimize merge conflicts and streamline the development pipeline. [Continuous Integration (CI)](https://deviq.com/practices/continuous-integration) is often an integral part of this strategy, as it allows for quick detection and resolution of issues.

## What is Long-Lived Feature Branching?

Long-Lived Feature Branching, on the other hand, involves creating separate branches to develop new features or make significant changes. These branches live independently of the mainline for extended periods, allowing developers to work in isolation. Once the feature or change is ready and tested, it's then merged back into the mainline, often requiring a comprehensive review and potentially complex conflict resolution. Branching strategies like Git Flow popularized this approach, and it's extremely common in open source software, where typically community contributors do not have mainline access, and so much create branches and make pull requests.

The term "long-lived" is given without any particular measure. How long "long" is really depends on how active the codebase is. The amount of change to the mainline since the branch was opened is the important factor, not necessarily the calendar time since the branch was first created or synchronized with the main branch.

## Trunk-Based Development Pros and Cons

### Pros:

1. **Quick Feedback Loop**: Continuous integration allows for instant feedback, making it easier to identify issues early.
2. **Reduced Merge Hell**: Merging becomes simpler due to frequent integrations.
3. **Increased Collaboration**: The pull-and-merge routine encourages better communication.
4. **Faster Time-to-Market**: Features can be deployed quicker and [more often](https://ardalis.com/deploy-more-often/) for testing and user feedback.
5. **Simplified Development Pipeline**: A single source of truth makes CI/CD configurations easier.

### Cons:

1. **Relies on Strong Testing**: Without robust automated tests, this approach can be risky. *Very* risky. But you probably should have good automated tests in place, anyway, which in turn unlock this capability.
2. **Not Ideal for Large Changes**: Significant architectural updates can be tricky to implement incrementally. Of course, even if you *generally* follow a trunk-based approach, you could make exceptions for sweeping major updates.
3. **Feature Flag Complexity**: Although useful, feature flags can add an additional layer of complexity. The conditional logic tends to add clutter, and once features are added, additional effort must be put in place to remove the conditionals.

## Long-Lived Feature Branches Pros and Cons

### Pros:

1. **Isolation**: Developers can work on large features without affecting the mainline.
2. **Code Stability**: The main branch remains stable. Automated protections can help ensure only tested, working code is allowed to be merged into the main branch.
3. **Suited for Big Bang Changes**: Ideal for implementing significant changes. Often overkill for small, incremental improvements.
4. **Flexible Release Planning**: Features can be bulk-released by using a (yet another) branch for a release, and merging several feature branches into the release branch, before finally merging the release into main. This is especially useful for interdependent features.

### Cons:

1. **Merge Hell**: The older a branch, the harder it is to merge. Dealing with merge conflicts can consume a significant amount of a team's time if branches are frequently allowed to stray from the mainline for extended periods of time.
2. **Slow Feedback Loop**: Integration happens less frequently, and certainly not continuously. Problems and incompatibilities between features will be detected later, often only after merging to main is attempted.
3. **Reduced Collaboration**: Working in isolation can be counter-productive. Code duplication, mis-communication, stalled effort, and more can all occur more easily in a lone developer's long-lived feature branch than in a mainline branch in which the whole team is actively participating.
4. **Mainline Drift**: The feature branch may diverge significantly from the mainline. This usually happens when development continues on the mainline after the feature branch was created. Rebasing/merging the mainline into the feature branch frequently can mitigate this, but often isn't practiced by team members, resulting in Merge Hell described above.

## Practical C# Example

If you're using Trunk-Based Development, adding work-in-progress (WIP) code without breaking the mainline is crucial. Here's a simple example using C# and a feature flag.

```csharp
public class FeatureFlags
{
    public static bool NewFeatureEnabled = false; // Feature Flag
}

public class Program
{
    public static void Main(string[] args)
    {
        // added conditional to check feature availability
        if (FeatureFlags.NewFeatureEnabled)
        {
            NewFeature();
        }
        else
        {
            OldFeature();
        }
    }

    public static void NewFeature()
    {
        Console.WriteLine("New feature code here");
    }

    public static void OldFeature()
    {
        Console.WriteLine("Old feature code here");
    }
}
```

By utilizing feature flags, you can safely integrate (and deploy!) WIP code into the mainline and enable it only when it's ready for release. And of course feature flags don't have to be hard-coded in your code, nor do they need to be boolean. You can use feature flags to enable features for beta customers, testers, or to allow different tiers of subscribers to unlock additional features, just as many SaaS products do today. You can also configure feature flags to turn themselves on at a given moment, allowing for new features to be released at any time without interaction from the DevOps team.

## Deploy or Release

I often ask developers at tech conferences (and occasionally on social media) what they think the difference is between *deploying* their software and *releasing* it. A sizable number always says there's no difference at all!

![deploy the feature / release the feature / They're the same picture (meme)](/img/deploy-feature-release-feature.jpg)

If you don't use any sort of feature flags, every deployment is going to have the same effect as a release. But if you're able to *deploy* your software as a technical/engineering practice, while allowing the business to make a business decision about when to *release* new features, you enable much better business agility.

[Deploy more often](/deploy-more-often/), and release whenever it makes sense for the business.

## Drama

Both of these approaches can make sense in different contexts. It depends™. However, if you're currently using one of these approaches, and someone on your team proposes the other, try to avoid *losing your mind* over the idea that *anyone* could *possibly* do things like *that*. Especially if you've never tried it. **Drama is good for social media engagement but rarely good for you and your team.**

Respect each other, learn what you can about the pros and cons of different approaches, experiment when it makes sense, and make a decision that works well for your team and situation.

## Conclusion

Whether you choose Trunk-Based Development or Long-Lived Feature Branches largely depends on your team's needs, the complexity of your project, and your business requirements. Trunk-Based Development is particularly effective in environments requiring quick iterations and a fast feedback loop. On the other hand, Long-Lived Feature Branches are more suited for projects that require significant changes, which may be risky to introduce incrementally.

In any case, the best strategy is one that adapts to your project's needs while mitigating its challenges. It's not a matter of one size fits all but finding the perfect fit for your team.

## Summary

In this article, we've explored the pros and cons of Trunk-Based Development and Long-Lived Feature Branches. We also demonstrated a C# example for safely integrating WIP code into the mainline using feature flags. The choice between these two strategies depends on various factors, such as the team's expertise, project complexity, and business needs. Whichever path you choose, remember that the strategy should be adaptable to your specific requirements.

## References

1. [Trunk Based Development](https://trunkbaseddevelopment.com/)
2. [Feature Branching is Evil](https://thinkinglabs.io/talks/2016/10/29/feature-branching-is-evil.html)
3. [Atlassian - Feature branching vs Trunk Based Development](https://www.atlassian.com/continuous-delivery/continuous-integration/trunk-based-development)
4. [Pros and Cons of Trunk Based Development vs. Git Flow](https://circleci.com/blog/trunk-vs-feature-based-dev/)
5. [Git Branching Strategies vs. Trunk-Based Development](https://launchdarkly.com/blog/git-branching-strategies-vs-trunk-based-development/)

If you're looking for more tips like this, [subscribe to my weekly tips newsletter](/tips) and be sure to follow me on [YouTube](https://www.youtube.com/ardalis?sub_confirmation=1).
