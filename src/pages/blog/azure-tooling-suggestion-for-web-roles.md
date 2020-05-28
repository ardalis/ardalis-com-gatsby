---
templateKey: blog-post
title: Azure Tooling Suggestion for Web Roles
path: blog-post
date: 2009-03-03T07:28:00.000Z
description: With Azure today, there are two projects, you can create a Web Role
  which is basically an ASP.NET Web Application that is configured to
  automatically deploy to the local dev fabric (local cloud proxy).
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Azure
  - ASP.NET
category:
  - Uncategorized
comments: true
share: true
---
With Azure today, there are two projects, you can create a Web Role which is basically an ASP.NET Web Application that is configured to automatically deploy to the local dev fabric (local cloud proxy). When you Run the application, with F5 or Ctrl-F5, it will package up the application and deploy it to your local dev fabric, along with starting other services like Azure Storage locally, so that you get a nice dev experience.

However, since it’s really an ASP.NET Project under the covers, the Web Role project also supports (in the solution explorer) the Right-Click, View in Browser command that ASP.NET apps all have. And it (mostly) works! However, it doesn’t actually run on the local dev fabric – it launches the Local Dev Server (Cassini) just like any ASP.NET project. This is something I find myself doing out of habit, and having a site designed to run on the dev fabric running in Cassini usually doesn’t work all that well. Hopefully later versions of the SDK will update the project template and/or tooling support so that one can launch the app in the dev fabric from the solution explorer, and one **cannot** launch a Web Role Azure project with Cassini.