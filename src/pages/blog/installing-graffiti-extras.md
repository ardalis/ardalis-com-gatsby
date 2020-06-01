---
templateKey: blog-post
title: Installing Graffiti Extras
path: blog-post
date: 2008-12-08T11:27:00.000Z
description: "I’ve been wanting to add Next/Previous links to my blog’s posts to
  provide easier navigation for folks who come to the blog and find themselves
  somewhere in the middle of it. My goal is for the top and/or bottom of each
  post to have something like this:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Graffiti
category:
  - Uncategorized
comments: true
share: true
---
I’ve been wanting to add Next/Previous links to my blog’s posts to provide easier navigation for folks who come to the blog and find themselves somewhere in the middle of it. My goal is for the top and/or bottom of each post to have something like this:

**<<*Blog Post Title*|*Blog Post Title*>>**

Most likely my designer will make it look better than this, of course. A quick search revealed that [Graffiti Extras](http://www.codeplex.com/GraffitiExtras/Release/ProjectReleases.aspx?ReleaseId=15653#ReleaseFiles) includes this functionality. I thought I’d grab the Binary release and fired up my FTP client and was ready to do things the old-fashioned way when I discovered the Package option is actually a much easier way to go. What’s a package? Well, [Keyvan has a nice overview of creating and using Graffiti CMS Packages here](http://nayyeri.net/blog/how-to-create-a-package-for-graffiti). Long story short – it’s a zipped folder of files that’s been encoded into an XML format so that you can upload a single, plain text file all in your browser to install addins. After uploading the package, Graffiti presented me with the following:

![image](/img/graffiti-extras.png)

Too easy.

**Don’t forget to go to Site Options > Plug-Ins and Enable the extension.**

My next step is to actually get the Post Navigation stuff working. Keyvan was nice enough to point me to this post on using the [Post Navigator Extension](http://nayyeri.net/blog/post-navigator-extension-for-graffiti). Most of this post talks about writing the extension itself (that would be the C# code) – since this is already done and I’m just hooking into it via Chalk in my themes, I only care about the bottom of the post:

```
$postNavigator.GetNavigator($post, "Previous", "Next")
&#160;
or
&#160;
$postNavigator.GetNavigator($post, true, true, " | ", "", "", "<< ", " >>")
```

**Doh!**

Only one problem – it doesn’t work with the default VistaDB database, which is the one I’m using. [Keyvan’s](http://nayyeri.net/blog) promised me a quick fix for this – I’ll post an update when I get it working.

**Update**

Keyvan fixed the issue and updated CodePlex’s source – the distribution downloads should be updated soon as well. Here’s what mine looks like now:

![image](/img/steve-blog-header.png)

Here’s the code I had to use (some line breaks added for this post):

```
<span style="color: #0000ff">&lt;</span><span style="color: #800000">div</span> <span style="color: #ff0000">class</span><span style="color: #0000ff">=&quot;nextprevious&quot;</span><span style="color: #0000ff">&gt;&lt;</span><span style="color: #800000">div</span> 
<span style="color: #ff0000">class</span><span style="color: #0000ff">=&quot;previous&quot;</span><span style="color: #0000ff">&gt;</span>$postNavigator.GetNavigator($post, 
true, true, &quot;<span style="color: #0000ff">&lt;/</span><span style="color: #800000">div</span><span style="color: #0000ff">&gt;&lt;</span><span style="color: #800000">div</span> <span style="color: #ff0000">class</span><span style="color: #0000ff">='next'</span><span style="color: #0000ff">&gt;</span>&quot;, &quot;&quot;, &quot;&quot;, 
&quot;← &quot;, &quot; →&quot;)<span style="color: #0000ff">&lt;/</span><span style="color: #800000">div</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">div</span><span style="color: #0000ff">&gt;</span>
```