---
templateKey: blog-post
title: GitHub Draft Pull Requests
path: /github-draft-pull-requests
date: 2020-03-25
featuredpost: false
featuredimage: /img/github-draft-pull-requests-760x360.png
tags:
  - git
  - GitHub
  - pull requests
category:
  - Productivity
  - Software Development
comments: true
share: true
---
A feature [introduced last month](https://github.blog/2019-02-14-introducing-draft-pull-requests/) by the GitHub team is called draft pull requests. When you create a Draft Pull Request, it cannot be merged until it is marked as ready for review. This is useful because often pull requests are used as conversations, often prior to the work being ready to merge. Common approaches to this in the past have included such classic approaches as:

* Adding “WIP” for “Work in Progress” to the PR title
* Adding “DO NOT MERGE” to the title (or description, tag, etc.)

In some cases, whole bot-based workflows were set up to look for things like “WIP” in PR names and to take actions like marking the PR as not approved until the label was removed or updated.

Draft pull requests essentially do away with the need for such hacks. Now when you create a pull request, you have the option (via the dropdown button) to create a draft pull request instead:

![Creating a draft pull request.](/img/pull-request.png)

Creating a draft pull request

After creating the pull request, it’s marked as Draft (1) and cannot be merged until the “Ready for review” button (2) is clicked. After which the merge button (3) will be enabled.

![](/img/connection-string-name.png)

So that’s it! One other benefit of draft pull requests is that if you have a [CODEOWNERS file in your repo](https://github.blog/2017-07-06-introducing-code-owners/), they won’t receive notifications about the PR until it is marked as ready to review.

If you found this useful, you may want to [sign up for my weekly dev tips newsletter](https://ardalis.com/tips), or you might be nice and tell your friends about this article via your social media platform of choice. Thanks!