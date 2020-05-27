---
templateKey: blog-post
title: ASP.NET Custom Errors Security Flaw
path: /asp-net-custom-errors-security-flaw
date: 2010-09-18
featuredpost: true
featuredimage: /img/security.jpg
twitter: na
tags:
  - asp.net
  - security
category:
  - Security
  - Software Development
comments: true
description: na
share: true
---
**Updated 5 October 2010: There is now a patch available via Windows Update. Read more about it [here](http://weblogs.asp.net/scottgu/archive/2010/09/30/asp-net-security-fix-now-on-windows-update.aspx), and ensure all ASP.NET web servers have been patched ASAP.**

Microsoft just released some details on a security flaw that was publicized a few hours ago. On this post, you can learn more about the [ASP.NET vulnerability](http://blogs.technet.com/b/srd/archive/2010/09/17/understanding-the-asp-net-vulnerability.aspx) and how to detect whether your web sites might be affected by them. This is a serious flaw that you should take steps to address as soon as possible, since the attack can be performed by anybody with the available tools, in less than a minute, and can provide them with access to any file the site has access to (including web.config), as well as potentially root level access to the machine. This [YouTube video shows the use of the tool (POET) in action](http://www.youtube.com/watch?v=yghiC_U2RaM&feature=player_embedded#!).

In order to detect sites on your server that may be vulnerable, copy the [script provided here](http://blogs.technet.com/b/srd/archive/2010/09/17/understanding-the-asp-net-vulnerability.aspx) to a file on your server named**DetectCustomErrors.vbs**. Next, open a command line window as administrator and run the following command (I ran it from d: which is the root folder of my drive where my web sites are located):

**cscript DetectCustomErrors.vbs**

The output will be something like the following:

[![image](/img/output.png "image")](/img/output.png)

Once you’ve identified the config files that are vulnerable, the simplest solution is to provide a single custom error page, like so:

`<customErrors mode="RemoteOnly" defaultRedirect="/Error.htm"/>`

**Do not include separate error codes for 404, 500, etc.** The attack relies on gaining information from the variability in error codes. You need to set a single defaultRedirect. It’s also insufficient to have no defaultRedirect.

The way the exploit works is by gaining information from which errors are returned and potentially from how long it takes for a given error to be returned. By always returning the same static file in response to any error, you deny the attacker this information and maintain the security of the application.

Don’t forget to apply this fix to non-production-but-public sites as well. If you have publicly accessible test, stage, beta, etc sites, they need to be addressed unless they are in a completely locked down DMZ, since anything on their machine could be compromised by this exploit.

Please share this post and the information in it as widely as possible. As of this moment, virtually any ASP.NET web site online can potentially be compromised with about a minute’s work. By working together quickly, we (developers and IT pros) should be able to eliminate this vulnerability quickly, saving our companies and clients from potentially large losses.

**Update** – There’s a slight bug in the script as published. Change line 123:

from : EnumWebConfig(objDir.Path)

to: EnumWebConfig(physicalPath)

**Update Update:** The above fix on line 123, and several others, are incorporated into the script now. [ScottGu also has posted details about the vulnerability and how to work around it](http://weblogs.asp.net/scottgu/archive/2010/09/18/important-asp-net-security-vulnerability.aspx).

**Additional Resources:**

If you have [a load balancer, you may be able to apply one rule to protect your sites](http://devcentral.f5.com/Tutorials/TechTips/tabid/63/articleType/ArticleView/articleId/41/Custom-error-pages-by-way-of-iRule.aspx)