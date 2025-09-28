---
title: Introducing Spectre.Console
date: "2022-10-19T00:00:00.0000000"
description: Spectre.Console is a dotnet library for making beautiful, more useful console applications.
featuredImage: /img/introducing-spectre-console.png
---

Spectre.Console is a dotnet library for making beautiful, more useful console applications. Here's a quick introduction to getting started with it.

If you'd rather watch a video, I've recorded a quick video for [NimblePros' YouTube channel](https://youtube.com/nimblepros/):

[YouTube: Introducing Spectre.Console](https://www.youtube.com/watch?v=rXJ2p2Am_0I)

## Getting Started

The quickest way to get started with Spectre.Console is to add it to a new console application. You can follow these steps in a console window right now:

```powershell
dotnet new console -n SpectreConsole
cd SpectreConsole
dotnet add package Spectre.Console
dotnet watch run
```

Now open up Program.cs in an editor and replace its contents with this:

```csharp
using Spectre.Console;

Console.WriteLine("Hello, World!");
AnsiConsole.Markup("[underline red] Hello [/] [bold green] World [/]!");
```

Save the file and you should see output like this in your terminal window:

![spectre console hello world output](/img/spectre-console-hello-world.png)

Notice that the second"Hello World" is now in Red and Green.

## Running the Examples

Another cool tool that Spectre Console uses is a library called [dotnet example](https://github.com/patriksvensson/dotnet-example), which can be used by any project to make it easier to demo. The tool looks in the"examples" or"samples" folder for any csproj or fsproj files and provides an easy way to list and run these from the console.

For Spectre Console, you just need to install the tool and then run it:

```powershell
dotnet tool install -g dotnet-example
```

Then pull down the [repo for Spectre Console](https://github.com/spectreconsole/spectre.console) and run the following in that repo's root folder:

```powershell
dotnet tool restore
dotnet example
```

This will show you all of the examples, like this:

![console listing spectre.console examples](/img/spectre-console-examples.png)

Here's what Spectre Console's Status update feature looks like:

![animated gif showing status updates streaming to console](/img/spectre-status.gif)

Another nice feature that virtually every console application could benefit from is better exception styling:

![console listing spectre.console exceptions](/img/spectre-console-exceptions.png)

## Next steps

This is one of those utilities that everyone should know about and consider using in their console apps (at least the ones that aren't throwaway). If you have a standard template you use for console applications, you might want to add this library to it. If you don't, you might want to consider creating one.

If you have a favorite feature of Spectre.Console that I didn't demo here, please share it in the comments below.

