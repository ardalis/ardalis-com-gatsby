---
templateKey: blog-post
title: XmlSerializer FileNotFoundException
path: blog-post
date: 2009-05-21T06:38:00.000Z
description: Recently a buddy of mine ran into this problem trying to serialize
  a custom object. The error message he got back was the ever-so-helpful
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - troubleshooting
category:
  - Uncategorized
comments: true
share: true
---
Recently a buddy of mine ran into this problem trying to serialize a custom object. The error message he got back was the ever-so-helpful

An unhandled exception of type ‘System.IO.FileNotFoundException’ occurred in mscorlib.dll Additional information: File or assembly name uwzg3j_w.dll, or one of its dependencies, was not found.

After a fair bit of research, he found the answer, which I thought would be worth sharing here for anybody else who’s stuck trying to figure this out. The class already had the \[Serializable] attribute on it, but of course the issue was with one of the members. One way to help diagnose these kinds of issues is with the [XmlSerializerPreCompiler](http://www.sellsbrothers.com/tools/#XmlSerializerPreCompiler)([GUI version](http://www.cybral.com/downloads.aspx)).

Finally, the thing that came to the rescue was being able to see the files that .NET creates, so you can open them up in Notepad and easily see just what the problem is. In this case, the root cause was the lack of an \[XmlIgnore] attribute on a static property, but the trick to being able to view the files is to turn off automatic deletion of temporary files, using this configuration script:



```
<span style="color: #0000ff">&lt;?</span><span style="color: #800000">xml</span> <span style="color: #ff0000">version</span><span style="color: #0000ff">=&quot;1.0&quot;</span> <span style="color: #ff0000">encoding</span><span style="color: #0000ff">=&quot;utf-8&quot;</span> ?<span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;</span><span style="color: #800000">configuration</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;</span><span style="color: #800000">system.diagnostics</span><span style="color: #0000ff">&gt;</span>
        <span style="color: #0000ff">&lt;</span><span style="color: #800000">switches</span><span style="color: #0000ff">&gt;</span>
            <span style="color: #0000ff">&lt;</span><span style="color: #800000">add</span> <span style="color: #ff0000">name</span><span style="color: #0000ff">=&quot;XmlSerialization.Compilation&quot;</span> <span style="color: #ff0000">value</span><span style="color: #0000ff">=&quot;4&quot;</span> <span style="color: #0000ff">/&gt;</span>
        <span style="color: #0000ff">&lt;/</span><span style="color: #800000">switches</span><span style="color: #0000ff">&gt;</span>
    <span style="color: #0000ff">&lt;/</span><span style="color: #800000">system.diagnostics</span><span style="color: #0000ff">&gt;</span>
<span style="color: #0000ff">&lt;/</span><span style="color: #800000">configuration</span><span
```

MSDN:[Troubleshooting Common Problems with XmlSerializer](http://msdn.microsoft.com/en-us/library/aa302290.aspx)