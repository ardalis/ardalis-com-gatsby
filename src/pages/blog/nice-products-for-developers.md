---
templateKey: blog-post
title: Nice Products for Developers
path: blog-post
date: 2007-10-01T11:39:44.540Z
description: We have a new intern starting with us at [Lake Quincy Media] today,
  and in the course of getting him set up, I thought I would mention of a few
  products we’re using that work quite well for us here.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - asp.net
  - C#
  - Cool Tools
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

[](http://www.appdev.com/ "appdev")We have a new intern starting with us at [Lake Quincy Media](http://lakequincy.com/) today, and in the course of getting him set up, I thought I would mention of a few products we’re using that work quite well for us here. The first one relates to training new interns with limited real world programming experience ([Kent State University](http://www.kent.edu/) doesn’t do us any favors here – no Microsoft technology, no SQL technology, and no web technology has been covered for most of their computer science graduates, much less students). For training, we use and have been very happy with [AppDev](http://www.appdev.com/). (sidenote: neither AppDev nor KSU’s web sites works without a www. prefix, making both of them unnecessarily difficult to access by just typing appdev.com or kent.edu in the address box of a browser – hopefully they’ll correct this).

![](/img/appdev.jpg)

We’re using the following courses to get our interns up to speed:

[Visual C# 2005: Developing Applications](http://www.appdev.com/prodfamily.asp?catalog%5Fname=AppDevCatalog&category%5Fname=CS05Product)

[ASP.NET Using Visual C# 2005](http://www.appdev.com/prodfamily.asp?catalog%5Fname=AppDevCatalog&category%5Fname=AC05Product)

[Exploring SQL Server 2005](http://www.appdev.com/prodfamily.asp?catalog%5Fname=AppDevCatalog&category%5Fname=ESQ05Product&cookie%5Ftest=1)

[Microsoft SQL Server 2005](http://www.appdev.com/prodfamily.asp?catalog%5Fname=AppDevCatalog&category%5Fname=SQ05Product)

<!--EndFragment-->

![](/img/cctray.jpg)

<!--StartFragment-->

[](http://confluence.public.thoughtworks.org/display/CCNET/CCTray "cctray")A few other things we always install are [Reflector](http://www.aisto.com/roeder/dotnet), [DebugView](http://www.microsoft.com/technet/sysinternals/utilities/debugview.mspx) (SysInternals), and [Daemon Tools](http://www.daemon-tools.cc/dtcc/announcements.php) for CD installs. The other thing we’re sure to install is [CCTray](http://confluence.public.thoughtworks.org/display/CCNET/CCTray), which works well with our [CruiseControl.Net](http://confluence.public.thoughtworks.org/display/CCNET/Welcome+to+CruiseControl.NET) Continuous Integration service, which we have pointing at a Team Foundation Server 2005 instance.

Naturally we install Visual Studio ( in this case 2008 beta 2) and [SQL Server 2005 (see this post on some notes on installing the dev tools](http://aspadvice.com/blogs/ssmith/archive/2007/09/24/Installing-SQL-2005-Management-Studio.aspx)) and Office 2007. We also install FireFox with [FireBug](https://addons.mozilla.org/en-US/firefox/addon/1843), which is an awesome tool for AJAX, general JavaScript, CSS, etc. I wish IE had something as nice, but I’ll settle for the [IE developer toolbar](https://www.microsoft.com/downloads/details.aspx?familyid=E59C3964-672D-4511-BB3E-2D5E1DB91038&displaylang=en).

[SlickRun](http://www.bayden.com/SlickRun) is another great tool, though in Vista it’s not as critical since you can pull up start and type in something and usually it’ll find it. But I still use it.

[![](<>)](http://www.thycotic.com/products_secretserver_screens.html) The last thing we’ve started using recently which has been a big help, especially when it’s time to build out a new machine is [Secret Server](http://www.thycotic.com/products_secretserver_overview.html). We’re using the online version of the tool but you can also install your own server and run it in-house. The application basically lets you store all kinds of secrets, such as passwords, installation keys, or even your bank pin numbers or your credit card numbers. The communication with the server takes place securely, and if you need to give a secret to someone else in your organization, you simply share it with them in the tool and send them a link to the (secure) URL which they can access with their login. It’s a closed system – you can’t send a secret to someone who doesn’t have an account and you’re limited in how many accounts you can have, but it definitely is more secure than IMing or emailing secure things around the organization, or storing things as files on computers which might one day be stolen or otherwise compromised. The application also features auditing, so you can tell if or when a given user has viewed or updated a given secret that you are the administrator of. It’s also great for sysadmins since it has built-in Active Directory integration, synchronization and remote password management, something we don’t use but which I can understand the utility of in a larger enterprise.

It comes with a free license for personal use, but again the real value of the product comes in an organization wherein you can share secrets securely without resorting to email or IM to transfer them.

<!--EndFragment-->