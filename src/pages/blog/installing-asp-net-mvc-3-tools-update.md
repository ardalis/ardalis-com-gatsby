---
templateKey: blog-post
title: Installing ASP.NET MVC 3 Tools Update
path: blog-post
date: 2011-04-13T02:05:00.000Z
description: Phil Haack has a post introducing the ASP.NET MVC 3 Tools Update
  that you probably should read.  This is my own experience installing the
  update and upgrading an existing MVC 3 project to use the new tooling.
featuredpost: false
featuredimage: /img/asp-net-mvc-logo.jpg
tags:
  - asp.net
  - asp.net mvc
category:
  - Software Development
comments: true
share: true
---
Phil Haack has a post [introducing the ASP.NET MVC 3 Tools Update](http://haacked.com/archive/2011/04/12/introducing-asp-net-mvc-3-tools-update.aspx) that you probably should read. This is my own experience installing the update and upgrading an existing MVC 3 project to use the new tooling. First, you’ll want to install the MVC 3 Tools Update, using one of these options:

* [Web Platform Installer for ASP.NET MVC 3 Tools Update](http://www.microsoft.com/web/gallery/install.aspx?appid=MVC3)
* [Download Page for ASP.NET MVC 3 Tools Update](http://go.microsoft.com/fwlink/?LinkID=208140)

And then you can read the [Release Notes](http://www.asp.net/learn/whitepapers/mvc3-release-notes) as well.

I’m not going to talk about what’s new with the Tools Update, except to re-emphasize the fact that MVC 3 didn’t change at all – only the tooling has changed. So, don’t worry about whether your application will need upgraded or will be compatible or any of that – it’s the same System.Web.Mvc.dll being used before and after this update.

I’m installing it via Web PI – here’s a quick walkthrough, after clicking the Web Platform Installer link above:

![SNAGHTML8a699](<> "SNAGHTML8a699")

Click OK. Lucky me, I need to install a new version of Web PI:

![SNAGHTML965d2](<> "SNAGHTML965d2")

Click “I Accept”… let the installer run. Shouldn’t require any action from you, and should then show this screen:

![SNAGHTMLb47b2](<> "SNAGHTMLb47b2")

Click “Install”

![SNAGHTMLbf0d2](<> "SNAGHTMLbf0d2")

Click “I Accept”.

![SNAGHTMLc5e52](<> "SNAGHTMLc5e52")

Wait for it…

![SNAGHTML1266d0](<> "SNAGHTML1266d0")

Yay!

Phil outlines a bunch of new stuff you get with the tooling update. A lot of the changes are in the ASP.NET MVC 3 project template, which of course only applies when you create a new project. So, what about existing ASP.NET MVC 3 projects – do they immediately take advantage of this new tooling goodness? Somewhat. The new template uses NuGet for its dependencies on jQuery, Modernizr, and EF Code First 4.1 – you can manually add these NuGet packages to your MVC 3 project, but just installing the Tools Update isn’t going to do it for you. Here are the packages included now by default:

![image](<> "image")

To add these to your pre-existing MVC 3 project, run these commands in the Package Manager console:

```
PM&gt; install-package jQuery
&#160;
PM&gt; install-package jQuery.vsdoc
&#160;
PM&gt; install-package jQuery.Validation
&#160;
PM&gt; install-package jQuery.UI.Combined
&#160;
PM&gt; install-package EntityFramework
&#160;
PM&gt; install-package Modernizr
&#160;
PM&gt; 
```

After installing these (on 13 April 2011), I have the following packages installed in my pre-existing project:

![image](<> "image")

So, the versions aren’t a complete match, but that’s to be expected since NuGet packages are updated frequently. You can get a particular version by simply passing in the version string with your request, for example:

```
PM&gt; install-package jQuery -version 1.4.4
```

One of the new features in the tools update is the ability to quickly flesh out a Controller by simply right-clicking and choosing Add Controller. If you have a model class, you can now use EF to create the scaffolding for this model class using this UI:

[![image](<> "image")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Installing-ASP.NET-MVC-3-Tools-Update_9A27/image_10.png)

This option is available in both new and pre-existing MVC 3 projects. About the only thing I couldn’t see a way to bring into my pre-existing project was this new feature:

[![SNAGHTML26d9fb](<> "SNAGHTML26d9fb")](http://stevesmithblog.com/files/media/image/Windows-Live-Writer/Installing-ASP.NET-MVC-3-Tools-Update_9A27/SNAGHTML26d9fb.png)

I’m sure it’s a setting in the project template somewhere, but I haven’t as yet gone digging to find it. Perhaps Phil or someone from his team will let us know how to do this in the comments below.

**Summary**

Installing the new MVC 3 Tools Update was quick and painless. The new features in my pre-existing MVC 3 application were welcome and either lit up automatically or were easily added via NuGet. It’s worth noting as well that if you hadn’t already upgraded your version of NuGet to 1.2, installing the tools update will do so as part of the process. And if you haven’t given NuGet much of a look yet, I recommend you browse the [NuGet Gallery at NuGet.org](http://nuget.org/) (which incidentally is running on [open-source code designed and developed by NimblePros](http://nimblepros.com/) and hosted at [CodePlex](http://orchardgallery.codeplex.com/), so if you want to host your own NuGet gallery for internal use or for your customers, you can customize it to fit your needs). There are already over 1000 packages available via NuGet, and nearly half a million package downloads already, according to [stats.nuget.org](http://stats.nuget.org/).