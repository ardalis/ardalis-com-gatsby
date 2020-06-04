---
templateKey: blog-post
title: ASP.NET Shared Authentication Problem Solved
path: /asp-net-shared-authentication-problem-solved
date: 2016-04-12
featuredpost: false
featuredimage: /img/shared-security.jpg
tags:
  - asp.net
  - authentication
  - security
category:
  - Security
  - Software Development
comments: true
share: true
---
Last week I worked with a client to solve an issue they were having with a new ASP.NET 4.x application they had created using Visual Studio 2015. Their site is set up so that all of the authentication occurs through a shared, single-sign on, web site. Individual web projects are then hosted as subdomains which share the authentication cookie. It looks something like this:

admin.foo.com (root, includes login)\
app1.foo.com (authenticates from admin.foo.com)\
app2.foo.com (authenticates from admin.foo.com)\
app3.foo.com (authenticates from admin.foo.com)

They’ve been upgrading their systems to take advantage of the latest version of .NET and Visual Studio 2015, and a couple of the existing ASP.NET apps had been upgraded to ASP.NET 4.6 without issue. However, when they added a new ASP.NET project, setting it up just as the others, it refused to recognize the authentication cookie.

## TL;DR Version

The solution in our case turned out to be to set the compatibilityMode to “Framework45” in the new project’s web.config, on its machineKey setting:

```xml
<machineKey compatibilityMode="Framework45" />
```

What finally led us in the right direction was to check the event log, where we found errors claiming “401.2: Unauthorized: Logon failed due to server configuration”. It would have been a bit more helpful if it had told us something more specific about the server configuration, but eventually we tracked it down.

I’m not sure why the upgrade path (for ASP.NET runtime version) didn’t result in the same problem as creating a new project did. Clearly something must be different. At the end of the day, though, we had other features that needed done so having fixed the issue in this case, we didn’t try to track it down further.

## References

[Cryptographic Improvements in ASP.NET 4.5 part 2](https://blogs.msdn.microsoft.com/webdev/2012/10/23/cryptographic-improvements-in-asp-net-4-5-pt-2/)\
[Problem Sharing ASP.NET Forms Auth](https://essenceofcode.com/2013/03/14/problem-sharing-asp-net-forms-authentication-or-a-tale-of-two-cryptography-cores/)\
[Access is Denied – 401.2 Unauthorized Error](http://stackoverflow.com/questions/20802673/access-is-denied-401-2-unauthorized-error)