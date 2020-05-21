---
templateKey: blog-post
title: Code Review Singleton Pattern Issues
path: blog-post
date: 2012-02-02T04:57:00.000Z
description: "One of my applications relies on a singleton pattern to create a
  single instance of a server which processes requests from many different
  ASP.NET handlers. It is created using pretty much standard Singleton code:"
featuredpost: false
featuredimage: /img/code-quality.png
tags:
  - C#
  - clean code
  - code review
  - software craftsmanship
category:
  - Software Development
comments: true
share: true
---
One of my applications relies on a singleton pattern to create a single instance of a server which processes requests from many different ASP.NET handlers. It is created using pretty much standard Singleton code:

```
<span style="color: #0000ff;">public</span> <span style="color: #0000ff;">static</span> Context CreateContext()
{
 <span style="color: #0000ff;">return</span> CreateContext(<span style="color: #0000ff;">new</span> ConfigurationFileSettings());
}
```

Recently, this server needed to be made aware of whether requests were coming into it via SSL or standard HTTP. The solution that was checked in (and which worked and passes local tests) is to create a new property of Context called IsSecureConnection, and to allow this to be passed into its public constructor like this:

```
<span style="color: #0000ff;">public</span> Context(ISettings settings,
 <span style="color: #0000ff;">bool</span> isSecureConnection)
{
    <span style="color: #0000ff;">this</span>.Settings = settings;
    <span style="color: #0000ff;">this</span>.IsSecureConnection = isSecureConnection;
}
```

This is pretty much classic [Dependency Injection](http://en.wikipedia.org/wiki/Dependency_injection) and most of the time is what I would consider the right approach to the problem. However, in this case it fails to take into account how this object is used, because of the fact that it’s using a Singleton. And in this case nothing ever calls this constructor anyway – the actual solution that was applied instead only made use of the IsSecureConnection property (which was read/write).

The client code in the ASP.NET handlers that invokes the Context class looks like this (before adding any support for SSL):

```
Context engineContext = Context.CreateContext();
```

After adding support for SSL, this code became:

```
Context engineContext = Context.CreateContext();
engineContext.IsSecureConnection = isSecureConnection;
```

Looks fine, right? Run it through some tests – things behave as expected. SSL requests get routed to the Context object with IsSecureConnection = true. Regular HTTP requests get routed with IsSecureConnection = false. Stick a fork in it and ship it…

**Global State and Static / Singleton Objects**

The problem of course is that many different ASP.NET handlers are talking to the same exact instance of Context. In this particular application, this is taking place tens of times each second. So if you imagine that 49 requests come in during a given second over HTTP and 1 comes in over HTTPS, it’s quite likely that while the Context has had its IsSecureConnection property set to one value, it’s in the middle of processing another request.

The other issue here is that whether or not a given request is using SSL is a lower level concern to the Context object which is in essence a request manager. The only call that the handlers ever send to Context is something like this:

```
Response myResponse = engineContext.GetResponse(_myParamsDTO);
```

This is the level of detail where the HTTP/HTTPS information is important, and the value should be passed at the method level into the GetResponse() method either as a separate parameter or as part of the DTO currently used. Then, even if many requests are being handled concurrently, none of them will be setting the global state of the singleton Context object, so all of them will be processed correctly.

**Recommendation**

In general, I’m not a big fan of the [Singleton pattern](http://en.wikipedia.org/wiki/Singleton_pattern), and even less so of static objects and methods. They’re extremely difficult to test and prone to problems with synchronization and multiple threading like the one shown here. In development, things that work just fine often end up failing in production under load. If you think your application really needs a static or singleton, consider whether or not this is a premature optimization, and build the application using standard object creation semantics until you have proof that this will not be capable of meeting your design’s needs.

If you do use static methods, you should be careful not to new up objects in them. That is, they should be leaf nodes in your object/call graph, operating only on their parameters and instantiating nothing on their own. In this way, they remain testable and do not introduce nasty dependencies into your application.