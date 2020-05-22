---
templateKey: blog-post
title: Handy EnumerableExtensions
path: blog-post
date: 2011-11-10T05:42:00.000Z
description: There’s a great site for finding extension methods,
  ExtensionMethod.net.  I don’t believe either of these came from there, and
  I’ve not (yet) submitted them there, but here are a couple of extensions on
  IEnumerable<T> that I’ve found useful recently.
featuredpost: false
featuredimage: /img/java-script.png
tags:
  - C#
  - dotnet
  - enumerables
  - tips and tricks
category:
  - Software Development
comments: true
share: true
---
There’s a great site for finding extension methods, [ExtensionMethod.net](http://extensionmethod.net/). I don’t believe either of these came from there, and I’ve not (yet) submitted them there, but here are a couple of extensions on IEnumerable<T> that I’ve found useful recently.

## ForEach<T>

The first one is simply a method that allows you to easily iterate over a sequence and perform an action on it. This is a pretty commonly useful extension method, so much so that it’s now included in .NET 4.0 out of the box. But if you’re using an older version of the framework, this is one you can roll yourself.

```
public static void ForEach<T>(this IEnumerable<T> items, Action<T> action)
{
    foreach (T item in items)
    {
        action(item);
    }
}
```

## ContainsAny<T>

If you have a collection, you can test for whether it contains an item by using the .Contains(T item) extension method. However, this only works for single instances of an item. What if you have a set of items and you need to know if that set contains any elements of a second set of items? For that, you want to use ContainsAny(), which you can use with either a params collection (specify each item inline) or with an enumerable parameter. Here are the methods:

```
<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">bool</span> ContainsAny&lt;T&gt;(<span style="color: #0000ff;">this</span> IEnumerable&lt;T&gt; sequence, <span style="color: #0000ff;">params</span> T[] matches)
{

    <span style="color: #0000ff;">return</span> matches.Any(<span style="color: #0000ff;">value</span> =&gt; sequence.Contains(<span style="color: #0000ff;">value</span>));

}

<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">static</span> <span style="color: #0000ff;">bool</span> ContainsAny&lt;T&gt;(<span style="color: #0000ff;">this</span> IEnumerable&lt;T&gt; sequence, IEnumerable&lt;T&gt; matches)

{

    <span style="color: #0000ff;">return</span> matches.Any(<span style="color: #0000ff;">value</span> =&gt; sequence.Contains(<span style="color: #0000ff;">value</span>));

}
```

And here are some passing unit tests that demonstrate how these are used:

```
[TestFixture]

<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">class</span> ContainsAnyShould

{

    [Test]

    <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">void</span> ReturnTrueGivenMatchInItemCollection()
  {

        var testList = <span style="color: #0000ff;">new</span> List&lt;<span style="color: #0000ff;">string</span>&gt;() { <span style="color: #006080;">"A"</span>, <span style="color: #006080;">"B"</span>, <span style="color: #006080;">"C"</span> };
      var filterList = <span style="color: #0000ff;">new</span> List&lt;<span style="color: #0000ff;">string</span>&gt;() { <span style="color: #006080;">"C"</span>, <span style="color: #006080;">"D"</span>, <span style="color: #006080;">"E"</span> };

     Assert.IsTrue(testList.ContainsAny(filterList));

    }
    [Test]

    <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">void</span> ReturnFalseGivenNoMatchInItemCollection()

    {

        var testList = <span style="color: #0000ff;">new</span> List&lt;<span style="color: #0000ff;">string</span>&gt;() { <span style="color: #006080;">"A"</span>, <span style="color: #006080;">"B"</span>, <span style="color: #006080;">"C"</span> };

        var filterList = <span style="color: #0000ff;">new</span> List&lt;<span style="color: #0000ff;">string</span>&gt;() { <span style="color: #006080;">"D"</span>, <span style="color: #006080;">"E"</span> };

        Assert.IsFalse(testList.ContainsAny(filterList));
    }

    [Test]

    <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">void</span> ReturnTrueGivenMatchInParamCollection()

    {

        var testList = <span style="color: #0000ff;">new</span> List&lt;<span style="color: #0000ff;">string</span>&gt;() { <span style="color: #006080;">"A"</span>, <span style="color: #006080;">"B"</span>, <span style="color: #006080;">"C"</span> };
        Assert.IsTrue(testList.ContainsAny(<span style="color: #006080;">"C"</span>, <span style="color: #006080;">"D"</span>, <span style="color: #006080;">"E"</span>));
   }

    [Test]

    <span style="color: #0000ff;">public</span> <span style="color: #0000ff;">void</span> ReturnFalseGivenNoMatchInParamCollection()

    {

        var testList = <span style="color: #0000ff;">new</span> List&lt;<span style="color: #0000ff;">string</span>&gt;() { <span style="color: #006080;">"A"</span>, <span style="color: #006080;">"B"</span>, <span style="color: #006080;">"C"</span> };
      Assert.IsFalse(testList.ContainsAny(<span style="color: #006080;">"D"</span>, <span style="color: #006080;">"E"</span>));

    }
```

Hope these help!