---
templateKey: blog-post
title: Roslynator for VS 2017
path: blog-post
date: 2017-08-15T21:45:00.000Z
description: Visual Studio 2017 15.3 was released this week, with support for
  .NET Core 2.0. Over the years, Visual Studio has added more and more tools to
  increase productivity, slowly catching up to extensions like Resharper.
featuredpost: false
featuredimage: /img/roslynator.png
tags:
  - visual studio
category:
  - Software Development
comments: true
share: true
---
[Visual Studio 2017 15.3](https://www.visualstudio.com/) was released this week, with support for .NET Core 2.0 (also released – [download separately here](https://www.microsoft.com/net/download/core)). Over the years, Visual Studio has added more and more tools to increase productivity, slowly catching up to extensions like [Resharper](https://www.jetbrains.com/resharper/). With the availability of Roslyn, it’s never been easier to create your own custom code analyzers and refactorings. [Roslynator](https://github.com/JosefPihrt/Roslynator)is an open source collection of over 180 analyzers and over 180 refactorings, as well as code fixes, which you can install as a Visual Studio extension:

![](/img/roslynator.png)

Once installed, Roslynator’s analyzers will run any time you’re looking at code in your editor. Any recommendations these analyzers find are surfaced using the familiar light bulb icon:

![](/img/lightbulb-refactor.png)

In the above example, the first group of refactoring options displayed come from Roslynator. You’ll notice that Visual Studio now ships with some similar ones (though for some reason they don’t follow the standard naming convention for private fields, choosing “someService” instead of “_someService”). As Visual Studio continues to add additional native functionality, you can tune Roslynator so you only get the analyzers and fixes you prefer. Doing so is simple either from Visual Studio options (for just your machine) or with the addition of configuration files (that are committed to the project’s source control) so your preferences persist with the project.

It’s worth understanding the difference between analyzers and refactorings. An analyzer represents a general coding rule or style guideline. Violations of this rule are referred to as diagnostics, and are displayed in the Error List in Visual Studio and as squiggles in the IDE. Often, analyzers will have associated code fixes that can be applied to diagnostics. Analyzers, diagnostics, and code fixes all go together. A refactoring is an operation that can be performed on a given span of text/code. To see available refactorings, highlight a keyword or block of code and use Ctrl+. (or alt+Enter).

Since Roslynator is open source, you can contribute to it and/or use it as an example of how to write your own analyzers, code fixes, and refactorings. A recent addition provides a warning when an overridden method’s parameter’s name doesn’t match the name of the method being overridden:

![](/img/parameter-name-differs.png)

This analyzer includes a code fix, which you can preview before applying:

![](/img/codefix-builder-modelbuilder.png)

Roslynator diagnostics like this one also appear in the Error List, with unique error codes to help you identify where they originated and to learn more about the rule that was violated:

![](/img/roslynator-error-list.png)

If you haven’t checked out Roslynator yet, you might give it a shot and see what you think.