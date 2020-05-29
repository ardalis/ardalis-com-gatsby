---
templateKey: blog-post
title: Principles, Patterns, and Practices of Mediocre Programming
path: blog-post
date: 2009-10-07T20:56:00.000Z
description: This is my first pass at a list of anti-principles, anti-patterns,
  and anti-practices that make up mediocre programming. I’m hoping to refine
  this list and update this listing based on community feedback, so please leave
  a comment or contact me to let me know what I’ve missed, and I’ll gladly
  credit you with a name and a link if you’d like.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - medicore
category:
  - Uncategorized
comments: true
share: true
---
This is my first pass at a list of anti-principles, anti-patterns, and anti-practices that make up *mediocre programming*. I’m hoping to refine this list and update this listing based on community feedback, so please leave a comment or contact me to let me know what I’ve missed, and I’ll gladly credit you with a name and a link if you’d like.



**Principles**

**Fast Beats Right (FBR)**– It’s more important to get something done that probably works, or that works right now even if it will be hard to change later, than to spend time ensuring that it is correct or is well designed. This is classic “cowboy coder” or “[duct tape programmer](http://www.joelonsoftware.com/items/2009/09/23.html)” thinking, and sometimes management may be OK with dictating that for a given feature or prototype, speed is more important than anything else. However, for typical, long-term projects where someone is going to have to maintain the application for years to come, this can be a very expensive principle to follow.

> **Preferred Principle(s)**
>
> “Continuous attention to technical excellence and good design enhances agility” –[Agile Manifesto](http://agilemanifesto.org/principles.html)

**Feaping Creaturitis Driven (FCD)**– A project built using FCD never, ever has a cycle that completes appropriately. Just when you can see the horizon, someone on the team adds yet another nozzle or value that they are desperately in love with.

> **Preferred Principle(s)**
>
> Plan with a short delivery schedule, deliver on that plan, and plan the next cycle. Avoid throwing new work into the current cycle.
>
> “Deliver working software frequently, from a couple of weeks to a couple of months, with a preference to the shorter timescale.” –[Agile Manifesto](http://agilemanifesto.org/principles.html)
>
> **Source**
>
> [Roger Pence](http://www.rogerpence.com/)(with credit to PL Plauger for the term “feeping creaturitis”)

**Assumption Driven Programming (ADP)**– Rather than wasting time thinking about edge cases, assume that the user will only use your software the way you mean for them to, and that nothing bad will happen. This is the quickest way to knock out a feature and be able to demo it to the customer anyway (as long as you are in charge of the demo script), and besides, it should be*obvious*to anyone how they’re*supposed*to use the application, so it’s the user’s fault if they do something unexpected.

Some typical “Assumptionist” questions:

> “What do you mean, you can’t change the configuration on a shared host?”
>
> “Why would the user type garbage in the address bar?”
>
> “Who would try to put a script file through this image upload form?”
>
> “Why would someone type SQL into a textbox clearly labeled ‘username’?”

ADP often leads to uncaught “sad path” bugs and security holes.

> **Preferred Principle(s)**
>
> Practice some defensive coding, and verify that inputs to your method are what you expect before working with them.
>
> Define with the customer what should happen when the unexpected occurs, and treat this behavior like any other feature.
>
> Write one test for the “happy (expected) path” but write several tests for various “sad paths” where things could go wrong.
>
> **Source**
>
> ###### [Felix Pleşoianu](http://profiles.yahoo.com/blog/FFXG7KNZPDPAKTN3Q2O3ISE5BM?eid=rJzZAgIwny4SUQfzTSydYL4GwMd6SAUUTPW9jwIL2FEY5xGkqA)
>
> [The Pragmatic Programmer](http://www.amazon.com/gp/product/020161622X?ie=UTF8&tag=aspalliancecom&linkCode=as2&camp=1789&creative=390957&creativeASIN=020161622X) calls this Programming by Coincidence (per [Adam](http://surrealization.com/))

**Telemarketer Principle (TP)**– Programming is about control, and the best way to ensure that your software does exactly what you want is for you to manage exactly when and how it behaves at all times. The Telemarketer Principle is summed up as “Make lots of calls to anything you might need in the system for your program.” If you cede control to other modules or let the system or a framework do things on your behalf, can you really be sure they’ll do it right? And just in case, don’t forget that for anything really important you can always **Reinvent The Wheel (RTW)**and call your own routine all over the place instead.



**Preferred Principle(s)**

> Follow the [Hollywood Principle](http://en.wikipedia.org/wiki/Hollywood_principle): “Don’t call us; we’ll call you.” If you find for instance that you’re making Response.Write or Console.Write or Window.Draw calls throughout your business logic, it’s likely that your design would benefit from this principle.
>
> The [Dependency Inversion Principle](http://en.wikipedia.org/wiki/Dependency_inversion_principle) can also help remove dependencies like these, and set up the ability for the callee to become the caller.

(do you have more *principles* of mediocre programming? Leave a comment below!)



**Patterns**

**Static Cling Pattern (SCP)**– Static (global) methods and objects are often an expedient way to add some functionality to an application without spending any time worrying about where the “right” place for it to live might be. Using static methods for truly stateless operations that work only on the parameters passed in and do not have any other dependencies is fine, but problems arise when static methods instantiate objects or call other methods outside the scope of the passed in parameters. Once this has gone on for a while, it can be very difficult to introduce seams into the application to decouple its components from one another – it has begun to suffer from “static cling”.

> **Preferred Pattern(s)**
>
> Dependency Inversion Principle. Calls to static methods are direct dependencies that cannot be easily injected. Replace them with interfaces and calls to instance methods on injected objects.
>
> **More Reading**
>
> [Static Methods are Death to Testability](http://misko.hevery.com/2008/12/15/static-methods-are-death-to-testability)
>
> **Source**
>
> ###### [Bob Lee, (of Guice)](http://code.google.com/p/google-guice)– (via[Nate Kohari](http://kohari.org/))

**Vestigial Structures Pattern (VSP)**– When features are removed that span multiple tiers, the bits that are no longer used are left behind “just in case.” As in biology, Vestigial Structures are usually in a degenerate, atrophied, or rudimentary condition, and tend to be much more variable than similar parts. Although structures usually called "vestigial" are largely or entirely functionless, a vestigial structure may retain lesser functions or develop minor new ones.

> **Preferred Pattern(s)**
>
> Vestigial Structures are typically symptoms of a muddled architecture, where it is difficult to tell where one feature ends and another begins. See also [Big Ball of Mud](http://en.wikipedia.org/wiki/Big_ball_of_mud).
>
> Source control. Delete it if it’s not used; if you end up needing it, pull it back out of source control.
>
> **Source**
>
> [Richard Dingwall](http://richarddingwall.name/)

**Flags Over Objects (FOO)**– Instead of using objects, polymorphism, or delegation, it’s much faster to just add a flag to a class and expose it. Then anywhere in the system that cares about that condition can simply add an if(foo.IsBar()) { … } clause to deal with this condition. Who needs inheritance?

> **Preferred Pattern(s)**
>
> Replace Conditional with Polymorphism,[Refactoring](http://www.amazon.com/gp/product/0201485672?ie=UTF8&tag=aspalliancecom&linkCode=as2&camp=1789&creative=390957&creativeASIN=0201485672), p255 ([online](http://www.refactoring.com/catalog/replaceConditionalWithPolymorphism.html))
>
> **Source**
>
> [Curtis Cooley](http://ponderingobjectorienteddesign.blogspot.com/2008/09/if-bugs.html)

**The God Class (TGC)**– Everybody knows that object-oriented programming is great because it lets us leverage and reuse classes to do all the work in our programs. And of course, nobody wants to have to look for the *right* class to do something, and the more classes you have, the less powerful each one is. It’s much better to just write (in Lord of the Rings voice here) **one class to rule them all**, a master class, capable of doing anything and everything your application might require. And who cares if it’s 5,000 lines of code?

> **Preferred Pattern(s)**
>
> Follow the [Single Responsibility Principle](http://en.wikipedia.org/wiki/Single_responsibility_principle) (SRP), which states that a class should have only one reason to change. If your class has more than one responsibility, it should be split into several classes.
>
> **Source**
>
> [Corey Coogan](http://blog.coreycoogan.com/)

**The Iceberg Class (TIC)**– About 88% of an iceberg’s mass is below water. How much of your class is down there, too? Consider a class that has fewer public methods than private methods – sometimes many times as much private as public functionality. Are such classes demonstrating good design, or might they represent several potential classes waiting to be teased apart?

> **Preferred Pattern(s)**
>
> Evaluate the class and determine whether its private methods tend to clump together in terms of their dependencies on one another and how they are called from the public interface. If there are obvious clusters of behavior, consider performing a class extraction to pull the behavior out into the open.
>
> **Source**
>
> [Michael Feathers](http://www.artima.com/weblogs/viewpost.jsp?thread=125574)

**Data Driven Architecture (DDA)**– Professional developers know that building applications in layers or tiers is a best practice. The traditional approach is to have at least 3 such layers: UI, Business, and Data. When organized following the DDA pattern, the Business Layer will reference the Data Layer, and the UI Layer will reference the Business Layer. This is obvious, since clearly the Business Layer needs to be able to fetch and persist data, so it has to reference the Data Layer, and the UI layer needs to provide an interface to the Business Layer, and so must reference it. The benefit of this layered approach is that the Data Layer could, theoretically, be completely rewritten without any changes being made to the UI layer. Only the layer one step up would need to change (and it must change, since any interfaces used can’t belong to the Business Layer using this approach, because then the Data Layer would need to reference the Business Layer in order to implement such interfaces, creating a circular reference.

> **Preferred Pattern(s)**
>
> The application’s Business Layer should be its Core. It should not depend on anything if possible, and certainly not on Infrastructure like data access. All project dependencies should point to the Business Layer / Core, which should define the interfaces it requires its collaborators to implement. See [Onion Architecture](http://jeffreypalermo.com/blog/the-onion-architecture-part-1) and [Hexagonal Architecture](http://c2.com/cgi/wiki?HexagonalArchitecture).
>
> The [Dependency Inversion Principle](http://en.wikipedia.org/wiki/Dependency_inversion_principle) can be valuable in achieving this reversal of project reference direction.

**Primitive Obsession (PO)**– Creating types is something to be avoided – the more types you have in your application, the more files there are, and the more complex it seems. Plus, everybody knows integers, strings, and datetimes perform WAY faster than custom-made classes. Who cares that you have no idea what a jagged array of int,int,int is supposed to be – that’s what Hungarian Notation is for, right?

**Preferred Pattern(s)**

Use types to constrain behavior and communicate intent. If you are working money and have methods that transfer funds from account A to account B, and negative amounts should not be allowed, consider using a custom money type that can only have positive values. If you need to pass some data to a View, consider a strongly typed ViewModel class (or even a dynamic object with named properties) rather than a tuple<int,int,string,bool,string,int>.

[James Shore as more on Primitive Obsession](http://jamesshore.com/Blog/PrimitiveObsession.html).

Source:[Refactoring, by Martin Fowler](http://amzn.to/hFzBEC)



(do you have more *patterns* of mediocre programming? Leave a comment below!)



**Practices**

**Found On Internet (FOI) –**When faced with a problem, the quickest fix is often to search the Internet. This is a valuable and effective way to research solutions. The mediocre programmer’s approach to this, however, is to locate the first blog post or forum response that looks like it might be a fit to the problem at hand, and then to cut and paste the code, hack at it until it compiles, and run the application to see if it seems to work. If it does, move on to the next fire. If not, continue hacking until it does or go to the next item in the search results.

> **Preferred Practice(s)**
>
> Spike a solution using the found code and see if it works in a variety of scenarios.
>
> Write some tests to confirm the behavior of the code does what it claims and works according to your expectations.
>
> Review a variety of possible approaches to the problem and try to determine if you’re actually asking the right question before jumping on a possible solution.

**Premature Optimization (PO)**– Developers like to write code that runs as quickly as possible. Certainly, performance is one factor in nearly all software, but like all factors it must be weighed against other attributes like maintainability and velocity of feature delivery. The practice of optimizing code before one knows if a bottleneck exists in the current code, or if the actual production performance of the application will not be sufficient without such optimization, tends to result in waste. More often than not, the code being optimized is either good enough as is, or simply is not the bottleneck and thus any optimizations made to it will not impact the actual performance of the application.

> **Preferred Practice(s)**
>
> Get actual performance requirements from the customer and write tests to ensure that given scenarios comply with these performance requirements. Do not optimize unless these tests fail.
>
> Collect actual data on the performance of the application and identify where the bottlenecks are. Spend your time eliminating the actual bottlenecks identified by your analysis, rather than guessing where the problem might be.

**Copy-Paste-Compile (CPC)**– Sometimes an application exhibits a bug or requires new functionality that has already been corrected elsewhere. All that needs done is to locate the correct section of code, copy it, and paste it into the section of code that requires this behavior. Make sure it still compiles and check it in. Another task complete!

> **Preferred Practice(s)**
>
> Get actual performance requirements from the customer and write tests to ensure that given scenarios comply with these performance requirements. Do not optimize unless these tests fail.
>
> Collect actual data on the performance of the application and identify where the bottlenecks are. Spend your time eliminating the actual bottlenecks identified by your analysis, rather than guessing where the problem might be.
>
> **(whoa, did someone *copy and paste the above and forget to update it?*)**
>
> Follow [Don’t Repeat Yourself](https://deviq.com/don-t-repeat-yourself/) and move logic that repeats into its own methods or objects. Fight duplication wherever you find it in your code.

**Reinventing The Wheel (RTW)**– Part of an application requires a little algorithm or utility that no doubt someone else has encountered before, but rather than using an existing framework class or well-known industry solution, the developer takes this as an opportunity to write the best XXX utility ever. It’s often more fun to write an algorithm or [regular expression](http://regexlib.com/) than to deliver yet another boring business form or report, but reinventing the wheel doesn’t add value. (also seen sometimes as **Not Invented Here (NIH)**).

> **Preferred Practice(s)**
>
> Know and use the framework. If you’re a .NET developer, the .NET framework has a ton of functionality in it and is usually a good first place to look.
>
> Share knowledge within your organization. It’s likely someone else in your company already has solved this problem.
>
> Quickly estimate the time it would take to build the functionality from scratch, and the cost of your time. See if a commercial tool could do the job for less, and see if management is willing to invest in such a tool.

**Copy Folder Versioning(CFV)**– Sometimes, changes to an application are big enough that they seem scary (even to a cowboy coder), so they decide to make a backup. Of course, there’s no source control software in use, so naturally the way to go is to make a copy of the folder containing the project (and, if you’re being extra professional, rename it from “Copy (2) of FooProject” to something more useful).

> **Preferred Practice(s)**
>
> Use Source Control! Please, if you’re still not using some kind of source control, start doing so today!
>
> Seriously, use source control.
>
> **Source**
>
> [Brendan Enrick](http://brendan.enrick.com/) helped come up with the[ TLA](http://en.wikipedia.org/wiki/Three-letter_abbreviation) for this one.

**Golden Hammer (GH)**– The Golden Hammer refers to a particular language, framework, library, or tool with which you are familiar, and with which you’re certain you can solve any problem. When wielding the Golden Hammer, every obstacle looks like a nail, and any suggestions by teammates that other tools might be better-suited to the task at hand go unheard. (aka Silver Bullet, Magic Bullet)

> **Preferred Practice(s)**
>
> Learn or at least become familiar with a variety of languages, tools, and frameworks. Keep an open mind about how to approach problems as you build an application.
>
> **Source**
>
> Peter Hickman
>
>

**Shiny Toy (ST)**– The Shiny Toy is latest, coolest tool or technology available. Its potential is boundless. It can solve world hunger and bring about lasting peace in the Middle East. But it’s still beta so of course you need to spend some time learning it, since there’s no documentation for it yet and nobody you’ve heard of has released a live application running with it. You’re sure it will do everything the application needs, though, without too much extra effort… (this is related to the Golden Hammer practice, above, but taken to the opposite extreme. Sometimes you will find someone who thinks their **Shiny Toy** is a **Golden Hammer**, though!).

> **Preferred Practice(s)**
>
> Prefer existing and well-known tools and patterns to unproven ones for production use. Learn about the new on your own time, at conferences, for your blog, or if you’re sure it solves a real problem the application has, with a [spike solution](http://c2.com/xp/SpikeSolution.html) that can quickly demonstrate whether or not it will work.
>
> **Source**
>
> [Kevin Babcock](http://www.myviewstate.net/)(renamed “Shiny Toy” by Steve Smith)
>
>

(do you have more *practices* of mediocre programming? Leave a comment below!)



**Additional References**

* [Anti-Patterns : Avoid Programming the Dark Side](http://systeminetwork.com/article/anti-patterns-avoid-programming-dark-side)
* Book:[Agile Principles, Patterns, and Practices in C#](http://www.amazon.com/gp/product/0131857258?ie=UTF8&tag=aspalliancecom&linkCode=as2&camp=1789&creative=390957&creativeASIN=0131857258)