---
templateKey: blog-post
title: Visual Studio XAML Editing Tip
path: blog-post
date: 2008-01-14T14:26:30.574Z
description: "So I’m working in XAML in Visual Studio 2008 and it has some nice
  statement completion features now, like automatically quoting my attributes
  for me (cool!). "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - silverlight
  - visual studio
  - WPF
  - XAML
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

So I’m working in XAML in Visual Studio 2008 and it has some nice statement completion features now, like automatically quoting my attributes for me (cool!). When there’s an item it knows, like Orientation=”Horizontal|Vertical” it will give me a dropdown and after selection, put the cursor after the closing double quote, as you would expect, like this (the _ represents the cursor):

<StackPanel Orientation=”Vertical”_

However, if you edit a field that doesn’t have a limited set of options, like Width, you don’t get this behavior, so you’re trapped inside of the double quotes:

<StackPanel Orientation=”Vertical” Width=”30_”

None of the standard keys within reach of a touch typist will get the cursor out of the quoted area, so you have to pick up your hand and go find the right arrow or end key (or if you’re really inefficient, use the mouse) before continuing on with your typing. For a fast typist like me, this gets old fast, and dramatically slows down the otherwise incredibly exciting task of hand typing XAML into a text editor.

To fix this, I’ve mapped shift-Space to the Next Word command in the text editor. To do this, in Visual Studio 2008 (I think it’s the same in 2005), go to Tools – Customize and click Keyboard, or go to Tools-Options-Keyboard. The ListBox has a few hundred items in it, so it comes with a handy filter textbox with the heading “Show commands containing:”. In this textbox, enter “WordNext” and you should see four options. Select Edit.WordNext.

In the Use new shortcut in: you can choose between Global or just limit it to Text Editor. Then in Press shortcut keys you should press the key combination you want to use (in my case shift+Space).

<!--EndFragment-->

![](/img/option-dialog.jpg)

<!--StartFragment-->

**Remember to click the Assign button and you’re done!**

<!--EndFragment-->