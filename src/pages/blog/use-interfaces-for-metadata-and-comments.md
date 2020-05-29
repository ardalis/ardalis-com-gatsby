---
templateKey: blog-post
title: Use Interfaces for Metadata and Comments
path: blog-post
date: 2010-10-27T11:34:00.000Z
description: If you’re using XML Comments for intellisense purposes, or are
  making heavy use of attribute-based metadata in your classes, you’ve likely
  found that these have a tendency to bloat your code and make it more difficult
  to follow.
featuredpost: false
featuredimage: /img/user-interface.jpg
tags:
  - meta data
category:
  - Software Development
comments: true
share: true
---
If you’re using XML Comments for intellisense purposes, or are making heavy use of attribute-based metadata in your classes, you’ve likely found that these have a tendency to bloat your code and make it more difficult to follow. For example, consider this simple configuration section handler:

```
<span style="color: #606060" id="lnum1">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> DemoSettings : ConfigurationSection, IDemoSettings
<span style="color: #606060" id="lnum2">   2:</span> {
<span style="color: #606060" id="lnum3">   3:</span>     <span style="color: #0000ff">private</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">readonly</span> DemoSettings settings = 
<span style="color: #606060" id="lnum4">   4:</span> ConfigurationManager.GetSection(<span style="color: #006080">&quot;DemoSettings&quot;</span>) <span style="color: #0000ff">as</span> DemoSettings;
<span style="color: #606060" id="lnum5">   5:</span>&#160; 
<span style="color: #606060" id="lnum6">   6:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> DemoSettings Settings
<span style="color: #606060" id="lnum7">   7:</span>     {
<span style="color: #606060" id="lnum8">   8:</span>         get { <span style="color: #0000ff">return</span> settings; }
<span style="color: #606060" id="lnum9">   9:</span>     }
<span style="color: #606060" id="lnum10">  10:</span>&#160; 
<span style="color: #606060" id="lnum11">  11:</span>     [ConfigurationProperty(<span style="color: #006080">&quot;sessionAttendees&quot;</span>
<span style="color: #606060" id="lnum12">  12:</span>         , DefaultValue = 200
<span style="color: #606060" id="lnum13">  13:</span>         , IsRequired = <span style="color: #0000ff">false</span>)]
<span style="color: #606060" id="lnum14">  14:</span>     [IntegerValidator(MinValue = 1
<span style="color: #606060" id="lnum15">  15:</span>         , MaxValue = 10000)]
<span style="color: #606060" id="lnum16">  16:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> SessionAttendees
<span style="color: #606060" id="lnum17">  17:</span>     
<span style="color: #606060" id="lnum18">  18:</span>         get { <span style="color: #0000ff">return</span> (<span style="color: #0000ff">int</span>) <span style="color: #0000ff">this</span>[<span style="color: #006080">&quot;sessionAttendees&quot;</span>]; }
<span style="color: #606060" id="lnum19">  19:</span>         set { <span style="color: #0000ff">this</span>[<span style="color: #006080">&quot;sessionAttendees&quot;</span>] = <span style="color: #0000ff">value</span>; }
<span style="color: #606060" id="lnum20">  20:</span>     }
<span style="color: #606060" id="lnum21">  21:</span>&#160; 
<span style="color: #606060" id="lnum22">  22:</span>&#160; 
<span style="color: #606060" id="lnum23">  23:</span>     [ConfigurationProperty(<span style="color: #006080">&quot;title&quot;</span>
<span style="color: #606060" id="lnum24">  24:</span>         , IsRequired = <span style="color: #0000ff">true</span>)]
<span style="color: #606060" id="lnum25">  25:</span>     [StringValidator(InvalidCharacters = <span style="color: #006080">&quot;~!@#$%^&*()[]{}/;’&quot;|&quot;)]
<span style="color: #606060" id="lnum26">  26:</span>     public string Title
<span style="color: #606060" id="lnum27">  27:</span>     {
<span style="color: #606060" id="lnum28">  28:</span>         get { return (string) this[&quot;</span>title<span style="color: #006080">&quot;]; }
<span style="color: #606060" id="lnum29">  29:</span>         set { this[&quot;</span>title&quot;] = <span style="color: #0000ff">value</span>; }
<span style="color: #606060" id="lnum30">  30:</span>     }
<span style="color: #606060" id="lnum31">  31:</span> }
```

This is an example of a [custom configuration section handler](/custom-configuration-section-handlers) which I’ve written about previously. I highly recommend [using such configuration sections instead of the built-in appSettings configuration section](/avoid-appsettings-usage-in-controls-or-shared-libraries), for a number of reasons. But note that the use of attributes alone adds quite a bit of bloat to this file, and it doesn’t even make use of any XML comments at this point in time.

I’ve found it to be worthwhile to [use interfaces to avoid direct dependencies on configuration files](/applying-interface-segregation-to-configuration-files), which helps achieve loose coupling and enable easier testing of a variety of configuration options. Another advantage I’ve recently discovered is the use of the interface to hold metadata and comments in a single location (following [the DRY principle](/don-rsquo-t-repeat-yourself)), which keeps implementations of the interface much cleaner.

Consider this interface for the above configuration section:

