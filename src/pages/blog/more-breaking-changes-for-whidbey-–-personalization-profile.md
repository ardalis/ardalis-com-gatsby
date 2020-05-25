---
templateKey: blog-post
title: More Breaking Changes for Whidbey – Personalization/Profile
path: blog-post
date: 2004-04-04T12:45:00.000Z
description: Personalization as a keyword/namespace has been replaced with
  Profile. The namespace, the config section, etc. Also, the provider model for
  personalization has changed between the PDC Whidbey and the March04Preview
  Whidbey, such that now providers must inherit from System.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Whidbey
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

Personalization as a keyword/namespace has been replaced with Profile. The namespace, the config section, etc. Also, the provider model for personalization has changed between the PDC Whidbey and the March04Preview Whidbey, such that now providers must inherit from System.Web.Profile.ProfileProvider, rather than implementing a couple of (now non-existent) interfaces. An example config section using the new syntax is as follows:

<!--EndFragment-->

```
<profile >

<properties>

<add name=“NickName“ type=“System.String“ />

<add name=“Address“ type=“System.String“ />

<add name=“College“ type=“System.String“ />

<add name=“SelectedTheme“ type=“System.String“ />

properties>

profile>
```

<!--StartFragment-->

The same information is captured, but theelements have been replaced by acollection withelements. Theelement, not shown, is still a viable option under. Once properties are entered here and the config file saved, the profile object can be used in a strongly-typed fashion, **with Intellisense**, throughout the application.

*Updated — More Changes:*

The ConfigurationSettings.ConnectionStrings\[”MyConnString”] collection no longer is a collection of strings. Instead, it is a collection of ConnectionStringSetting objects, which have among their properties ConnectionName, ConnectionString, and ProviderName. If you used the old syntax before, you need to add “.ConnectionString” in the new build to get it to work.

Thesection of web.config has been updated. There is now asection under, and theelement has been moved out of thesection and into thesection. Thesection is also under thesection, like so:

A good place to find these largely undocumented config file changes is by looking in machine.config at theelement at the top of the file.

*Updated Again:*The attribute to specify the master page for the page attribute is no longer master (that gives a somewhat esoteric error message of ‘master is readonly and cannot be set’) – it is now MasterPageFile. For instance:\
**<%@ Page MasterPageFile=”~/Site.Master” %>**

<!--EndFragment-->