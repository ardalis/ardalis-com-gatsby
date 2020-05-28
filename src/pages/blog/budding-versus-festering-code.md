---
templateKey: blog-post
title: Budding Versus Festering Code
path: blog-post
date: 2010-06-28T14:21:00.000Z
description: This is in response to [Michael Feathers’ recent post on Festering
  Code Bases and Budding Code Bases]
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Budding Code
  - Code Bases
category:
  - Uncategorized
comments: true
share: true
---
This is in response to [Michael Feathers’ recent post on Festering Code Bases and Budding Code Bases](http://michaelfeathers.typepad.com/michael_feathers_blog/2010/06/festering-code-bases-and-budding-code-bases.html).

Certainly the default tooling in the Visual Studio space has, until recently, made it dramatically easier to add code to an existing class than to create a new class. However, tools like ReSharper have a large impact on this, and can make it extremely easy to create new classes, put them in their own files, and move those files where they are supposed to go with just a few keystrokes (and VS2010 is coming along in some of these areas as well). So, I think there is a trend in the tooling to make the cost of budding less – it would be interesting to add something to the IDE that would make the cost of festering INCREASE

![](/img/budding-code.png)

Imagine an add-in that would grow more and more annoying as the size of your class increased. Clippy pops up and starts to say “It looks like you’re adding code to a 3000 line class – can I recite the Single Responsibility Principle to you?”

Now we might see something like the virtuous cycle it sounds like Michael Feathers is advocating for, and perhaps with enough added cost to festering code bases, we would see the de facto trend shift toward more budding-style development (and perhaps, as he notes, the problems that this might bring with it).