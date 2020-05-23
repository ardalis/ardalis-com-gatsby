---
templateKey: blog-post
title: Support for Value Objects in C#
date: 2018-12-13
path: /support-for-value-objects-in-csharp
featuredpost: false
featuredimage: /img/csharp-760x360.png
tags:
  - .net
  - .net core
  - C#
  - c# features
  - ddd
  - domain driven design
  - language design
  - value objects
category:
  - Software Development
comments: true
share: true
---

As someone who uses many [Domain-Driven Design patterns](https://www.pluralsight.com/courses/domain-driven-design-fundamentals) in my .NET code, I've long wanted to have built-in immutable [value objects](https://deviq.com/value-object/) in C#. Value objects have a few characteristics:

- They're immutable. You can't change their state.
- Their state is fully set when they're created. Because, they're immutable once created.
- Two value objects are considered equal if all of their properties match; otherwise not.
- To "change" a value object, an operation can provide you with a new instance with the desired values.

C# has planned to add some support for value objects for a while, but there are many considerations and of course they want to make sure they ship something that will work for a long time and for a lot of customers. This isn't an easy task and there are many ways to implement immutability and of course my desires won't necessarily match others'. However, let me note how I would like value objects to work in the interest of providing solid evidence for at least one approach to solving this problem at the language level.

## String and DateTime are Value Objects

Whenever I explain the concept of value objects to developers, I almost always use the string and DateTime types as perfect examples. They don't have any identity; they're considered equal if their properties match; when you call ToLower() or AddDays(1) to change them you get a new instance - the original instance remains unchanged. If the C# team is able to implement value objects in such a way that they behave identically to String and DateTime that would be ideal since it will provide consistency. If they're able to implement support for this feature such that string and DateTime literally use the feature they ship, that would be an amazing example of [dogfooding](https://deviq.com/dogfooding/) the new feature and verifying it works as expected!

## Feature Expectations

My expectations for this feature are that I can decorate a class in some fashion (ideally not an attribute but that's just my preference) so that the compiler is able to enforce the "rules" of value objects. To wit:

- Its constructor (or equivalent - see below) accepts arguments for all of its properties (and/or sets default values for them).
- It overrides equality correctly and completely in a way that doesn't require me to manually implement this code.
- It ensures that the state of an instance cannot be modified once it's been created.

That's it.

## Possible Implementations

There are several ways this could be implemented:

- Language keyword on class
- Attribute on class
- Constructor-based
- Property-initializer-based

My preference (which you probably guessed from how I described my feature expectations) is for a language keyword that designates a class as being a value object (and/or immutable and equatable if you prefer) and that it be constructor-based. But let's consider the options.

Adding new language keywords to C# is never done lightly. An attribute would no doubt be a much easier sell. I think attributes are less discoverable and more verbose than language keywords, so I'd prefer the latter, but I'd certainly accept an attribute if that were the only workable solution. One could argue that there are two features in play here: immutability and automatic equality checking. If these are for whatever reason implemented independently, I'd really prefer it if there were a single keyword or attribute that combined them so that one wouldn't need to remember to apply them both in order to get value object behavior.

When it comes to setting the state of an immutable object, the obvious technique is to use a constructor. However, one could also modify the existing object initializer syntax in order to support this scenario, and there are some benefits to this approach. Consider this type which we want to be a value object:

public class Name
{
    public string First { get; }
    public string Last { get; }
}

We could add a constructor that takes in both values,

var CustomerName = new Name("Steve", "Smith");

or the new language feature could somehow allow object initializer syntax to work like this:

var customerName = new Name { First = "Steve", Last = "Smith" }; // doesn't work currently without property setters

The second approach is more verbose, but where it could prove useful is if our type evolves. What if later one we discover we need to support a middle name as well?

public class Name
{
    public string First { get; }
    public string Middle { get; }
    public string Last { get; }
}

Let's assume we have a bunch of already-shipped code using the previous Name type and we don't want to break it with this addition. The problem is that we used a positional constructor, meaning that the positions of the terms are significant (unlike object initializers which can have their name/value assignments in any order). If we used a constructor, we could do something like this:

public Name(string first, string last, string middle = "")
{
  First = first;
  Middle = middle;
  Last = last;
}

Note that we had to add the new property to the end in order for existing calls to the constructor to continue working without breaking. This of course isn't ideal because obviously we would prefer to have the arguments be in (first, middle, last) order. Our initial design's failure to consider middle names will now haunt us forever with a less-than-ideal constructor. With object initializer syntax, we wouldn't need to change the constructor at all, we would just make sure the Middle property was set to a default value using an auto property initializer in the class definition, and then any client code that needed to specify the Middle name would do so like this:

var customerName = new Name 
{ 
  First = "Steve", 
  Middle = "ardalis", // not really...
  Last = "Smith" 
};

This is a point in favor of this syntax, but I'm still not sold.

## Consistency and the Explicit Dependencies Principle

At this point I'm trained to know that everywhere I see code that instantiates an object and then immediately follows that with assignments in {...} that it's performing property initialization. I know that property initialization works with, well, properties, and further that these properties must have accessible setters in order for this to work.

I also know that classes that need certain things in order to be value should generally take them in via their constructor. This follows the [Explicit Dependencies Principle](https://deviq.com/explicit-dependencies-principle/) and results in better, more intention-revealing classes. It also avoids the issue of classes that are in an invalid state for some period of time between when they're instantiated and when they've been properly initialized by setting certain properties or calling certain methods, none of which is self-documenting within the language. The thing about constructors is that they must be called and as a class author I can specify exactly which constructors are available, ensuring that code creating instances of my class will do so properly. For example, if I have a rule that all InsurancePolicy instances must have a PolicyNumber, I can create a constructor that takes in (and assigns) PolicyNumber and not offer a default constructor. That doesn't mean InsurancePolicy is immutable, but it communicates and enforces my design rule, ensuring there is never a policy without a number in my system. Similarly if I have a service that requires some dependency, for instance an ICustomerNotifier, I can again request this through the constructor and make it very clear this is something this type needs and ensure the type cannot be created without the client providing it.

Thus, when I look at client code for a class, if I see that it's using object initializers instead of a constructor, I (currently) conclude that the type being created must be mutable. Currently implemented immutable types are not created using object initializers. I can't do this, for instance:

var appointmentDate = new DateTime
{
  Day = 25,
  Month = 12,
  Year = 2018
};

If the object initializer approach is used, then for the sake of consistency this should be a supported approach. I suspect it would not be, and so again there would be inconsistency.

The other issue I have with object initializers is that they don't necessarily communicate as clearly as constructors do. When I look at intellisense for "new DateTime(" I can see all of its available constructors. There are numerous ways in which I can provide the state required to produce an immutable value object representing a date and time. Some of the fields are obviously required, while others can be added if necessary. This is all obvious from the constructors available and reveals to me how I'm expected to work with this type. With object initializers, presumably I would just have intellisense offering me the next alphabetical property to be set, and if some where required and others were not, I would need to indicate that somehow (perhaps by the omission or presence of an auto property initializer?) in the class definition and then communicate that to the client code trying to instantiate the type. This doesn't seem like a good approach.

What if C# made it so optional arguments could go anywhere in a constructor, not just the end? The only way I see that working is with named parameters, but that results in a very verbose approach that most developers won't use if the (current) succinct approach remains an option (which of course it would have to). And so it would only really help if users of the class used named parameters from the start, so that later changes didn't impact them. If they used the positional constructor, they would still be broken by future updates of the sort described above.

## What About the Impact of Changes to the Class?

Ok, so I've made my case about why I prefer constructors - what about the first/middle/last problem? In my case, I would change the constructor to make sense so that it had first, middle, last. Another possible language change that could help this would be to let me give middle a default value even though it's not at the end, but that probably ends up needing verbose named parameter syntax on the client so I won't even go there. I would break things. I would fix the code that had been creating the object with just "steve","smith" and change it to pass in a third argument in the middle. I'm OK with this in order to get the benefits of consistency and intention-revealing code, and because frankly in my experience most value objects are small and very stable. They might change a bit when you're first creating and implementing and integrating them into your system, but once they're done, they don't change very often. And if they need to, it's probably a good idea to revisit everywhere you were using it anyway.

What do you think? Is first-class support for value objects something you'd like to see in C#? What implementation would you like to see used for it?
