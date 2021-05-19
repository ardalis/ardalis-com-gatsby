---
templateKey: blog-post
title: Review - Dart PowerWEB LiveControls 1.1.3
date: 2005-08-04
path: blog-post
description: Using Dart PowerWEB LiveControls, it is possible to achieve the benefits of AJAX-style web application behavior without the need to write (or know) a lot of client-side JavaScript, which is otherwise generally required. Steven Smith reviews this set of powerful and easy to use controls.
featuredpost: false
featuredimage: /img/dart-powerweb.png
tags:
  - reviews
category:
  - Software Development
comments: true
share: true
---

## Overview

I’ve recently had the opportunity to work with [Dart’s PowerWEB LiveControls](http://dart.com/powerweb/livecontrols.asp) suite at a client who was building a call center application using ASP.NET architecture. One requirement of the application was that incoming calls and work items needed to be visible to all users with up-to-the-second frequency. Using Dart’s controls, and most importantly their LiveDataGrid control, this requirement was easily met. Using AJAX-style ([what’s this?](http://en.wikipedia.org/wiki/AJAX)) callbacks, the LiveControls allow for a dramatically improved user experience, without the need for the developer to hand code a bunch of JavaScript. In fact, the LiveControls build on the standard ASP.NET web controls, so the programming model changes very little when using these controls instead of the default controls.

## Installation and Versions

At the time of this review, the latest version of Dart’s PowerWEB LiveControls for ASP.NET suite is 1.1.3. You can download the latest version from [dart.com](http://dart.com/powerweb/livecontrols.asp). Pricing starts at $499 for a single server. A developer license is *free* – nothing needs to be purchased until the application is deployed to production.

Upon downloading the suite, installation entails running a single .msi file, which walks the user through a typical setup routine. For me, the whole product installed without incident in just a couple of minutes. Once set up, a new PowerWEB entry under the Start menu's Programs folder will lead you to documentation and samples. The installer will also place the controls in your VS.NET toolbox, as shown in Figure 1.

#### Figure 1: Dart PowerWEB LiveControls in VS.NET Toolbox

![Dart PowerWEB LiveControls in VS.NET Toolbox](/img/dart-powerweb-toolbox.png)

After installation, you’ll probably want to run the LiveTutorial sample application first. You’ll find this sample application by clicking on the Start menu and navigating to the Programs, PowerWEB, LiveControls for ASP.NET, Sample Code folder. You can see it live online [here](http://dotnet.dart.com/livetutorial/default.aspx). Notice how most activities do not cause the page to postback, resulting in a much smoother experience for the user. This is the most compelling feature of these controls, and is something I expect users will demand more and more as applications that utilize this functionality become more commonplace.

## What's Included

This suite includes the following controls:

- **LiveButton**
- LiveCallback
- **LiveCheckBox**
- **LiveCheckBoxList**
- LiveDataGrid
- **LiveDropDownList**
- **LiveHyperLink**
- **LiveImage**
- **LiveImageButton**
- **LiveLabel**
- **LiveLinkButton**
- **LiveListBox**
- LiveMessageBox
- **LivePanel**
- **LivePlaceHolder**
- **LiveRadioButton**
- **LiveRadioButtonList**
- LiveSound
- **LiveTextBox**
- LiveTimer
- LiveWrapper

Those listed in bold inherit from the standard ASP.NET controls, and thus can be used in place of those controls with minimal code changes. The LiveDataGrid doesn’t directly inherit from the `System.Web.UI.WebControls.DataGrid` class, but does expose the same interface, so it too can be used like its corresponding standard control.

Using the sample code that ships with the suite, it’s very easy to get up to speed with these controls. Probably the biggest thing to watch out for is the LiveTimer control should it used in a large-scale application. It might be very tempting to have the timer initiate a callback to the server every second, and this works fine if the number of users is fairly small and well-known. However, for a public Internet site, it may not be wise, since it could result in thousands of requests being made to the server every second.

## Summary and Resources

AJAX-style applications have really taken off in popularity, mainly since the use of these technologies in recent mainstream applications like [Google Gmail](http://gmail.com/) and [Google Maps](http://maps.google.com/). Although this technology is by no means new, the ease with which these applications can be built has increased dramatically with the release of control suites such as Dart’s LiveControls. I’ve been very impressed with the ease of use of these controls, and will be looking for ways to integrate them into my future applications.

[Dart's Comparison of LiveControls vs. Other Techniques](http://dart.com/powerweb/livecontrols_guide.asp)

[Anand's Review of Dart's LiveControls](http://aspalliance.com/678) (May 2005)

[Ajax.NET Library](http://ajax.schwarz-interactive.de/csharpsample/default.aspx)

Originally published on [ASPAlliance.com](http://aspalliance.com/702_Review__Dart_PowerWEB_LiveControls_113)
