---
templateKey: blog-post
title: Referencing Common Values Between Apps/Projects
path: blog-post
date: 2017-07-23T21:59:00.000Z
description: A pretty common scenario in building real world business software
  is the need to share certain pieces of information between multiple projects
  or applications. Frequently these fall into the category of configuration
  settings, and might include things like
featuredpost: false
featuredimage: /img/referencing-common-values-between-apps-projects.png
tags:
  - configuration
  - design patterns
  - tip
category:
  - Software Development
comments: true
share: true
---
A pretty common scenario in building real world business software is the need to share certain pieces of information between multiple projects or applications. Frequently these fall into the category of configuration settings, and might include things like:

* Resource or CDN URLs or base URLs
* Connection Strings
* Public/Private Keys and Tokens

Some of these are more sensitive than others, obviously, and you should definitely strive to [avoid storing database credentials in source control](https://ardalis.com/avoid-storing-database-credentials-in-source-control). In many cases, different apps shouldn’t be sharing a central database, anyway, as that’s likely to lead to the [One Database To Rule Them All antipattern](http://deviq.com/one-thing-to-rule-them-all/). Leaving aside databases and connection strings, how should you share common pieces of information between projects? There are several patterns you can consider.

## In Code

The first pattern is simply to share the data in code. You might have a Constants or Settings class that is literally copied and pasted between projects. Or it might belong to one project that is referenced by another. You could compile it into a DLL that all projects reference. And of course, taking this to its logical next step, you can create a NuGet package that includes this hardcoded value. For example:

```
public static class CloudSettings
{
  public string StaticResourcesUrlPrefix { get; } = "http://somesite.com/prod/";
 
  // more settings go here
}
```

The benefit of this approach is that it’s very simple. The values are tracked in source control, which is a good thing if they’re not sensitive (not so good if they’re meant to be secret). Values are easily discovered by developers and can be updated easily in the codebase. However, these settings are probably not visible or configurable by operations staff, and any changes to settings must be done via a deployment, as opposed to something lighter-weight. Code-based values also aren’t as easily changed from one environment to the next, so promoting code from dev to test to stage to prod environments may be more difficult. This can be overcome with conditional logic or precompiler directives, but either of those degrades the simplicity of this approach (its chief advantage).

Even if you’re not hard-coding shared setting *values*, it can be worthwhile to share a library containing the shared setting *keys*. This might take the form of just constant values, as described here, or ideally you can use **interfaces** to describe your settings values in a strongly-typed manner, and use a convention to convert properties on your interfaces into settings keys.

To convert the above bit of code into an interface, just make this small change:

```
public interface CloudSettings
{
  string StaticResourcesUrlPrefix { get; }
 
  // more settings go here
}
 
public class CloudSettings : ICloudSettings
{
  public string StaticResourcesUrlPrefix { get; } = "http://somesite.com/prod/";
 
  // more settings go here
}
```

## Configuration

Probably the most common approach to solving this problem is to use configuration. In this case, you might simply add a key representing the setting in question to your project’s settings file, along with the appropriate value. Once you’ve done this once, it’s pretty easy to copy-paste this same setting into other environment-specific files or other projects’ settings files. This approach works well and offers more flexibility than the hardcoded-in-code approach. Be sure to follow these tips when working with configuration files in .NET, though:

* [Apply Interface Segregation to Config Files](https://ardalis.com/applying-interface-segregation-to-configuration-files)
* [Use Custom Configuration Section Handlers](https://ardalis.com/custom-configuration-section-handlers) (pre .NET Core)
* [Refactor Static Config Access](https://ardalis.com/refactoring-static-config-access)

The biggest downside to the configuration approach is that over time you may end up with a ton of configuration settings, possibly without much cohesion between them. They’re also not quite as easy to update or automate in a cloud environment as something like environment variables, discussed next.

## Environment Variables

A third approach is to store settings in environment variables. Environment variables are easy to update when using cloud hosting services or Docker containers. They work well cross-platform and they’re very well-supported in .NET Core. The default code templates for ASPNET Core applications, at least in the 1.x timeframe, uses both configuration files and environment variables for app settings. They way it’s configured by default, for a given setting key, the app will first check if there is an environment variable. If there is, it uses that value. Otherwise, it falls back to looking in settings file(s) for a value that matches a given key. At [some of my clients](https://ardalis.com/mentoring) we have implemented similar systems for .NET 4.6 apps. With this approach, you can also easily vary the behavior based on the environment. For instance, if you want to ensure your production environment uses environment variables, but it’s easier for your dev team to use config files, you could have your code throw an exception when the app is running in production and a value isn’t found in an environment variable. At dev time, values not in environment values could fall back to a local config file.

## Hybrid Patterns

None of these approaches are exclusive – you can mix and match them to suit your needs. For example, it’s pretty common to combine environment variables with configuration settings, with one falling back to the other. You can take this a step further and specify default values in code, to use when a value is not found in either configuration files or environment variables.

These are design patterns, not absolute solutions. Use your experience to come up with a solution that solves your problems in the simplest way possible. If you’re not sure of the best approach, ask online or enlist the help of an expert. **An ounce of bad design prevention is worth months of refactoring and rewriting to fix a poor design decision.**

## Recommendations

Start with something simple; grow complexity only if/when it becomes necessary:

* Start with a hardcoded string.
* Move that to a constant.
* Move that to a strongly typed settings class.
* Move that to an interface.
* Implement the interface to use config, environment variables, or whatever you need.

Avoid tightly coupling to a particular configuration system.

Avoid static access to any configuration system if it impact testability. Think about how you might unit test different configuration options at runtime. If it doesn’t impact testability, it may be fine, but in general watch out for [static cling](http://deviq.com/static-cling/) in your code.