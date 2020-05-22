---
templateKey: blog-post
title: JustCode JustRocks
path: blog-post
date: 2012-10-26T21:22:00.000Z
description: I have been a ReSharper fanboy for a long, long time. I have
  recommended it in user group and conference talks and on my blog.
featuredpost: false
featuredimage: /img/image_thumb_12_keyboard.png
tags:
  - justcode
  - review
  - telerik
category:
  - Software Development
comments: true
share: true
---
I have been a ReSharper fanboy for a long, long time. I have recommended it in user group and conference talks and on my blog. It was one of my favorite tools for a long time, and it remains a great product. However, I’m happy to say with all honesty that I now prefer JustCode. This is fortunate, as I now work for the company that makes JustCode, but I’ve held off on endorsing it (or completely replacing ReSharper in my actual work) until I felt it really met my needs. That day has come. Let me share with you why I’m now a convert.

## Must-Have Refactorings

There are a few refactorings that I use all the time because of the way I write testable, maintainable code (see my online programming course on [SOLID Principles of Object Oriented Design](http://pluralsight.com/training/Courses/TableOfContents?courseName=principles-oo-design)). For instance, I try to follow the [Explicit Dependencies Principle](http://deviq.com/explicit-dependencies-principle), which means that my classes take in the things they need via their constructors (or method parameters). When you’re writing code like this, it’s common to create a constructor, add several parameters (usually interface types), and then assign each parameter to a private readonly field of the same type. You end up with something like this:

![](/img/image_5_cart.png)

## Strategy Pattern

We’re essentially talking about the [Strategy Pattern](http://deviq.com/most-popular-patterns/strategy-design-pattern), or Dependency Injection here, and doing a lot of this is very tedious. The name of the operation in JustCode is Create and Initialize Field. Fortunately, with JustCode, you can now just type “ctor TAB TAB” (using Visual Studio’s code snippet), add a parameter (e.g. ISendEmail mailSender), then bring up the Visual Aid Menu (I map this to Alt+Enter, which is R#’s default – JustCode uses ctrl+` by default which is nowhere near the keys I normally have my fingers on – fortunately you only need to change this once since your settings persist between computers as I’ll detail shortly), and select the first item, Create and Initialize Field ‘_mailSender’ by pressing Enter:

![](/img/image_6_fcrn.png)

The whole thing takes very few keystrokes and doesn’t require the mouse, which of course is key to frictionless coding. Essentially for me it’s:

ctor TAB TAB *typename* *variablename* alt+Enter Enter

Of course if the type already exists you can tab complete it rather than typing the whole thing.

## Dealing with Files

Frequently when you’re working test-first or in a way that minimizes dependencies, you’ll end up with a solution that involves a lot of small classes with well-defined responsibilities and interfaces. Using the typical Visual Studio approach to creating these files and classes is tedious – it’s much nicer to simply create the interface and class definitions in whatever file happens to be open, and then move them using JustCode shortcuts. For example, in this screenshot you can see that I’ve defined the interface in the same file as the class, so it’s underlined (because by default it’s recommended to have types in separate files). Mousing over, you’ll see warning:

![](/img/image_7_interface.png)

Clicking there and then hitting alt+Enter Enter will move the interface into its own file.

![](/img/image_10_fcrn.png)

Result:

![](/img/image_thumb_2_result.png)

Of course, you can also make sure filenames match your typenames. Any time a typename doesn’t match the current filename, you’ll get a warning and a suggestion to either Move Type To Another File or Rename File To Match Type Name.

Clean Up

Of course I’m a fan of Clean Code, so being able to quickly and easily clean up code is very helpful. I especially like to remove clutter, so unused using directives and other redundant bits of code I like to eliminate wherever possible, so they don’t obscure the intent of the actual code doing the work. JustCode supports a bunch of options for cleaning up and formatting code, and you can save your personal preferences in a profile. Here are some of the options available:

![](/img/image_thumb_3_justrocks.png)

One nice feature of JustCode is that you don’t have to do this in each file. You can do it at the project or solution level:

![](/img/image_thumb_4_just_clean.png)

## Navigation

When you write code such that it’s loosely coupled and testable (e.g. follows SOLID principles), you tend to have a lot more types than in a tightly coupled big-ball-of-mud solution. You also tend to have a lot more instances where your code is executing functionality through an interface, rather than through an explicit implementation. This makes the default navigation features of Visual Studio insufficient, or at least annoying. Very commonly as a developer you will want to find a particular type, or a particular file, or jump to the actual implementation of a method being called. Justcode makes all of these very easy.

Find Type / File

To find a type, just use the defau

lt keyboard shortcut. Since I’m a former R# user, I have ctrl+N and ctrl+shift+N embedded in my brain as Find Type and Find File. If you type in capital letters, it will quickly find camel-cased types that match (e.g. “ISE” will find “**IS**end**E**mail” as shown).

![](/img/image_thumb_5_ise.png)

You can do the same with files, searching for camel-case or for substrings:

![](/img/image_thumb_6_pro.png)

This is much, much faster than hunting through Solution Explorer looking for a particular class that you think might be implementing the interface you’re using. Speaking of which, let’s look at how we navigate through a call stack. Using only Visual Studio, if you want to find out what the implementation of Send() does in this code, you can do so by ctrl+Clicking on it.

![](/img/image_thumb_7_cartprocessor.png)

Of course, ctrl+Click will lead you here:

![](/img/image_thumb_8_interface.png)

This isn’t all that helpful in most cases. Fortunately, JustCode will easily let you Go To Implementation of the interface method (and again these are using the default R# key bindings):

![](/img/image_thumb_9_checkout.png)

This leads you here:

![](/img/smtpsender.png)

which is probably where you wanted to go to see what the code is actually doing.

## Speed

One issue I had with some of the early versions of JustCode was with its speed. The latest version is very fast, and I no longer have any complaints. I’m certainly not finding that I’m waiting on it, which occasionally was the case in the past.

## Cloud Sync

Most of the features I’ve described above already exist in ReSharper – in fact that’s where I fell in love with most of them. Now let’s look at some of the new and awesome features that JustCode has added that make it stand apart from its competitors. Chief among these, to me, is the ability to synchronize settings in the cloud. Those of you who know me through Microsoft MVP or ASPInsiders program may know that I have been lobbying Microsoft to provide a way to store and sync Visual Studio’s settings in the cloud since around 2003. And here it is 2012 and there’s still no support for it. About the best you can do is export/import your settings and sync them via DropBox or similar, which isn’t awful, but it’s enough extra friction that I’ve never fallen in love with this solution. What I want is for VS to “just work” the way I want it to when I sign into a new machine on my domain, or when I do a new install. JustCode now solves this problem.

In a previous release, JustCode provided a means to sync its own settings in the cloud, including all of the code templates and whatever preferences you had set up for formatting, cleaning, etc. However, in the most recent release, JustCode now will sync all Visual Studio settings, which is far more useful as it includes key bindings and other environment changes (e.g. turning on line numbers in the editors). I’m composing this article on a newly-installed Win8 machine, and I’m pleased to say I didn’t have to adjust any of my Visual Studio settings in order to get things set up how I like it. I simply installed JustCode, provided my Telerik credentials, and it does the rest. You can upload or download changes on-demand, as well as enabling automatic sync, as shown here:

![](/img/image_31_justcodeuseroptions.png)

Of course, if you don’t want to sync everything, you can choose a subset. And if you don’t trust automatic sync, you can choose to only upload/download on demand. You can also back up a given configuration, and then restore it later, allowing you to try something out and then easily revert. This can also be useful for presenters, who maybe use a black background and small fonts on their desktop, but want to use a white background and large fonts when presenting. JustCode accommodates this via its Cloud Backups.

This has literally been something I’ve wanted for almost ten years as a Visual Studio user, and it’s already making my life much easier, as I use quite a few different machines in my work. I was very excited to learn about, and now to use, this feature, and it works great. For more on this, read about [how to Save Your Visual Studio Settings in the Cloud](http://blogs.telerik.com/justteam/posts/12-10-22/save-your-visual-studio-settings-in-the-cloud.aspx).

## Keymaps

Another thing I’ve struggled with when I would try and evaluate competing tools (when I used R#) is relearning the keymaps of the various tools on the market. It was always tedious to reset key binding in Visual Studio’s settings, and of course you would have to do this on every machine you used, or every time you reinstalled your tools. It was a big barrier to switching, and of course this is a good thin

g for ReSharper (and other tools) if it provides some vendor lock-in. But for an individual developer who wants to be able to use, or at least evaluate, other tools, it was a problem. Fortunately, JustCode has a solution to this as well. You can simply choose one of the default keymaps that already has all of the mappings you’re familiar with. In my case, I went with the R#/IDEA keymap, as shown:

![](/img/image_thumb_12_keyboard.png)

This dialog appears as part of the Getting Started wizard when you first install JustCode, making it very easy to evaluate JustCode using the key bindings you already have committed to memory. The JustCode team also has an article describing how they came up with the [JustCode Keyboard Shortcuts Profiles](http://blogs.telerik.com/justteam/posts/12-10-24/justcode-keyboard-shortcuts-profiles.aspx) feature that you may want to check out.

## Summary

I’ve waited a long time to be able to write this article. When I joined Telerik earlier this year, I still wasn’t completely convinced that JustCode was really a tool I could recommend over my old friend ReSharper. I’m very pleased, as a Telerik employee, to be able to confidently endorse it now. If you’ve tried it before and found it lacking, I would encourage you to give it another shot. If you’re not using any Visual Studio add-in, and you’re trying to write loosely coupled, testable code, JustCode will eliminate a ton of the friction involved in doing so. You can [download a JustCode Trial here](http://www.telerik.com/download-trial-file.aspx?pid=717), if you’d like.

And since it’s almost election time here in the United States, let me end with “I’m Steve Smith, and I approve this message.”