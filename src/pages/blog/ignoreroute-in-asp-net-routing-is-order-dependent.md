---
templateKey: blog-post
title: IgnoreRoute in ASP.NET Routing is Order Dependent
path: blog-post
date: 2009-05-12T06:42:00.000Z
description: I’m wiring up the IoCController Factory from MVCContrib into an MVC
  application and I kept running into an issue where a request was coming in
  looking for a ContentController.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
I’m wiring up the IoCController Factory from [MVCContrib](http://www.codeplex.com/MVCContrib) into an MVC application and I kept running into an issue where a request was coming in looking for a ContentController. The reason for this is that in my CSS file I have a property like this:

**background: transparent url(images/logo.gif) no-repeat scroll left top;**

which is in the Content folder. The resulting request for “/Content/images/logo.gif” was matching the default routing rule:

**routes.MapRoute(\
"Default", // Route name\
"{controller}/{action}/{id}", // URL with parameters\
new { controller = "Home", action = "Index", id = "" } // Parameter defaults\
);**

and the result was that it excpeted to find a controller by the name of Content. I searched and found [this post](http://209.85.173.132/search?q=cache:rRf4IN5R1agJ:www.codingcontext.com/%3Ftag%3Dioc+asp.net+mvc+contentcontroller+ioc&cd=2&hl=en&ct=clnk&gl=us&client=firefox-a) that had some useful ideas that I tried. At first, adding this had no effect:

**routes.IgnoreRoute("{Content}/{*pathInfo}");**

However, once I realized that the order mattered, and moved this to the top of my RegisterRoutes() method, it worked as expected.

I can understand that the ordering of the routes is important, for matching purposes, but it’s not intuitive to me that ignored routes should be order-dependent. I would think that there would be two lists in the RouteCollection, one for actual routes, and a separate one for ignored route patterns. The ignored routes would be checked every time, and anything that matched ignored (duh), while the actual routes would be checked in order, with the first matching route determining the appropriate controller to use. However, this doesn’t appear to be the case.

The following **will ignore the Content folder** for routing purposes:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> RegisterRoutes(RouteCollection routes)
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     routes.IgnoreRoute(<span style="color: #006080">&quot;{Content}/{*pathInfo}&quot;</span>); 
<span style="color: #606060">   4:</span>&#160; 
<span style="color: #606060">   5:</span>     routes.MapRoute(
<span style="color: #606060">   6:</span>         <span style="color: #006080">&quot;Default&quot;</span>,                                              <span style="color: #008000">// Route name</span>
<span style="color: #606060">   7:</span>         <span style="color: #006080">&quot;{controller}/{action}/{id}&quot;</span>,                           <span style="color: #008000">// URL with parameters</span>
<span style="color: #606060">   8:</span>         <span style="color: #0000ff">new</span> { controller = <span style="color: #006080">&quot;Home&quot;</span>, action = <span style="color: #006080">&quot;Index&quot;</span>, id = <span style="color: #006080">&quot;&quot;</span> }  <span style="color: #008000">// Parameter defaults</span>
<span style="color: #606060">   9:</span>     );
<span style="color: #606060">  10:</span> } 
```

The following **will not ignore the Content folder**:

```
<span style="color: #606060">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">void</span> RegisterRoutes(RouteCollection routes)
<span style="color: #606060">   2:</span> {
<span style="color: #606060">   3:</span>     routes.MapRoute(
<span style="color: #606060">   4:</span>         <span style="color: #006080">&quot;Default&quot;</span>,                                              <span style="color: #008000">// Route name</span>
<span style="color: #606060">   5:</span>         <span style="color: #006080">&quot;{controller}/{action}/{id}&quot;</span>,                           <span style="color: #008000">// URL with parameters</span>
<span style="color: #606060">   6:</span>         <span style="color: #0000ff">new</span> { controller = <span style="color: #006080">&quot;Home&quot;</span>, action = <span style="color: #006080">&quot;Index&quot;</span>, id = <span style="color: #006080">&quot;&quot;</span> }  <span style="color: #008000">// Parameter defaults</span>
<span style="color: #606060">   7:</span>     );
<span style="color: #606060">   8:</span>&#160; 
<span style="color: #606060">   9:</span>     routes.IgnoreRoute(<span style="color: #006080">&quot;{Content}/{*pathInfo}&quot;</span>);
<span style="color: #606060">  10:</span> }
```

It seems the actual implementation of IgnoreRoute is more of an actual MapRoute that simply maps to nothing. Thus, it follows all the same ordering logic that MapRoute follows. Once you make this realization, it makes sense, and of course you’ll want to put your IgnoreRoutes first (assuming you really want them to always be ignored) – otherwise they won’t be ignored.