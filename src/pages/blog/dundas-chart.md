---
templateKey: blog-post
title: Review - Dundas Chart 3.5
date: 2003-07-27
path: blog-post
description: A review of Dundas Chart 3.5, covering installation, documentation, getting started and some simple usage scenarios.
featuredpost: false
featuredimage: /img/dundas-chart.png
tags:
  - ASP.NET
category:
  - Software Development
  - Productivity
comments: true
share: true
---

## Installation

[Dundas Chart 3.5](http://www.dundas.com/index.aspx?Section=ChartHome&body=body.htm) (in beta at time of publication) is the latest version of Dundas' Charting component for ASP.NET. I've had the opportunity to use it for some simple real-world applications I've been building, and I thought I'd share my experiences here.

- Detected and uninstalled previous version - no problem.
- Installed in about 5 minutes with no errors or problems.
- My configuration: Windows XP Pro, Visual Studio .NET 1.1 and 1.0

Upon completion, the installer opens up the readme and runs the sample by default. These are also available in the start menu.

## Configuration and Samples

The Readme has the usual what's new, requirements, and configuration settings, all of which seem up-to-date and correct.

The Samples open up in a nice treeview/frame combination, and work 100% out-of-the-box in my testing.

The new 3.5 feature, Data Source Binding, looks very nice, at first glance. The SVG charts require an Adobe plugin for my IE 6 client, but work fine once that's done.

## Integration and Design Time Support in VS.NET 2003

By default, it is not included in the IDE. However, the Readme explains how to correct this by using the "Customize Toolbox" ("Add/Remove Items" in VS.NET 2003) option in the toolbox, and once that's done, it works fine.

Dragging a Chart onto a web page using the VS.NET designer opens up the Dundas Chart Wizard (by default - you can turn it off if you like). This is a **very** useful tool, and makes adding charts to your web forms a breeze. Once the wizard is completed, the chart appears on the design surface approximately as it will when it is rendered. To return to the wizard to edit the chart's properties, simply right-click on the chart control on the design surface, and select 'Wizard'.

![Screenshot](/img/dundas-chart-1.gif)

A new feature of this version of Dundas Chart is the addition of the Series Data menu to the wizard. This allows you to connect to a data source and preview the data you're going to use in the chart, and to determine which columns from the data should be used. For my sample application, I was using a custom data layer, so I already had my data in a DataTable object. But if that had not been the case, I could have quickly grabbed the data using the wizard, and avoided the two lines of code I ended up writing to bind to my DataTable.

![Screenshot](/img/dundas-chart-2.gif)

![Screenshot](/img/dundas-chart-3.gif)

As you can see, the wizard is very easy to use - there's no need to go crawling through obtuse APIs to learn how to set up a chart object and make it render itself. Just drag the control onto the design surface, run through the wizard, maybe write a line or two of code to wire things together, and voila! A beautiful chart. I think the most difficult part of this whole process was granting write permissions to the folder where the chart images are created for the ASPNET account, and that took about 30 seconds and was clearly documented in the readme.

## Features I Use

I have fairly simple charting needs. Typically I want to show how statistical information has changed from month-to-month for things like server traffic or advertising revenue. Dundas' control provides support for these simple line charts with a minimal amount of code or thought on my part, which I like. Their control also has support for more esoteric charts, such as the radar chart they have added in version 3.5, which I'm hoping to have the opportunity to put to use in the near future.

You can see how I've put the control to use to display the activity of the moderators on the ASP.NET Forums from these screenshots:

![Screenshot](/img/dundas-chart-4.gif)

![Screenshot](/img/dundas-chart-5.gif)

## Summary

I've used Dundas Chart for several development projects in the last few months, using versions 3.1 and the latest beta of 3.5. In each case, I have found the product to install painlessly and quickly, and to be a complete breeze to configure and get working both in the development environment (VS.NET 1.0 and VS.NET 2003) and in production on the server.

### Links

[Dundas Charting Home](http://www.dundas.com/index.aspx?Section=ChartHome&body=body.htm)

Originally published on [ASPAlliance.com](http://aspalliance.com/209_Review_Dundas_Chart_35).
