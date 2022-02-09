---
templateKey: blog-post
title: Dotnet Format and File Scoped Namespaces
date: 2021-10-26
description: "The dotnet format tool is now a part of the dotnet CLI with .NET 6, and you can use it to easily adopt the new file scoped namespace feature that ships with C# 10."
path: blog-post
featuredpost: false
featuredimage: /img/dotnet-format-and-file-scoped-namespaces.png
tags:
  - dotnet
  - .net
  - .net core
  - c#
  - csharp
category:
  - Software Development
comments: true
share: true
---

The dotnet format tool is now a part of the dotnet CLI with .NET 6, and you can use it to easily adopt the new file scoped namespace feature that ships with C# 10.

## dotnet format

If you don't know the dotnet format tool, it's available as a separate install in previous versions of .NET, but ships as part of the .NET 6 SDK. It's used to format your codebase using rules specified in an `.editorconfig` file, and can ensure things like spacing, indentation, and whether certain characters appear on their own line are applied consistently throughout your codebase.

I recently recorded a short video demonstrating how to use the new `dotnet format` tool on a real project, including how to apply one of my favorite C# 10 features, file scoped namespaces, throughout a codebase. You can watch it here and/or read on. I do share a few extra tips in the video toward the end:

<iframe width="560" height="315" src="https://www.youtube.com/embed/5UO6tvMWuW8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## File Scoped Namespaces in C# 10

If you're a .NET developer and you're not yet familiar with file-scoped namespaces, I'm sure you'll probably encounter them in the very near future. The lead designer of the C# language team at Microsoft, [Mads Torgersen](https://twitter.com/madstorgersen), recently commented on [.NET Rocks](https://www.dotnetrocks.com/?show=1761) that over 99% of all C# files on GitHub have just one namespace. Which means that the vast majority of the lines of code in that file was indented, typically by 2 or 4 characters, for the entire file (minus some `using` statements).

What if you could just declare the namespace on a single line, and that namespace would affect the rest of the file from that point onward?

Sure, it wouldn't work for a handful of files that **do** use multiple namespaces in the file. Those files would continue to use the current { } syntax that we've had since C# 1.0. But **every other file** could just use a one-line namespace statement and **outdent** the entire contents of the file (minus using statements above the namespace of course) by one indent level. Think of how many whitespace characters could be saved!

Also, it's worth noting that indentation and whitespace are useful signals in your codebase. But they're only useful if there's variation. If the entire code section of the file is all indented the same amount because of a namespace, it's only adding noise, not signal.

This person on Twitter said it well:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I like indentation for programming logic and scoping, but it needs to provide a signal. If the entire file (essentially) is always the same, there&#39;s no signal there - it&#39;s just noise. And the real signals (indents for methods, ifs,loops, try-catch) are less pronounced as a result</p>&mdash; Steve &quot;ardalis&quot; Smith (@ardalis) <a href="https://twitter.com/ardalis/status/1446158937879875591?ref_src=twsrc%5Etfw">October 7, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Outdenting (it's a word!) the bulk of your code also makes life easier when you copy code listings into documentation, book manuscripts, slide decks, etc. It seems like a stupid little thing but I'm very jazzed about it.

What I'm not thrilled by is the prospect of *having to touch every file of every one of my ongoing projects* (open source and otherwise) to make this change consistently. **Ugh**.

## Dotnet Format for File Scoped Namespace

Fortunately this is where dotnet format comes in. You can modify your `.editorconfig` file to specify that you want to use this new file scoped namespaces feature. You can further specify that it's important enough that you don't just want it as a *suggestion* but you want to *fix* it anywhere it's not this way. To do that you add a line like this one:

```
csharp_style_namespace_declarations = file_scoped:warning
```

Note that you need the `:warning` at the end to make sure this is enforced.

With this in place in your .editorconfig, you can now use `dotnet format style` to update your whole project or solution, provided that it's using `<TargetFramework>net6.0</TargetFramework>` or higher. You can also use a "Refactor whole solution" option in some IDEs like Visual Studio 2022 (does Rider support this? Let me know and I will update).

## Summary

The dotnet format tool is a great way to quickly apply formatting from your .editorconfig to your entire project or solution. It handles style rules as well as whitespace, and can even apply rules based on brand new C# 10 features like file scoped namespaces. Once you start using file scoped namespaces I doubt you'll ever want to go back to needlessly indented code files again (in fact, since more files have only one class in them, I think support for file scoped classes could be a worthwhile *option* as well).

Be sure to watch the short video on [Using dotnet format on YouTube](https://www.youtube.com/watch?v=xbq7fbg8UxA) to see a few more gotchas and another tip on how to use dotnet format as part of your automated build process. Hit subscribe if you find the videos useful - I'm hoping to record them more regularly if people seem to like them.
