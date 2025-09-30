﻿---
title: AssemblyBinding in Web Config and XMLNS
date: "2006-11-15T21:09:54.2000000-05:00"
description: Ran into this (again, I think) today while setting up some assembly binding between Telerik and PeterBlum controls in my LakeQuincy web site.
featuredImage: img/assemblybinding-in-web-config-and-xmlns-featured.png
---

Ran into this (again, I think) today while setting up some assembly binding between [Telerik](http://telerik.com/) and [PeterBlum](http://peterblum.com/) controls in my [LakeQuincy](http://lakequincy.com/) web site. The short version is that the presence of an xmlns= in your `<configuration>` node of web.config will prevent ASP.NET 2.0 from reading any assemblyBinding tag. So if you have something like this:

```xml
<configuration xmlns="http://schemas.microsoft.com/.NetConfiguration/v2.0">
```

You will want to replace it with this:

```xml
<configuration>

```

Then your <assemblyBinding> tags in your <runtime> element (like the one shown below) should magically work ok:

```xml
<assemblyBinding xmlns="urn:schemas-microsoft-com:asm.v1">
<dependentAssembly>
<assemblyIdentity name="RadComboBox.Net2" publicKeyToken="175e9829b585f1f6" culture="neutral" />
<bindingRedirect oldVersion="2.0.0.0-2.4.0.0" newVersion="2.5.0.0" />
</dependentAssembly>
</assemblyBinding>
```

Otherwise you may encounter something like this error:

> **Could not load file or assembly 'RadComboBox.Net2, Version=2.0.3.0, Culture=neutral, PublicKeyToken=175e9829b585f1f6' or one of its dependencies. The located assembly's manifest definition does not match the assembly reference. (Exception from HRESULT: 0x80131040)**

