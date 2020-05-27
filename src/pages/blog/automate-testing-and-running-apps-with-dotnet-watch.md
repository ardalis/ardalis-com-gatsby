---
templateKey: blog-post
title: Automate Testing and Running Apps with dotnet watch
path: blog-post
date: 2017-06-14T02:09:00.000Z
description: If you’re using the dotnet CLI tools to develop your .NET Core
  apps, you’re probably very familiar with typing dotnet run and/or dotnet test
  every time you make a change to your app.
featuredpost: false
featuredimage: /img/bitmap-medium_net-core-logo_2colors_square_boxed_rgb.png
tags:
  - .net core
  - dotnet
  - tip
category:
  - Software Development
comments: true
share: true
---
If you’re using the dotnet CLI tools to develop your .NET Core apps, you’re probably very familiar with typing dotnet run and/or dotnet test every time you make a change to your app. This kind of manual process, even if you’re a quick typist (or just use up-arrow, enter), can add friction to your process. Friction is bad, and can bring you out of the zone when you’re trying to focus on improving your app and what it does. One way you can eliminate this friction is to have your app automatically restart or run its tests whenever a change is made to it. You can use the **dotnet watch** tool for exactly this purpose.

Here’s a screenshot of what things look like when you have dotnet watch running your unit tests (click for larger image if necessary):

![](/img/dotnet-watch-test.png)

**In step 1**, I’m just running the tests as I normally would to confirm they work as expected. Note there is only 1 test and it is passing (this is just a new instance of the dotnet new xunit project template).

**In step 2**, I execute dotnet watch test, which runs the test(s) again and begins watching for changes.

**In step 3**, I’ve just created a second (failing) test and saved my test file. You can see that this triggers dotnet test to run again, building the project and once more running the tests, including the new failing test.

## Configuring dotnet watch in your Project

To use dotnet watch, you need to add a reference to the tool to the project you’re using it with. This is done by editing the csproj file and adding a new section:

```
<ItemGroup>
  <DotNetCliToolReference Include="Microsoft.DotNet.Watcher.Tools" Version="1.0.1" />
</ItemGroup> 
```

Once you’ve added this and performed a restore, you should be able to use dotnet watch with standard dotnet commands. The two most common commands you’ll use it with are **run** and **test**, to support automatically re-running the app or automatically re-running tests on the app. You can use the usual supported arguments with these commands, too. For more info, check out this article in the [docs](https://docs.microsoft.com/en-us/aspnet/core/tutorials/dotnet-watch).

Remember, **duplication in logic calls for abstraction, but duplication in process calls for automation**. This is another example of where you can apply the [Don’t Repeat Yourself principle](http://deviq.com/don-t-repeat-yourself/) to your code.

## Try It Yourself

Follow these steps to get dotnet watch working in a test project:

1. Make sure you have the .NET Core SDK installed, and a text editor.
2. Open a cmd, terminal, or PowerShell window.
3. Create and navigate to a new folder.
4. Run **dotnet new xunit** to create a new test project.
5. Open the .csproj file that was created (I use VS Code) and add the <ItemGroup> section shown above just before the closing </Project> tag.
6. Run **dotnet restore**.
7. Run **dotnet test**. You should see one test pass.
8. Run **dotnet watch test**. You should see output similar to the screenshot above.
9. Add a new test or change the existing test. Save your changes. You should see the tests execute again in your window.
10. Tip: [Change the title of your cmd or PowerShell window](http://ardalis.com/set-cmd-or-powershell-window-title) so you know it’s your test/app runner and you don’t accidentally close it.