---
title: Markdown Code Block Syntax Highlighting and Diff
date: "2021-11-03T00:00:00.0000000"
description: If you're writing blog posts, GitHub content, and/or Stack Over flow questions and answers using Markdown, it's often helpful to show code in code blocks of within code fences. Did you know these support many different languages to allow for proper syntax highlighting, including a diff 'language'?
featuredImage: /img/markdown-code-block-syntax-highlighting-and-diff.png
---

If you're writing blog posts, GitHub content, and/or Stack Over flow questions and answers using Markdown, it's often helpful to show code in code blocks of within code fences. Did you know these support many different languages to allow for proper [syntax highlighting](https://www.markdownguide.org/extended-syntax/#syntax-highlighting), including a diff 'language'?

## Markdown code fences

Markdown is a great language to use to write content in, because it offers built-in styling without the security and other issues that similar markup languages like HTML have. As a result, it's become pretty ubiquitous within the software development space, and most online platforms support some flavor of it. If you really want a great editor for markdown, I recommend my friend [Rick Strahl's Markdown Monster](https://markdownmonster.west-wind.com/) (no affiliate link or kickbacks) tool. Personally, I just write the markdown by hand, usually with VS Code, as I'm doing now for this article.

Different platforms have different support for Markdown features, but virtually all of them support code listing using something commonly referred to as "code fences." Code fences are a markdown syntax used to denote the start and end of a code block, like this one:

```
Console.WriteLine("Hello World!);
```

The code fence syntax starts with three backticks (`) on one line, followed by the code on separate lines, and then terminated by another triple-backtick on its own line.

If you only use the basic code fence feature, you won't see any syntax highlighting. This is because you haven't indicated anything about what kind of code is in the code block. Here's another example where I specify the language as `json`:

```json
{
 name:"NimblePros",
 description:"We help sftware teams deliver better software, faster.",
 website:"nimblepros.com",
 twitter:"@nimblepros"
}
```

In the above code listing, there is better syntax highlighting, because I've indicated what language to use. Nothing forces you to use the *correct* language for your code block - you'll just get odd results. For instance, if you try to highlight your JSON as XML or your C# as VB.

GitHub has some nice docs on [code highlighting with GitHub flavored Markdown](https://docs.github.com/en/github/writing-on-github/working-with-advanced-formatting/creating-and-highlighting-code-blocks). Stack Overflow also has docs on [editing with Stack Overflow's Markdown](https://stackoverflow.com/editing-help).

You'll find [a list of supported languages for highlight.js, the tool used by Stack Overflow's Markdown](https://github.com/highlightjs/highlight.js/blob/main/SUPPORTED_LANGUAGES.md). It's quite extensive.

My goal here isn't to reproduce the information already available in these resources, but to make sure you're aware of it and can leverage it in your technical writing.

I also want to introduce you to one generally-supported language that you may not have used before, even if you're a long time Markdown user.

## The diff Syntax Highlighting Language

In addition to the many other languages that support syntax highlighting in your Markdown files, you can specify the language of `diff`. This language will let you use syntax highlighting on line-by-line diff(erence) files like you get in commit messages and pull requests using git (and other source control providers). [Learn more about the diff format and its syntax on Wikipedia](https://en.wikipedia.org/wiki/Diff#Unified_format).

For example, the json block above could show some changes using a code listing like this one:

```diff
{
 name:"NimblePros",
- description:"We help sftware teams deliver better software, faster.",
+ description:"We help software teams deliver better software, faster.",
 website:"nimblepros.com",
 twitter:"@nimblepros"
}
```

(you didn't realize that typo was left in there on purpose, did you? 🙂)

As you write content in Markdown format and need to show how code is changing from one step to another, the diff language syntax and syntax highlighting can provide a great way to communicate information to readers. I've written a lot of documentation for [docs.microsoft.com](https://docs.microsoft.com) and occasionally use line highlighting (a yellow background, typically) to show a line that's been added or changed. Since this isn't supported by Markdown, it required some custom code and was based on line number references that could easily break as the code evolved. Using the diff format for this kind of thing would have provided a different result, but probably a more maintainable one and possibly a better one for many readers. Especially when code is being modified, not just added (it's nice to see the old and new side-by-side - or at least one above the other).

So, what do you think? Are you using diff in your markdown code blocks already? Do you think you will? Do you have a favorite code block highlighting or Markdown tip you want to share? Please let me know in the comments or on Twitter with a link to this article and a mention of @ardalis. Cheers!

