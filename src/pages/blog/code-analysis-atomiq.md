---
templateKey: blog-post
title: Code Analysis Using Atomiq
date: 2011-03-08
path: blog-post
description: Code analysis is one way you can keep your code clean and your technical debt low. One of the simplest ways to achieve this is to minimize blocks of duplicate code, usually the result of cut-and-paste coding. Atomiq is an inexpensive, simple-to-use tool that detects duplicate blocks of code, making it easy to apply refactorings to eliminate the duplication.
featuredpost: false
featuredimage: /img/atomiq.png
tags:
  - analytics
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

Atomiq is a code analysis tool that quickly locates duplicate code within software applications by analyzing the source code.  It works at the source, not binary, level, and so can be applied to applications written in a variety of languages.  Although it doesn't support auto-correction or refactoring within the application, it can quickly locate problems which can then be addressed through your standard code editor of choice.

## Getting Started With Atomiq

You can [download Atomiq from GetAtomiq.com](http://getatomiq.com/). There's currently a 7-day free trial.  For this article, I'm using version 1.0.26.87.  A Pro license of Atomiq is just $30, or you can get a Console Edition (for use as part of an automated build process) for just under $100.

Once you have the application, it's just an EXE that you can run from anywhere.  The first time you run it, you'll want to create a New Project.

This will bring up the Analysis Options window.  Assuming you're working with a C# application, you simply need to pick the folder for the root of your source tree.  If you're using a different programming language, choose the standard file type extension from the dropdown list.  You can adjust how strict Atomiq is about finding duplicate lines of code by sliding the Min Similarity Length picker - the default is 6 lines of similar code to be considered as a duplicate block.  You can add your own regular expressions to exclude any files that are auto-generated or otherwise will clutter your results.

For this example, I'm going to point Atomiq at a small open-source project that provides an [ASP.NET Control Panel for MVC or Web Forms applications called Isis](http://isis.codeplex.com/).  You can grab the latest version of Isis from source if you wish - the version I'm running this against is [Change Set 9bad56eb44d5](http://isis.codeplex.com/SourceControl/changeset/changes/9bad56eb44d5).  Since it's a relatively small project, Atomiq doesn't find too much duplicate code in it, but it does find some.

Overall there are 3 blocks of duplicate code, in 3 files, with a total of 24 lines (8 lines each, it turns out).  You can navigate through the files that have duplication using the Files treeview.

Once you select a file, you can see all of the duplicate code blocks within that file.  Selecting an individual block will display the code, as well as where the similar code exists and what that code looks like in the other files.

In this case, there are several properties of these three Controller classes that seem to be common.  It looks like the simplest refactoring to correct the issue and remove the duplication would be to pull the members up into a base class.  Since the classes already implement a common interface, I simply created an abstract base class that implements the interface and pulled the common, default implementations in as virtual methods, and left the bits that need to change between each controller as abstract methods:

```csharp
public abstract class ControllerBase : IControlPanelController
{
    public abstract void Render(TextWriter writer);

    public abstract ControllerTab Tab { get; }

    public virtual string Action { get; set; }

    public virtual string Parameter { get; set; }

    public virtual IEnumerable<string> SubTabs
    {
        get { return new string[0]; }
    }
}
```

Then it's a simple matter to change each of the three controllers to inherit from `ControllerBase` rather than `IControlPanelController`.

After only changing the `ApplicationController`, re-running Atomiq yields a new result.

Refactoring the `HomePageController` and `TraceController` similarly results in a clean bill of health from Atomiq.  The resulting code is checked in as [changeset 7be186e3264f](http://isis.codeplex.com/SourceControl/changeset/changes/7be186e3264f).

Another cool feature of Atomiq's that doesn't demo well on such a small project is the WheelView.  If you point Atomiq at a larger project like [NServiceBus](http://nservicebus.com/), you can generate the WheelView.

With the WheelView, different folders are color-coded and ring the outside of the circle, with subfolders closer in and individual files closest to the center.  The lines running through the middle of the wheel are duplicate blocks of code.  Those that pass between files are multi-colored, with the tips being the colors of the files at the opposite end.  Those that are within the same file are single-color, and don't pass through the center.  In any case, you want to strive for a WheelView that you can see through.  If you point this at your code and the center is completely covered with lines criss-crossing everywhere, you probably have some technical debt to deal with.  Give it a shot - the demo is fully functional and is just an xcopy-able EXE.  Point it at your current project and see how much duplication it uncovers.  Feel free to post your "high score" number of duplicate lines/blocks/files.

## Summary

The [Don't Repeat Yourself Principle](https://deviq.com/principles/dont-repeat-yourself) is one of the fundamentals of object oriented software development.  Using [Atomiq](http://getatomiq.com/), you can quickly locate copy-paste-code (one of the [Practices of Mediocre Programming](https://ardalis.com/principles-patterns-and-practices-of-mediocre-programming/)) and correct it by refactoring the code using proper abstractions.  Learn more about the [Principles of Object Oriented Design](https://www.pluralsight.com/courses/principles-oo-design) with Pluralsight On Demand training.

Originally published on [ASPAlliance.com](http://aspalliance.com/2048_Code_Analysis_Using_Atomiq)
