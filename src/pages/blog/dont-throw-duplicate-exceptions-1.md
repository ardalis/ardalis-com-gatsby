---
templateKey: blog-post
title: Dont Throw Duplicate Exceptions
path: blog-post
date: 2010-05-17T04:22:00.000Z
description: In your code, you’ll sometimes have write code that validates input
  using a variety of checks. Assuming you haven’t embraced AOP and done
  everything with attributes, it’s likely that your defensive coding is going to
  look something like this
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - duplicate exceptions
category:
  - Uncategorized
comments: true
share: true
---
In your code, you’ll sometimes have write code that validates input using a variety of checks. Assuming you haven’t embraced AOP and done everything with attributes, it’s likely that your defensive coding is going to look something like this:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> Foo(SomeClass someArgument)
{
  <span style="color: #0000ff">if</span>(someArgument == <span style="color: #0000ff">null</span>)
  {
      <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> InvalidArgumentException(<span style="color: #006080">&quot;someArgument&quot;</span>);
    }
  <span style="color: #0000ff">if</span>(!someArgument.IsValid())
    {
    <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> InvalidArgumentException(<span style="color: #006080">&quot;someArgument&quot;</span>);
    }
&#160;
  <span style="color: #008000">// Do Real Work</span>
}
```

Do you see a problem here? Here’s the deal – Exceptions should be meaningful. They have value at a number of levels:

* In the code, throwing an exception lets the develop know that there is an unsupported condition here
* In calling code, different types of exceptions may be handled differently
* At runtime, logging of exceptions provides a valuable diagnostic tool

It’s this last reason I want to focus on. If you find yourself literally throwing the exact exception in more than one location within a given method, stop. The stack trace for such an exception is likely going to be identical regardless of which path of execution led to the exception being thrown. When that happens, you or whomever is debugging the problem will have to guess which exception was thrown. Guessing is a great way to introduce additional problems and/or greatly increase the amount of time require to properly diagnose and correct any bugs related to this behavior.

**Don’t Guess – Be Specific**

When throwing an exception from multiple code paths within the code, be specific. Virtually ever exception allows a custom message – use it and ensure each case is unique. If the exception might be handled differently by the caller, than consider implementing a new custom exception type. Also, don’t automatically think that you can improve the code by collapsing the if-then logic into a single call with short-circuiting (e.g. if(x == null || !x.IsValid()) ) – that will guarantee that you can’t easily throw different information into the message as easily as constructing the exception separately in each case.

The code above might be refactored like so:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> Foo(SomeClass someArgument)
{
  <span style="color: #0000ff">if</span>(someArgument == <span style="color: #0000ff">null</span>)
  {
    <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> ArgumentNullException(<span style="color: #006080">&quot;someArgument&quot;</span>);
  }
  <span style="color: #0000ff">if</span>(!someArgument.IsValid())
    {
    <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> InvalidArgumentException(<span style="color: #006080">&quot;someArgument&quot;</span>);
      }
&#160;
  <span style="color: #008000">// Do Real Work</span>
 }
```

In this case it’s taking advantage of the fact that there is already an ArgumentNullException in the framework, but if you didn’t have an IsValid() method and were doing validation on your own, it might look like this:

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> Foo(SomeClass someArgument)
{
  <span style="color: #0000ff">if</span>(someArgument.Quantity &lt; 0)
  {
      <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> InvalidArgumentException(<span style="color: #006080">&quot;someArgument&quot;</span>, 
      <span style="color: #006080">&quot;Quantity cannot be less than 0. Quantity: &quot;</span> + someArgument.Quantity);
  }
    <span style="color: #0000ff">if</span>(someArgument.Quantity &gt; 100)
  {
    <span style="color: #0000ff">throw</span> <span style="color: #0000ff">new</span> InvalidArgumentException(<span style="color: #006080">&quot;someArgument&quot;</span>,
      <span style="color: #006080">&quot;SomeArgument.Quantity cannot exceed 100.  Quantity: &quot;</span> + someArgument.Quantity);
  }
&#160;
  <span style="color: #008000">// Do Real Work</span>
}

```

Note that in this last example, I’m throwing the same exception type in each case, but with different Message values. I’m also making sure to include the value that resulted in the exception, as this can be extremely useful for debugging. (How many times have you wished NullReferenceException would tell you the name of the variable it was trying to reference?)

Don’t add work to those who will follow after you to maintain your application (especially since it’s likely to be you). Be specific with your exception messages – follow [DRY](http://stevesmithblog.com/blog/don-rsquo-t-repeat-yourself) when throwing exceptions within a given method by throwing unique exceptions for each interesting case of invalid state.