---
templateKey: blog-post
title: Determine Whether an Assembly was compiled in Debug Mode
path: blog-post
date: 2009-06-17T00:22:00.000Z
description: "I’m working on a little application right now that provides some
  insight into the assemblies in use for a given application. One of the things
  that I want to be able to show is whether or not each assembly was built in
  Debug or Release mode. "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - ASP.NET
  - DOTNET
category:
  - Uncategorized
comments: true
share: true
---
I’m working on a little application right now that provides some insight into the assemblies in use for a given application. One of the things that I want to be able to show is whether or not each assembly was built in Debug or Release mode. As you’re no doubt aware,[running applications in production that were built in Debug mode can be a major performance problem](http://weblogs.asp.net/scottgu/archive/2006/04/11/442448.aspx)(at a minimum – depending on what else you have turned on in Debug mode it could also be a security issue).

So I did some searching and quickly found some sample code that I was able to use in some test code to confirm that it is working. Fellow MVP Bill McCarthy wrote (like, 5 years ago to the day!) about how to do this in Visual Basic. Not that I have anything against VB, but my preference since VB6 has been C# (if nothing else, it makes JavaScript much easier to grok), so I had to translate the code into C#, which provides me with something to share with you. This is literally Bill’s code, translated by me into C#. Any bugs you can probably assign to me as the translator, rather than Bill as original author.

## Check If An Assembly Was Compiled In Debug Mode

```
private bool IsAssemblyDebugBuild(string filepath)
{
    return IsAssemblyDebugBuild(Assembly.LoadFile(Path.GetFullPath(filepath)));
}
     
private bool IsAssemblyDebugBuild(Assembly assembly)
{
    foreach (var attribute in assembly.GetCustomAttributes(false))
    {
        var debuggableAttribute = attribute as DebuggableAttribute;
        if(debuggableAttribute != null)
        {
            return debuggableAttribute.IsJITTrackingEnabled;
        }
    }
    return false;
}
```

Later, this kind of detection was added to [Glimpse](http://getglimpse.com/), so you can use that tool to identify if you’ve deployed Debug-built assemblies to your server for your ASP.NET apps.

([follow me](http://twitter.com/ardalis) on twitter)