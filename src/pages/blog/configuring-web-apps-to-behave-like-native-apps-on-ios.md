---
templateKey: blog-post
title: Configuring Web Apps To Behave Like Native Apps on iOS
path: blog-post
date: 2012-03-27T01:13:00.000Z
description: There are a number of things you can do with your web-based
  application to have it behave like a native iOS application.
featuredpost: false
featuredimage: /img/ios.jpg
tags:
  - mobile
category:
  - Software Development
comments: true
share: true
---
There are a number of things you can do with your web-based application to have it behave like a native iOS application. One of these I mentioned previously, which is to [disable the user’s ability to zoom in and out using pinch gestures](http://ardalis.com/how-do-i-disable-zoom-in-an-ipad-iphone-mobile-web-app). In addition, you can hide the Safari user interface “chrome” so that the user is unaware they’re in a browser. You can also add splash screens and customize the icon that is shown when users add the web application to their device’s home screen.

## Hide Safari Browser UI

This is referred to as “standalone mode” for your web application, and is accomplished with this meta tag:

```html
<meta name="apple-mobile-web-app-capable" content="yes" />
```

There will still be a status bar at the top of the application. You can further customize the appearance by setting the status bar to be black, allowing your app to utilize the entire screen.

```html
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
```

## Customize iPad or iPhone Icons for Web Apps

Users can easily add links to web pages to their iOS device’s home screen. As a web developer, you’d like to be able to control the appearance of the icon that is used to represent your web site or application on the user’s device. You can do this with a few more meta tags. Incidentally, Apple calls these “Web Clips” though I can’t fathom why. So, if you’re searching for more information on customizing how your web app’s icon appears on a user’s home screen, search for web clips.

At its simplest, all you need to do is specify an icon. This can be done using this meta tag:

```html
<link rel="apple-touch-icon" href="/custom_icon.png />
```

If you don’t want the icon to be messed with at all by iOS, then you need to add –precomposed to it:

```html
<link rel="apple-touch-icon-precomposed" href="/custom_icon.png />
```

By default, icons should be 57×57 pixels in size. However, some devices use different resolutions for their icons. You can (and should) create icons for each of the supported sizes and specify them using the sizes attribute, like so:

```html
<link rel="apple-touch-icon" sizes="72x72" href="touch-icon-ipad.png" />
```

```html
<link rel="apple-touch-icon" sizes="114x114" href="touch-icon-iphone4.png" />
```

You can also simply add these icons to your web site’s root URL, and if they use a well-known name they will be discovered and used. The most basic filename is simply **apple-touch-icon.png**, but you can include size information and whether it is precomposed as well (e.g. **apple-touch-icon-57×57-precomposed.png**). Naturally, you’ll be (slightly) better off from a performance perspective if you tell iOS which icon to use via a <link> than by having it try multiple different convention-based image URLs.

## Adding a Splash Screen

Many native apps on mobile devices like iOS display a splash screen as the application is launching. Web pages and applications, typically, do no such thing. Thus, one more way you can make your web apps behave more like native apps on iOS is to add a splash screen to them. apple calls these Startup Images, and the process is largely the same as for customizing icons – you simply need to add the appropriate tags via <link> elements. As with icons, there are options available to specify different splash screen images for different device sizes. The most basic option is to simply set a single image:

```html
<link rel="apple-touch-startup-image" href="/startup.png" />
```

For iPhone and iPod touch, the image needs to be 320×460 pixels. However, if you want to use a higher-resolution image for iPads(1 and 2 in this case), etc. you can achieve this like so:

```html
<link rel="apple-touch-startup-image" href="/startup-748x1024.jpg"
  media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:landscape)" />
```

```html
<link rel="apple-touch-startup-image" href="/startup-768x1004.jpg">
  media="screen and (min-device-width: 481px) and (max-device-width: 1024px) and (orientation:portrait)" />
 ```

## Summary

Especially as [Single Page Applications take off in popularity](http://ardalis.com/getting-started-with-single-page-applications-in-asp.net), the ability to run such applications on iOS devices as if they were actually native apps will be an important feature. Here I’ve shown a few settings that can easily be applied to any such application, or to any web page, to make the user experience of working with the web page nearly indistinguishable from using a native iOS application. You can learn more about [customizing web content for iOS in the iOS Developer Library](http://developer.apple.com/library/ios/#DOCUMENTATION/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html).