---
templateKey: blog-post
title: Custom Configuration Section Handlers
path: blog-post
date: 2010-05-04T05:51:00.000Z
description: Most .NET developers who need to store something in configuration
  tend to use appSettings for this purpose, in my experience. More recently, the
  framework itself has helped things by adding the <connectionStrings /> section
  so at least these are in their own section and not adding to the appSettings
  clutter that pollutes most apps.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
Most .NET developers who need to store something in configuration tend to use appSettings for this purpose, in my experience. More recently, the framework itself has helped things by adding the <connectionStrings /> section so at least these are in their own section and not adding to the appSettings clutter that pollutes most apps. I [recommend avoiding appSettings for several reasons](https://ardalis.com/avoid-appsettings-usage-in-controls-or-shared-libraries). In addition to those listed there, I would add that strong typing and validation are additional reasons to go the custom configuration section route.

For my ASP.NET Tips and Tricks talk, I use the following example, which is a simple DemoSettings class that includes two fields. The first is an integer representing how many attendees there are present for the talk, and the second is the title of the talk. The setup in web.config is as follows:

```
<configSections>
<section name="DemoSettings" type="ASPNETTipsAndTricks.Code.DemoSettings" />
</configSections>
 
<DemoSettings 
  sessionAttendees="100" 
  title="ASP.NET Tips and Tricks DevConnections Spring 2010" />
```

Referencing the values in code is strongly typed and straightforward. Here I have a page that exposes two properties which internally get their values from the configuration section handler:

```
public partial class CustomConfig1 : System.Web.UI.Page
{
    public string SessionTitle
    {
        get
        {
            return DemoSettings.Settings.Title;
        }
    }
    public int SessionAttendees
    {
        get
        {
            return DemoSettings.Settings.SessionAttendees;
        }
    }
}
```

Note that the settings are only read from the config file once – after that they are cached – so there is no need to be concerned about excessive file access.

Now we’ve seen how to set it up on the config file and how to refer to the settings in code. All that remains is to see the file itself:

```
public class DemoSettings : ConfigurationSection
{
    private static DemoSettings settings = 
        ConfigurationManager.GetSection("DemoSettings") as DemoSettings;
    public static DemoSettings Settings{ get { return settings;} }
 
    [ConfigurationProperty("sessionAttendees"
      , DefaultValue = 200
      , IsRequired = false)]
    [IntegerValidator(MinValue = 1
      , MaxValue = 10000)]
    public int SessionAttendees
    {
        get { return (int)this["sessionAttendees"]; }
        set { this["sessionAttendees"] = value; }
    }
 
    [ConfigurationProperty("title"
      , IsRequired = true)]
    [StringValidator(InvalidCharacters = "~!@#$%^&*()[]{}/;’\"|\\")]
    public string Title
    {
        get { return (string)this["title"]; }
        set { this["title"] = value; }
 
    }
}
```

The class is pretty straightforward, but there are some important components to note. First, it must inherit from **System.Configuration.ConfigurationSection**. Next, as a convention I like to have a static settings member that is responsible for pulling out the section when the class is first referenced, and further to expose this collection via a static read only property, Settings. Note that the types of both of these are the type of my class,**DemoSettings**.

The properties of the class, SessionAttendees and Title, should map to the attributes of the config element in the XML file. The \[Configuration Property] attribute allows you to map the attribute name to the property name (thus using both XML standard naming conventions and C# naming conventions). In addition, you can specify a default value to use if nothing is specified in the config file, and whether or not the setting must be provided (Is Required). If it is required, then it doesn’t make sense to include a default value.

Beyond defaults and required, you can specify more advanced validation rules for the configuration values using additional C# attributes, such as \[IntegerValidator] and \[StringValidator]. Using these, you can declaratively specify that your configuration values be in a given range, or omit certain forbidden characters, for instance. Of course you can write your own custom validation attributes, and there are others specified in System.Configuration.

Individual sections can also be loaded from separate files, using syntax like this:

```
<DemoSettings configSource="demosettings.config" />
```

**Summary**

Using a custom configuration section handler is not hard. If your application or component requires configuration, I recommend creating a custom configuration handler dedicated to your app or component. Doing so will reduce the clutter in appSettings, will provide you with strong typing and validation, and will make it much easier for other developers or system administrators to locate and understand the various configuration values that are necessary for a given application.