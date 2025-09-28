---
title: Alternatives to the Singleton Design Pattern
date: "2010-11-23T00:00:00.0000000"
description: The Singleton Design Pattern is one of the simplest and most widely known design patterns in use in software development. However, despite its simplicity, it is very easy to get wrong and the consequences of its use even when properly implemented can outweigh its benefits. It turns out there are other ways to achieve the goals of the Singleton pattern which will often prove to be simpler, safer, and more maintainable.
featuredImage: /img/alternatives-to-singleton.png
---

## Introduction

The Singleton Design Pattern is one of the simplest design patterns in software development, yet one of the easiest to misuse as well. In this article, we'll examine some alternatives to the Singleton pattern in its most naïve implementation, as well as consider an alternative to making classes themselves responsible for managing their instances.

## The Singleton Pattern

The Singleton pattern works by restricting construction of a class to itself, by making the constructor private. Then a property (or method) typically called Instance is set up to provide access to the one-and-only-one instance of the class, which is instantiated on the first request.

The naïve implementation of the Singleton pattern should never be used in any multi-threaded environment, including an ASP.NET application.

The problem with this implementation is that it is not thread-safe, meaning that two threads could simultaneously create two instances of the object.

This issue can be addressed in several ways. The first is to apply locking, but the simple, brute-force approach to locking doesn't actually work very effectively in terms of efficiency, so as a further optimization one tends to arrive at double-check locking, which works (though not in Java 1.5 or earlier) but is rather complex and very easy to get wrong.

A somewhat simpler approach is to rely on.NET's lazy type instantiation and implement the Instance through the use of a nested class. Note that a static constructor for the nested class is required, in order to ensure the CLR does not mark the nested type with a flag called `beforefieldinit`. You can read more about why this is important in [Jon Skeet's excellent article on Singletons](http://csharpindepth.com/Articles/General/Singleton.aspx), which is where the LazySingleton pattern comes from.

## Single Responsibility Principle

The [Single Responsibility Principle](https://deviq.com/principles/single-responsibility-principle) is one of the fundamentals of object-oriented programming. In essence, it states that a class or module should never have more than one reason to change. The more things a class or module is charge of, the more kinds of change the class is affected by. You can learn more about this and other related principles in my [Principles of Object Oriented Design course on PluralSight On Demand](https://www.pluralsight.com/courses/principles-oo-design). Also be sure to check out the Software Craftsmanship 2011 Calendar, which includes SRP and 11 other important principles of writing better software and makes a great addition to your team room.

In the case of the Singleton pattern, the class is being given the extra responsibility, above and beyond whatever it actually does, of managing how many instances of itself are allowed to exist within the application. This additional responsibility clearly violates SRP, and especially since there are so many ways to implement the Singleton pattern, and so many of these have negative consequences, my advice is to move the responsibility of managing the object's lifetime to a separate class with just this responsibility. The simplest way to achieve this is through the use of an Inversion of Control Container, or IOC Container.

## Testing

Singletons are death to testability. They cause tight coupling between different parts of your application. If you must have them, then a common workaround is to add a Reset() or set() method to the Singleton so that test classes are able to change the instance that is being used, or to reset it to null before each test. If you're not using an IOC Container to manage the liftetime of your objects, then the only way to test them effectively is to hack in back doors to your beautifully crafted Singleton pattern and then add a bunch of comments telling developers "don't call this outside of test classes". It's crap. It stinks. Don't do it.

## IOC Container Managed Lifetime

At the time of this writing there are exactly 3.2 billion different IOC containers available to.NET developers. In the vast majority of common scenarios, they are functionally equivalent, while they do vary widely in terms of performance and ease of configuration. For the purposes of this article we are going to look only at the Unity container, which is available from Microsoft Patterns and Practices. You can easily install it in your application using the [NuGet package installer](http://nuget.codeplex.com/) if you've installed that into Visual Studio 2010, or you can grab [Unity from its home on CodePlex](http://unity.codeplex.com/) and add references the old fashioned way.

The best way to show how some code works is of course to write some tests. In this case, we want to show that Unity by default will return to us a new instance of a given type when we ask it for one, but that if we provide it with the proper parameters, it will provide us with the same instance again and again just like a Singleton-pattern class's Instance property would.

The code in Listing 1 demonstrates these two tests in practice. The first test shows that when we simply call the `RegisterType` method, resolving this type yields separate new instances of the type. However, if we pass in a new `ContainerControlledLifetimeManager()` to the `RegisterType()` method, we then get the same instance with each call to `Resolve()`.

#### Listing 1 - Implementing Singleton Behavior with Unity

```csharp
using Microsoft.Practices.Unity;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Tests
{
 public interface IFoo
 {
 }

 public class Foo: IFoo
 {}

 [TestClass]
 public class UnityShould
 {
 private UnityContainer _container;
 [TestInitialize]
 public void Setup()
 {
 _container = new UnityContainer();
 }

 [TestMethod]
 public void ReturnNewInstanceByDefault()
 {
 _container.RegisterType<IFoo, Foo>();

 var firstInstance = _container.Resolve<IFoo>();
 var secondInstance = _container.Resolve<IFoo>();

 Assert.AreNotSame(firstInstance, secondInstance);
 }

 [TestMethod]
 public void ReturnSameInstanceWhenConfiguredToDoSo()
 {
 _container.RegisterType<IFoo, Foo>
 (new ContainerControlledLifetimeManager());

 var firstInstance = _container.Resolve<IFoo>();
 var secondInstance = _container.Resolve<IFoo>();

 Assert.AreSame(firstInstance, secondInstance);
 }
 }
}
```

Running these tests reveals they are correct.

The great thing about using a container to manage the object lifetimes is that it then becomes trivial to change, and simple to change the behavior as needed (say, between production environment, unit tests, integration tests, full system tests, etc.). And as you can see from the code above, which includes 100% of the required to code make these tests pass, getting started with an IOC container takes only a couple of lines of code, so there's no good reason not to start using one in your application if you haven't been for lack of exposure or comfort with them.

## References

[Singleton Article by Jon Skeet](http://csharpindepth.com/Articles/General/Singleton.aspx)

[Unity on CodePlex](http://unity.codeplex.com/)

[Principles of Object-Oriented Design course on PluralSight](https://www.pluralsight.com/courses/principles-oo-design)

[Design Patterns Library on PluralSight](https://www.pluralsight.com/courses/patterns-library)

Originally published on [ASPAlliance.com](http://aspalliance.com/2028_Alternatives_to_the_Singleton_Design_Pattern)

