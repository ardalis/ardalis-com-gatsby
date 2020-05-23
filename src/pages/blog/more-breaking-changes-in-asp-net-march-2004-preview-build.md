---
templateKey: blog-post
title: More Breaking Changes in ASP.NET (March 2004 Preview Build)
path: blog-post
date: 2004-03-28T13:07:00.000Z
description: I’m not sure if it’s new or not, but I hadn’t seen
  **System.Data.ProviderBase** before, so perhaps that’s where some of this
  functionality has moved.
featuredpost: false
featuredimage: /img/asp-net-mvc-logo.jpg
tags:
  - asp.net
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

Found some more breaking changes:

**System.Web.Personalization** no longer exists. I believe it’s been renamed to **System.Web.Profile** but I haven’t 100% confirmed this yet.

**System.Configuration.Settings** no longer exists. I can’t find its replacement. I’m looking for where IProvider and ISettingsProvider are defined now. I can’t find these either, so I’m thinking they may no longer exist.

I’m not sure if it’s new or not, but I hadn’t seen **System.Data.ProviderBase** before, so perhaps that’s where some of this functionality has moved.

Looks like these two Interfaces are no longer used, and instead it’s using a base type **System.Web.Profile.ProfileProvider** which is derived from **System.Configuration.SettingsProvider**. I had written a custom provider for the personalization engine that used an XML file in the /Data folder for its data. Looks like I’ll need to modify that class quite a bit to conform to this new pattern for providers.

<!--EndFragment-->