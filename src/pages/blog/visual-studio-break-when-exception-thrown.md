---
templateKey: blog-post
title: Visual Studio Break When Exception Thrown
path: blog-post
date: 2007-07-07T02:35:32.265Z
description: By default, Visual Studio will only break when an exception is
  unhandled in user code. This is often some distance from where the actual
  exception took place, as several try…catch blocks might have been involved in
  the meantime before the exception goes unhandled.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Visual Studio
category:
  - Uncategorized
comments: true
share: true
---
By default, Visual Studio will only break when an exception is unhandled in user code. This is often some distance from where the actual exception took place, as several try…catch blocks might have been involved in the meantime before the exception goes unhandled. A recent thread on the ALT.NET mailing list discussed some techniques for getting round this issue if you the developer would really like to see exactly the line of code that is failing. One such technique (Jon Davis) used precompilation directives to conditionally add the try-catch statements, like so:

```
<span style="color: #0000ff">void</span> MyMethod()

{

<span style="color: #cc6633">#if</span> !DEBUG

                <span style="color: #0000ff">try</span> 

                {

<span style="color: #cc6633">#endif</span>

                                <span style="color: #008000">// the logic that might throw</span>

                                DoSomething();

<span style="color: #cc6633">#if</span> !DEBUG

                }

                <span style="color: #0000ff">catch</span> (Exception e)

                {

                                LogError(e);

                                <span style="color: #008000">// etc…</span>

                }

<span style="color: #cc6633">#endif</span>

}
```

This gets pretty ugly fast, but it gets the job done. However, another list member (Nick Blumhardt) wrote in and pointed out a feature of Visual Studio that effectively does this for you if it’s the desired behavior. From the Debug menu, <!--StartFragment-->

choose Exceptions (or use Ctrl-Alt-E) which brings up this dialog:

[![image](<>)](http://stevesmithblog.com/files/media/image/WindowsLiveWriter/VisualStudioBreakWhenExceptionThrown_96A1/image_2.png)

If you check the box under Thrown for Common Language Runtime Exceptions, the debugger will break on the line where it occurs rather than when it goes unhandled in some catch block. The downside to using this option is that it applies to all code, not just a particular method. You can mix and match the two techniques if you only want certain code blocks to break when the exception is thrown, but personally I would avoid the former technique as I think it results in uglier code that is less clear, and doesn’t behave the same under development as in production.

It’s also worth pointing out that [Visual Basic can use Catch Exception When {expression}](http://msdn.microsoft.com/en-us/library/fk6t46tz(VS.80).aspx) to achieve this quite easily. For instance, a DEBUG flag could be used for the When condition. This would still result in code that differs in behavior between DEBUG and production, but at least it’s far more elegant and easier to read and maintain. C#, unfortunately, lacks such a feature.