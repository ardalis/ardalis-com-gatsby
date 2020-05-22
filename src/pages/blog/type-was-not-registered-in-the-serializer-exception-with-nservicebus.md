---
templateKey: blog-post
title: Type was not registered in the serializer exception with NServiceBus
path: blog-post
date: 2011-01-07T11:19:00.000Z
description: "If you encounter this error in your ASP.NET application after
  updating it while using NServiceBus:"
featuredpost: false
featuredimage: /img/bus-2523410_1280.jpg
tags:
  - nservicebus
category:
  - Software Development
comments: true
share: true
---
If you encounter this error in your ASP.NET application after updating it while using [NServiceBus](http://nservicebus.com/):

> **Server Error in ‘/’ Application.\
> Type DataPump.Infrastructure.Messages.MyMessage was not registered in the serializer. Check that it appears in the list of configured assemblies/types to scan.\
> Description: An unhandled exception occurred during the execution of the current web request. Please review the stack trace for more information about the error and where it originated in the code.**
>
> **Exception Details: System.InvalidOperationException: Type DataPump.Infrastructure.Messages.MyMessage was not registered in the serializer. Check that it appears in the list of configured assemblies/types to scan.**

you can most likely clear it by deleting the Temporary ASP.NET Files, which you’ll find in your c:WindowsMicrosoft.NETFramework(64){version} folder.

You may need to stop your w3svc process for the site in question in order to unlock the files.