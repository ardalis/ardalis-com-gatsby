---
templateKey: blog-post
title: WPF for ASP.NET Developers
path: blog-post
date: 2007-06-13T13:43:24.604Z
description: Brian Noyes gave a presentation to the [Cleveland .NET SIG] last
  night on WPF for ASP.NET Developers. I took some notes, which I’ll present a
  few of here in case they’re helpful to anyone else.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - silverlight
  - WPF
  - XAML
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Brian Noyes gave a presentation to the [Cleveland .NET SIG](http://www.bennettadelson.com/technicalresources/sig.aspx) last night on WPF for ASP.NET Developers. I took some notes, which I’ll present a few of here in case they’re helpful to anyone else.

* WPF
* * Logical Pixels, not physical pixels, each 1/96 of an inch
  * Vector Graphics based
  * Containers
  * * Many controls are containers
    * Support composition (images within buttons within buttons etc.)
  * Declarative XAML
  * * Documents and Media are 1st class objects
    * * Video/Audio
      * Word DOCs, PDF, etc.
  * Supports Interop (both ways) with Windows Forms in about 4 LOC
  * Requires .NET 2.0
  * * New features will require .NET 3.0/3.5
* Application Types
* * Windows Application
  * * Same as Windows Forms
    * Can support ClickOnce deployment
  * XBAP
  * * XAML Browser Application
    * Runs in the browser transparent to the user
    * Behind scenes, uses ClickOnce to deploy
    * Limited Security Context
  * XAML in the Browser
  * * Static – no script/DLLs
    * Basically a way to render without resorting to HTML
* Silverlight 1.1 – What’s needed?
* * Runtime
  * SDK
  * Orcas B1 and Tools
  * Expression Blend 2
* Silverlight 1.1 – Features
* * .NET Codebehind
  * Some Controls
  * Access to BCL
  * LINQ
  * Networking stack including REST/RSS
  * Dynamic Language Support
  * Some DRM story
* XAML Basics
* * Elements define objects or set properties – similar to ASP.NET markup
  * XML namespaces scope objects defined in markup
  * * Think Imports or using statements
  * Dependency Properties – Attached Property
  * * Objects can refer to properties of their containers
    * e.g. <Grid><Image Grid.Column=”1” … /></Grid>
    * Also used to affect behavior, particularly in WF
  * Note calls to InitializeComponent() at design time, even though this doesn’t exist until runtime.
* Data Binding
* * Example: Text=”{Binding Path=Title}”
  * Window.DataContext is the property to assign collections or objects to
* Blend2
* * Supports Adding Events to Controls if VS is used at same time
  * Switches focus to VS and adds the event
  * Requires VS to compile the app then before Blend can preview it
  * My take – better than hand writing the events but very klugey to have to jump between the tools, especially when MSBuild would be so easy to call from Blend.

Overall it was a good overview. I missed the very beginning. The slides and demos and such are available on [Brian’s blog](http://www.softinsight.com/bnoyes/PermaLink.aspx?guid=ba6d5462-5901-492b-84f2-0af3536419b4). If that doesn’t work, try the [.NET SIG Presentations area](http://www.bennettadelson.com/technicalresources/presentations.aspx).

\[categories: XAML,WPF,Silverlight]

<!--EndFragment-->