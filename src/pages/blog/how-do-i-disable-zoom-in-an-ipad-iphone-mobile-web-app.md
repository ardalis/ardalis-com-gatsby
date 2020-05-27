---
templateKey: blog-post
title: How Do I Disable Zoom in an iPad iPhone Mobile Web App?
path: blog-post
date: 2012-03-26T23:10:00.000Z
description: "If you’re building web-based applications for mobile devices like
  the iPad/iPhone and you want to mimic native applications’ look and feel and
  experience, one thing you may want to do is disable the pinch zoom gesture. "
featuredpost: false
featuredimage: /img/mobile-app.jpg
tags:
  - iOS
  - iPad
  - iPhone
  - mobile
category:
  - Software Development
comments: true
share: true
---
If you’re building web-based applications for mobile devices like the iPad/iPhone and you want to mimic native applications’ look and feel and experience, one thing you may want to do is disable the pinch zoom gesture. Most native applications don’t offer support for this, but of course most mobile browsers currently do, so a sure way for users to tell that they’re actually viewing a web page is to let them resize the page easily using these gestures. To disable the pinch zoom, you can simply specify an identical starting and maximum scale. This is achieved by adding a viewport meta tag to the page or site in question, like so:

```
<span style="color: #0000ff">&lt;</span><span style="color: #800000">meta</span> <span style="color: #ff0000">name</span><span style="color: #0000ff">="viewport"</span>
```



```
   <span style="color: #ff0000">content</span><span style="color: #0000ff">="width=device-width, initial-scale=1.0, maximum-scale=1.0"</span> <span style="color: #0000ff">/&gt;</span>
```

By adding this viewport tag, you’re forcing the browser to maintain a 100% scale for the page. You can also use the ViewPort meta tag to help optimize how your page or site renders in mobile devices, without limiting users’ ability to zoom in and out. Simply remove the maximum-scale setting in the above meta tag.

With this setting in place, you’re one step closer to creating a web application that behaves like a native iOS app. You can learn more about ViewPort settings specific to the Safari browser on iOS from the [iOS Developer Library article on Configuring the Viewport](http://developer.apple.com/library/ios/#DOCUMENTATION/AppleApplications/Reference/SafariWebContent/UsingtheViewport/UsingtheViewport.html#//apple_ref/doc/uid/TP40006509-SW19).