---
templateKey: blog-post
title: Make the Implicit Explicit
date: 2021-12-07
description: When practicing software architecture and design, one important consideration is how the rules of the system are modeled. Are the rules ad hoc and a matter of tribal knowledge of the developers who came before, or are they explicit in the way the system and its classes are designed and used? Whenever possible, favor making the implicit explicit in your design, so that as developers come and go, the design remains consistent and discoverable.
path: blog-post
featuredpost: false
featuredimage: /img/make-implicit-explicit.png
tags:
  - software architecture
  - software design
  - object-oriented design
  - software engineering
  - DDD
  - encapsulation
  - clean architecture
  - refactoring
category:
  - Software Development
comments: true
share: true
---

When practicing software architecture and design, one important consideration is how the rules of the system are modeled. Are the rules ad hoc and a matter of tribal knowledge of the developers who came before, or are they explicit in the way the system and its classes are designed and used? Whenever possible, favor making the implicit explicit in your design, so that as developers come and go, the design remains consistent and discoverable.

## Implicit design rules

Most systems include some implicit design rules. These come in many forms, but you may not know what I mean when I say "implicit rules" or "implicit design", so let's look at a few examples. Many of these are examples of code smells, which I describe and show how to address in my [refactoring courses on Pluralsight](https://www.pluralsight.com/authors/steve-smith) (the most comprehensive one is the retired "Refactoring Fundamentals" course which you can find from my author page).

Let's say you have a system that deals with subscriptions. It includes a class `MemberSubscription` to represent an individual member's subscription details. It might look like this:

```csharp
public class MemberSubscription
{
  public int Id { get; set; }
  public int MemberId { get; set; }
  public DateTime StartDate { get; set; }
  public DateTime EndDate { get; set; }
}
```

Now, stop reading for a moment and think to yourself, are there any things a consumer of this class *could* do, but probably *shouldn't* do as a well-behaved part of the app in which this class lives? Let's ignore using reflection for the moment and only consider strongly-typed compile-time code.

Thought of any?

Here are a few that come immediately to mind for me - let me know in the comments what I missed:

- Should I be able to set the Id at all?
- Since the Id is an int, it's probably not set by the app, but by a database, so it probably can be readonly from the app's perspective.
- Assuming I can set the Id, should I be able to set it to 0 or a null value?
- What about MemberId? I probably need to set it at some point, perhaps at object creation.
- Should I be able to set MemberId after object creation?
- Should I be able to set it to anything, or should it be constrained to potentially valid Ids? Or actual, existing Member Ids?
- Should I be able to change the Start Date? In this case, probably yes.
- Should I be able to change it to any date, past or future? Possibly. Independently of End Date? Maybe.
- What if the End Date is tomorrow - should I be able to make the Start Date some time next month? Probably not.
- This is the whole class - there is no non-default constructor. So, should I be able to just create one of these with defaults for all values? How many of these values need to be set for this to be "valid"?

I'm sure you can probably keep going but I'll stop here. There are a lot of questions, a lot of assumptions, about what one should or shouldn't be doing with a class like this one. It doesn't leverage encapsulation or other object-oriented design techniques to enforce constraints that limit how it should be used.

Someone, reading this:

> "But I don't like constraints. I like to be able to do whatever I want without restriction so nothing prevents me from building the app however I want."

**Oh, my sweet summer child.**

!["Oh my sweet summer child from Game of Thrones"](/img/oh-my-sweet-summer-child.jpg)

## Why constraints?

Constraints are our friends. Constraints are the reason we're able to drive millions of vehicles on roads without constant death and destruction (even with constraints, vehicles kill tons of people every year...). Let's work with this metaphor for a moment, shall we? What kinds of constraints exist that help make driving safer?

First, there are laws and regulations. Requirements to get a license to drive. Requirements for vehicle safety and inspections. Traffic rules regarding speed and which side of the road to drive on and whether you can pass or not.

These are generally pretty explicit. There are explicit rules with explicit penalties for not following them. But as an individual driver you can choose to ignore many of these rules (at your own risk) and perhaps avoid consequences. People speed. People drive without a license. People drink and drive.

Going beyond explicit-but-not-enforced rules you have additional constraints that you typically cannot choose to ignore. Some vehicles have have their top speed limited by a governor. While you can choose to drive on the wrong side of your neighborhood road, the divided highway in the major interchange has concrete walls constraining where you can drive. Similarly, when construction crews are working, they might rely on some cones or barrels to help oncoming traffic "decide" to merge to the left, but often where the actual work is occurring the workers have the good sense to put concrete barriers between themselves and moving traffic. Some constraints are more effective than others.

Returning to software, constraints abound especially in strongly-typed languages like C# or Java. That's what strong-typed *is* after all, a constraint that enforces certain contracts. Want to pass an int value into a method that expects a string? The compiler isn't going to like that. Want to do the same in JavaScript? No problem! (until perhaps at runtime).

Don't like constraints, but you use `public|protected|private|internal` keywords? Guess what? Those are all constraints. They're *limiting* how other code can work with class members.

You know what doesn't have a lot of constraints? Shared, writeable global state. Have you ever been working in a method or class and felt like the variable lifetime and scoping rules were getting in your way? Just throw out that constraint and add a single `public static Dictionary<object,object> AllTheThings;` bag of state to your app, and look at how easily you'll be able to work with any value, any time, anywhere.

