---
templateKey: blog-post
title: Applying Interface Segregation to Configuration Files
path: blog-post
date: 2010-08-31T12:48:00.000Z
description: In .NET, it’s very easy to set up custom configuration section
  handlers to handle your application or component’s configuration needs.  As my
  previous post shows, it’s also very easy to configure these with attributes
  that enforce required fields and other validation.
featuredpost: false
featuredimage: /img/cloud-native.jpg
tags:
  - configuration
  - isp
  - solid
category:
  - Software Development
comments: true
share: true
---
In .NET, it’s very easy to set up [custom configuration section handlers](g/custom-configuration-section-handlers) to handle your application or component’s configuration needs. As my previous post shows, it’s also very easy to configure these with attributes that enforce required fields and other validation. However, over time it’s very easy to create fairly large configuration sections that violate the [Interface Segregation Principle](https://deviq.com/interface-segregation-principle/), which states that classes shouldn’t be forced to depend on things they don’t need.

Consider this relatively simple configuration section:

```xml
<configSections>
  <section name="ConfigurationSettings" 
type="InterfaceSegregation.Configuration1.ConfigurationSettings, InterfaceSegregation"/>
</configSections>
<ConfigurationSettings 
  ApplicationName="Interface Segregation"
  AuthorName="Steve Smith"
  CacheDuration="60"
  DatabaseServerName="localhost"
  DatabaseName="Northwind"
  DatabaseUserName="ssmith"
  DatabasePassword="secret"
  WebServiceBaseUri="http://localhost/"
  />
```

I’ve intentionally made it a bit more verbose than needed (obviously the database settings could be combined into a connection string, etc), but the intent is to show that my relatively generic Settings section has completely lost its *cohesion*. Let’s look at an interface that we’ve created to support these settings (because we don’t want to have an [Insidious Dependency On Our Configuration File](/insidious-dependencies) in our code):

```csharp
public interface IConfigurationSettings : IApplicationIdentitySettings
{
  // application identity settings
  string ApplicationName { get; }
  string AuthorName { get; }

  // performance tuning settings
  int CacheDuration { get; }

  // data access settings
  string DatabaseServerName { get; }
  string DatabaseName { get; }
  string DatabaseUserName { get; }
  string DatabasePassword { get; }

  // web service api settings
  string WebServiceBaseUri { get; }
}
```

From the comments I’ve included in this interface, it’s clear that there are four different kinds of settings grouped together by this interface. With only 8 properties, it has already become an example of a “fat” interface. Now let’s look at one of the clients of this interface, a simple AboutPage file (that isn’t an ASP.NET page, but could be):

```csharp
public class AboutPage
{
  private readonly IConfigurationSettings _configurationSettings;
  
  public AboutPage(IConfigurationSettings configurationSettings)
  {
    _configurationSettings = configurationSettings;
  }

  public AboutPage() : this(ConfigurationSettings.Settings)
  {}

  public void Render(TextWriter writer)
  {
    writer.Write("{0} By {1}",
    _configurationSettings.ApplicationName,
    _configurationSettings.AuthorName);
  }
}
```

This class takes advantage of Dependency Injection to eliminate a direct dependency on the ConfigurationSettings class/file, through the use of the IConfigurationSettings interface. However, it’s still depending on a much larger interface than it needs, and thus is violating ISP. Fortunately, there’s a very easy fix for this that will let us ensure this class only depends on what it needs, without breaking anything else in our application. The refactoring involves creating a new interface for AboutPage to depend upon, that is more cohesive and only includes things AboutPage (and perhaps other classes that require the same things) requires. First, we need to identify these settings and come up with a name for the new interface:

```csharp
public interface IApplicationIdentitySettings
{
    string ApplicationName { get; }
    string AuthorName { get; }
}
```

Next, we need to modify the IConfigurationSettings interface so that it no longer has these settings, but inherits them from the newly created IApplicationIdentitySettings interface:

```csharp
public interface IConfigurationSettings : IApplicationIdentitySettings
{
  // performance tuning settings
  int CacheDuration { get; }

  // data access settings
  string DatabaseServerName { get; }
  string DatabaseName { get; }
  string DatabaseUserName { get; }
  string DatabasePassword { get; }

  // web service api settings
  string WebServiceBaseUri { get; }
}
```

Finally, the AboutPage class can be modified to use the new, more focused interface. In its default constructor, though, it can still use the ConfigurationSettings.Settings class, as this implements IConfigurationSettings, which now automatically implements IApplicationIdentitySettings:

```csharp
public class AboutPage
{
  private readonly IApplicationIdentitySettings _applicationIdentitySettings;

  public AboutPage(IApplicationIdentitySettings applicationIdentitySettings)
  {
    _applicationIdentitySettings = applicationIdentitySettings;
  }

  public AboutPage() : this(ConfigurationSettings.Settings)
  {}

  public void Render(TextWriter writer)
  {
    writer.Write("{0} By {1}",
    _applicationIdentitySettings.ApplicationName,
    _applicationIdentitySettings.AuthorName);
  }
}
```

## Summary

The Interface Segregation Principle states that classes should not be forced to depend on things they do not use. By refactoring “fat” interfaces into smaller, more focused and cohesive interfaces defined by the clients that use them, we can reduce the coupling in our code. This results in code that is easier to change, maintain, and test, not to mention being much more fun to work with. Be breaking up the fat interface but using interface inheritance to ensure the original interface remains unchanged, this refactoring can be done to existing codebases without requiring extensive changes that spider through every class that touches the original interface.