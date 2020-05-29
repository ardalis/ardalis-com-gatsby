---
templateKey: blog-post
title: List Services Running on Remote Servers
path: blog-post
date: 2011-02-06T03:47:00.000Z
description: "As I wrote earlier, Lake Quincy Media’s AdSignia ad platform is
  utilizing services and a message-based architecture to decouple the system
  from the database and improve performance and reliability of the servers.  "
featuredpost: false
featuredimage: /img/network-2402637_1280.jpg
tags:
  - devops
  - it
  - servers
  - services
category:
  - Software Development
comments: true
share: true
---
As I wrote earlier, [Lake Quincy Media’s](http://lakequincy.com/) AdSignia ad platform is utilizing services and a [message-based architecture](/message-based-architecture-goodness) to decouple the system from the database and improve performance and reliability of the servers. It’s proven useful to quickly work with the services across multiple nodes in the web cluster, and PowerShell is the obvious choice for automating some of these tasks. When building up a collection of PowerShell scripts to support an application, I recommend that you store them in source control with the application itself. It’s also worth following the [Don’t Repeat Yourself principle](/don-rsquo-t-repeat-yourself), which you can do by [using PowerShell functions to return results from one PowerShell script file to another](/pass-results-from-one-powershell-script-to-another).

In my case, since I have a number of servers involved in the application, it makes sense to store the list of server names in their own file. I only need the names, so returning a simple array of strings does the trick:

**ListServers.ps1**

```
# List Production Servers
&#160;
function ListServers
{
  <span style="color: #0000ff">return</span> <span style="color: #006080">&quot;server1&quot;</span>,<span style="color: #006080">&quot;server2&quot;</span>,<span style="color: #006080">&quot;server3&quot;</span>,<span style="color: #006080">&quot;yetanotherserver&quot;</span>
}
```

Now the next step is to get a list of services running on each of these machines. I found a post that showed [how to list remote services using PowerShell](http://thepowershellguy.com/blogs/posh/archive/2007/01/03/powershell-using-net-to-manage-remote-services.aspx), which led me to this code:

**ListServices.ps1**

```
# List DataPump Services and Status on Production Servers
&#160;
<span style="color: #0000ff">if</span> (-not ([appdomain]::CurrentDomain.getassemblies() |? {$_.ManifestModule -like <span style="color: #006080">&quot;system.serviceprocess&quot;</span>})) {[<span style="color: #0000ff">void</span>][System.Reflection.Assembly]::LoadWithPartialName(<span style="color: #006080">'system.serviceprocess'</span>)}
&#160;
. ./ListServers.ps1; $servers=ListServers
&#160;
function ListServices
{
&#160;
$all = $<span style="color: #0000ff">null</span>
&#160;
<span style="color: #0000ff">foreach</span>($s <span style="color: #0000ff">in</span> $servers)
{
  <span style="color: #0000ff">if</span> ($all -eq $<span style="color: #0000ff">null</span>) { $all = [System.ServiceProcess.ServiceController]::GetServices($s) } 

  <span style="color: #0000ff">else</span>

  {
  $all = $all + [System.ServiceProcess.ServiceController]::GetServices($s) | ? {$_.DisplayName -like <span style="color: #006080">&quot;AdSignia*&quot;</span>}
  }

}

&#160;
<span style="color: #0000ff">return</span> $all
&#160;
}
&#160;
ListServices | Format-Table -AutoSize -Property MachineName,DisplayName,Status
```

You can run this from the command line directly by calling .ListServices.ps1, or you can call the ListServices function from another script, which proves useful when you want to Start or Stop a Remote Service using a Powershell script.

Calling it directly results in something like this:

```
<br />MachineName        DisplayName        Status<br />-----------        -----------        ------<br />server1              AdSignia.Service1  Running<br />server2              AdSignia.Service1  Running<br />server3        AdSignia.Service1  Running<br />yetanotherserver   AdSignia.Service2  Running
```

So there you have it – how to list the services running on a remote server using PowerShell. Note that if you want to list \*all\* of the services, simply remote this bit from the foreach loop:

> \| ? {$_.DisplayName -like "AdSignia*"}