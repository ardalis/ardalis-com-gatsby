---
templateKey: blog-post
title: Could not load file or assembly Microsoft.ReportViewer.WebForms
path: blog-post
date: 2007-01-24T17:27:21.277Z
description: "Ran into this error while deploying an application to production:
  Configuration Error"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - error
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Ran into this error while deploying an application to production:

## *Configuration Error*

**Description:** An error occurred during the processing of a configuration file required to service this request. Please review the specific error details below and modify your configuration file appropriately.

**Parser Error Message:** Could not load file or assembly ‘Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a’ or one of its dependencies. The system cannot find the file specified.

A quick [search found the issue](http://forums.microsoft.com/MSDN/ShowPost.aspx?PostID=76154&SiteID=1). The server needs these three files:

Microsoft.ReportViewer.Common.dll\
Microsoft.ReportViewer.WebForms.dll\
Microsoft.ReportViewer.ProcessingObjectModel.dll

These get installed by ReportViewer.exe, which can be found here:

***C:Program FilesMicrosoft Visual Studio 8SDKv2.0BootStrapperPackagesReportViewerReportViewer.exe***

In my case I just FTP’s up my entire ***C:Program FilesMicrosoft Visual Studio 8SDKv2.0BootStrapperPackagesReportViewer***folder to the server and then I was able to run the EXE without problem.

<!--EndFragment-->