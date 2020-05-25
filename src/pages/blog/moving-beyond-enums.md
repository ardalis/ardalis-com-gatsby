---
templateKey: blog-post
title: Moving Beyond Enums
path: blog-post
date: 2011-08-30T12:16:00.000Z
description: "I just published an article on ASPAlliance on Moving Beyond Enums,
  describing when and how to move from enums to classes in your code when you
  start demanding more from your enums than they were designed to give.  "
featuredpost: false
featuredimage: /img/csharp-760x360.png
tags:
  - C#
  - enum
  - Enums
category:
  - Software Development
comments: true
share: true
---
I just published an article on [ASPAlliance on Moving Beyond Enums](http://aspalliance.com/2075_Moving_Beyond_Enumerations), describing when and how to move from enums to classes in your code when you start demanding more from your enums than they were designed to give. Check it out and let me know what you think. I also thought I’d post an alternate LINQ-ified version of the DisplayFriendlyNames() method I used in the article.

Original, non-LINQ version:

```
public static string DisplayFriendlyNames()
{
    var sb = new StringBuilder();
    foreach (Role role in Role.List())
    {
        if (role.IsVisible)
        {
            sb.AppendLine(role.Name);
        }
    }
    return sb.ToString();
}
```

LINQ version:

```
public static string DisplayFriendlyNames()
{
    var sb = new StringBuilder();
    Role.List().Where(r => r.IsVisible)
        .ToList()
        .ForEach(r => sb.AppendLine(r.Name));
    return sb.ToString();
}
```

It’s up to you which one you prefer. I generally prefer eliminating if-then conditionals wherever possible, and using LINQ for filtering. Note the .ToList() above is needed simply to be able to use .ForEach(). You can read more about why this is necessary on [Eric Lippert’s blog, where you’ll also find an IEnumerable<T> ForEach<T> extension method](http://blogs.msdn.com/b/ericlippert/archive/2009/05/18/foreach-vs-foreach.aspx).