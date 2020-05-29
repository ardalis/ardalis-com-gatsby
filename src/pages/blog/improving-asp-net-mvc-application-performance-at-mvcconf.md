---
templateKey: blog-post
title: Improving ASP.NET MVC Application Performance at MVCConf
path: blog-post
date: 2011-02-09T03:39:00.000Z
description: Yesterday I gave a presentation to a little over 300 attendees of
  [MVCConf] on Improving ASP.NET MVC Application Performance.
featuredpost: false
featuredimage: /img/asp-net-mvc-logo.jpg
tags:
  - asp.net mvc
  - performance
category:
  - Software Development
comments: true
share: true
---
Yesterday I gave a presentation to a little over 300 attendees of [MVCConf](http://www.mvcconf.com/) on Improving ASP.NET MVC Application Performance. There were some great responses on twitter and generally the ratings on [SpeakerRate](http://speakerrate.com/talks/5535) were positive, which was great because I was a bit worried going into the presentation, since I’d only committed to giving a talk at the conference a few day earlier. I’m uploading the recording of the session to the MVCConf team now, and will add a link here when it’s available.

Since the session was less than an hour, I had a couple of small things that I had wanted to touch on but didn’t have a chance, so I’ll mention those now. I mentioned that having Caching details scattered throughout Controllers and Actions is a bad design that violates the [Don’t Repeat Yourself principle](https://deviq.com/don-t-repeat-yourself/) (featured in the [2011 Software Craftsmanship calendar](http://nimblepros.com/products/software-craftsmanship-2011-calendar.aspx), too). The simplest way to avoid this is to use a Cache Profile. Cache Profiles are defined in web.config under the <system.web><caching> element. You might define a caching profile for the product pages in your web application like so:

![image](<> "image")

Then, within a Controller or Action, when you add an OutputCache attribute, you can specify the cache profile by name, rather than specifying the duration and varybyparam right there in your code. Like so:

![image](<> "image")

The other thing I didn’t cover as deeply as I wanted to was the details of the performance tips for ASP.NET MVC that I showed. I demonstrated the effects of several optimizations on an ASP.NET MVC 3 page that include no database access. These tips were:

1. Switch from Debug to Release mode and turn off debug=”true” in web.config.
2. Avoid passing a null to a strongly typed View that uses Html.EditorFor() and similar helpers.
3. Remove unused view engines to avoid file misses when looking for templates.
4. Turn on output caching.

If you want to make sure your files in production are compiled correctly, you can use the [Isis ASP.NET Control Panel](http://isis.codeplex.com/) to do this, as well as providing one-stop access to manage your trace, error, cache, etc. for your ASP.NET applications. It’s an open source project that’s still rather rough around the edges, but even just the ability to quickly confirm that no assemblies are in production that were built with debug symbols is very useful.

The results look like this:

![image](<> "image")

However, what I didn’t show was the page being tested. The controller is a simple Add() method and the View is a strongly typed view using the MVCMusicStore’s Order object. The Add method, by default, simply has one line: return View();. The View generated looks like this:

```
@model MvcMusicStore.Models.Order<br /><br />@{<br />    ViewBag.Title = <span style="color: #006080">&quot;Add&quot;</span>;<br />    Layout = <span style="color: #006080">&quot;_Blank.cshtml&quot;</span>;<br />}<br /><br />&lt;h2&gt;Add&lt;/h2&gt;<br /><br />&lt;script src=<span style="color: #006080">&quot;@Url.Content(&quot;</span>~/Scripts/jquery.validate.min.js<span style="color: #006080">&quot;)&quot;</span> type=<span style="color: #006080">&quot;text/javascript&quot;</span>&gt;&lt;/script&gt;<br />&lt;script src=<span style="color: #006080">&quot;@Url.Content(&quot;</span>~/Scripts/jquery.validate.unobtrusive.min.js<span style="color: #006080">&quot;)&quot;</span> type=<span style="color: #006080">&quot;text/javascript&quot;</span>&gt;&lt;/script&gt;<br /><br />@<span style="color: #0000ff">using</span> (Html.BeginForm()) {<br />    @Html.ValidationSummary(<span style="color: #0000ff">true</span>)<br />    &lt;fieldset&gt;<br />        &lt;legend&gt;Order&lt;/legend&gt;<br /><br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-label&quot;</span>&gt;<br />            @Html.LabelFor(model =&gt; model.OrderDate)<br />        &lt;/div&gt;<br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-field&quot;</span>&gt;<br />            @Html.EditorFor(model =&gt; model.OrderDate)<br />            @Html.ValidationMessageFor(model =&gt; model.OrderDate)<br />        &lt;/div&gt;<br /><br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-label&quot;</span>&gt;<br />            @Html.LabelFor(model =&gt; model.Username)<br />        &lt;/div&gt;<br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-field&quot;</span>&gt;<br />            @Html.EditorFor(model =&gt; model.Username)<br />            @Html.ValidationMessageFor(model =&gt; model.Username)<br />        &lt;/div&gt;<br /><br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-label&quot;</span>&gt;<br />            @Html.LabelFor(model =&gt; model.FirstName)<br />        &lt;/div&gt;<br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-field&quot;</span>&gt;<br />            @Html.EditorFor(model =&gt; model.FirstName)<br />            @Html.ValidationMessageFor(model =&gt; model.FirstName)<br />        &lt;/div&gt;<br /><br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-label&quot;</span>&gt;<br />            @Html.LabelFor(model =&gt; model.LastName)<br />        &lt;/div&gt;<br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-field&quot;</span>&gt;<br />            @Html.EditorFor(model =&gt; model.LastName)<br />            @Html.ValidationMessageFor(model =&gt; model.LastName)<br />        &lt;/div&gt;<br /><br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-label&quot;</span>&gt;<br />            @Html.LabelFor(model =&gt; model.Address)<br />        &lt;/div&gt;<br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-field&quot;</span>&gt;
<br />            @Html.EditorFor(model =&gt; model.Address)<br />            @Html.ValidationMessageFor(model =&gt; model.Address)<br />        &lt;/div&gt;<br /><br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-label&quot;</span>&gt;<br />            @Html.LabelFor(model =&gt; model.City)<br />        &lt;/div&gt;<br />        &lt;div <span style="color: #0000ff">class</span>=<span style="color: #006080">&quot;editor-field&quot;</span>&gt;<br />
```

Note that this particular view makes heavy use of Html helpers for LabelFor, EditorFor, etc. This is the reason why the optimizations being made have such a dramatic impact on the overall performance. It’s also worth noting that since no data access is included in these tests, these are basically micro-optimizations that most likely would not have a huge impact on the overall page performance once typical data access is included. That said, these can add up to a significant difference, so they’re worth knowing about and applying where they make sense.

You can [download the slides and samples from the presentation here](http://ssmith-presentations.s3.amazonaws.com/ImprovingASPNETMVCPerformance.zip). You can also [view the slides on slideshare](http://www.slideshare.net/ardalis/improving-aspnet-mvc-application-performance). I also promised that I’ll have an article on the CachedRepository Pattern soon – that’s in the works and I hope to have it done later this week. I’ll link to it from here as well. I also mentioned that [using an IOC container like StructureMap with ASP.NET MVC 3](/how-do-i-use-structuremap-with-asp-net-mvc-3) can help make it easy to reconfigure the site’s behavior while tuning – [read more here](/how-do-i-use-structuremap-with-asp-net-mvc-3). And of course, you can [follow me on twitter](http://twitter.com/ardalis), [subcribe to my RSS](http://feeds.feedburner.com/StevenSmith) (even [via email](http://feedburner.google.com/fb/a/mailverify?uri=StevenSmith)), etc. to be sure you get such updates.