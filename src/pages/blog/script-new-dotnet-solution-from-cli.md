---
templateKey: blog-post
title: How to Create a new Solution and Projects using dotnet CLI
date: 2021-08-17
description: I create a lot of samples, demos, open source projects, etc. and I like to use the fairly standard repository layout of having a solution file in the root and project files in a src subfolder. Achieving this in Visual Studio is tedious, but fortunately this series of dotnet CLI commands quickly create the structure for you.
path: blog-post
featuredpost: false
featuredimage: /img/create-new-solution-and-projects-using-dotnet-cli.png
tags:
  - dotnet
  - .NET
  - visual studio
category:
  - Software Development
  - Productivity
comments: true
share: true
---

I create a lot of samples, demos, open source projects, etc. and I like to use the fairly standard repository layout of having a solution file in the root and project files in a src subfolder. Achieving this in Visual Studio is tedious, but fortunately this series of dotnet CLI commands quickly create the structure for you.

This script uses the following commands, which have good documentation online. You can also type in the command followed by `-h` (or `--help`) in your terminal to see a summary of its usage and supported arguments.

- [dotnet new](https://docs.microsoft.com/dotnet/core/tools/dotnet-new)
- [dotnet sln](https://docs.microsoft.com/dotnet/core/tools/dotnet-sln)

When I'm creating a new project, I usually create the remote git repo (on GitHub for most of my open source stuff, or possibly in Azure DevOps for other things) first. Once it's created, I clone it locally and open up a terminal window in that local folder.

Most of my .NET source code repositories have a single solution in them. I adjust these steps a bit for those that have more than one, usually with top level sub-folders per solution and then the same structure under that as I typically put in the root. So a distributed system might have `/AppA` and `/AppB` in the root, but within each of those there would be a solution file and folders for `src` etc. as described below.

A typical file/folder structure for the root of a .NET project will have the following in it:

- `src` folder, where the actual real source code is located
- `tests` folder, where unit, integration, and other tests are located
- `CompanyName.ApplicationName.sln` solution file, for use with Visual Studio (et al)

Unfortunately, I've found it to be tedious to get Visual Studio to create a new solution for me using this structure. So, for real applications that I want to use a clean architecture approach with ASP.NET Core, I use my [Clean Architecture solution template](https://github.com/ardalis/CleanArchitecture) and just create the whole starting project with `dotnet new clean-arch`. This saves a ton of tedious work and gives me a great starting point for ASP.NET Core apps that value loose coupling, testability, and possibly [domain-driven design patterns](https://www.pluralsight.com/courses/fundamentals-domain-driven-design).

However, that [solution template](https://www.nuget.org/packages/Ardalis.CleanArchitecture.Template/) is overkill for smaller samples and apps. So for those I just use this script, changing the names as needed, from the root of the git repository I've cloned locally:

```powershell
dotnet new sln
mkdir src

dotnet new console -o src/Sample.Console
dotnet sln add src/Sample.Console/Sample.Console.csproj
```

The first step creates a new, empty solution. By default it will have the same name as the folder you're in, which usually maps to your git repo name. If you want to specify the name just add `-n {NAME}` to that command.

The second step is to create the `src` subfolder. You can add additional folders here as well if you like (e.g. `tests`).

The next two steps you should repeat as needed for each project you wish to create and add to your solution. The name for each project will match the folder name you specify with the -o argument.

After running the above script the folder structure will look like this:

![folder structure screenshot](img/dotnet-new-sln-folder-structure.png)

Of course, once you have a script like this, you can easily make a parameterized script out of it if you have many common solutions you produce, or just bookmark this blog and copy/paste it into a text editor each time you need it, changing the project names as required.

If you found this helpful, consider sharing it with a friend! Thanks!
