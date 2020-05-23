---
templateKey: blog-post
title: Nuget Publication Checklist
date: 2019-01-24
path: /nuget-publication-checklist
featuredpost: false
featuredimage: /img/nuget-package-publication-checklist.png
tags:
  - checklist
  - nuget
  - nuget package
category:
  - Software Development
comments: true
share: true
---

I have a few Nuget packages that I maintain, and when I get a new PR or add a new feature or bugfix, I like to try and get the change out quickly. Unfortunately, this is a somewhat manual process for me currently, and I don't do it all that often, so I screw it up a high percentage of the time. Or I end up putting it off because it's not something I can just click a button to perform.

This post serves to document the steps I need to take when making an update to an open-source project that has an associated Nuget package. I'll update it as necessary to suit my needs, and hopefully others will find it useful as well. Eventually I'll try to automate it, but for now a manual, error-prone process is improved by a standardized process with a checklist, which in turn is improved by a scripted version of the same process.

I'm trying this out as I write this using my [GuardClauses](https://github.com/ardalis/GuardClauses) project. The steps should be pretty much the same for [SmartEnum](https://github.com/ardalis/SmartEnum) or any of my other open source projects that are [published as NuGet packages](https://www.nuget.org/packages?q=ardalis).

1. Clone the repository and/or get latest on master.
2. Build the solution and run all unit tests.
3. Update project csproj file with incremented version number and release notes (e.g. `1.2.5`)
4. Open a terminal window in the project's folder.
5. Run `dotnet pack -c release /p:Version=1.2.5` 
6. Navigate to the `/bin/release` folder.
7. Go to NuGet.org in a browser and get publication key - copy it to clipboard. [![NuGet API Keys](/img/nuget-api-keys.png)](/img/nuget-api-keys.png)
8. In terminal, run `dotnet nuget push -s https://www.nuget.org/api/v2/package -k [key] Ardalis.GuardClauses.1.2.5.nupkg` It will likely take several minutes for the new package to appear in nuget.
9. Tag the current commit in git using `git tag -a 1.2.5 -m 'Published 1.2.5 to nuget.org'`
10. Push the tag to GitHub using `git push --follow-tags`
11. This should automatically produce [a new Release on GitHub](https://github.com/ardalis/GuardClauses/releases) as well.

That should do it. You can also blog/tweet about the new release so people know about it.
