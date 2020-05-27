---
templateKey: blog-post
title: Passing Default Parameter Objects in JavaScript
path: blog-post
date: 2014-01-27T17:14:00.000Z
description: "You can use the jQuery extend() function to elegantly configure
  your functions to accept a single parameter object, while providing default
  behavior for any options that are not set. "
featuredpost: false
featuredimage: /img/image_thumb_3_jquery.png
tags:
  - javascript
  - jquery
category:
  - Software Development
comments: true
share: true
---
You can use the [jQuery extend() function](http://api.jquery.com/jquery.extend)to elegantly configure your functions to accept a single parameter object, while providing default behavior for any options that are not set. For instance, imagine you have a simple function that simply says “Hello, World”. You could code it like this:

![](/img/image_3_jquery.png)

Now, if you want to start passing in parameters, you can easily do so by parameterizing the method, but every time you do, you break any code that was expecting the original parameterless version. This can quickly grow out of hand within a few revisions of the function’s signature. A simple way to avoid this issue and allow for your function to version forward effectively is to accept a parameter object. An initial version might look like this, inspecting the typeof the parameter to see if it is undefined, and if so, using the default options. Otherwise, use the options that were provided as the parameter.

![](/img/image_thumb_2_jquery.png)

This is great, but what if we want to change some of the parameters, but not all of them. Trying to only change the greeting results in:

![](/img/image_thumb_3_jquery.png)

The jQuery extend() function provides a handy way for us to have default values in a parameter object, but override any that are provided to the function. Here’s the code for the updated version of the function, now using extend (and the slightly worse-named parameter object variable, params):

![](/img/image_thumb_4_jquery.png)

Note that the default values are specified as the first parameter to .extend(), and the ones that are passed in are the second parameter. Also note that in the case no parameter object is passed in, we simply initialize params to be an empty object ({}). You can check this out yourself by looking at [this jsFiddle showing all of the code](http://jsfiddle.net/Kzdsu/2).