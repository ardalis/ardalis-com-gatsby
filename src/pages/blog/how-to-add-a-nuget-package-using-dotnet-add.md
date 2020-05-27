---
templateKey: blog-post
title: How to add a Nuget Package Using dotnet add
path: blog-post
date: 2017-02-01T04:01:00.000Z
description: "A feature I’ve long wished for in .NET Core and its command line
  interface (CLI) is the ability to manage nuget references from the command
  line. "
featuredpost: false
featuredimage: /img/nuget.png
tags:
  - .net core
  - nuget
category:
  - Software Development
comments: true
share: true
---
A feature I’ve long wished for in .NET Core and its command line interface (CLI) is the ability to manage nuget references from the command line. This becomes increasingly important as the final version of the tooling for .NET Core (and [Visual Studio 2017](https://www.visualstudio.com/vs/visual-studio-2017-rc/)) moves from a JSON-based project file to an XML-based one (for compatibility with the hundreds of other projects Visual Studio supports in that format). Adding references to project.json wasn’t too bad, but it’s ever-so-slightly more painful to do in XML, and I’ve grown increasingly fond of using the dotnet CLI, especially when I’m working with Visual Studio Code (and sometimes on macOS).

To check if you have the dotnet CLI installed correctly ([get it here](https://github.com/dotnet/cli)), run these commands in a new folder:

`dotnet new console dotnet restore
dotnet build
dotnet run`

**Update (June 2017)**: Previous versions of dotnet new defaulted to the console template (as shown in the screenshot below). Current versions require you to specify it (as noted above).

**Sample output:**

1. ![](/img/dotnet-cli.png)

   As of the latest release candidate of Visual Studio 2017 (or the latest SDK install of .NET Core), you can now use dotnet add to add packages and/or references to a project. You can view the built-in help by running these commands:

   `dotnet add --help `\
   `dotnet add package --help
   dotnet add reference --help`

   **Sample output:**

   ![](/img/dotnet-add-cli.png)

   For example, if you want to add Entity Framework 6.1 to your .NET Core app, you would run this command (yes, you can use EF 6 from .NET Core!):

   `dotnet add package EntityFramework`

   Alas, there’s no statement completion for the package name when you type it into the CLI. Sample output:

   ![](/img/dotnet-add-ef.png)

   Having access to the CLI makes it much easier to write setup scripts, or to quickly add common packages to projects where you know the package name and can type reasonably quickly. If the command line isn’t your thing, don’t worry, you still have a bunch of other ways to work with packages, including editing the project file directly and using the GUI tools in VS2017 (or the built-in Package Manager Console there, and its PowerShell cmdlets).