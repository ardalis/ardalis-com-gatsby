---
templateKey: blog-post
title: "NUnit 2.1 Final Release Available "
path: blog-post
date: 2003-09-01T22:44:00.000Z
description: "From Charlie Poole on the TDD List: The final release of NUnit 2.1
  is now available for download"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - NUnit 2.1
category:
  - Software Development
comments: true
share: true
---
<!--StartFragment-->

From Charlie Poole on the TDD List:

> The final release of NUnit 2.1 is now available for download at

*[http://nunit.sourceforge.net](http://nunit.sourceforge.net/)*.

This release has a number of improvements, most notably that it will

run under version 1.0 of the .NET framework as installed. It includes

separate configuration files for use with .NET versions 1.0 and 1.1.

Both configs are copied and the correct version for the current system

is installed ready for use.

NUnit 2.1 can run tests built against NUnit 2.0. A sample config file

for use in this situation is included.

Substantial changes have been made to error and exception reporting.

The exception type is listed along with all inner exceptions. In the

console runner, this includes a full stacktrace. The full trace for

exceptions that are caught by the GUI runner is now available under

the Tools | Exception Details… menu item.

This release has been verified to install and run under Windows 98.

The feature of watching for changes in the assemblies and reloading

them automatically is disabled in this environment. We haven’t tested

under Windows ME, but believe it will work in that environment as well.

Unfortunately, at this time SourceForge is down and the URL for NUnit 404s, but hopefully that is only temporary.

<!--EndFragment-->