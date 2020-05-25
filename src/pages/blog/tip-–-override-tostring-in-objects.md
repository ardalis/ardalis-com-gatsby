---
templateKey: blog-post
title: Tip – Override ToString() in Objects
path: blog-post
date: 2014-06-12T16:00:00.000Z
description: Most of your domain objects should override ToString() for the
  simple reason that if you ever want to simply display the object’s state, you
  shouldn’t need to implement a custom formatter for it.
featuredpost: false
featuredimage: /img/java-script.png
tags:
  - C#
  - clean code
  - tip
category:
  - Software Development
comments: true
share: true
---
Most of your domain objects should override ToString() for the simple reason that if you ever want to simply display the object’s state, you shouldn’t need to implement a custom formatter for it. Furthermore, it’s well-known that the default System.Object implementation of .ToString(), which outputs the type’s name, is useless 99% of the time. Thus, it’s generally a good idea to implement .ToString() on your classes that have some kind of state, and to have your implementation present at least the bare-bones information about this state. If it’s a customer, maybe the .ToString() renders their customer ID and name. If it’s an Order, maybe .ToString() renders the order ID and total purchase price. It’s up to you as the application developer to come up with something that makes sense, and don’t worry too much about getting it perfect, as it’s easy to change later and easy to let users of your class customize if the need should arise.

In particular, if you want to allow clients of your class to specify how it should format the results of a .ToString() call, you can use IFormattable and IFormatProvider to do so. [Bill Wagner](http://billwagner.cloudapp.net/) describes how to do this in his book, [Effective C#, Second Edition](http://amzn.to/e9GdZq). If you don’t have a copy, you can learn more about [IFormattable and IFormatProvider in the docs](http://msdn.microsoft.com/en-us/library/system.iformattable.tostring.aspx).

Of course, locating which objects need to have .ToString() implemented can be tedious, and it would be nice to be able to simply run a query against your codebase to determine how many classes you need to look at. Not all classes really need to have a .ToString() implemented – for instance I probably wouldn’t bother doing so with my implementations of the Repository pattern. But my domain objects, these almost certainly should have ToString() implemented as a general guideline (this is, after all, more of a guideline than a rule).

Using [Nitriq code analysis](http://nitriq.com/), you can easily construct a LINQ query that will show all of the types in your assembly that are lacking an implementation of .ToString(), which is sort of a brute force approach:

```
var results = 
    from type <span style="color: #0000ff;">in</span> Types
    <span style="color: #0000ff;">where</span> (type.Methods.Count(m=&gt;m.Name == <span style="color: #006080;">"ToString"</span>) == 0) 
    &amp;&amp; type.IsInCoreAssembly
    &amp;&amp; type.IsClass
    &amp;&amp; !type.IsEnum
    &amp;&amp; !type.IsAbstract
    
select <span style="color: #0000ff;">new</span> { type.TypeId, BaseType=type.BaseType==<span style="color: #0000ff;">null</span> ? String.Empty :type.BaseType.FullName , type.FullName};
```

This query will return subclasses of classes that override .ToString(), but it’s a good start. I haven’t bothered optimizing it for this case because the larger concern I have is that it returns a lot of classes, like Repository implementations, that probably don’t need to follow this rule. So, until I can figure out a way to get past that issue (perhaps a commonly used attribute for domain objects, especially one that’s already being used for validation, etc), the gain in accuracy from eliminating subtypes of types that implement .ToString() doesn’t seem all that worthwhile.