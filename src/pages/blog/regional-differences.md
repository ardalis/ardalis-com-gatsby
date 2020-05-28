---
templateKey: blog-post
title: Regional Differences
path: blog-post
date: 2013-05-21T16:52:00.000Z
description: "A while ago I ran a poll on twitter asking how developers
  recommend regions be used. About 15% of the respondents chose Other and/or
  chose to leave a comment. "
featuredpost: false
featuredimage: /img/app-1013616_1280.jpg
tags:
  - antipattern
  - clean code
  - regions
  - software craftsmanship
  - tips and tricks
category:
  - Software Development
comments: true
share: true
---
A while ago I ran a poll on twitter asking how developers recommend regions be used. About 15% of the respondents chose Other and/or chose to leave a comment. The comments are useful because they often highlight answer categories that I overlooked when I set up the poll. In this case, there were a lot of comments, I think because there are a lot of different opinions about regions in general, some of them rather heated.

The largest number of respondents simply never use Regions. A number of comments went on to say things like “Regions aren’t evil I just don’t know a situation where they’re useful.” The most popular use of regions from the ones I provided was for wrapping interface implementations, which isn’t too surprising since these regions are often automatically added when an interface is implemented automatically. Similarly, a large number of comments referenced “generated code” as a use case for regions, which I probably should have included in the original listing.

I added a couple of the options as items that I would consider obvious wrong answers on a standardized test. Surprisingly, both got a reasonable number of votes, with 13% of respondents recommending the use of regions with long functions. Now, some of these votes probably belong to commenters like this one: “Hiding long methods as I refactor it”. If you’re temporarily collapsing sections of a long function during your refactoring exercise, that seems quite reasonable to me. But if you’re putting regions into your function as a recommended, long-term approach, then I probably don’t want to work on that codebase with you. I would much rather functions be small enough that (without regions) they fit on one screen, and if they get too big for that, fix the problem by extracting out well-named and well-composed methods, as opposed to hiding the problem behind regions. And regions within regions. Wow.

My personal opinion is that regions had some great and common use cases in the early versions of .NET and C#. For instance, the first version of ASP.NET used regions appropriately to hide auto-generated wire-up code in the codebehind. A large number of comments continue to suggest that regions be used for generated code. Today, two things make this less of an issue. The first is partial classes. Generated code today is almost always in its own class, or could be, and as such rather than wrapping it with a region, I find it is better to simply use a partial class to keep the generated code in a separate file from the custom code. The second feature is more of an IDE feature. A lot of users find regions helpful as a code navigation tool, or as a way to limit what they are looking at on the screen. VS2010 provides great support for expanding and collapsing methods and other areas of code that you don’t wish to see, and tools like ReSharper make it trivial to navigate to a type or member anywhere in your solution (ctrl-T, then type a substring of the type, then enter and you’re there. For a member, the default keymap is the not-quite-as-easy-to-type ctrl-F12). A number of comments also suggested using regions for using statements. These don’t tend to bother me because I can quickly scroll down and not have to see them on my screen, and my using statements are usually quite small since ReSharper will clean up the ones I don’t need and will auto-add any that I do need, and my classes are small so they aren’t generally using more than a handful of other namespaces. And of course, Visual Studio supports collapsing using statements, too.

**Why Consider Them Harmful, Smelly, or even “Evil”?**

Evil is obviously a strong word, and of course since regions have no effect on compiled code, they can’t directly have any impact on the software you’re creating. However, I do think it is at least fair to say that regions often represent “code smells.” ([learn more about code smalls and how to fix them](https://www.pluralsight.com/courses/refactoring-fundamentals)) That is, areas of your code that may be worth investigating to see if there is rotten code that needs to be cleaned up. Why do some, including me, tend to feel this way? Because regions are often a symptom of underlying problems with the code itself. Regions do two things:

1. 1. Provide a single-line comment
   2. Wrap some number of lines of code and allow it to be hidden on demand

When might you need these features?

1. The intent of the code is unclear
2. The code is too long to quickly understand at a glance
3. Both of the above
4. You prefer an “outline view” of classes so you can drill into each category of member when you dig into a class

In the case of items 1 through 3, regions are covering up problems.

If the intent of a block of code is unclear, fix the code. Extract a method. Rename the variables. Refactor. Simplify. Don’t add a comment or a region (glorified comment) to try and cover up the problem. If you spill something in the kitchen, should you clean up the floor, or just throw a rug over it or put out an orange cone to warn people about the spill? Which option is going to keep the kitchen optimally usable? The same goes for your code. Keep it clean. **Regions are rugs under which to sweep smelly code.**

If the code is simply too long, fix it. Eliminate duplication. Refactor. Abstract details into larger-grained operations. If you’re spending 10 lines of plumbing code talking to a database or service, move that into its own method or class that is only responsible for that work. If you’re spending lots of lines of code copying values from one object to another, use a tool like [Automapper](http://automapper.org/) to map the values with one line of code. Keep your code concise and at the appropriate level of abstraction for the method you’re in, and don’t mix plumbing code with application code if you can help it.

In the case of 4, regions are being used to do something that your IDE should be able to easily do for you. I won’t say regions are being mis-used in this context, but I do think that if a large number of people use them for this purpose, then Visual Studio or one of the add-in providers should provide this kind of view such that you don’t have to implement yourself in the source code with region statements. I definitely think it’s valid that some developers prefer this view of their classes, I just don’t think they should have to clutter up everybody’s codebase in order to do so. Let the IDE do that work. And of course, if the classes and methods are small, the need for a high-level view is significantly lessened. If you prefer to have all of your public properties in one section, public methods in another, private members in another, etc. then wouldn’t you prefer to have an IDE that would simply let you specify the organization you prefer, and automatically have it in every file you open?

**Summary**

Almost half of the developers polled would never recommend using regions. Yet nearly 15% of those polled would recommend using them to organize long methods. A great many use them to organize code into categories (public, private, methods, properties), though this could probably be better done automatically by a tool. When .NET was young, regions provided a useful way to hide generated code within classes or to provide expand/collapse capabilities within the IDE. Today, partial classes and improvements to the IDE and various plug-ins make these uses unnecessary for many developers. Clearly, there are still some opportunities for IDE/plug-in vendors to build in code organization support that will further erode the legitimate use cases for regions. If you’re not using them for such organizational purposes today, think about the underlying reason you’re using a region the next time you add one, and consider if you wouldn’t be better off correcting the underlying code deficiency rather than hiding it under the region rug.