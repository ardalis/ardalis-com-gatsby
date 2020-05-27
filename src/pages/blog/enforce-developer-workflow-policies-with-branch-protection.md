---
templateKey: blog-post
title: Enforce Developer Workflow Policies with Branch Protection
date: 2019-09-11
path: /enforce-developer-workflow-policies-with-branch-protection
featuredpost: false
featuredimage: /img/enforce-developer-workflow-policies-with-branch-protection.png
tags:
  - ci
  - code quality
  - continuous integration
  - git
  - GitHub
  - process
  - quality
  - workflow
category:
  - Software Development
comments: true
share: true
---

A frequent question I hear from clients is some variant of "Ok, Continuous Integration is great, but how do we get everybody on the team to pay attention to it?" This is obviously a bigger problem if the question is coming from a lone junior developer, as opposed to a technical manager. In the case of the junior developer, they may need some help convincing _the rest of the team_ that CI is worthwhile. But assuming the team is on board, it can still be difficult to change old habits. Sure, there's a build server running, but is it helpful at all if nobody pays any attention to it, and whether or not builds pass or fail?

One developer workflow that I've found works extremely well when combined with git for source control is to require all updates to the master branch be done with pull requests. With this simple rule in place, you now can work out what rules, if any, you want to put in place around when a pull request can be merged.

For example, you can require that the CI server's build complete successfully. Traditionally, CI typically ran after changes were committed into the main branch of source control, and thus problems were found after they were added to the codebase. This is clearly not ideal. Using pull requests and a requiring a passing build before a merge can occur ensures that problems are found before the code makes it into the main branch, which is clearly better. (The CI server should still run builds on the master branch after each merge, too, but these should virtually never fail).

Another common constraint to place on pull requests is reviews. You can require that one or more other team members sign off on the pull request before it's allowed to be merged. This theoretically at least ensures that the changes have been reviewed by at least 1 (or n) other team member(s), which is a great way to both improve code quality and disseminate understanding of the codebase among the whole team.

## Branch Protection Rules in GitHub

To configure these rules in a GitHub-based repository, click on the Settings tab, then choose Branches.

![](/img/image-3-enforce.png)

/settings/branches in a GitHub repository

From here you can choose what the default branch should be. For many projects, a dev branch is the main place that day-to-day work goes on, while master is used only to track code that's gone to production. If you want to follow this approach, you could make dev the default branch, so that by default pull requests would expect to go against it instead of master.

To configure branch protection, click the Add rule button next to Branch protection rules (or click Edit for the branch with the rules you want to modify, if you've already configured some). You should see rule settings similar to this:

![](/img/image-4-enforce.png)

Edit branch protection rule in GitHub

By default, branch protection disables force-pushes to the matching branch. This means you can't push to them directly - you have to make a pull request and then merge/rebase that into the branch. You also can't delete the branch.

The request reviews section has some additional options:

![](/img/image-6-enforce.png)

Require pull request reviews options.

This lets you specify how many reviews are required, and optionally you can require re-review if additional commits are added after an initial approval is given. You can also identify some code files as having a designated code owner, who must review any changes that would impact these files (so not just any team member can approve a change).

Status checks are how GitHub refers to build success/failure from continuous integration servers. You can require the status check be successful before a pull request can be merged. You can further require that the PR's branch be up-to-date, since otherwise your build isn't really testing what the code will look like once it's merged, but rather an out-of-date version of the code. Setting up status checks between your build server and your GitHub repository should be pretty straightforward. [If you're using TeamCity, I have an article from a few years ago showing how to do this.](https://ardalis.com/4-tips-to-integrate-teamcity-and-github)

Once you have builds running and reporting their status back to GitHub, they should appear in the list of "Status checks found in the last week for this repository". Check the one(s) that you want to require.

The last two options can further protect your branch. You can require signed commits, which requires verified signatures on commits pushed to the branch. I haven't used this option. And you can enforce all of these rules on administrators in addition to everyone else. I usually check this. If you're an administrator and you need to do something that this policy is blocking, it should at least make you think twice before doing it. If you need to, you can always disable this rule, perform the action (such as a direct commit to master), and then enable the rule again.
