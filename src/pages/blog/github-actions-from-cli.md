---
templateKey: blog-post
title: GitHub Actions from CLI
path: blog-post
date: 2020-11-11T09:20:00.000Z
description: If you're going to be using GitHub actions a lot, it may be worthwhile to create reusable templates you can create from the dotnet command line interface.
featuredpost: false
featuredimage: /img/generate-github-actions-from-dotnet-new-templates.png
tags:
  - github
  - continuous integration
  - actions
  - dotnet
  - cli
category:
  - Software Development
comments: true
share: true
---

Tim Heuer recently published [an article showing how to create your own dotnet CLI templates for generating GitHub action YAML files](https://timheuer.com/blog/generate-github-actions-workflow-from-cli/). I thought I'd give it a try and see how it worked, so here's my experience with it. It works by adding a template to the list of available templates used with the `dotnet new` command.

## Install the template

To install custom templates, you run this command and specify a NuGet-hosted package, in this case [TimHeuer.GitHubActions.Templates](https://www.nuget.org/packages/TimHeuer.GitHubActions.Templates/):

```powershell
dotnet new --install TimHeuer.GitHubActions.Templates
```

Tim's GitHubActions package is [open source and available on GitHub](https://github.com/timheuer/dotnet-workflow) if you want to modify it or use it as an example for your own template.

Once you've installed the tool, you can view a list of all installed templates you have for `dotnet new` by running `dotnet new -l`:

![dotnet new list](/img/dotnet-new-list.png)

## Using the template

To use the template, you reference its short name, `workflow`:

```powershell
dotnet new workflow
```

The default generates a default .NET Core workflow. You can customize its name, SDK version, and branch name like this:

```powershell
dotnet new workflow --sdk-version 5.0.100 -n publish -b main
```

This will produce a YAML file named `publish.yaml` which will trigger on the `main` branch and will build using .NET 5 (5.0.100 specifically).

Be sure to run the command from the root of your git/GitHub repository. It will put the resulting file in a `.github/workflows` folder, as you can see here:

![dotnet new workflow](/img/dotnet-new-workflow.png)

## How does it work?

If you're interested in seeing how the template works, [have a look at the source](https://github.com/timheuer/dotnet-workflow/tree/main/src). There's a `template.json` file that specifies metadata that appears in the `dotnet new -list` command. It also includes descriptions of the arguments that can be provided to the command, which are also referenced from the `dotnetcli.host.json` file.

For more info on how to create your own `dotnet new` templates, read the docs on [custom templates for dotnet new](https://docs.microsoft.com/en-us/dotnet/core/tools/custom-templates).
