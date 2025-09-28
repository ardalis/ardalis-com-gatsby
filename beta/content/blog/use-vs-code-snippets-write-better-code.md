---
title: Using Visual Studio 2005 Code Snippets to Write Better Code Faster
date: "2006-05-29T00:00:00.0000000"
description: Code Snippets provide simple code generation for repetitive tasks within the Visual Studio 2005 IDE. For example, rather than typing a complete property declaration or case statement, just type a brief shortcut, TAB, and fill in a couple of values. The construct is built for you. In this article, Steve shows how to take advantage of the built in Visual Studio 2005 Code Snippets and how to write your own.
featuredImage: /img/visual-studio-better-code-faster.png
---

## Introduction

In my accompanying article, [Visual Studio Debugger Tips and Tricks](http://aspalliance.com/796), I showed a number of ways that properties and classes could be customized with attributes in order to make debugging such classes simpler and more streamlined. The end result of those attributes was something like the `Person2` class shown in Listing 1.

#### Listing 1

```csharp
[DebuggerDisplay("Person2: {Name}")] class Person2
{
 [DebuggerBrowsable(DebuggerBrowsableState.Never)]
 private string _name;
 public string Name
 {
 [DebuggerStepThrough]
 get
 {
 return _name;
 }
 [DebuggerStepThrough]
 set
 {
 _name = value;
 }
 }
}
```

Clearly there is a lot more code here than before we started adding attributes, and arguably the code is a bit tougher to read with all of this attribute"clutter." We can fix the latter easily enough through the use of a #region, which can encapsulate the property in a named region (in this case called Name). The end result is something we can easily collapse so that we are not faced with all this clutter while we are working with our `Person2` class. To do this, you could hand-type #region Name and then #endregion, but a much more efficient way is to take advantage of Code Snippets. In this case, you can simply highlight the lines you would like to place in a #region and right click, select Surround With, and then choose #region. The #region statements are placed for you and the name of the region is highlighted in green and has focus, such that as soon as you start typing, it will have whatever value you type for it. Hit enter and the Code Snippet wizard completes, the green highlighting disappears and you are left with your code.

Code Snippets are a fantastic feature of Visual Studio 2005. If you have not used them yet, make a point to try them out. There is no limit to the kind of code generation you can accomplish with these template-driven tools. You can [learn more about them](http://gotcodesnippets.com/faq.aspx), find others and share your own at [GotCodeSnippets.com](http://gotcodesnippets.com/). Visual Studio comes with a bunch of snippets built in, but you can modify these or create your own as well. For instance, by default if you type"prop" in a C# class, you will see Intellisense showing prop as a code snippet. Similarly,"propg" will create a get-only property.

By default,"prop" defaults to an int, but simply type string and it will change the"int" fields to strings.

Okay, so Code Snippets are cool, there is a bunch built-in and you can make your own, but what does that have to do with the [Debugging Tips and Tricks article](http://aspalliance.com/796) Well, if you decide you would like to always create your properties such that DebuggerStepThrough is specified, the property is in its own #region, and DebuggerBrowsable is set to Never, you can simply create your own snippet or modify one of the existing ones. You can view all of the existing snippets using the Snippet Manager under the Tools menu or the shortcut, Ctrl-K-Ctrl-B. The"prop" snippet, for instance, is located under \Program Files\Microsoft Visual Studio 8\VC#\Snippets\1033\Visual C#\prop.snippet. Snippets are simply XML files, so you can open this and edit it with Visual Studio or Notepad. However, there are two tools available that are specifically designed for editing snippets.

## Editing Code Snippets

The two most popular tools for editing Code Snippets are the [Code Snippet Editor for Visual Basic 2005](http://msdn.microsoft.com/vbasic/downloads/tools/snippeteditor/) (which works fine for all languages despite the name) and [Snippy, a GotDotNet project](http://www.gotdotnet.com/codegallery/codegallery.aspx?id=b0813ae7-466a-43c2-b2ad-f87e4ee6bc39) for doing the same. These tools work fairly similarly to one another.

## Resources

[Enhancing Debugging with the Debugger Display Attributes](http://msdn2.microsoft.com/en-US/library/ms228992.aspx)

[Anson Horton's PDC Tips and Tricks](http://blogs.msdn.com/ansonh/archive/2005/12/06/500823.aspx)

[GotCodeSnippets.com](http://gotcodesnippets.com/)

[VB Code Snippet Editor](http://msdn.microsoft.com/vbasic/downloads/tools/snippeteditor/)

[Snippy - GotDotNet Project](http://www.gotdotnet.com/codegallery/codegallery.aspx?id=b0813ae7-466a-43c2-b2ad-f87e4ee6bc39)

## Summary

Visual Studio's Code Snippets provide a simple and powerful way to integrate code generation into your day-to-day development. Tools like the [GotCodeSnippets.com](http://www.gotcodesnippets.com/) site should eventually provide a large library of useful snippets, which can be shared among developers in much the same way [RegExLib.com](http://regexlib.com/) provides an easy way to share common [regular expressions](http://regexadvice.com/). Using tools like [Snippy](http://www.gotdotnet.com/codegallery/codegallery.aspx?id=b0813ae7-466a-43c2-b2ad-f87e4ee6bc39) and the [Code Snippet Editor for Visual Basic 2005](http://msdn.microsoft.com/vbasic/downloads/tools/snippeteditor/), it is very easy to create or customize snippets to suit your needs. So, what are you waiting for? Start using them!

Originally published on [ASPAlliance.com](http://aspalliance.com/863_Using_Visual_Studio_2005_Code_Snippets_to_Write_Better_Code_Faster)

