---
title: How to measure elapsed time of command line tools using PowerShell
date: "2021-04-05T00:00:00.0000000"
description: Want to compare how long a command takes to run with different parameters? Curious how long it takes a multi-step build/test script to run, overall? PowerShell has a command for that.
featuredImage: /img/measure-command-line-script-time.png
---

I'm using the command line to run build scripts and other tasks more and more, especially now that.NET Core /.NET 5 has the `dotnet` CLI and things like `docker` and `docker-compose` are in heavy use. When you're running a single command, like `dotnet build` or `dotnet test` it usually tells you about how long it took to run. But when you have a scripted build that involves multiple steps, it's often nice to be able to see how long the whole thing took. Especially if you're trying to optimize it and/or see how it compares on different machines.

That's where PowerShell's `Measure-Command` command comes in. There's a good overview of it [here](https://stackoverflow.com/a/3513669/13729), but for my purposes I'll elaborate below.

First, you can wrap `Measure-Command` around an arbitrary script file, which is what many examples show, like this:

```powershell
Measure-Command {./SomeScript.ps1 }
```

This will run the enclosed script and provide a report on how long it took (in many different units). You can also run arbitrary CLI commdands (like `dotnet build` shown below):

![PowerShell Measure-Command](/img/powershell-measure-command-01.png)

But notice you don't get any output from the command you run. Using a tip from the Stack Overflow answer I linked above, the way to measure the script **and** see its output is to pipe the output to another commandlet that will write to the host.

```powershell
Measure-Command { dotnet build | Out-Default}
```

![PowerShell Measure-Command with output piped to Out-Default](/img/powershell-measure-command-02.png)

With this combination, you can see both the output of the script or command being measured as well as the results. If you want to compare two (or more) runs, be sure to use the *TotalUnits* such as **TotalMilliseconds** since the `Days|Hours|Minutes|Seconds|Millseconds` units are all just individual pieces of the full time elapsed.

