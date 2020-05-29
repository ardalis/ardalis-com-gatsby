---
templateKey: blog-post
title: Log Method Name Helper
path: blog-post
date: 2011-05-29T19:19:00.000Z
description: "Sometimes it’s handy to see the order in which methods are firing,
  or how long they’re taking, without having to attach a debugger.  Typically,
  you might write some code like this:"
featuredpost: false
featuredimage: /img/tips.png
tags:
  - .net
  - logging
  - tips
category:
  - Software Development
comments: true
share: true
---
Sometimes it’s handy to see the order in which methods are firing, or how long they’re taking, without having to attach a debugger. Typically, you might write some code like this:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> Foo()
{

Debug.Print(<span style="color: #006080">&quot;Entering Foo&quot;</span>);
<span style="color: #008000">// other stuff</span>

}

<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> Bar()

{

Debug.Print(<span style="color: #006080">&quot;Entering Bar&quot;</span>);

<span style="color: #008000">// other stuff</span>

}
```

This of course gets tedious after a while. There are all kinds of things wrong with this approach. It isn’t[DRY](/don-rsquo-t-repeat-yourself). It includes magic strings. You’d almost never need it if you were following TDD. Etc. If you really need this kind of logging detail on a lot of methods, I’d encourage you to investigate [AOP options like PostSharp](http://www.sharpcrafters.com/aop.net). However, if you’re not quite ready for that but do want to at least eliminate the magic strings from the above code, you can use this little helper to get the type and name of the method for your logging purposes:

```
<span style="color: #0000ff">private</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> LogMethod()
{

var stackTrace = <span style="color: #0000ff">new</span> StackTrace();
var method = stackTrace.GetFrame(1).GetMethod();
Debug.Print(method.ReflectedType.Name + <span style="color: #006080">&quot;.&quot;</span> + method.Name);

}
```

Drop that into the class you’re working in, and replace your calls with a call to LogMethod(). Naturally if you need to record both entering and existing of each method, you can adjust to something like this:

```
<span style="color: #0000ff">private</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> LogMethodStart()
{
var stackTrace = <span style="color: #0000ff">new</span> StackTrace();
var method = stackTrace.GetFrame(1).GetMethod();
Debug.Print(<span style="color: #006080">&quot;Entering &quot;</span> + method.ReflectedType.Name + <span style="color: #006080">&quot;.&quot;</span> + method.Name);
}

<span style="color: #0000ff">private</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> LogMethodEnd()

{
var stackTrace = <span style="color: #0000ff">new</span> StackTrace();
var method = stackTrace.GetFrame(1).GetMethod();
Debug.Print(<span style="color: #006080">&quot;Exiting &quot;</span> + method.ReflectedType.Name + <span style="color: #006080">&quot;.&quot;</span> + method.Name);
}
```

For obvious reasons you should avoid leaving these in your production code. One easy way to ensure this is the use of the **Conditional** attribute. By adding this attribute and specifying DEBUG you can ensure these methods are not even included in your DLLs when you perform a Release build. Here’s an example showing this attribute in use:

```
[Conditional(<span style="color: #006080">&quot;DEBUG&quot;</span>)]
<span style="color: #0000ff">private</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> LogMethod()
{
var stackTrace = <span style="color: #0000ff">new</span> StackTrace();
var method = stackTrace.GetFrame(1).GetMethod();
Debug.Print(method.ReflectedType.Name + <span style="color: #006080">&quot;.&quot;</span> + method.Name);
}
```

Naturally if you’re going to be using this in many classes, you can add it to a common helper class. Note that if you decide to refactor out the duplication in the above Start/End methods, you’ll most likely need to adjust the hard-coded GetFrame(1) to use a higher number, since you’ll need to unwind the stack further to get to the method you’re actually interested in (most likely just incrementing it to 2 will do the trick, assuming you only create one more method).