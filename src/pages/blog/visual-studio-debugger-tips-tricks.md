---
templateKey: blog-post
title: Visual Studio Debugger Tips and Tricks
date: 2006-05-29
path: blog-post
description: The Debugger in Visual Studio 2005 is an extremely powerful tool for finding problem areas in your applications. Its default behavior is not always the most efficient, however. In this article, Steve shows a number of customizations that can be applied to optimize the debugger, making it an even more powerful development tool.
featuredpost: false
featuredimage: /img/vs-debugger-tips.png
tags:
  - visual studio
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

Visual Studio 2005 provides a powerful debugger which makes stepping through your code to find problems a breeze.  However, sometimes it offers too much information, and it can become tedious to find just what you are looking for amidst all of the extra noise.  Fortunately, the debugger can be customized using a few simple techniques.

## TMI! Too Much Information

Many times the debugger's default behavior goes into more detail than is actually necessary.  It does not know any better, so by default it is going to show you every line of code, every member of a given class, and let you, the programmer, figure out what is important and what is not.  Frequently, though, this results in a lot more tedious stepping through the code or a much tougher time locating the property you actually care about.

Two common annoying scenarios occur when debugging properties.  Properties typically consist of a private field and a public accessor or set of accessors.  These accessors are usually used as if they were simply fields, as in the following code fragment:

#### Listing 1

```csharp
myPerson.Name = Console.ReadLine();
if (myPerson.Name == "Steve")
{
  Console.WriteLine("Hello, Steve!");
}
```

In this case, `Name` is being used as a simple string value.  While debugging, we probably do not care to step into the `get()` and `set()` accessor to see that `Name` is actually returning or setting the value of the `_name` private instance string variable, but unfortunately by default this is what we will see as we step through the code.  Rather than simply moving from the `if()` statement into the `// do stuff` section, the debugger will jump to the `Name` `get()` accessor, allowing us to see what is almost certainly (assuming property best practices are being followed) a single line returning a private instance variable.  While a single line might not seem worth worrying about, in practice the debugger breaks on the opening `{`, the `return _name;` statement, and the closing `}`, resulting in 3 extra steps.  And the same is true when assigning a value to `.Name`.

Stepping through the code above, assuming the breakpoint is set on the line with the `Console.ReadLine()` and ends with the closing brace of the if statement, takes 13 clicks of the F11 key.  Considering we're talking about 5 lines of code, that is quite a few.

The `Name` property might be implemented like so:

#### Listing 2

```csharp
private string _name;
public string Name
{
  get
  {
    return _name;
  }
  set
  {
    _name = value;
  }
}
```

The second problem area involves the Locals window.  While stepping through code, the Locals window in the IDE will show the current values of all objects in scope.  In the example below, you can see that it lists the `myPerson` instance which includes one property with a public `Name` and a private `_name`.  Again, in practice these two values will always be the same, something that is true for 99% of property values.  Thus, it would be nice, especially for classes with a lot of members, to only show one or the other of these two fields, rather than both.

## Attributes

