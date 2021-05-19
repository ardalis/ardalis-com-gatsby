---
templateKey: blog-post
title: Installing Orchard Content Management System
date: 2011-03-29
path: blog-post
description: Orchard is a free, open source content management system built on the ASP.NET platform and suitable for blogging or other content sites. It is very extensible and easy to set up. In this article, Steve shows how to get started using Orchard on your local machine in just a few minutes.
featuredpost: false
featuredimage: /img/orchard-content-management.png
tags:
  - blogging
category:
  - Productivity
  - Software Development
comments: true
share: true
---

## Introduction

[Orchard](http://www.orchardproject.net/) is a free, open source, community-focused content management system built on the ASP.NET platform.  It uses ASP.NET MVC 3, the Razor view engine, and is an [Outercurve Foundation project](http://www.outercurve.org/Galleries/ASPNETOpenSourceGallery/OrchardProject).  In this article, we'll look at how to get started with Orchard 1.0 by installing it.

## Installing Orchard

There are a few different ways you can install Orchard.  Probably the simplest if you're not already using WebMatrix is to use the Web Platform Installer.  The distribution files and source are also available, if you prefer - get them from [the current release on CodePlex](http://orchard.codeplex.com/releases/view/50197).  If you are using WebMatrix, you can install Orchard directly from there as well.  There's [a walkthrough that covers much of what I'm showing here on the Orchard site](http://orchardproject.net/docs/Installing-Orchard.ashx) - this article shows my own experience with the latest installation of the project.

First, you'll need to [install the Web Platform Installer](http://www.microsoft.com/web/downloads/platform.aspx), if you haven't already done so.  As I write this, the latest version is 3.01, according to the launcher filename (wpilauncher_3_01.exe).

Next, search for Orchard in the search box (or just click Add if you see it in the initial results).

Click the Add button next to the release you wish to install.  You can doubleclick on an individual item to see its details.  The 2/21/2011 release is version 1.0.20, which is what I'll be using.  I expect a 1.1 release to be coming out soon, but for now I'm going to stick with the latest approved release.

Click Install. Then click I Accept on the next screen.

Next, provide the bits of information about where and how you would like Orchard to be installed.

Assuming you choose wisely, you should be able to Continue.

Go ahead and click the blue Launch Orchard CMS link to test out the newly installed application on your local computer.

Fill in the blanks one last time - for your first try I recommend using the default built-in data storage option.  After a short while (maybe 20 seconds on my machine), the site should be fully configured.

## Customizing Orchard

Now that we have Orchard installed, let's walk through how to use, briefly.  The initial Welcome to Orchard post is actually more than just some boilerplate - it's worth reading and it includes some working links to the admin area of the application.  For instance, the second paragraph has a link to "manage your settings" - go ahead and click that.  This will bring you to the dashboard.

From here, you can see all of the various menu options and settings you can control for your new site.  If you want to create a new page on your site, simply click the link to Page under New at the top.  You can create a blog - even multiple blogs - from the Blogs menu option.

Once you have a blog set up, you can add a new post to it easily enough from the New Post link.

Of course, the default theme isn't ideal.  You can customize the theme from the dashboard as well.  Not surprisingly, this is done from the Themes menu.  You can even install a theme from an online gallery (built using the [orchard gallery open source project](http://orchardgallery.codeplex.com/) developed by [NimblePros](https://nimblepros.com/)).  Currently the gallery has dozens of themes to choose from - I pick Vintage Brown - Version: 1.0.

The next step is to enable the theme and tell the site to use it.  You can also Preview the theme before making it live.

It's great that I can write new posts from the web site, but I'm a big fan of Windows Live Writer.  Luckily, it's pretty easy to make that work with Orchard, too.  First, you need to go into the dashboard and enable this as a feature.  Go to Configuration - Features and enable the Remote Blog Publishing feature under Content Publishing.

Launch WLW and add a new blog account.  When prompted for which blog service you use, choose "Other services".  Specify the web address of your blog (e.g. "http://localhost:8086/steve" for my test) and your user name and password (the admin account if that's all you have set up currently).

That's it!  It should automatically locate what it needs.

You can write a test post from WLW. That's it!  You're ready to start blogging or continue adding content to your new site built on the open source Orchard CMS platform.

## Summary

Getting started with Orchard is very easy.  In fact, writing this whole article along with all the text, screenshots, and of course the installation of Orchard itself, only took about half an hour.  The community around Orchard is growing quickly, and the code itself is continuing to expand at a quick pace.  Check it out if you're looking for an open source, .NET content management solution or blogging platform.

Originally published on [ASPAlliance.com](http://aspalliance.com/2051_Installing_Orchard_Content_Management_System)
