---
templateKey: blog-post
title: Looking for ConfigurationManager?
path: blog-post
date: 2005-08-26T14:47:51.584Z
description: In .NET 2.0 there is a new configuration class called ConfigurationManager.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - asp.net
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

In .NET 2.0 there is a new configuration class called

ConfigurationManager. It supercedes the ConfigurationSettings class that

most .NET developers are familiar with today. When you create a website in

VS2005 the ConfigurationManager class should be available because by default the

necessary reference is included in the website’s compile settings.

However, other types of projects don’t have this reference, to

System.Configuration (the assembly, not the namespace), by default. As a

result, you may have, for instance, a Console Application in which you are

typing System.Configuration. and hoping to find ConfigurationManager in the

resulting Intellisense dialog, but it’s not present. The solution is to

remember that you need to manually go to the project, click Add Reference, and

scroll down within the .NET tab until you find System.Configuration. Once

this reference is added, System.Configuration.ConfigurationManager (and many

other classes) will once more be available to you.

<!--EndFragment-->