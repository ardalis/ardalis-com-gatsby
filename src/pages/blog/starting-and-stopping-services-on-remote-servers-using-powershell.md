---
templateKey: blog-post
title: Starting and Stopping Services on Remote Servers using PowerShell
path: blog-post
date: 2011-02-06T03:42:00.000Z
description: This wraps up my mini-series on using PowerShell to help manage
  services running on multiple remote servers.  In my case, these scripts exist
  to make it easy for me to globally start and stop services on a number of web
  servers.
featuredpost: false
featuredimage: /img/get-start.jpg
tags:
  - powershell
  - services
category:
  - Software Development
comments: true
share: true
---
This wraps up my mini-series on using PowerShell to help manage services running on multiple remote servers. In my case, these scripts exist to make it easy for me to globally start and stop services on a number of web servers that are part of [Lake Quincy Media’s](http://lakequincy.com/) AdSignia ad platform – you can read more about the [message-based architecture we’re using here](/message-based-architecture-goodness).

I learned the basics of starting and stopping services [here](http://thepowershellguy.com/blogs/posh/archive/2007/01/03/powershell-using-net-to-manage-remote-services.aspx). I adapted this so that I could store all of my server’s names in one PowerShell script, and call into it with another to [list all of the running servers on remote servers using another PowerShell script](/list-services-running-on-remote-servers). I also made sure to make the ListServices.ps1 script use a function as well, so that I could call into it from my StartServices and StopServices scripts. Here they are:

**StartServices.ps1**

```
# Start Services on Production Servers
&#160;
. .ListServices.ps1; $result = ListServices

&#160;
<span style="color: #0000ff">if</span>($result -eq $<span style="color: #0000ff">null</span>) { <span style="color: #006080">&quot;Result is null&quot;</span> }
&#160;
<span style="color: #0000ff">foreach</span>($result <span style="color: #0000ff">in</span> $result)
{

  <span style="color: #006080">&quot;Starting &quot;</span> + $result.DisplayName + <span style="color: #006080">&quot; on &quot;</span> + $result.MachineName

  (<span style="color: #0000ff">new</span>-Object System.ServiceProcess.ServiceController($result.DisplayName,$result.MachineName)).Start()

}

&#160;
.ListServices.ps1
```

**StopServices.ps1**

```
# Stop Services on Production Servers
&#160;

. .ListServices.ps1; $result = ListServices
&#160;
<span style="color: #0000ff">if</span>($result -eq $<span style="color: #0000ff">null</span>) { <span style="color: #006080">&quot;Result is null&quot;</span> }
&#160;

<span style="color: #0000ff">foreach</span>($result <span style="color: #0000ff">in</span> $result)

{

  <span style="color: #006080">&quot;Stopping &quot;</span> + $result.DisplayName + <span style="color: #006080">&quot; on &quot;</span> + $result.MachineName

  (<span style="color: #0000ff">new</span>-Object System.ServiceProcess.ServiceController($result.DisplayName,$result.MachineName)).Stop()

}

&#160;

.ListServices.ps1
```

These two scripts will work with whatever list of services you return back from[ListServices.ps1](/list-services-running-on-remote-servers)– they are not specific to my application’s services. I would caution you not to return a full list of services on the machine – stopping ALL services on the machine, especially if it’s a production server, would probably be a **Bad Thing™.**Don’t do that.