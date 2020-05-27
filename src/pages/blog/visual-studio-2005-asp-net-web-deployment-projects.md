---
templateKey: blog-post
title: Visual Studio 2005 ASP.NET Web Deployment Projects
path: blog-post
date: 2006-03-16T12:48:25.881Z
description: "ASP.NET now supports something called Web Deployment Projects,
  which are an add-in for Visual Studio 2005 that is currently still in beta. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - asp.net
  - VS.NET
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

ASP.NET now supports something called [Web Deployment Projects](http://msdn.microsoft.com/asp.net/reference/infrastructure/wdp), which are an add-in for Visual Studio 2005 that is currently still in beta. You can download the installer from here:

[http://msdn.microsoft.com/asp.net/reference/infrastructure/wdp/](http://msdn.microsoft.com/asp.net/reference/infrastructure/wdp)

I recently took them for a spin with a site of mine. The key benefit I was after was the ability to swap out web.config sections as part of the deployment process. This would let me automatically deploy my production web.config with its production database connection strings, etc. without having to manually swap out the file or remember not to copy the web.config file. Basically, I want to have a single config file and have the deployment *process* manage the details of altering the config file for dev or production deployment purposes.

If you’re going to play with these, I strongly recommend you read these three sources **first:**

* [Using Web Deployment Projects with VS 2005](http://go.microsoft.com/fwlink/?LinkId=55638) (Word document)
* Scott Guthrie’s Blog: [VS 2005 Web Deployment Projects](http://weblogs.asp.net/scottgu/archive/2005/11/06/429723.aspx)
* Scott Guthrie’s Blog: [Visual Studio 2005 Web Deployment Project support available for Download](http://weblogs.asp.net/scottgu/archive/2005/11/10/430283.aspx)

My experience with the WDP was mostly very good. One thing to note — do not confuse these with [Web Application Projects](http://msdn.microsoft.com/asp.net/reference/infrastructure/wap) (WAP), as these have nothing to do with one another. For a little while I had “web projects” in my brain and thought they were the same or at least tied together. They’re not.

Next, you need to understand that the WDP project is completely dependent on your solution configuration. When you open the project and edit its settings, you can easily select whether you’re dealing with Release or Debug (or custom) build settings. However, there is no way to run the project directly for a given build configuration without setting your solution configuration. For instance, in my case I only wanted the project to work in Release mode, so I really didn’t want to do anything at all with Debug mode. Unfortunately, you can’t avoid having both listed in the project, so you simply need to be careful you pick the one you want. Secondly, while working in my solution in Debug mode, I would like to test that the project works by right-clicking on it and selecting Build, and I’d like that to run the Release version (again, because that’s the only one I care about). Unfortunately, I didn’t find any way to do this. What you can do, and what is recommended in several places that you do, is be sure to uncheck the Build checkbox in your Build Configuration Manager for your Debug solution environment. This will at least keep the WDP from being built with every dev build (ctrl-shift-b) you perform for the solution. This is a good thing since the WDP builds take a little time.

As I mentioned, the only thing I really wanted the WDP for was to be able to automatically swap out sections of my web.config. There are a few undocumented (at least I didn’t find them) requirements for this feature to work:

* The config section must support the new 2.0 [ConfigSource](http://msdn2.microsoft.com/en-us/library/system.configuration.sectioninformation.configsource(VS.80).aspx) property. This is easily implemented, if you have the source for your section.
* The assembly containing the config section handler must be in the GAC. Otherwise, the WDP will fail during builds when it tries to parse the <section /> element in your web.config file. The error message will be something like “An occurred creating the configuration section handler for Assembly.Name: Could not load file or assembly ‘Assembly.Name’ or one of its dependencies. The system cannot find the file specified. (c:pathtoWDPOutputFolderweb.config line 5)”

To implement ConfigSource, I simply added this property to my Config class:

```
\[XmlAttribute(“configSource”)]

publicstringConfigSource

{

get{return_configSource; }

set{ _configSource =value; }

}
```

In my case, I was trying to get a UrlMapper to work. I used to favor one written by [Scott Mitchell on MSDN](http://msdn.microsoft.com/library/en-us/dnaspp/html/urlrewriting.asp), but I’ve recently fallen in love with [Ewal.Net’s URLMapper](http://ewal.net/2004/04/14/a-url-redirecting-url-rewriting-httpmodule). In order to get it to work for my project I had to make some modifications to it, including adding the configSource property and signing it for installation in the GAC, and these changes were very easily done because the code is so well written, organized, and elegent. Kudos to Erv.

Now I have a WDP that works for what I want. It would be great if the requirement for config section replacements to be in the GAC were overcome before the WDP comes out of beta, but for me that was not a showstopper.

<!--EndFragment-->