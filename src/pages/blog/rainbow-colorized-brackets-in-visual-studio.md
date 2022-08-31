---
templateKey: blog-post
title: Rainbow Colorized Brackets in Visual Studio
date: 2022-08-31
description: "A popular extension and later core feature of VS Code, rainbow bracket colorization is now available as a free extension for Visual Studio."
path: blog-post
featuredpost: false
featuredimage: /img/rainbow-colorized-brackets-in-visual-studio.png
tags:
  - visual studio
  - vscode
  - programming
category:
  - Software Development
comments: true
share: true
---

A popular extension and later core feature of VS Code, rainbow bracket colorization is now available as a free extension for Visual Studio called [Rainbow Braces](https://marketplace.visualstudio.com/items?itemName=MadsKristensen.RainbowBraces), by Mads Kristensen. It was just released in the last week and currently lists support only for Visual Studio 2022.

Colorizing brackets makes it much easier to visually match opening and closing brackets (or braces or parentheses or curly brackets) with one another. For example, here's a fairly simple method that includes an `if` statement with several sets of nested parentheses:

![rainbow braces dark theme](/img/rainbow-braces-dark.png)

Having the different colors makes it easier for (non color blind) programmers to match up braces, especially on the same line where vertical spacing and indenting are less help.

The extension also supports various themes. Here's the same code with a light theme:

![rainbow braces light theme](/img/rainbow-braces-light.png)

The extension includes some configuration options, allowing you to toggle whether you want colorization enabled at all, as well as for:

- curly brackets { }
- parentheses ( )
- square brackets [ ]
  
You can also customize the colors if you don't like the defaults (there are 4 levels of colors you can specify).

If you're using Visual Studio 2022 (or later), I encourage you to check out this extension and see how you like it. And if you've been using VS Code, you may want to read this post from a year ago that describes how and why the VS Code team took a similar extension there and pulled it into the core product (in the process speeding it up by 10000x):

[Bracket pair colorization 10,000x faster in VS Code](https://code.visualstudio.com/blogs/2021/09/29/bracket-pair-colorization)

## What do you think?

Are you using bracket colorization? Has it changed your life, or is it pretty much 'meh'? Do you hate it and disable it the first chance you get if others are using it? Let me know in the comments below.