But seriously, constraints are valuable and important parts of your system design. Constraints communicate the expected use of the system. They provide guard rails (driving metaphor callback!) to keep folks working with your design on the right track.

> If you get the constraints right, you make the right way easy and the wrong way hard, which helps the team fall into the pit of success.

Now, some genius will respond with "who are you to say what the 'right' way is?" to which I must make clear, I'm not. The team designing and building the app is deciding. It's the right way *for that app* because that's how the team designed the app.

## Being Explicit

Explicit designs bake the right behavior in. They enforce the expected way to do things so that assumptions are no longer a required part of the process. Tribal knowledge and even documentation needs are reduced in systems that have fewer, clear and consistent ways to do things.

Ideally, there should only be one way to accomplish a particular task in the system. Having multiple ways to achieve the same (or apparently the same) result is poor design. It forces developers to make decisions about which is the "right" way. If you're building a general purpose framework, providing some flexibility to developers who will work with it can be a good thing. But if you're building a single application with a team of developers, it's going to work out better if the whole team is aligned and building things in a consistent fashion. Design your system so this is built in, rather than a set of conventions that are documented somewhere that hopefully all team members read and remember (every time).

Let's return to the `MemberSubscription` design above, and consider now the `Member` as well. Members may have one or more subscriptions, so the class modeling this relationship might look like this:

```csharp
public class Member
{
  public int Id { get; private set; }
 
  // other properties

  public List<MemberSubscription> Subscriptions { get; private set; }

  public void AddSubscription(Subscription subscription)
  {
    Subscriptions.Add(subscription);
  }  
}
```

Once more, stop reading ahead, look at this class, and answer this question. How many different ways are there to add a subscription to a member? And how many different *kinds* of subscriptions does it accept?

The obvious answer is "too many" for both questions.

Consumers of this design can do any of the following:

```csharp
public void SomeMethod(Member member)
{
  // 1. Empty sub
  member.AddSubscription(new Subscription());
  // 2. Another empty sub
  member.Subscriptions.Add(new Subscription());
  // 3-4. Non-matching member's subscription (using AddSubscription or Subscriptions.Add)
  // member.Id == 1
  member.AddSubscription(new Subscription { MemberId = 2});
  // 5+
  // Missing start date
  // Missing end date
  // End Date precedes Start Date
  // Probably others
  // Hey at least we have strong types!
}
```

So, how would you constrain this design so that there were fewer ways to perform the operation of "add a subscription to a member" or "subscribe a member"?

First, don't expose a collection property directly. I've written a lot about this, but it's still incredibly common. [Encapsulate collection properties in your domain model](https://ardalis.com/encapsulated-collections-in-entity-framework-core/) so you don't expose the full collection functionality (clear, delete, etc.) to the app. Once you've hidden your actual underlying collection, expose only those methods (like `AddSubscription`) that you want to allow.

Second, *somewhere* we need to make sure that we don't have garbage in the `MemberSubscription` instance that we add to the `Member`. There are a couple of approaches here. You can add a constructor to `MemberSubscription`, make it the only (non-private - EF might need a private one) constructor, and ensure appropriate values are set. But there are limits on this approach. For instance, how is the constructor supposed to know what members exist, and thus was memberId values are valid? Still, it's better than nothing and for rules that don't require additional context, it's a good place to enforce them. For example, if Start Date must precede End Date, the constructor is a good place to put this requirement. Another option would be to use a `DateTimeRange` value object type which might have this behavior baked in, and then your `MemberSubscription` doesn't need to worry about this rule anymore. Julie Lerman and I show an example of this in our [Pluralsight DDD Fundamentals course](https://www.pluralsight.com/courses/fundamentals-domain-driven-design).

Additionally, we can change how we think about the `AddSubscription` method, and turn it into a sort of factory method. Rather than passing in a `MemberSubscription` of dubious origin, we can instead create the subscription in the very method that adds it, using something like this:

```csharp
public class Member
{
// other members omitted

// this uses the DateTimeRange value object which includes a Start and End
public void AddSubscription(DateTimeRange dateRange)
  {
    // constructor accepts memberId and a date range
    var memberSub = new MemberSubscription(this.Id, dateRange);

    // any other checks like looking for duplicate subscriptions go here
    
    Subscriptions.Add(memberSub);

    // any follow-on behavior or raising of events goes here
  }
}
```

Between this method and encapsulating the `Subscriptions` property, there are far fewer ways to improperly add a subscription to a member. And because most of these constraints exist in the code design and are enforced by the compiler, you don't need to write unit tests for them! There's no test to see what happens when someone tries to add a subscription to a member with a member id that doesn't match because you can't do that! There's no test to see what happens if a member subscription has dates that are out of order because you can't do that! The constraints force the code to follow "the rules" without the need for extensive tribal knowledge about how things work, documentation on the "right" and "wrong" ways, and excessive tests to cover many bad paths. In short, the design has made explicit the previously implicit assumptions about how this simple relationship should work.

## Summary

> Making the implicit explicit is a key design principle in software design.

It goes hand-in-hand with leveraging constraints to limit possible errors and mistakes and encapsulation (itself a set of constraints). Avoid thinking about constraints as having strictly negative connotations (if you do), and instead learn to value them for their ability to guide people (developers in this case) to do the "right" thing (for your project).

Found this useful? Share your thoughts and a link on Twitter and mention @ardalis. I'll most likely retweet it. Disagree and think this is all a load of bunk? Feel free to tweet that as well and I'll be happy to (respectfully) discuss, debate, and learn with/from you.
