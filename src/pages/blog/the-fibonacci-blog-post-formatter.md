---
templateKey: blog-post
title: The Fibonacci Blog Post Formatter
path: blog-post
date: 2009-06-11T00:38:00.000Z
description: Sarah suggested Tuesday that I write a blog PostFormatter that only
  changed the format of blog posts created on days that were Fibonacci Sequence
  days (e.g. 1, 2, 3, 5, 8…). I’d hoped to code something like that up during my
  Ann Arbor talk last night but ended up not having the time, so just to show
  how easily this could be done, I threw something together today.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - PostFormatter
category:
  - Uncategorized
comments: true
share: true
---
[Sarah](http://twitter.com/sadukie) suggested Tuesday that I write a blog PostFormatter that only changed the format of blog posts created on days that were [Fibonacci Sequence](http://en.wikipedia.org/wiki/Fibonacci_number) days (e.g. 1, 2, 3, 5, 8…). I’d hoped to code something like that up during my Ann Arbor talk last night but ended up not having the time, so just to show how easily this could be done, I threw something together today.

First, this is for a demo application that I used in my talks this week – if you want to follow along, [grab the code from my last post](/asp-net-mvc-and-solid-programming-principles-june-2009).

I already had a well-tested but not at all optimized Fib generator/tester class from some Euler problems I’d worked on as part of a coding kata, so I just reused that for the formatter. The complete code for the new IPostFormatter implementation is shown here:

```
<span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">class</span> FibPostFormatter : IPostFormatter
{
    <span style="color: rgb(0, 0, 255);">public</span> Post FormatPost(Post post)
    {
        var fibChecker = <span style="color: rgb(0, 0, 255);">new</span> FibonacciChecker();
        <span style="color: rgb(0, 0, 255);">if</span> (fibChecker.IsFib(post.DatePosted.Day))
        {
            post.Title = <span style="color: rgb(0, 96, 128);">&quot;[FibDate!] &quot;</span> + post.Title;
        }
        post.EncodedTitle = Utility.BuildFriendlyUrl(post.Title);
        post.Abstract = Utility.GetAbstract(post.Contents);
        <span style="color: rgb(0, 0, 255);">return</span> post;
    }
 
    <span style="color: rgb(0, 0, 255);">private</span> <span style="color: rgb(0, 0, 255);">class</span> FibonacciChecker
    {
        <span style="color: rgb(0, 0, 255);">private</span> List&lt;<span style="color: rgb(0, 0, 255);">int</span>&gt; fibNumbers;
 
        <span style="color: rgb(0, 0, 255);">public</span> FibonacciChecker()
        {
            fibNumbers = <span style="color: rgb(0, 0, 255);">new</span> List&lt;<span style="color: rgb(0, 0, 255);">int</span>&gt;();
        }
        <span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">bool</span> IsFib(<span style="color: rgb(0, 0, 255);">int</span> numberToTest)
        {
            var fibNumbers = <span style="color: rgb(0, 0, 255);">new</span> List&lt;<span style="color: rgb(0, 0, 255);">int</span>&gt;();
            fibNumbers = GenerateFibs(numberToTest);
            <span style="color: rgb(0, 0, 255);">return</span> fibNumbers.Contains(numberToTest);
        }
 
        <span style="color: rgb(0, 0, 255);">public</span> List&lt;<span style="color: rgb(0, 0, 255);">int</span>&gt; GenerateFibs(<span style="color: rgb(0, 0, 255);">int</span> upperBound)
        {
            fibNumbers = <span style="color: rgb(0, 0, 255);">new</span> List&lt;<span style="color: rgb(0, 0, 255);">int</span>&gt;();
            <span style="color: rgb(0, 0, 255);">if</span> (fibNumbers.Count == 0)
            {
                fibNumbers.Add(1);
                fibNumbers.Add(2);
            }
            <span style="color: rgb(0, 0, 255);">int</span> index = 2;
            <span style="color: rgb(0, 0, 255);">int</span> term = 0;
            <span style="color: rgb(0, 0, 255);">while</span> (term &lt;= upperBound)
            {
                term = fibNumbers[index - 2] + fibNumbers[index - 1];
                fibNumbers.Add(term);
                index++;
            }
            <span style="color: rgb(0, 0, 255);">return</span> fibNumbers;
        }
    }
 
}
```

Again, it could benefit from some optimization – it was the result of a timeboxed Euler exercise and it certainly is adequate for testing of days up to and including 31.

Naturally I wanted to be sure this worked, so I added the following test class:

```
<span style="color: rgb(0, 0, 255);">using</span> System;
<span style="color: rgb(0, 0, 255);">using</span> System.Collections.Generic;
<span style="color: rgb(0, 0, 255);">using</span> Microsoft.VisualStudio.TestTools.UnitTesting;
<span style="color: rgb(0, 0, 255);">using</span> SolidBlog.Controllers;
<span style="color: rgb(0, 0, 255);">using</span> SolidBlog.Models;
 
<span style="color: rgb(0, 0, 255);">namespace</span> SolidBlog.Tests.Formatters
{
    [TestClass]
    <span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">class</span> PostFormatterTester
    {
        <span style="color: rgb(0, 0, 255);">private</span> <span style="color: rgb(0, 0, 255);">const</span> <span style="color: rgb(0, 0, 255);">string</span> TEST_TITLE = <span style="color: rgb(0, 96, 128);">&quot;test title&quot;</span>;
        <span style="color: rgb(0, 0, 255);">private</span> FibPostFormatter _fibPostFormatter;
        <span style="color: rgb(0, 0, 255);">private</span> <span style="color: rgb(0, 0, 255);">const</span> <span style="color: rgb(0, 0, 255);">string</span> EXPECTED_PREFIX = <span style="color: rgb(0, 96, 128);">&quot;[FibDate!] &quot;</span>;
 
        [TestInitialize]
        <span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">void</span> Setup()
        {
            _fibPostFormatter = <span style="color: rgb(0, 0, 255);">new</span> FibPostFormatter();
        }
 
        [TestMethod]
        <span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">void</span> FibDaysShouldBeFormattedAsFib()
        {
            var fibDays = <span style="color: rgb(0, 0, 255);">new</span> List&lt;<span style="color: rgb(0, 0, 255);">int</span>&gt;() {1, 2, 3, 5, 8, 13, 21};
            <span style="color: rgb(0, 0, 255);">foreach</span> (var day <span style="color: rgb(0, 0, 255);">in</span> fibDays)
            {
                Post myPost = _fibPostFormatter.FormatPost(GetTestPostForDayOfJanuary(day));
                Assert.AreEqual(EXPECTED_PREFIX + TEST_TITLE, myPost.Title, 
                    <span style="color: rgb(0, 96, 128);">&quot;Didn't format title correctly for fib day &quot;</span> + day);
            }
        }
 
        [TestMethod]
        <span style="color: rgb(0, 0, 255);">public</span> <span style="color: rgb(0, 0, 255);">void</span> NonFibDaysShouldNotBeFormattedAsFib()
        {
            var fibDays = <span style="color: rgb(0, 0, 255);">new</span> List&lt;<span style="color: rgb(0, 0, 255);">int</span>&gt;() { 4, 6, 7, 9, 10, 11, 12, 14, 15, 16, 17, 18, 19, 
                20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31 };
            <span style="color: rgb(0, 0, 255);">foreach</span> (var day <span style="color: rgb(0, 0, 255);">in</span> fibDays)
            {
                Post myPost = _fibPostFormatter.FormatPost(GetTestPostForDayOfJanuary(day));
                Assert.AreEqual(TEST_TITLE, myPost.Title, 
                    <span style="color: rgb(0, 96, 128);">&quot;Formatted title incorrectly for nonfib day &quot;</span> + day);
            }
        }
 
 
        <span style="color: rgb(0, 0, 255);">private</span> Post GetTestPostForDayOfJanuary(<span style="color: rgb(0, 0, 255);">int</span> day)
        {
            DateTime testPostDate = <span style="color: rgb(0, 0, 255);">new</span> DateTime(2009, 1, day);
            var myPost = <span style="color: rgb(0, 0, 255);">new</span> Post() { DatePosted = testPostDate, Title = TEST_TITLE, 
                Abstract = <span style="color: rgb(0, 96, 128);">&quot;&quot;</span>, Contents = <span style="color: rgb(0, 96, 128);">&quot;&quot;</span> };
 
            <span style="color: rgb(0, 0, 255);">return</span> myPost;
        }
 
    }
}
```

Both tests pass. Finally, to wire this up in my blog application, I simply need to turn on the IoC stuff in global.asax (uncomment line 35) and be sure to use the new Create() action of my PostController (line 175 in PostController needs renamed to Create and the other Create() renamed to something else). Finally, change the IPostFormatter line in ConfigureIoC() in global.asax (line 51/52) to the following:

```
StructureMapConfiguration.BuildInstancesOf&lt;IPostFormatter&gt;().TheDefaultIsConcreteType
    &lt;FibPostFormatter&gt;();
```

With that you can run the app and if you happen to create a new post on one of the Fib sequence days of the month, you’ll see that it makes a note of this by prefixing the title with “\[FibDate!] “.

Note that to achieve this (assuming that the application we were changing already was using IoC and the refactored version of Create()) we didn’t have to change any existing code (well, ok, one line of IoC bootstrapping code). That’s the [Open/Closed Principle](http://en.wikipedia.org/wiki/Open/closed_principle). Adding additional features or changing the system’s behavior should not require that you change existing code, but rather that you encapsulate new behavior into new classes that can be swapped out via the interfaces used to refer to them.

a2chrisn4u