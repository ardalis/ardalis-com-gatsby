---
templateKey: blog-post
title: IsNull Extension Method
path: blog-post
date: 2008-07-02T02:09:23.715Z
description: I’m strongly considering adopting the use of an IsNull extension
  method in my .NET 3.5 coding projects.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - IsNull
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I’m strongly considering adopting the use of an IsNull extension method in my .NET 3.5 coding projects. A quick search to see what others have to say about this revealed a new web site dedicated to [extension methods](http://www.extensionmethod.net/), which includes this [IsNull method](http://www.extensionmethod.net/Details.aspx?ID=111) ready to go:

<!--EndFragment-->

```
<span style="color: #0000ff">public static</span> <span style="color: #0000ff">bool</span> IsNull(<span style="color: #0000ff">this</span> <span style="color: #0000ff">object</span> source)

{

  <span style="color: #0000ff">return</span> source == <span style="color: #0000ff">null</span>;
}
```

<!--StartFragment-->

The String class supports the IsNullOrEmpty() method now, but you have to pass it your instance yourself. This is another good candidate for Extension Method treatment. [Brad Wilson posted about this earlier this year](http://bradwilson.typepad.com/blog/2008/01/c-30-extension.html), and received some good comments, none of which seem to indicate that these are evil or icky.

From the [ExtensionMethod.Net](http://extensionmethod.net/) site, here is an example of the String check that I use so frequently:

<!--EndFragment-->

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">bool</span> IsNotNullOrEmpty(<span style="color: #0000ff">this</span> <span style="color: #0000ff">string</span> input) {

    <span style="color: #0000ff">return</span> !String.IsNullOrEmpty(input);

}
```

There are actually quite a few cool ones for strings. I think I like having Format as an extension as well:

<!--EndFragment-->

```
<span style="color: #0000ff">using</span> System;
<span style="color: #0000ff">using</span> System.Linq
<span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">class</span> StringExtensions

{

    <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">string</span> Format(<span style="color: #0000ff">this</span> <span style="color: #0000ff">string</span> format, <span style="color: #0000ff">object</span> arg, <span style="color: #0000ff">params</span> <span style="color: #0000ff">object</span>[] additionalArgs)

    {

        <span style="color: #0000ff">if</span> (additionalArgs == <span style="color: #0000ff">null</span> || additionalArgs.Length == 0)

        {

            <span style="color: #0000ff">return</span> <span style="color: #0000ff">string</span>.Format(format, arg);

        }

        <span style="color: #0000ff">else</span>

        {

            <span style="color: #0000ff">return</span> <span style="color: #0000ff">string</span>.Format(format, <span style="color: #0000ff">new</span> <span style="color: #0000ff">object</span>[] { arg }.Concat(additionalArgs).ToArray());

        }

    }

}
```

<!--StartFragment-->

**Update: The Format extension method doesn’t work as-is. I’ve renamed mine to Formatx(), which works.**

<!--EndFragment-->