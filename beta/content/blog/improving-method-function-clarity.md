---
title: Improving Method and Function Clarity
date: "2021-06-22T00:00:00.0000000"
description: When you look at a method or function, it should have a name that describes what it does. Naming things is hard but important, and probably the most important thing you can do when you design a method or function is give it a good name.
featuredImage: /img/improving-method-function-clarity.png
---

(Originally sent to my [weekly tips subscribers](/tips) in March of 2019)

When you look at a method or function, it should have a name that describes what it does. Naming things is hard but important, and probably the most important thing you can do when you design a method is give it a good name. This mainly applies to methods (or functions) that are or may be called from more than one place. It's less necessary when the function is just a lambda expression (as are very common in LINQ and other C# patterns) or a callback (as are very common in JavaScript designs).

## Small and Clear

The second-most important thing you can do is make the thing the method is supposed to do incredibly obvious in the code itself. What you don't want is a method that says "DoX" and then when you go to read it the method's code says:

- Check if this state is X
- Check if this other state is Y
- Check this other argument to make sure it's at least 42
- Do this seemingly unrelated thing
- Do the thing*
- Do another unrelated thing
- Return an error in an else block from a check
- And from another check
- And from the first check
- Return success if you got here

It takes a fair bit of investigative work for someone reading this pseudo-code to discover"Do the thing"* in a deeply nested if statement 50 lines deep into the method, surrounded by all that other clutter. If you want your methods to be more clear, keep them short and keep them focused on the"happy path". That is, the thing they're all about doing when everything goes right.

How do you do that? Well, first, **keep methods short**. No, even shorter than that. Does that mean you should reduce everything down to single-letter variable names? Of course not. The goal is clarity, so you're looking for a mix of short enough to be easily understood **but also** descriptive enough to be easily understood.

## Avoid Else Statements

Second, **avoid else statements**. If you have to do validation in the method, use the [guard clause pattern](https://deviq.com/design-patterns/guard-clause) so you can exit immediately if values are invalid. If you can quickly return a value in some cases, do that early in the method as well, again without an else clause - just return. Anything that will get you out of the function faster is worth doing as early as possible, both for performance and clarity reasons.

Obviously you can't *always* avoid else statements, but given the choice between exiting the function or including an else statement, choose the return/throw option.

## Wrapper Functions and Call Chains

Third, use wrapper functions. If you absolutely must catch an exception as part of a method (meaning, you can actually do something about the exception, because if not, you should just [let it throw](https://www.youtube.com/watch?v=iEKLFS-aKcw&ab_channel=DisneyUK)), move the body of the try block into its own method so the only thing in the calling method is the try-catch. Name both methods appropriately, if possible. For example:

```csharp
// initial version
public void SaveOrder(Order order)
{
 try
 {
 // validate order

 // open database connection

 // save order
 }
 catch (Exception ex)
 {
 // if it's a connection failure, retry
 // otherwise log and throw
 }
}

// refactored - TrySaveOrder only worries about the try/catch logic
public void TrySaveOrder(Order order)
{
 try
 {
 SaveOrder(order);
 }
 catch (SqlException ex)
 {
 // retry N times; consider Circuit Breaker pattern
 }
 catch (Exception ex)
 {
 // log the details
 throw;
 }
}
public void SaveOrder(Order order)
{
 // validate order

 // open database connection

 // save order
}
```

This approach helps your methods follow the [Single Responsibility Principle](https://deviq.com/principles/single-responsibility-principle). Note that you don't *have* to use two methods in the same class or scope. Frequently cross-cutting concerns like error handling and logging can be done in [decorators](https://deviq.com/design-patterns/design-patterns-overview) that follow the same interface as an underlying class but wrap it with additional functionality. In that case you wouldn't need `TrySaveOrder` but instead you'd have the try-catch functionality in an `ExceptionHandlingRetryDecorator`'s `SaveOrder` method, and you would wrap the original `OrderService` (or whatever) class with it.

## Keep It Obvious

There are other tricks you can do but at the end of the day the method's name and what it does should match and both should be extremely obvious to anyone reading the code, not buried in deeply nested conditional constructs. If you find naming is difficult, it's almost always a sign that your method is doing too much, so pull out a few pieces that you *can* easily name into their own methods so the original method at least gets a bit smaller.

## Regions in Methods

If your method is big enough to benefit from having regions inside of it, it's certainly bigger than it should be. On the plus side, the region names usually make great method names for the methods you should extract and call. Learn more about when it is and isn't a good idea to [use regions in your C# code](https://ardalis.com/regional-differences/).

