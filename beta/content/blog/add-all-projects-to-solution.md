---
title: Add All Projects to Solution with dotnet CLI
date: "2022-12-15T00:00:00.0000000"
description: If you need to just create a new solution file with all projects in all subfolders in it, this should work for you.
featuredImage: /img/add-all-projects-to-solution.png
---

If you need to just create a new solution file with all projects in all subfolders in it, this should work for you.

## Scenario

For whatever reason, you'd like to quickly create a Visual Studio solution file that includes all of the Visual Studio (dotnet) projects in any subfolder. In my case, sometimes I've needed to do this in order to easily be able to calculate code metrics on the total of a GitHub repository or set of samples. You may just want to be able to see *all* of the projects in one place. It can be tedious to locate and add every csproj file in every subfolder by hand, especially in a codebase you're not familiar with.

[YouTube: Add All Projects in Git Repo to Solution (and analyze them)](https://www.youtube.com/watch?v=NTRzU8to4j4)

## The dotnet sln Command

It may surprise you to learn that you can create.NET solution files from the command line. The syntax is pretty straightforward:

```powershell
dotnet new sln -n Everything
```

In the above, the `-n` flag allows you to specify the name; otherwise it will use the current foldername as a default. In my case since I wanted every project in it, I just named it *Everything*. The result of this command is an empty solution file named *Everything.sln*.

Next you just need to add all of the project files. Unfortunately there's no built-in way to do that with the `dotnet sln` command, but you can easily script it. This should work from Powershell or a linux shell:

```powershell
dotnet sln add (ls -r **/*.csproj)
```

This will recursively find `.csproj` files in any subfolder and will add them to the solution using the `dotnet sln add` command. With just these two commands you can easily add many Visual Studio projects to a solution file without manually adding them.

## Troubleshooting

If you already have a solution file in the folder where you're running this, you just need to specify your solution file's name in the command. So if your solution file is named *Everything.sln* you'd run this:

```powershell
dotnet sln./Everything.sln add (ls -r **/*.csproj)
```

## References

- [Stack Overflow - How to add all projects to a single solution file](https://stackoverflow.com/q/52017316/13729)

