---
templateKey: blog-post
title: PDC – Jim Allchin's Keynote
path: blog-post
date: 2005-09-13T14:27:09.728Z
description: Jim Allchin gave the second keynote, which included many demos from
  a variety of Microsoft teams and a couple of partners.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - asp.net
  - Events
  - Microsoft Office
  - VS.NET
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

Jim Allchin gave the second keynote, which included many demos from a variety

of Microsoft teams and a couple of partners. Most of it centered around

new features that will be available in Vista. For example, their virtual

memory system will be able to take advantage of external memory, such as from

USB drives. They showed off a feature called SuperFetch, but unfortunately

I was dozing off for most of that demo so all I saw was that it was searching

the system for various files and (presumably) pre-fetching them.

One security issue Jim stressed was the ability to run applications in a Low

Integrity Mode, which would basically create a sandbox around an application and

allow limits to be placed on its privileges.

New things coming soon include WPF/E which is Windows Presentation

Framework/Everywhere — a lightweight XAML+JScript implementation for multiple

form factors/devices.

A NetFlix demo showed off many of the 3D graphics capabilities of

Vista. The demo showed off a service to allow a user to add/remove/arrange

movies in their Netflix queue using a Windows client, tablet, or mobile

device.

The bulk of the demos were done by Don Box, Scott Guthrie, Anders Heljsberg

and centered around LINQ (Language INtegrated Query) and Atlas. Basically

this will allow query information to be part of the developer’s primary

language, rather than requiring the developer to learn SQL or XPath and a

separate API to use these other languages (e.g. System.Data or

System.Xml). Two of the namespaces demo’d include System.Xml.XLinq and

System.Data.DLinq. Here’s an example of the code that one would write

using LINQ to get a list of processes running on one’s system and output it to

the console:

var query

\=\
from p in Process.GetProcesses()\
where p.WorkingSet >

1024\*1024\*4 // 4mb\
orderby p.WorkingSet descending\
select new

{\
p.ProcessName,\
p.WorkingSet\
};

foreach (var item in

query)\
Console.WriteLine(…)

Another interesting feature of this is that

regular expressions can easily be used for the matching in queries.

Further, it is trivial to take the above code and wire it up to data from a

database and/or from an XML document, as they later went on to show.

Scott Guthrie showed off Atlas, which is

currently available for download from the [ASP.NET beta](http://beta.asp.net/default.aspx?tabindex=7&tabid=47)

[website](http://beta.asp.net/default.aspx?tabindex=7&tabid=47). It’s Microsoft’s AJAX story for v2 and looks pretty

slick. You’ll find quickstart tutorials and hands-on labs at the link

above.

<!--EndFragment-->