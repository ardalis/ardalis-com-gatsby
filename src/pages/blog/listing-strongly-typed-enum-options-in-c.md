---
templateKey: blog-post
title: Listing Strongly Typed Enum Options in C#
path: blog-post
date: 2017-11-28T20:02:00.000Z
description: In a previous article, I wrote about the [Strongly Typed Enum
  Pattern in C#](https://ardalis.com/enum-alternatives-in-c), which can be used
  in place of the built-in enum. Read that article to get a quick understanding
  of *why* you might not want to use enum types. Go ahead, this article will
  still be here.
featuredpost: false
featuredimage: /img/csharp.png
tags:
  - C#
  - nuget
  - quality
  - tip
category:
  - Software Development
comments: true
share: true
---
In a previous article, I wrote about the [Strongly Typed Enum Pattern in C#](https://ardalis.com/enum-alternatives-in-c), which can be used in place of the built-in enum. Read that article to get a quick understanding of *why* you might not want to use enum types. Go ahead, this article will still be here.

Ok, so in that example, I had a list of options (for instance, *Roles*) that I wanted to represent using objects instead of primitive enum types. It’s often necessary to be able to get a list of all of the available options, perhaps in order to populate a UI element like a DropDownList. In the previous article’s example, I simply hardcoded the short list of values, like so:

```csharp
public static IEnumerable<Role> List() {
    // alternately, use a dictionary keyed by value
    return new\[]{Author,Editor,Administrator,SalesRep};
}
```

This approach works well enough, but doesn’t scale well and violates [the DRY principle](http://deviq.com/don-t-repeat-yourself/), since every time we go to add a new option to our collection, we’ll need to remember to also add it to this array returned by this method. That’s easily missed. Let’s look at two ways we can dynamically return the list we want.

## Using Reflection

First, let’s review the full type we’re working with here:

```csharp
public class Role
{
    public static Role Author {get;} = new Role(0, "Author");
    public static Role Editor {get;} = new Role(1, "Editor");
    public static Role Administrator {get;} = new Role(2, "Administrator");
    public static Role SalesRep {get;} = new Role(3, "Sales Representative");
 
    public string Name { get; private set; }
    public int Value { get; private set; }
 
    private Role(int val, string name) 
    {
        Value = val;
        Name = name;
    }
 
    public static IEnumerable<Role> List()
    {
        // alternately, use a dictionary keyed by value
        return new[]{Author,Editor,Administrator,SalesRep};
    }
 
    public static Role FromString(string roleString)
    {
        return List().Single(r => String.Equals(r.Name, roleString, StringComparison.OrdinalIgnoreCase));
    }
 
    public static Role FromValue(int value)
    {
        return List().Single(r => r.Value == value);
    }
}
```

Looking at this class, it’s clear that any static member of the Role class that is of type Role should be included in the list. Thus, we can use reflection to access this list of static members, constrain it to those of type Role, and return that list, like so:

```csharp
public static List<Role> ListRoles()
{
    return typeof(Role).GetProperties(BindingFlags.Public | BindingFlags.Static)
        .Where(p => p.PropertyType == typeof(Role))
        .Select(pi => (Role)pi.GetValue(null, null))
        .OrderBy(p => p.Name)
        .ToList();
}
```

This works, and is a nice example of how you can easily combine LINQ and reflection to quickly work with object metadata. However, reflection has negative performance implications, and there’s no reason to perform this work over and over again at runtime when the values in question will never change. Thus, we can optimize this by performing the reflection only once, and keeping a static list of Roles in memory, like so:

```csharp
public class Role
{
    public static Role Author { get; } = new Role(0, "Author");
    public static Role Editor { get; } = new Role(1, "Editor");
    public static Role Administrator { get; } = new Role(2, "Administrator");
    public static Role SalesRep { get; } = new Role(3, "Sales Representative");

    public static List<Role> AllRoles
    {
        get
        {
            return _allRoles;
        }
    }
    // if you move this above the static properties, it fails
    private static List<Role> _allRoles = ListRoles();

    private static List<Role> ListRoles()
    {
        return typeof(Role).GetProperties(BindingFlags.Public | BindingFlags.Static)
            .Where(p => p.PropertyType == typeof(Role))
            .Select(pi => (Role)pi.GetValue(null, null))
            .OrderBy(p => p.Name)
            .ToList();
    }
// more methods
}
```

In the above example, client code can iterate over the AllRoles property to get the list of Roles, and this will use reflection just once to populate the list. Note the comment above the _allRoles declaration. If you decide you’d rather have the private static _allRoles field appear higher in your class definition, perhaps above the public static Role declaration, it will change the behavior of the class and the ListRoles method will fail. Usually, you can order your fields and properties however you like without altering behavior, but in this instance the static initialization occurs in the order in which the static members are listed, and so if _allRoles is defined earlier, its call to ListRoles will take place before any members of type Role have been defined. Keep this in mind as we look at another approach to this problem.

## Update Collection in Constructor

Another approach that doesn’t require reflection but still achieves the goal of keeping the solution DRY involves adding each option to a list as it is created. Since the type has no public constructor, we know the only time the constructor logic will be called is when the static initializers are called for each member. To avoid confusion with the prior example, I’ll show this one using a type named JobTitle instead of Role, but which is otherwise identical:

```csharp
public class JobTitle
{
    // this must appear before other static instance types.
    public static List<JobTitle> AllTitles { get; } = new List<JobTitle>();
 
    public static JobTitle Author { get; } = new JobTitle(0, "Author");
    public static JobTitle Editor { get; } = new JobTitle(1, "Editor");
    public static JobTitle Administrator { get; } = new JobTitle(2, "Administrator");
    public static JobTitle SalesRep { get; } = new JobTitle(3, "Sales Representative");
 
    public string Name { get; private set; }
    public int Value { get; private set; }
 
    private JobTitle(int val, string name)
    {
        Value = val;
        Name = name;
        AllTitles.Add(this);
    }
// other methods
}
```

Note the comment at the top of the above class definition. In this case, the static List<JobTitle> *must* appear before any of the JobTitle options are defined. This again comes down to order of operations during class (and static) construction. If you move the AllTitles definition below the JobTitle-typed members, then the first constructor call (for Author) will attempt to cal AllTitles.Add(this) and will get a NullReferenceException because AllTitles’ initialization hasn’t yet taken place.

In any case, assuming you keep the constructor sequence details in mind, this provides a clean approach that doesn’t require the use of reflection. Of the three approaches (original hard-coded list, reflection, list populated via constructor), this is my preferred approach. It’s extremely simple and gets the job done without unnecessary cleverness.

### Sample

You can view a small console app [sample on GitHub which demonstrates several ways to list strongly typed enums in C#](https://github.com/ardalis/EnumAlternative).

**Update**

Working with Scott Depouw, we’ve created a [SmartEnum](https://www.nuget.org/packages/Ardalis.SmartEnum/) base class that’s available via Nuget and makes it much easier to create these kinds of smart enum types. Check it out on [Nuget](https://www.nuget.org/packages/Ardalis.SmartEnum/) and [GitHub](https://github.com/ardalis/SmartEnum).

Check out my podcast, [Weekly Dev Tips](http://www.weeklydevtips.com/), to hear a new developer productivity tip every week. You can also [join my mailing list](https://ardalis.com/tips) for similar (but different!) tips in your inbox every Wednesday!