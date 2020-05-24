---
templateKey: blog-post
title: Use RedGate ANTS Profiler with Vista and ASP.NET
path: blog-post
date: 2007-03-02T16:36:41.779Z
description: Found these two forum posts that show how, as well as how to wire
  up ANTS to Webdev.WebServer.exe (aka Cassini).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - vista
  - asp.net
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Found these [two](http://www.red-gate.com/MessageBoard/viewtopic.php?t=3770&highlight=vista) [forum posts](http://www.red-gate.com/MessageBoard/viewtopic.php?t=3472)that show how, as well as how to wire up ANTS to Webdev.WebServer.exe (aka Cassini).

Here’s the summary:

<!--EndFragment-->

* Start ANTS Profiler  Select either Profile memory or Profile performance 
* Select .NET desktop application as the type of project 
* Click the elipsis (…) to the right of .NET desktop application and browse to c:windowsmicrosoft.netFrameworkv2.0.50727 and select Webdev.WebServer.exe
* Let the working directory automatically update 
* Fill in the arguments necessary to start your web application: 
  /Path:”c:inetpubMyApp” -the path to the web application on your hard drive 
  /port:8080 -a TCP port not currently used by IIS (or other app) 
  /vpath:”/MyApp” -the name of the virtual directory where the app normally is found in when you run it in IIS 
* Choose what code to profile and click Finish 
* Start a web browser and enter the address of the web app on your local machine, in this case http://localhost:8080/MyApp 
* Use ANTS Profiler as normal (take snapshot, etc) 
* When you are finished, close the web browser and then the console window launched by webdev.webserver.