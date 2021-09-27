---
templateKey: blog-post
title: GitHub Actions On Demand
path: blog-post
date: 2021-09-27
description: You can configure certain GitHub actions so that they can be triggered on demand, not just when a commit is added or merged.
featuredpost: false
featuredimage: /img/github-actions-on-demand.png
tags:
  - github
  - continuous integration
  - actions
  - github actions
category:
  - Software Development
comments: true
share: true
---

I use GitHub Actions a lot. They're a great tool for performing continuous integration (CI) and continuous deployment (CD) for your applications. However, by default they typically only are triggered by changes to your application's source code in the form of commits and/or merges/rebases. This means that to trigger a particular workflow, you usually need to make a commit, and obviously this can be a hassle in a number of situations.

Fortunately, GitHub supports triggering GitHub Actions on demand. To trigger any GitHub Action on demand, you simply need to add a keyword to its YML file, called `workflow_dispatch`. Personally, I have a hard time remembering the term "workflow dispatch", which is why I usually end up searching for "on demand" and not immediately finding anything. I'm actually publishing this just so that I can google "ardalis github actions on demand" and find this next time I need it. :)

The [documentation for GitHub Actions' "workflow dispatch" trigger show how to create a manually triggered workflow](https://docs.github.com/en/actions/learn-github-actions/events-that-trigger-workflows#workflow_dispatch). However, they don't show how you add a `workflow_dispatch` trigger to a GitHub action that already has other triggers, which may not be obvious.

I've figured this out with some of my various [Ardalis NuGet Packages](https://www.nuget.org/profiles/ardalis), so here is an example from my most popular NuGet Package, [Ardalis.GuardClauses](https://www.nuget.org/packages/Ardalis.GuardClauses):

```yaml
name: .NET Core

on:
  workflow_dispatch:
    branches: [ main ]
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:

    runs-on: windows-latest

    steps:
    - uses: actions/checkout@v2
    - name: Setup .NET Core
      uses: actions/setup-dotnet@v1
      with:
        dotnet-version: 3.1.402
    - name: Install dependencies
      run: dotnet restore
    - name: Build
      run: dotnet build --configuration Release --no-restore
    - name: Test
      run: dotnet test --no-restore --verbosity normal
```

You'll find the [latest full GitHub action for GuardClauses here](https://github.com/ardalis/GuardClauses/blob/main/.github/workflows/build.yml). While you're there, be sure to add a ⭐ to the repo! Thanks!

## Workflow Dispatch and On Demand GitHub Actions

If you have multiple triggers, you can just add `workflow_dispatch` to the list in the YAML file. This will let you trigger the workflow manually. What does that look like? You just go to the actions tab, choose the workflow, and you should see an option to "Run workflow". You can further choose which branch to run it against, if you like.

![GitHub Actions Run Workflow Screenshot](/img/github-actions-on-demand-ui-screenshot.png)

That's all you need to be able to run your actions any time you like, without the need to add bogus commits!