The first tips for optimizing the Visual Studio debugger utilize Attributes.  Attributes are a fantastic way to add additional semantic information about your code in a declarative fashion, and in this case they are used to inform the debugger that certain code sections should be treated differently.  You can learn more about attributes with [Programming with Attributes](http://aspalliance.com/37).

### DebuggerStepThrough (1.x/2.x)

The `System.Diagnostics.DebuggerStepThrough` attribute ([docs](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpref/html/frlrfsystemdiagnosticsdebuggerstepthroughattributeclasstopic.asp)) informs the Visual Studio debugger (or, technically, any debugger) that the decorated method should not be stepped into, even when the Step Into command is given.  It does, however, still allow for (and honor) breakpoints to be set within the method.

By adding the `DebuggerStepThrough` attribute to property declarations, a lot of unnecessary steps can be taken out of the debugging process, since property accessors would then be treated as simple fields.  Unfortunately, you cannot simply apply this attribute to a property, it must be set for each accessor.  As such, the Name property could be rewritten as follows:

#### Listing 3

```csharp
private string _name;
public string Name
{
  [DebuggerStepThrough]get
  {
    return _name;
  }
  [DebuggerStepThrough]set
  {
    _name = value;
  }
}
```

After making these changes and stepping through the code from Listing 1, the total number of F11 (step into) actions required to step through the code is reduced to 5 -- one per line of code.  This represents a reduction of 54%!

### DebuggerBrowsable (2.x)

The next attribute that can improve the debugging experience is `System.Diagnostics.DebuggerBrowsable` ([docs](http://msdn2.microsoft.com/en-US/library/system.diagnostics.debuggerbrowsableattribute(VS.80).aspx)).  This attribute works with the Locals window, and can be used to eliminate redundant fields.  This attribute accepts one parameter which must be one of the `DebuggerBrowsableState` enumeration values of Never, Collapsed, or RootHidden.  Collapsed is the default behavior you are probably familiar with.  None can be used to hide certain fields from being displayed.  The RootHidden option will hide the root object, but will show its children if the member is an array or collection.  Unfortunately, this attribute is not supported by Visual Basic.

Using this attribute in our example, we can mask the presence of the private local _name variable from the Locals window.  Listing 4 shows our updated property code.

#### Listing 4

```csharp
[DebuggerBrowsable(DebuggerBrowsableState.Never)]
private string _name;
public string Name
{
  [DebuggerStepThrough]get
  {
    return _name;
  }
  [DebuggerStepThrough]set
  {
    _name = value;
  }
}
```

### DebuggerDisplayAttribute (2.x)

Another sometimes useful attribute is `DebuggerDisplayAttribute` ([docs](http://msdn2.microsoft.com/en-US/library/system.diagnostics.debuggerdisplayattribute.debuggerdisplayattribute(VS.80).aspx)).  This attribute is applied to a class and allows a custom string to be displayed when instances of the type are moused over during a debugging session.  By default, the type of the variable is shown, or if the `.ToString()` method has been overridden, the result of the `.ToString()` method is shown.  Thus, there is no need to use this attribute if the `.ToString()` method will show what you want to see.  One interesting thing to note about this attribute is that it can include both literal string data and expressions using the object's members.  For example, the expression `"Name = {Name}"` would display the following when `Name = "Steve"`:

```csharp
Name = Steve
```

In addition to controlling what you see when you mouse over an instance of the type, the `DebuggerDisplayAttribute` also affects the Value shown in the Locals window.  For instance, by modifying the `Person2` class to include the attribute as shown in Listing 5, we can achieve a different view in the Locals window.

#### Listing 5

```csharp
[DebuggerDisplay("Person2: {Name}")]
class Person2
{
…
}
```

## But That's A Lot More Code To Write...

In our simple example here, we've taken the one-property Person class and overhauled it with the Person2 class, the entirety of which is listed below as Listing 6.

#### Listing 6

```csharp
[DebuggerDisplay("Person2:{Name}")]class Person2
{
 [DebuggerBrowsable(DebuggerBrowsableState.Never)]
  private string _name;
  public string Name
  {
    [DebuggerStepThrough]get
    {
      return _name;
    }
    [DebuggerStepThrough]set
    {
      _name = value;
    }
  }
}
```

Clearly, there is a lot more code here than before and, arguably, the code is a bit tougher to read with all this attribute "clutter".  We can fix the latter easily enough through the use of a #region which can encapsulate the property in a named region (in this case called Name).  The end result is something we can easily collapse so that we are not faced with all this clutter while we are working with our `Person2` class.  To do this, you could hand type #region Name and then #endregion, but a much more efficient way is to take advantage of Code Snippets.  In this case, you can simply highlight the lines you would like to place in a #region and right click, select Surround With, and then choose #region.  The #region statements are placed for you and the name of the region is highlighted in green and has focus, such that as soon as you start typing it will have whatever value you type for it.  Hit enter and the Code Snippet wizard completes, the green highlighting disappears, and you are left with your code.

Code Snippets are a fantastic feature of Visual Studio 2005.  If you have not used them yet, make a point to try them out.  There is no limit to the kind of code generation you can accomplish with these template-driven tools.  You can [learn more about them](http://gotcodesnippets.com/faq.aspx), find others, and share your own at [GotCodeSnippets.com](http://gotcodesnippets.com/).

For more on Code Snippets, please see my related article [Using Visual Studio 2005 Code Snippets to Write Better Code Faster](https://ardalis.com/use-vs-code-snippets-write-better-code/).

## What About Others' Code?

All of the above attributes and techniques work splendidly... when you have the source code and the luxury of being able to modify it.  What about when it is somebody else's code?  What if it is a third party component you want to adjust, or even a .NET Framework object?  Fortunately, you can apply all of the above Debugger attributes to any assembly via a file called autoexp.cs.  The autoexp.cs file is normally located in your My Documents/Visual Studio 2005/Visualizers folder, where you will note there is also an autoexp.dll.  The .cs file gets compiled into the dll, which the debugger uses for its debug-time visualizer behavior.  In this file you will find all kinds of examples of built-in visualizers for .NET types, which you can customize and use as the basis for custom visualizers of your own.  Listing 7 shows an example of some of the visualizers built into autoexp.cs.

#### Listing 7

```csharp
// mscorlib
[assembly: DebuggerDisplay(@"\{Name ={Name} FullName = {FullName}}", Target = typeof(Type))]
 
// System.Drawing
[assembly: DebuggerDisplay(@"\{Name ={fontFamily.Name} Size={fontSize}}", Target = typeof(Font))]
[assembly: DebuggerDisplay(@"\{Name ={name}}", Target = typeof(FontFamily))]
[assembly: DebuggerDisplay(@"\{Color ={color}}", Target = typeof(Pen))]
[assembly: DebuggerDisplay(@"\{X = {x} Y ={y}}", Target = typeof(Point))]
[assembly: DebuggerDisplay(@"\{X = {x} Y ={y}}", Target = typeof(PointF))]
[assembly: DebuggerDisplay(@"\{X = {x} Y ={y} Width = {width} Height = {height}}", Target = typeof(Rectangle))]
[assembly: DebuggerDisplay(@"\{X = {x} Y ={y} Width = {width} Height = {height}}", Target = typeof(RectangleF))]
[assembly: DebuggerDisplay(@"\{Width ={width} Height = {height}}", Target = typeof(Size))]
[assembly: DebuggerDisplay(@"\{Width ={width} Height = {height}}", Target = typeof(SizeF))]
[assembly: DebuggerDisplay(@"\{Color ={color}}", Target = typeof(SolidBrush))]
 
// System.Web.UI.WebControls
[assembly: DebuggerDisplay(@"\{Text ={Text}}", Target = typeof(WebControls::Button))]
[assembly: DebuggerDisplay(@"\{Text ={Text}}", Target = typeof(WebControls::Label))]
[assembly: DebuggerDisplay(@"\{Text ={Text}}", Target = typeof(WebControls::HyperLink))]
[assembly: DebuggerDisplay(@"\{Text ={Text} Checked = {Checked}}", Target = typeof(WebControls::CheckBox))]
[assembly: DebuggerDisplay(@"\{Text ={Text} Checked = {Checked}}", Target = typeof(WebControls::RadioButton))]
[assembly:DebuggerDisplay(@"\{SelectedDate = {SelectedData}}", Target =typeof(WebControls::Calendar))]
[assembly: DebuggerDisplay(@"\{Text ={Text}}", Target = typeof(WebControls::LinkButton))]
 
// System.Web.UI.HtmlControls
[assembly: DebuggerDisplay(@"\{Value ={Value}}", Target = typeof(HTMLControls::HtmlInputButton))]
[assembly: DebuggerDisplay(@"\{InnerText ={InnerText}}", Target = typeof(HTMLControls::HtmlGenericControl))]
[assembly: DebuggerDisplay(@"\{Value ={Value}}", Target = typeof(HTMLControls::HtmlTextArea))]
[assembly: DebuggerDisplay(@"\{Value ={Value}}", Target = typeof(HTMLControls::HtmlInputText))]
[assembly: DebuggerDisplay(@"\{Value ={Value} Checked = {Checked}}", Target =typeof(HTMLControls::HtmlInputCheckBox))]
[assembly: DebuggerDisplay(@"\{Value ={Value} Checked = {Checked}}", Target =typeof(HTMLControls::HtmlInputRadioButton))]
```

## Downloads

You can download the sample [here](http://index.aspalliance.com/FileGallery/ArticleSamples/Details/163_DebuggerDemo.aspx).

## Summary

With a few simple tweaks, the Visual Studio debugger can be streamlined and customized to make it work much more effectively.  Rather than showing you more than you need to know or forcing you to follow repetitive code paths, you can focus on just the parts of your application you need to see when debugging. I also highly recommend reading the resources listed at the end of this article, especially [Anson Horton's PDC tips and tricks](http://blogs.msdn.com/ansonh/archive/2005/12/06/500823.aspx) -- his PDC presentation served as the inspiration for this article. You will also want to read the related article, Visual Studio 2005 Code Snippets, so that you can encapsulate these tricks into your day-to-day activities without having to write much code.

## Additional Resources

[Enhancing Debugging with the Debugger Display Attributes](http://msdn2.microsoft.com/en-US/library/ms228992.aspx)

[Anson Horton's PDC Tips and Tricks](http://blogs.msdn.com/ansonh/archive/2005/12/06/500823.aspx)

[GotCodeSnippets.com](http://gotcodesnippets.com/)

Originally published on [ASPAlliance.com](http://aspalliance.com/796_Visual_Studio_Debugger_Tips_and_Tricks)
