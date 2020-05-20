---
templateKey: blog-post
title: Enum Alternatives in C#
path: blog-post
date: 2016-07-27T05:59:00.000Z
description: Some time ago I wrote about Moving Beyond Enums and published an
  article on ASPAlliance by the same title. Unfortunately the latter article was
  largely screenshot-based, and those images seem to have disappeared, so I
  thought I’d revisit the topic here.
featuredpost: false
featuredimage: /img/enum.png
tags:
  - C#
  - clean code
  - enum
  - pattern
  - quality
  - solid
category:
  - Software Development
comments: true
share: true
---
Some time ago I wrote about [Moving Beyond Enums](http://ardalis.com/moving-beyond-enums) and published [an article on ASPAlliance by the same title](http://aspalliance.com/2075_Moving_Beyond_Enumerations). Unfortunately the latter article was largely screenshot-based, and those images seem to have disappeared, so I thought I’d revisit the topic here.

Enums are simple value-type flags that provide very minimal protection from invalid values and no behavior. They’re helpful in that they’re an improvement from magic numbers, but that’s about it. If you want to constrain the possible values a type might be, an enum can’t necessarily help you, since invalid types can still be provided. For example, this enum has four values and by default will have an int type. The values range from 0 to 3.

`public enum Roles {
    Author,
    Editor,
    Administrator,
    SalesRepresentative
}`

Now some method accepts this type as a parameter:

`public string DoSomething(Roles role) {
    // do some different behavior based on the enum - probably a switch or if chain here
    return role.ToString();
}`

Many developers don’t realize that you should check that the incoming value is an actual, valid Role value. That’s because any int will work if you cast it:

`var result = myObject.DoSomething((Roles)10);`

What will role.ToString() print in this case? “10”. And if you have a switch or if-chain based on the enum type? Whatever it’s default case is, that’s the behavior invalid values will end up using.

Displaying enums in UI elements like DropDownLists is another challenge if they need to have spaces. In the example above, SalesRepresentative is fine as an enum label, but not great to present to the user. You can get around this using attributes, such as the System.ComponentModel.Description attribute, but really this is just putting lipstick on a pig. The larger issue is that enums don’t support behavior of any sort.

The [type safe enum pattern](http://blog.falafel.com/introducing-type-safe-enum-pattern/) addresses this. My friend Scott Depouw has a nice write-up of the pattern. It’s my preferred approach in most cases. The pattern creates a class to represent the enumeration, and can even use the same name and syntax so that a refactoring doesn’t require [shotgun surgery](https://www.pluralsight.com/courses/refactoring-fundamentals). Converting the Roles enum above to the pattern might look like this (I’m changing Roles to Role in this case because I prefer the singular):

`public class Role {
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
}`

You can further extend types like this with additional behavior; Jimmy Bogard demonstrates a rich helper class in his [Enumeration Classes article](https://lostechies.com/jimmybogard/2008/08/12/enumeration-classes/).

Using this Role type, you can constrain parameters much better than with an enum, and you can add whatever additional behavior you require. However, it’s not completely foolproof. Jon Skeet demonstrates a way in which a persistent coder could still manage to instantiate an instance of Role, despite its private constructor, [violating the type safe enum pattern](https://codeblog.jonskeet.uk/2014/10/23/violating-the-smart-enum-pattern-in-c/).

**Update:** For those looking for how to persist this pattern using an ORM like Entity Framework, I’ve written up [how to persist type safe enums using EF6](/persisting-the-type-safe-enum-pattern-with-ef-6).

Further Update: For a better way of implementing the List() method, check out [Listing Strongly Typed Enum Options in C#](https://ardalis.com/listing-strongly-typed-enum-options-in-c).