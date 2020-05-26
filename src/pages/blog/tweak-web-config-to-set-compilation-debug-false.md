---
templateKey: blog-post
title: Tweak web.config To Set Compilation Debug False
path: blog-post
date: 2008-03-30T12:23:23.581Z
description: "ASP.NET applications should never run with <compilation
  debug=”true”> in production. It can have drastic performance implications (of
  the negative kind). "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - C#
  - CC.NET
  - Cool Tools
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

ASP.NET applications should never run with <compilation debug=”true”> in production. It can have [drastic performance implications](http://weblogs.asp.net/scottgu/archive/2006/04/11/Don_1920_t-run-production-ASP.NET-Applications-with-debug_3D001D20_true_1D20_-enabled.aspx) (of the negative kind). Obviously, in a perfect world, developers would always remember to verify this setting whenever they upload changes to production, but unfortunately many organizations utilize fallible humans in their deployment process, and this is something that is easily missed.

As part of an automated build process, this problem can be eliminated fairly easily. Most sections within web.config can be extracted to separate files (using the configSource=”{path}” attribute), and separate files can be pulled in for TEST, STAGE, and PRODUCTION environments. However, the bulk of the <system.web> section will likely need to be the same between all three of these environments, so maintaining separate versions of this configuration element would violate [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself) and would be prone to problems. The solution in this case is to keep these settings in the main web.config file, and tweak them as part of the deployment process within the automated build. If you’re using [Web Deployment Projects](http://weblogs.asp.net/scottgu/archive/2008/01/28/vs-2008-web-deployment-project-support-released.aspx), they can help in this case. If you’re not, keep reading.

The easiest way to accomplish the modification of the web.config file is with an EXE that can be called from MSBuild, NAnt, CCNET, or whatever build automation software you’re using. If you’re only using one of these, it might make sense to create a custom MSBuild or NAnt task just for this purpose, but having the EXE is a bit more general purpose as it can then be called from any of these, or even from a batch file. I decided to name the EXE TweakConfig, and while it includes some code for checking parameters and such, its main function boils down to this (thanks [Dan Wahlin](http://weblogs.asp.net/dwahlin) for the original version of this code):

<!--EndFragment-->

```
 <span class="kwrd">private</span> <span class="kwrd">static</span> <span class="kwrd">void</span> ModifyDebugValue(<span class="kwrd">string</span> path, <span class="kwrd">bool</span> debugState)

        {

            XmlDocument doc = <span class="kwrd">new</span> XmlDocument();

            doc.Load(path);

            XmlElement compile = <br>doc.DocumentElement.SelectSingleNode(<span class="str">"system.web/compilation"</span>) <span class="kwrd">as</span> XmlElement;

            <span class="kwrd">if</span> (compile != <span class="kwrd">null</span>)

            {

                compile.SetAttribute(<span class="str">"debug"</span>, debugState.ToString().ToLower());

            }

            doc.Save(path);

        }

For example:
<strong>c:&gt;tweakconfig.exe web.config debug=false</strong>
```

<!--StartFragment-->

would set the <compilation debug=”true|false”> section to **false**.

We built this into a continuous integration solution for a client last week, and it’s working great. I’ve been helping a few different companies with their continuous integration server setup (with CruiseControl.NET), and wrote a white paper a couple of months ago for Microsoft on the topic (with TFS 2008), so this is an area I’m spending a fair bit of time on lately. If you’d like help getting up to speed with automated builds and continuous integration for your company, feel free to [contact me](http://aspadvice.com/blogs/ssmith/contact.aspx).

I’ve made the [source project](http://aspalliance.com/download/tweakconfig.zip "TeakConfig CS Project") and the [EXE](http://aspalliance.com/download/TweakConfigEXE.zip "TweakConfig EXE") available. If you find any bugs or enhance it, please email me and I’ll update my files.

<!--EndFragment-->