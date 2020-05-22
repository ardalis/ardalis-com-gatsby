---
templateKey: blog-post
title: Moores Law and the Hybrid Mobile Application
path: blog-post
date: 2013-12-05T17:24:00.000Z
description: "If you’re building software today, you’ve probably faced the
  question of whether or not you need to build a mobile version of your
  application. "
featuredpost: false
featuredimage: /img/mobile-app.jpg
tags:
  - mobile
category:
  - Software Development
comments: true
share: true
---
If you’re building software today, you’ve probably faced the question of whether or not you need to build a mobile version of your application. In that case, or in the case where you’re decided from the outset you’re building a mobile app, the next question is, which mobile platform do you target? Here there are several options:

* Target Android. It’s got the biggest market share. ([69% in 2012](http://venturebeat.com/2013/01/28/android-captured-almost-70-global-smartphone-market-share-in-2012-apple-just-under-20))
* Target iOS. It’s where the money is ([iOS apps earn over 2x as much as Android for paid downloads and In-App Purchases](http://www.businessinsider.com/chart-of-the-day-the-difference-in-developer-revenue-between-android-and-ios-2013-11)).
* Target Windows Phone 8. Its Nokia phones are gaining in popularity (sales [doubled from Q3 2012 to Q3 2013](http://bgr.com/2013/11/14/windows-phone-blackberry-market-share-2)), but it’s still a small player ([4% globally](http://www.wpcentral.com/windows-phone-gains-4-percent-market-share-q3-2013-android-ios-stay-flat)).
* Target [all of the above](http://venturebeat.com/2013/11/20/html5-vs-native-vs-hybrid-mobile-apps-3500-developers-say-all-three-please):

  * Build a [responsive, mobile-optimized web site](http://readwrite.com/2013/04/16/10-developer-tips-to-build-a-responsive-website-infographic#awesm=~opaa4j0FfwWi8a)
  * Build a hybrid mobile application using HTML5/JS running on the mobile device
  * Build separate native applications for each platform

Of course there are many valid reasons for building native apps. If there are unique device capabilities that you cannot utilize otherwise, naturally write native code. If you only need it to run on one device and your team knows that platform, write native code. However, if you’re going for maximum reach, then you’re going to want something that runs on all phones. That means you’re either going to have to write at least the UI layer multiple times (even using something like Xamarin, which requires separate code for [iOS](http://xamarin.com/ios) and [Android](http://xamarin.com/android)), or you’re going to want to embrace web-powered options.

Building a mobile-enhanced web application is of course still a viable option. However, this limits you to running in the browser, and although there are tricks that can be used to [remove the browser chrome](http://stackoverflow.com/questions/6440386/is-it-possible-hide-ios-browser-chrome-on-a-normal-webpage) or have the bookmarked web page [appear like an app on the device](http://www.marcofolio.net/webdesign/build_native-looking_apps_for_ios.html), the page is still not going to show up in the app store, and thus won’t benefit from the discoverability this provides. Web sites also cannot take advantage of many device capabilities that native or hybrid applications can, which of course can also be a showstopper.

### So what about Hybrid Mobile Applications?

These would seem like the no-brainer solution. They’re built like web pages, but are packaged up and deployed to the device as an actual app. They’re sold in the app store, and in most cases [they’re indistinguishable from native apps](http://www.youtube.com/watch?v=hHk1ENkwWq8). However, [some notable companies have thrown HTML5-based apps under the bus](http://venturebeat.com/2012/09/11/facebooks-zuckerberg-the-biggest-mistake-weve-made-as-a-company-is-betting-on-html5-over-native), claiming they were the root cause of problems the app had. These claims were quickly proved bogus, in this case via [a copy of Facebook’s app built using HTML5](http://www.sencha.com/blog/the-making-of-fastbook-an-html5-love-story) by developers *who actually knew what they were doing*. Remember, **developers can build slow, buggy crap on any platform – that’s not the platform’s fault**.

It will always be possible to achieve faster performance using native code than using something that sits above native code. This is true on your desktop computer and on your web server. Well-tuned native C++ code is going to run faster than C# code running in the CLR. The thing to remember is that performance is only one consideration for your application, and that [premature optimization is the root of all software evil](http://c2.com/cgi/wiki?PrematureOptimization). If your application can achieve “good enough” performance using an abstraction layer that makes you more productive, and this means you can release your software sooner, with fewer bugs, for less cost, then that’s probably a reasonable way to go. Remember when considering optimizations, going [beyond “good enough” is waste](http://ardalis.com/Beyond-Good-Enough-Is-Waste) in most cases.

The other thing to remember is that [Moore’s Law still applies](http://en.wikipedia.org/wiki/Moore's_law). Yes, mobile devices have more limited computing power than their desktop forefathers, but these devices’ capabilities are increasing dramatically and constantly. What’s more, the operating systems and Javascript engines that run on these devices are also being improved rapidly. That means [any perceivable difference in performance between well-written native and hybrid applications is rapidly vanishing](http://venturebeat.com/2013/11/07/how-to-build-a-hybrid-app-that-performs-like-native-yes-it-can-be-done), and with it the advantage of writing native code for every platform “because performance.”