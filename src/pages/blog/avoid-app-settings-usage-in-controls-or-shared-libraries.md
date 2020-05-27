---
templateKey: blog-post
title: Avoid app Settings Usage in Controls or Shared Libraries
path: blog-post
date: 2008-07-28T08:33:00.000Z
description: Since .NET 1.0, there has been a built-in appSettings section in
  configuration files. Many developers use this space to store application
  settings, such as the name of the site or (before <connectionStrings />)
  database connection information.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - appSettings
category:
  - Uncategorized
comments: true
share: true
---
Since .NET 1.0, there has been a built-in appSettings section in configuration files. Many developers use this space to store application settings, such as the name of the site or (before <connectionStrings />) database connection information. However, many third party tools also make use of this collection, which is a bad practice. Third party tools should use their own [configuration section, which is incredibly easy to do today](http://haacked.com/archive/2007/03/12/custom-configuration-sections-in-3-easy-steps.aspx) (and [wasn’t all that hard in past versions](http://haacked.com/archive/2004/06/25/verylastconfigurationsectionhandler.aspx)), in my opinion. I’m curious to know why more companies don’t do this, however, as the only thing I can see is that it’s laziness or just “the way we’ve always done it” that’s the reason.

Personally, I avoid using appSettings even for my own application configuration settings. Why? Because it really is too stinking easy to create your own custom configuration section, and this provides a much more readable and strongly typed way to access the values your application needs. AppSettings might be ok for a quick spike of a site where you’re not doing anything “the right way” out of some desire for expediency, but otherwise it should be avoided. There are two reasons why I feel this way.

**Global Scope and Naming Collisions**

AppSettings is basically a global variable collection. There is nothing to prevent two separate control vendors from using the same key for their appSettings variable names. In practice this doesn’t happen very often because vendors are smart enough to use long names (for the most part) that include their company and/or product name in them. However, this could easily be avoided (due to its being unnecessary) if a company- or product-specific configuration section were used instead.

**Organization and Clarity**

The second and arguably more applicable reason to avoid overusing appSettings for shared components is organization and clarity. There is zero discoverability of configuration options available within appSettings. The only way to figure out what is available to configure is the documentation. Further, once several different vendors’ settings are intermingled in appSettings (along with a variety of actual site-specific settings), it can be quite a mess and quite long. This can result in errors when changes are made to the configuration settings.

**Favor Custom Configuration Sections for Controls and Shared Code**

Default configuration options should be distributed with the control in a self-contained section, making it easy for users to see the default values. Updates to the configuration file can then be as simple as cut-and-paste since the section is self-contained – there is less risk of the user screwing up the configuration instructions because they’re trying to edit an already crowded and disorganized appSettings section in the configuration file.