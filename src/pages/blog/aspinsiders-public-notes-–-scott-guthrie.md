---
templateKey: blog-post
title: ASPInsiders Public Notes – Scott Guthrie
path: blog-post
date: 2006-12-05T21:10:37.754Z
description: "VS 2005 SP1 coming soon (end of year, hopefully). Will include:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - Events
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

**VS 2005 SP1 coming soon (end of year, hopefully). Will include:**

* 2200+ bug fixes
* Built-in Web Application Project support
* GDRs are public fixes (patch rollups) that include rollups of QFEs – GDRs are similar to service packs but service packs affect support (Microsoft supports the latest service pack and the previous service pack, but not further back). So – GDRs are good because they provide public fixes without eliminating support for any prior versions.
* The service pack 1 beta is not like a typical product beta (e.g. use at your own risk bits) — it contains well tested product fixes that are signed off on, and should be usable on “production” machines. When SP1 RTM comes out, just uninstall the beta and install the RTM SP.

**Data Publishing for Hosting**

* Free add-on for VWD or Visual Studio
* Right-click on SQL Express or SQL Server and generate a .sql file or publish database to server using a web service (if the hoster has set up the web services required). Transfers both schema and data, with built-in support for ASP.NET provider schema.
* Currently hosted on CodePlex
* Should be released this month.

**VS2005 Team Edition for Data Professionals**

* Just released
* Supports schema versioning, change management
* Schema Compare
* Data Compare
* DataGenerator
* DB Unit Test Creation
* Improved TSQL Editor

**SharePoint 2007**

* VS 2005 Extensions for SharePoint provide authoring support for SharePoint web parts and will deploy the parts to the server
* ASP.NET AJAX support coming in SharePoint 2007 SP1

**Expression Designer Suite**

* Expression Web
* Expression Blend aka “Sparkle” targets WPF/WPF/E
* Expression Design — XAML export, image design
* Expression Media – includes support for searching, annotations of images

**IIS7**

Lots of cool things coming. XCOPY config deployment using new system.webServer config section. Support for new modules and handlers, like a DirListHandler that will change the default IIS file list to show something much more interesting, like turning a folder full of images into a simple photo gallery with no code (cool demo, Scott!). It’s included in Vista (note to self – check it out).

[More Info](http://iis.net/)

**ASP.NET AJAX 1.0**

* Coming soon, but not before Christmas
* Futures CTP — many of these will come rolled up into Orcas; a few will probably come post-Orcas.
* ASP.NET AJAX will integrate with WPF/E
* All source (both server and client) will ship with ASP.NET AJAX
* Futures CTP will include Redist rights, too.

**VS Orcas**

* Will support targeting multiple versions of .NET Framework (2.0, 3.0, vNext)
* When opening VS 2005 projects, developers can choose to auto-upgrade if desired
* JavaScript Intellisense and improved debugging
* Debugger visualizers for JavaScript
* Language Integrated Query (LINQ)
* New asp:ListView control, new LinqSqlDataSource which works against LINQ entities

More cool stuff coming. The WPF/E stuff that just dropped yesterday looks quite cool – haven’t had a chance to play with it myself yet.

<!--EndFragment-->