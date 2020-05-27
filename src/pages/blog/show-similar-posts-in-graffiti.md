---
templateKey: blog-post
title: Show Similar Posts in Graffiti
path: blog-post
date: 2008-07-10T09:31:00.000Z
description: I couldn’t find this with ~~Google~~Live Search but ScottW hooked
  me up. If you want to show related or similar posts in your posts in Graffiti,
  just add this script to your post.view file (which, amazingly enough, you can
  do via the admin tool without FTPing any files to your blog – how cool is
  that?).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Graffiti
category:
  - Uncategorized
comments: true
share: true
---
I couldn’t find this with ~~Google~~Live Search but [ScottW](http://simpable.com/) hooked me up. If you want to show related or similar posts in your posts in [Graffiti](http://graffiticms.com/), just add this script to your post.view file (which, amazingly enough, you can do via the admin tool without FTPing any files to your blog – how cool is that?).

```
<span style="color: #008000">#set($similarPosts = $data.SimilarSearch($post.Id,3)) #foreach($sp in $similarPosts)</span>
 
<span style="color: #008000">#beforeall</span>
&lt;h3&gt;Similar Posts&lt;/h3&gt;
&lt;ol id=<span style="color: #006080">"similarPosts"</span> class=<span style="color: #006080">"list"</span>&gt;
 
<span style="color: #008000">#each</span>
&lt;li&gt;&lt;a href=<span style="color: #006080">"$sp.Url"</span>&gt;$sp.Title&lt;/a&gt;&lt;/li&gt;
 
<span style="color: #008000">#afterall</span>
&lt;/ol&gt;
<span style="color: #008000">#end</span>
```

In theory, at the bottom of this post, you now see a Similar Posts section… I’m not 100% sure what magic it uses to determine that a post is “similar” – we’ll just have to see.