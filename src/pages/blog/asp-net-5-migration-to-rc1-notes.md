---
templateKey: blog-post
title: ASP.NET 5 Migration to RC1 Notes
path: blog-post
date: 2015-12-16T13:24:00.000Z
description: >
  I’ve been migrating a number of articles from docs.asp.net to RC1 from beta8
  (and earlier) and these are some of my notes. You may also find the following
  links helpful:
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - asp.net core
category:
  - Software Development
comments: true
share: true
---
I’ve been migrating a number of articles from docs.asp.net to RC1 from beta8 (and earlier) and these are some of my notes. You may also find the following links helpful:

* Eric Anderson [Migration from Beta 8 to RC1](http://www.elanderson.net/2015/11/migration-from-asp-net-5-beta-8-to-rc1/)
* DamienBod [Updating to Beta8 from Older Beta Versions](http://damienbod.com/2015/10/16/asp-net-5-updating-to-beta8-from-older-beta-versions/)
* Shawn Wildermuth [Upgrading ASP.NET 5 Beta 8 to RC1](http://wildermuth.com/2015/11/18/Upgrading_ASP_NET_5_Beta_8_to_RC1)
* View [All Breaking Changes from Beta8 to RC1 on GitHub](https://github.com/aspnet/Announcements/issues?q=is%3Aopen+is%3Aissue+milestone%3A1.0.0-rc1)

## Get Latest Version

The first step is to make sure you have the latest bits installed yourself, including the tooling updates (for Visual Studio). The easiest way to do this is to go to [get.asp.net](http://get.asp.net/).

I’m not going to go through all of the changes that others have previously covered. I just want to point out some errors I ran into and how I resolved them. See [Shawn’s post](http://wildermuth.com/2015/11/18/Upgrading_ASP_NET_5_Beta_8_to_RC1) for a more complete walkthrough of changes that are needed to pretty much all beta8 projects to migrate them to RC1.

**Error: Could not load type ‘Microsoft.Dnx.Host.Clr.EntryPoint’ from assembly ‘Microsoft.Dns.Host.Clr’**

This error can occur because you don’t have a main method in your Startup.cs. This requirement was added in RC1. You can simply copy this into your Startup.cs. Alternately, create a new web project an copy the method from its startup.cs file into your project.

`public static void Main(string[] args) => WebApplication.Run<Startup>(args);`

**Error: app.UseDatabaseErrorPage(DatabaseErrorPageOptions.Showall)**

This method no longer takes a parameter. Replace it with **app.UseDatabaseErrorPage()**.

## Entity Framework Updates

EF updated a bunch of the names of its methods for ModelBuilder. Mostly this involved adding “Has” to them.

Change Annotation to HasAnnotation

Change Index to HasIndex

Change ForeignKey to HasForeignKey

I also ran into errors with a model class that didn’t have a setter, which worked in the previous version. I had to make the following change:

`// beta 8 version `\
`public string Name { get; } = String.Empty;
// RC1 version
public string Name {get; private set; } = String.Empty;`

## MVC Updates

If you’re using the default starter web template, there were many changes to AccountController and ManageController. You’re probably best off just copying these in from a new project built using the RC1 templates. You’ll also need RemoveLoginViewModel class from the ViewModels/Manage folder.

## IIS Problems

I was able to run the project using Kestrel, but not IIS, until I updated the web.config file located in wwwroot to the following:

```
<configuration>   \
<system.webServer>
    <handlers>
      <add name="httpPlatformHandler" path="\*" verb="\*" modules="httpPlatformHandler" resourceType="Unspecified"/>
    </handlers>
    <httpPlatform arguments="%DNX_ARGS%" processPath="%DNX_PATH%" startupTimeLimit="3600" stdoutLogEnabled="false"/>
  </system.webServer>
</configuration>
```

That’s all I have for now – if you have questions or other suggestions, please add them to the comments below. Thanks!