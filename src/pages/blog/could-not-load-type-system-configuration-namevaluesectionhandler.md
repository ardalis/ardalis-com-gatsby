---
templateKey: blog-post
title: Could not load type System.Configuration.NameValueSectionHandler
path: blog-post
date: 2010-05-04T05:44:00.000Z
description: "If you upgrade older .NET sites from 1.x to 2.x or greater, you
  may encounter this error when you have configuration settings that look like
  this:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - system configuration
category:
  - Uncategorized
comments: true
share: true
---
If you upgrade older .NET sites from 1.x to 2.x or greater, you may encounter this error when you have configuration settings that look like this:

```
<section name="CacheSettings"
    type="System.Configuration.NameValueFileSectionHandler, System"/>
```

Once you try to run this on an upgraded appdomain, you may encounter this error:

> **An error occurred creating the configuration section handler for CacheSettings: Could not load type ‘System.Configuration.NameValueSectionHandler’ from assembly ‘System.Configuration, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a’.**

Microsoft moved a bunch of the Configuration related classes into a separate assembly, System.Configuration, and created a new class, ConfigurationManager. This presents its own challenges which I’ve blogged about in the past[if you are wondering where ConfigurationManager is located](http://aspadvice.com/blogs/ssmith/archive/2005/08/26/1912.aspx). However, the above error is separate.

```
<section name="CacheSettings"
    type="System.Configuration.NameValueSectionHandler,
   System, Version=2.0.0.0, Culture=neutral, 
   PublicKeyToken=b77a5c561934e089"/>
```

The issue in this case is that the NameValueSectionHandler is still in the System assembly, but is in the System.Configuration namespace. This causes confusion which can be alleviated by using the following section definition:

(you can remove the extra line breaks within the type=””)

With this in place, your web application should once more be able to load up the **NameValueSectionHandler**. I do [recommend using your own custom configuration section handlers instead of appSettings](https://ardalis.com/avoid-appsettings-usage-in-controls-or-shared-libraries), and I would further suggest that you not use NamveValueSectionHandler if you can avoid it, but instead prefer a [strongly typed configuration section handler](https://ardalis.com/custom-configuration-section-handlers).