```
<span style="color: #606060" id="lnum1">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">interface</span> IDemoSettings
<span style="color: #606060" id="lnum2">   2:</span> {
<span style="color: #606060" id="lnum3">   3:</span>     <span style="color: #008000">/// &lt;summary&gt;</span>
<span style="color: #606060" id="lnum4">   4:</span>     <span style="color: #008000">/// Should indicate how many people are in the session</span>
<span style="color: #606060" id="lnum5">   5:</span>     <span style="color: #008000">/// &lt;/summary&gt;</span>
<span style="color: #606060" id="lnum6">   6:</span>     [ConfigurationProperty(<span style="color: #006080">&quot;sessionAttendees&quot;</span>, 
<span style="color: #606060" id="lnum7">   7:</span>         DefaultValue = 200, 
<span style="color: #606060" id="lnum8">   8:</span>         IsRequired = <span style="color: #0000ff">false</span>)]
<span style="color: #606060" id="lnum9">   9:</span>     [IntegerValidator(MinValue = 1, 
<span style="color: #606060" id="lnum10">  10:</span>         MaxValue = 10000)]
<span style="color: #606060" id="lnum11">  11:</span>     <span style="color: #0000ff">int</span> SessionAttendees { get; set; }
<span style="color: #606060" id="lnum12">  12:</span>&#160; 
<span style="color: #606060" id="lnum13">  13:</span>     <span style="color: #008000">/// &lt;summary&gt;</span>
<span style="color: #606060" id="lnum14">  14:</span>     <span style="color: #008000">/// The name of the presentation</span>
<span style="color: #606060" id="lnum15">  15:</span>     <span style="color: #008000">/// &lt;/summary&gt;</span>
<span style="color: #606060" id="lnum16">  16:</span>     [ConfigurationProperty(<span style="color: #006080">&quot;title&quot;</span>, 
<span style="color: #606060" id="lnum17">  17:</span>         IsRequired = <span style="color: #0000ff">true</span>)]
<span style="color: #606060" id="lnum19">  19:</span>     <span style="color: #0000ff">string</span> Title { get; set; }
<span style="color: #606060" id="lnum20">  20:</span> }
```

With this in place, we can eliminate the attributes from the class file and still get the validation these attributes provide. Further, the XML comments will appear in intellisense when these properties are used in our code. The adjusted configuration section handler now looks like this:

```
<span style="color: #606060" id="lnum1">   1:</span> <span style="color: #0000ff">public</span> <span style="color: #0000ff">class</span> DemoSettings : ConfigurationSection, IDemoSettings
<span style="color: #606060" id="lnum2">   2:</span> {
<span style="color: #606060" id="lnum3">   3:</span>     <span style="color: #0000ff">private</span> <span style="color: #0000ff">static</span> <span style="color: #0000ff">readonly</span> DemoSettings settings = 
<span style="color: #606060" id="lnum4">   4:</span>         ConfigurationManager.GetSection(<span style="color: #006080">&quot;DemoSettings&quot;</span>) <span style="color: #0000ff">as</span> DemoSettings;
<span style="color: #606060" id="lnum5">   5:</span>&#160; 
<span style="color: #606060" id="lnum6">   6:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">static</span> DemoSettings Settings
<span style="color: #606060" id="lnum7">   7:</span>     {
<span style="color: #606060" id="lnum8">   8:</span>         get { <span style="color: #0000ff">return</span> settings; }
<span style="color: #606060" id="lnum9">   9:</span>     }
<span style="color: #606060" id="lnum10">  10:</span>&#160; 
<span style="color: #606060" id="lnum11">  11:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">int</span> SessionAttendees
<span style="color: #606060" id="lnum12">  12:</span>     {
<span style="color: #606060" id="lnum13">  13:</span>         get { <span style="color: #0000ff">return</span> (<span style="color: #0000ff">int</span>) <span style="color: #0000ff">this</span>[<span style="color: #006080">&quot;sessionAttendees&quot;</span>]; }
<span style="color: #606060" id="lnum14">  14:</span>         set { <span style="color: #0000ff">this</span>[<span style="color: #006080">&quot;sessionAttendees&quot;</span>] = <span style="color: #0000ff">value</span>; }
<span style="color: #606060" id="lnum15">  15:</span>     }
<span style="color: #606060" id="lnum16">  16:</span>&#160; 
<span style="color: #606060" id="lnum17">  17:</span>     <span style="color: #0000ff">public</span> <span style="color: #0000ff">string</span> Title
<span style="color: #606060" id="lnum18">  18:</span>     {
<span style="color: #606060" id="lnum19">  19:</span>         get { <span style="color: #0000ff">return</span> (<span style="color: #0000ff">string</span>) <span style="color: #0000ff">this</span>[<span style="color: #006080">&quot;title&quot;</span>]; }
<span style="color: #606060" id="lnum20">  20:</span>         set { <span style="color: #0000ff">this</span>[<span style="color: #006080">&quot;title&quot;</span>] = <span style="color: #0000ff">value</span>; }
<span style="color: #606060" id="lnum21">  21:</span>     }
<span style="color: #606060" id="lnum22">  22:</span> }
```

It’s about 30% smaller (lines of code) on a class with only 2 properties. If this configuration section had many more properties, or many more attributes, or was using XML comments to start with, the reduction would be much greater.

Here’s what Visual Studio 2010 provides when referencing the class now, with the XML comments stored in the interface:

![image](<> "image")

And of course, the attributes still kick in if we don’t have required attributes in the configuration file, or if our values are outside of specified ranges.

**Summary**

In general, interfaces don’t get enough use in most applications. This is just one more reason why interfaces are useful as a means of cleaning up code and keeping a proper separation between the abstraction and the contract of what a class should do, and the actual implementation of that abstraction and contract.