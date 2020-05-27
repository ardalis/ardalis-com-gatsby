---
templateKey: blog-post
title: "Fixed: CCNET + MSBUILD Logger Error"
path: blog-post
date: 2007-07-22T12:28:00.000Z
description: "Ran into a snag this weekend with my build server – it started
  throwing errors related to the path to a folder, like this:"
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - C#
  - CC.NET
  - ci
  - Team System
  - VSTS
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Ran into a snag this weekend with my build server – it started throwing errors related to the path to a folder, like this:

**.MSBUILD : error MSB4015: The build was aborted because the “MsBuildToCCNetLogger” logger failed unexpectedly during shutdown. System.ArgumentException: The path is not of a legal form. at System.IO.Path.NormalizePathFast(String path, Boolean fullCheck) at System.IO.Path.GetDirectoryName(String path) at Rodemeyer.MsBuildToCCNet.MsBuildToCCNetLogger.WriteErrorsOrWarnings(XmlWriter w, String type, IEnumerable list) at Rodemeyer.MsBuildToCCNet.MsBuildToCCNetLogger.WriteProject(XmlWriter w, Project p) at Rodemeyer.MsBuildToCCNet.MsBuildToCCNetLogger.WriteLog(XmlWriter w) at Rodemeyer.MsBuildToCCNet.MsBuildToCCNetLogger.Shutdown() at Microsoft.Build.BuildEngine.Engine.UnregisterAllLoggers()**

I hadn’t changed anything in my server configuration, nor had I moved around any files in my project. The last thing I’d done was make some updates to my Database Project (VSTS Database Professional SKU), which had resulted in some errors and warnings (which I was happy to ignore since they were without merit).

My first thought was that perhaps I’d run into an existing bug, so I upgraded from [CruiseControl .NET 1.1 to 1.3](http://confluence.public.thoughtworks.org/display/CCNET/Welcome+to+CruiseControl.NET), the latest build. That didn’t work.

The logger I’m using is a separate open source DLL from [Christian Rodemeyer, Rodemeyer.MsBuildToCCnet.dll](http://confluence.public.thoughtworks.org/display/CCNETCOMM/Improved+MSBuild+Integration). Mine was from Jan 2007 and his latest on his [website](http://confluence.public.thoughtworks.org/display/CCNETCOMM/Improved+MSBuild+Integration) was from March 2007, so I upgraded. That didn’t work, either.

Happily, I had a decent stack trace and the source to MsBuildToCCnet is available (and complete with a .sln file and everything – nice!) so I snagged it and quickly found my problem in Logger.cs \[line 157]:

<!--EndFragment-->

```
<span class="kwrd">private</span> <span class="kwrd">void</span> WriteErrorsOrWarnings(XmlWriter w, <span class="kwrd">string</span> type, System.Collections.IEnumerable list)

{

    <span class="kwrd">foreach</span> (ErrorOrWarningBase ew <span class="kwrd">in</span> list)

    {

        w.WriteStartElement(type);

        w.WriteAttributeString(<span class="str">"code"</span>, ew.Code);

        w.WriteAttributeString(<span class="str">"message"</span>, ew.Text);

        w.WriteAttributeString(<span class="str">"dir"</span>, Path.GetDirectoryName(ew.File));

        w.WriteAttributeString(<span class="str">"name"</span>, Path.GetFileName(ew.File));

        w.WriteAttributeString(<span class="str">"pos"</span>, <span class="str">"("</span> + XmlConvert.ToString(ew.Line) + <span class="str">", "</span> + XmlConvert.ToString(ew.Column) + <span class="str">")"</span>);

        w.WriteEndElement();

    }

}
```

<!--StartFragment-->

My error was occurring on Path.GetDirectoryName() so I logged the value of ew.File (a string property) and found that it was empty. Probably the database error or warning I was getting was not associated with a file, and that was the root of my problem.

I updated the method as follows – feel free to cut-and-paste. Hopefully Christian will include this in a future revision:

<!--EndFragment-->

```
<span class="kwrd">private</span> <span class="kwrd">void</span> WriteErrorsOrWarnings(XmlWriter w, <span class="kwrd">string</span> type, System.Collections.IEnumerable list)

{

    <span class="kwrd">foreach</span> (ErrorOrWarningBase ew <span class="kwrd">in</span> list)

    {

        w.WriteStartElement(type);

        w.WriteAttributeString(<span class="str">"code"</span>, ew.Code);

        w.WriteAttributeString(<span class="str">"message"</span>, ew.Text);

        <span class="kwrd">if</span> (!String.IsNullOrEmpty(ew.File)) <span class="rem">// Added 22 July 2007 by Steven Smith</span>

        {

            w.WriteAttributeString(<span class="str">"dir"</span>, Path.GetDirectoryName(ew.File));

            w.WriteAttributeString(<span class="str">"name"</span>, Path.GetFileName(ew.File));

        }

        w.WriteAttributeString(<span class="str">"pos"</span>, <span class="str">"("</span> + XmlConvert.ToString(ew.Line) + <span class="str">", "</span> + XmlConvert.ToString(ew.Column) + <span class="str">")"</span>);

        w.WriteEndElement();

    }

}
```

<!--StartFragment-->

Hopefully if you encounter the same issue, this post will help you resolve it. Not writing out the dir and name attributes appeared to have no ill effect on the overall logger behavior, and my build is **green again**! w00t!

<!--EndFragment-->