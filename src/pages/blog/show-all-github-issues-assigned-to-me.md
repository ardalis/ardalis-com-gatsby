---
templateKey: blog-post
title: Show All GitHub Issues Assigned to Me
path: blog-post
date: 2017-07-04T22:08:00.000Z
description: I’m a big fan of GitHub and the workflow it provides. I find it to
  be very productive and collaborative, as well as lightweight. I work on quite
  a few different GitHub repositories, either for my own projects, for open
  source projects, or for clients.
featuredpost: false
featuredimage: /img/octocat.png
tags:
  - git
  - GitHub
  - tip
category:
  - Software Development
comments: true
share: true
---
I’m a big fan of GitHub and the workflow it provides. I find it to be very productive and collaborative, as well as lightweight. I work on quite a few different GitHub repositories, either for my own projects, for open source projects, or for clients. It’s especially helpful in any project with more than a few issues to be able to view just the issues that pertain to me. That might be issues I’ve authored, or issues that are assigned to me. Let’s look at the [ASP.NET Core documentation GitHub repo issue list](https://github.com/aspnet/Docs/issues) for a couple of examples.

Modify the filter on the list of issues as follows:

```

```

You can also save a [link to this filter showing all GitHub repositories issues authored by you](https://github.com/aspnet/Docs/issues/created_by/ardalis). Currently it results in the following, showing two open issues created by me:

![](/img/github-docs-issues-created.png)

Now modify the filter list again to list all issues assigned to a particular user:

```
is:open is:issue assignee:ardalis
```

You can save a[link to all GitHub repository issues assigned to you](https://github.com/aspnet/Docs/issues/assigned/ardalis), too, if you like. Here’s a screenshot showing the current list of issues assigned to me:

![](/img/github-docs-issues-assigned.png)

Note that both of the above links are completely public. You can see in the screenshots that I’m not logged into GitHub, and they still work just fine. They’re useful in their own right, but sometimes you want to see all of the issues that are assigned to you, across all repositories. For that, you can use the following link (assuming you’re logged into GitHub):

https://github.com/issues/assigned

You’ll get a 404 if you try to go to this URL anonymously, but once you’re logged in, you should see something like this:

![](/img/github-all-assigned-issues.png)

You can use the Visibility tab to constrain this listing to only show Public or Private repositories (the screenshot above is only showing Public ones – notice the ‘is:public’ string in the search textbox). Of course, you can also use this same URL scheme to view issues created by you or in which you’re mentioned:

* [Show Me All GitHub Issues I’ve Created](https://github.com/issues)
* [Show Me All GitHub Issues Assigned To Me](https://github.com/issues/assigned)
* [Show Me All GitHub Issues Mentioning Me](https://github.com/issues/mentioned)

Hope that helps! If you have any related tricks you use to organize your use of GitHub, please share them below in the comments.

Thanks to [Kevin Jones for reminding me of these last week](https://twitter.com/vcsjones/status/880096136408829953).