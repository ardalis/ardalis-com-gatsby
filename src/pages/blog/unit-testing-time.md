---
templateKey: blog-post
title: Unit Testing Time
path: blog-post
date: 2008-07-07T02:38:26.520Z
description: "[Oren] has a post showing how he [deals with time sensitive code
  in his unit tests]. One thing that’s interesting is that, like my previous
  post, deals with the System.Func<T> construct introduced in .NET 3.5."
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Unit Testing
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[Oren](http://ayende.com/) has a post showing how he [deals with time sensitive code in his unit tests](http://ayende.com/Blog/archive/2008/07/07/Dealing-with-time-in-tests.aspx). One thing that’s interesting is that, like my previous post, deals with the System.Func<T> construct introduced in .NET 3.5. I see this convention more and more and it’s really growing on me. I’ve dealt with timing issues in my own code using a convention similar to the one Ayende demonstrates, which is to create a singleton or static property for the system time, and consistently reference this time everywhere rather than DateTime.Now(). References to DateTime.Now() are dependencies that should be abstracted away through some form of Dependency Injection or similar technique. Writing unit tests that look like this is icky (trust me, I know, this is from some real code of mine that wraps HttpRuntime.Cache):

<!--EndFragment-->

```
[TestMethod]

<span style="color: #0000ff">public</span> <span style="color: #0000ff">void</span> TimeDependency()

{

    myCache.Insert(myKey, myValue, cacheSeconds);

    Assert.AreEqual(myValue, myCache[myKey], <span style="color: #006080">"Value removed immediately - should still be there."</span>);

    System.Threading.Thread.Sleep(<span style="color: #0000ff">new</span> TimeSpan(0, 0, 0, cacheSeconds).Add(TimeSpan.FromMilliseconds(500)));

    Assert.IsNull(myCache[myKey], <span style="color: #006080">"Value should be expired from cache at this point."</span>);

}
```

<!--StartFragment-->

Any time you’re having to put Thread.Sleep() in your unit test, that’s a big sign something’s wrong.

To correct this, what I have done in the past is define a ***Context.ServerTime*** property of type DateTime which I can set, but which defaults to DateTime.Now(). However, Oren’s technique of actually using a delegate for the time, which can be replaced with either a static value or a new method for computing the current time, seems like a definite improvement (and looks like this):

<!--EndFragment-->

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">class</span> SystemTime 

{  

    <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> Func&lt;DateTime&gt; Now = () =&gt; DateTime.Now; 
}
```

<!--StartFragment-->

With this code in place, changing the definition of “now” in a unit test involves simply one line of code:

<!--EndFragment-->

```
SystemTime.Now = () =&gt; <span style="color: #0000ff">new</span> DateTime(2008,1,1);
```

<!--StartFragment-->

The () => syntax is simply a parameterless delegate. I’m really loving these.

<!--EndFragment-->