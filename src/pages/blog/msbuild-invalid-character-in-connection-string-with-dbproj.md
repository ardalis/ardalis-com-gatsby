---
templateKey: blog-post
title: MSBuild Invalid Character in Connection String with dbproj
path: blog-post
date: 2011-02-03T03:29:00.000Z
description: "If you get this error: error MSB5016: The name “Intitial Catalog”
  contains an invalid character or something similar when trying to specify a
  connection string within an MSBuild task, like this one:"
featuredpost: false
featuredimage: /img/cloud-native.jpg
tags:
  - data access
category:
  - Software Development
comments: true
share: true
---
If you get this error:

> **error MSB5016: The name “Intitial Catalog” contains an invalid character “ “.**

or something similar when trying to specify a connection string within an MSBuild task, like this one:



```
&lt;MSBuild Projects=<span style="color: #006080">&quot;srcDatabasesNorthwind.dbproj&quot;</span> 
    Targets=<span style="color: #006080">&quot;Build;Deploy&quot;</span> 
        Properties=<span style="color: #006080">&quot;TargetDatabase=Northwind;TargetConnectionString=&quot;Data Source=localhost;Initial Catalog=Northwind;Persist Security Info=True;User Id=foo;password=bar;Enlist=False;&quot;&quot;</span> /&gt;
        &#160;
        &#160;
```

The issue is with the semicolons in the querystring. If you replace them with %3B then the error goes away:

```
&lt;MSBuild Projects=<span style="color: #006080">&quot;srcDatabasesNorthwind.dbproj&quot;</span> 
Targets=<span style="color: #006080">&quot;Build;Deploy&quot;</span> 
Properties=<span style="color: #006080">&quot;TargetDatabase=Northwind;TargetConnectionString=&quot;Data&#x20;Source=localhost%3BInitial&#x20;Catalog=Northwind%3BPersist&#x20;Security&#x20;Info=True%3BUser&#x20;Id=foo%3Bpassword=bar%3BEnlist=False%3B&quot;&quot;</span> /&gt;
&#160;
&#160;
```

Hope this helps! You can also escape the spaces with but I don’t believe that’s required.