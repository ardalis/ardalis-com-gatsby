---
templateKey: blog-post
title: Group Your Constants and Enums
path: blog-post
date: 2017-05-17T02:36:00.000Z
description: >
  It’s not unusual in applications to have a few constants defined for things
  you know are never going to change (so you don’t need to store them in the
  database, or if they are in the database, you don’t need to fetch them every
  time you need them).
featuredpost: false
featuredimage: /img/constantsgroups-760x346.png
tags:
  - C#
  - enum
  - tip
category:
  - Software Development
comments: true
share: true
---
It’s not unusual in applications to have a few constants defined for things you know are never going to change (so you don’t need to store them in the database, or if they are in the database, you don’t need to fetch them every time you need them). I usually like to keep these in a single file called Constants.cs in my .NET/.NET Core applications, so that anywhere I need a constant I can reference it with something like:

`LaunchShip(Constants.TIE_FIGHTER); `\
`LaunchShip(Constants.X_WING);`

This works well, but if you have a large application with many different constants, you may end up with a LOT of constants appearing in Intellisense when you type “Constants.” Sometimes you have constants that only really relate to a particular part of the application. A fairly common use case for constants in some applications I work on is to define default ID values for certain properties of newly created entities. For example, there might be more than one instance of a constant like DEFAULT_THEME_ID, depending on what the thing being themed is. In either case, rather than creating separate constants classes and files for each part of the application, an approach I’ve found works well is to use nested classes. The nested classes should correspond to the parts of the application that will use the constant.

As an example, you could have the following Constants.cs file:

`public static class Constants {
    public static class EditorThemes
    {
        public const int LIGHT = 0;
        public const int DARK = 1;
        public const int PLAID = 2;
    }
// more stuff here
}`

When you use this in your code, your Intellisense will look like this:

![](/img/constantsgroups.png)

Once you choose the EditorThemes, Intellisense updates with:

![](/img/constantsgroupsoptions.png)

You can use this approach for single values, not just enum-like collections, and it works equally well for non-integer types:

```
public class Constants
{
    public static class Fighters
    {
        public const string DEFAULT_FIGHTERNAME = "X-Wing";
        public static readonly Guid DEFAULT_FIGHTER_ID = Guid.Empty; // static readonly values work, too
    }

    // other static class groupings
}
```

When you reference this code, again you’ll get Intellisense as you drill down into Constants, and then Fighters, to see constants related to this group.

**What about Enums?**

It’s also not that unusual to have enums in their own file for many applications. You can use this same approach there, if you have a lot of enums and you want to group them. Consider this an alternative to using folders and namespaces and scattering your enums throughout your project file system.

```
public static class Enums
{
    public static class Shipping
    {
        public enum Status
        {
            Pending,
            AwaitingPickup,
            InTransit,
            Delivered
        }

        public enum Providers
        {
            USPS,
            UPS,
            FedEx
        }
    }

    // other nested classes for other groups of enums
}
```

**Partial Classes**

Another tip for organizing your constants that gives you centralized access but keeps the files themselves close to the code that uses them is to use partial classes. You can put global constants in a Constants.cs file in the root or a centralized location, but make it a partial class and put additional partial Constants classes in other folders in your project. Thanks to ghidello below for this suggestion!

## No Namespace Required!

Another tip if you want to have truly global constants is to simply avoid wrapping them in a namespace. This will make them available globally without the need for a particular “using” statement. Thanks to Vignesh via twitter for this last tip!

<blockquote class="twitter-tweet" data-lang="en">
<p lang="en" dir="ltr">cool..another tip would be to have this Constant class not under any namespace so it's available without requiring extra "using .."</p>
— Vignesh.N (@N_Vignesh) <a href="https://twitter.com/N_Vignesh/status/877247715993931777">June 20, 2017</a></blockquote>
<script src="//platform.twitter.com/widgets.js" charset="utf-8" async=""></script>

Want one developer tip like this one in your inbox every week? [Sign up now for free](http://ardalis.com/tips).