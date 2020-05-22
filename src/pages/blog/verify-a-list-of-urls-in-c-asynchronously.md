---
templateKey: blog-post
title: Verify a List of URLs in C# Asynchronously
path: blog-post
date: 2010-11-11T12:14:00.000Z
description: Recently I wanted to test a bunch of URLs to see whether they were
  broken/valid.  In my scenario, I was checking on URLs for advertisements that
  are served by Lake Quincy Media’s ad server (LQM is the largest Microsoft
  developer focused advertising network/agency).
featuredpost: false
featuredimage: /img/web-address.jpg
tags:
  - async
  - C#
  - testing
category:
  - Software Development
comments: true
share: true
---
Recently I wanted to test a bunch of URLs to see whether they were broken/valid. In my scenario, I was checking on URLs for advertisements that are served by [Lake Quincy Media’s ad server](http://lakequincy.com/) (LQM is the largest Microsoft developer focused advertising network/agency). However, this kind of thing is an extremely common task that should be very easy for any web developer or even just website administrator to want to do. It also gave me an opportunity to use the new asynch features in .NET 4 for a production use, since prior to this I’d only played with samples.

**Check if a URL is OK**

First, you’ll need a method that will tell you whether a given URL is OK. What OK means might vary based on your needs – in my case I was just looking for the status code. I found the following code [here](http://stackoverflow.com/questions/924679/c-how-can-i-check-if-a-url-exists-is-valid/3808841#3808841).



```
<span style="color: #606060" id="lnum1">   1:</span> <span style="color: #0000ff">private</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">bool</span> RemoteFileExists(<span style="color: #0000ff">string</span> url)
<span style="color: #606060" id="lnum2">   2:</span> {
<span style="color: #606060" id="lnum3">   3:</span>     <span style="color: #0000ff">try</span>
<span style="color: #606060" id="lnum4">   4:</span>     {
<span style="color: #606060" id="lnum5">   5:</span>         var request = WebRequest.Create(url) <span style="color: #0000ff">as</span> HttpWebRequest;
<span style="color: #606060" id="lnum6">   6:</span>         request.Method = <span style="color: #006080">&quot;HEAD&quot;</span>;
<span style="color: #606060" id="lnum7">   7:</span>         var response = request.GetResponse() <span style="color: #0000ff">as</span> HttpWebResponse;
<span style="color: #606060" id="lnum8">   8:</span>         <span style="color: #0000ff">return</span> (response.StatusCode == HttpStatusCode.OK);
<span style="color: #606060" id="lnum9">   9:</span>     }
<span style="color: #606060" id="lnum10">  10:</span>     <span style="color: #0000ff">catch</span>
<span style="color: #606060" id="lnum11">  11:</span>     {
<span style="color: #606060" id="lnum12">  12:</span>         <span style="color: #0000ff">return</span> <span style="color: #0000ff">false</span>;
<span style="color: #606060" id="lnum13">  13:</span>     }
<span style="color: #606060" id="lnum14">  14:</span> }
```

**Using this Synchronously**

If you want to use this synchronously, it’s pretty simple. Get a list of URLs and write a loop something like this:

```
<span style="color: #606060" id="lnum1">   1:</span> <span style="color: #0000ff">foreach</span> (var link <span style="color: #0000ff">in</span> myLinksToCheck)
<span style="color: #606060" id="lnum2">   2:</span> {
<span style="color: #606060" id="lnum3">   3:</span>    link.IsValid = RemoteFileExists(link.Url);
<span style="color: #606060" id="lnum4">   4:</span> }
```

I checked about 1500 URLs with my script and I wrote it with a flag that would let me run it synch or asynch. The synchronous version took **about an hour and forty minutes** to complete. The asynch one took **about seventeen minutes** to complete.

**Make it Parallel**

If you want to see how to do things using the parallel libraries that are now part of .NET 4, there’s no better place to start than the [Samples for Parallel Programming with the .NET Framework 4](http://code.msdn.microsoft.com/ParExtSamples). There’s some very cool stuff here. Be sure to check out the Conway’s Game of Life WPF sample.

For me, there were two steps I had to take to turn my synchronous process into a parallelizable process.

1. Create an Action<T> method that would perform the URL check operation and store the result in my collection. I created a method UpdateUrlStatus(Link linkToCheck) to do this work.

2. Call this method using the new Parallel.For() helper found in System.Threading.Tasks.

Here’s the code, slightly modified from my own domain-specific code:

```
<span style="color: #606060" id="lnum1">   1:</span> var linkList = GetLinks();  
<span style="color: #606060" id="lnum2">   2:</span> Console.WriteLine(<span style="color: #006080">&quot;Loaded {0} links.&quot;</span>, linkList.Count);
<span style="color: #606060" id="lnum3">   3:</span>     
<span style="color: #606060" id="lnum4">   4:</span> Action&lt;<span style="color: #0000ff">int</span>&gt; updateLink = i =&gt;
<span style="color: #606060" id="lnum5">   5:</span>     {
<span style="color: #606060" id="lnum6">   6:</span>         UpdateLinkStatus(linkList[i]);
<span style="color: #606060" id="lnum7">   7:</span>         Console.Write(<span style="color: #006080">&quot;.&quot;</span>);
<span style="color: #606060" id="lnum8">   8:</span>     };
<span style="color: #606060" id="lnum9">   9:</span> Parallel.For(0, linkList.Count, updateLink);
<span style="color: #606060" id="lnum10">  10:</span>&#160; 
<span style="color: #606060" id="lnum11">  11:</span> <span style="color: #008000">// replaces this synchronous version:</span>
<span style="color: #606060" id="lnum12">  12:</span> <span style="color: #0000ff">for</span>(<span style="color: #0000ff">int</span> i=0; i &lt; linkList.Count; i++)
<span style="color: #606060" id="lnum13">  13:</span> {
<span style="color: #606060" id="lnum14">  14:</span>     updateLink(i);
<span style="color: #606060" id="lnum15">  15:</span> }
```

In my scenario, using the parallel instead of the iterative approach dropped the time from about 100 minutes down to about 17. That’s on a machine that appears to windows to have 8 cores. 100/8 = 12.5 so it’s not quite a straight eightfold increase, but it’s close. If you’ve got applications that are doing a lot of the same kind of work and each operation has little or no dependencies on the other operations, consider using Action<T> and Parallel.For() to take advantage of the many cores available on most modern computers to speed it up.