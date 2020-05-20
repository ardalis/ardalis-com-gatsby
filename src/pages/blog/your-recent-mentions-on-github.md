---
templateKey: blog-post
title: Your Recent Mentions on GitHub
path: blog-post
date: 2016-09-26T05:07:00.000Z
description: The other day I saw someone mention me in a pull request for a
  client’s GitHub repository (probably on my phone).
featuredpost: false
featuredimage: /img/octocat.png
tags:
  - GitHub
  - tip
category:
  - Software Development
comments: true
share: true
---
The other day I saw someone mention me in a pull request for a client’s GitHub repository (probably on my phone). When I had some time to look into the issue, I’d deleted the email notification, and I couldn’t remember which repository it was on (they have a few). So I checked my GitHub profile page, figuring it would show things that recently mentioned me. Unfortunately, not. I posted to twitter asking about it, and [Shayne Boyer](https://twitter.com/spboyer) sent me a link to a custom search that does the trick:

<blockquote class="twitter-tweet" data-lang="en">
<p lang="en" dir="ltr"><a href="https://twitter.com/ardalis">@ardalis</a> <a href="https://twitter.com/github">@github</a> here is yours: <a href="https://t.co/zi5KIaxcwo">https://t.co/zi5KIaxcwo</a></p>
— Shayne Boyer (@spboyer) <a href="https://twitter.com/spboyer/status/779417587893604352">September 23, 2016</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8" async=""></script>

Basically, if you [go to this GitHub search page](https://github.com/search?utf8=%E2%9C%93&q=mentions%3Aardalis&type=Issues) you can see all issues (which includes pull requests) that mention you (just replace ardalis with your own username).

Hit that search as an anonymous user (or someone without rights to view certain repositories), and you’ll see only public mentions (or mentions on repos you have access to). Hit it while you’re logged in and searching for yourself, and you’ll see all of the issues and pull requests that mention you across all repositories, public and private, to which you have access.

If you need to further filter the results, perhaps to only show non-work (or work) mentions, you can specify a single repo by adding this to the search:

`repo:aspnet/docs`

Or you can filter out a repo with:

`-repo:aspnet/docs`

Thanks to Brendan Thomas for this last tip.

Of course, once you have a search that works for you, you can bookmark the URL and return to it whenever you like.