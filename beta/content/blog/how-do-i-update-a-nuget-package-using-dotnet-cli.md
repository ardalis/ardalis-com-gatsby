---
title: How do I Update a Nuget Package using dotnet CLI
date: "2017-05-24T22:23:00.0000000-04:00"
description: "The current version of the dotnet command line interface provides features to add a nuget package, but doesn't expose a separate command to update them. However, you can actually achieve this by simply running the dotnet add package command, for example:"
featuredImage: /img/nuget.png
---

The current version of the dotnet command line interface provides features to [add a nuget package](http://ardalis.com/how-to-add-a-nuget-package-using-dotnet-add), but doesn't expose a separate command to update them. However, you can actually achieve this by simply running the dotnet add package command, for example:

`dotnet add package Microsoft.AspNetCore`

If you don't provide a version flag, this will default to upgrading to the latest version. To specify a version, add the -v parameter:

`dotnet add package Microsoft.AspNetCore -v 1.0.2`

Here you can see a sample project with an older version of AspNetCore shown in Visual Studio's Nuget Package Manager:

![](/img/nuget-updates-available.png)

Run the command in Powershell:

![](/img/dotnet-add-package.png)

The result is the updated version in the project.

![](/img/nuget-installed-packages.png)

Currently there isn't a command to browse, search, or list packages from the dotnet CLI. However, this is coming in version 2.0.

