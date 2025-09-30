---
title: ASP.NET Caching Tips from PDC 2003
date: "2003-10-30T00:00:00.0000000"
description: I hosted a Birds of a Feather Session at PDC 2003 which was attended by about 30 people, including Rob Howard from the ASP.NET team. During the course of the event, a number of tips and resources for caching in.NET were revealed. The highlights are listed here.
featuredImage: /img/pdc-2003-caching.png
---

## Caching Tips

I hosted a Birds of a Feather Session at PDC 2003 which was attended by about 30 people, including Rob Howard from the ASP.NET team. During the course of the event, a number of tips and resources for caching in.NET were revealed. The highlights are listed here.

- Output caching, even for just a couple of seconds, can dramatically reduce database load if pages are being hit several times per second and making several db calls per page.
- The Application object is essentially deprecated by the Cache object. It only exists in the framework today to avoid confusion for ASP developers coming from legacy ASP.
- The Cache object implements locking internally, so unless outside code is dependent on the concurrency of the caching operation, there is no need to implement locking. In the case where there is contention and dependency on the cached value, the framework's locking mechanisms (e.g. the lock keyword in C#) should be utilized.
- In ASP.NET 1.1 (and beyond), there is a Shared attribute for the output cache directive for user controls. This boolean attribute, when set to true, will allow multiple pages to share the same cache entry for a user control. This is extremely beneficial for navigation/chrome user controls which are shared on every page. In order for the sharing to work, the variable names of the controls must be identical between the pages. In ASP.NET 1.0 (or when shared is false), output cached user controls are stored as separate cache entries for every page. This exists today, but many people aren't aware of it.
- To efficiently cache bits of information within a request, especially useful for passing around security information between different components and controls, store the information in the HttpContext.Items collection. This collection exists within a single web request, and is disposed after each request ends.
- Store cache durations in a configuration file.
- Enable/Disable caching site-wide from a configuration file.
- Store cache keys in a configuration file, so that different members of teams will not come up with their own separate cache keys for the same data (e.g. 'Users' and 'User_Collection' and 'UserTable' and 'UserDataTable' all for the same object holding the same data, stored by different developers in different places in an application).
- AppSettings and other configuration items are cached with a file system dependency. In Whidbey, changes to the web.config will not always cause an app restart, so if you are relying on Application_Start to pick up changes in these values, stop! Set up your own cache dependency on the web.config or use a time limit, or come up with another pattern so that you can pick up changes to your config items without depending on an app restart (note that going directly against these values rather than caching them is fine, since they are themselves cached).

## Links

[Effective Cache Expriations](http://aspalliance.com/articleViewer.aspx?aId=69)

[On the Hour Caching](http://www.aspalliance.com/articleViewer.aspx?aId=66)

Originally published on [ASPAlliance.com](http://aspalliance.com/249_ASPNET_Caching_Tips_from_PDC_2003).

