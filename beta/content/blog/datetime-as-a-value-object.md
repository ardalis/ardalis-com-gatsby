---
title: DateTime as a Value Object
date: "2022-01-12T00:00:00.0000000"
description: When teaching DDD, I often use DateTime as a good example of a value object. This article details some of the lessons one can learn from this common.NET data structure.
featuredImage: /img/datetime-as-a-value-object.png
---

[Value Objects](https://deviq.com/domain-driven-design/value-object) are a key part of [Domain-Driven Design](https://www.pluralsight.com/courses/fundamentals-domain-driven-design) and domain models created by this process. However, they're not used nearly as often by teams as they should be, and they're frequently misunderstood even by experienced dev teams.

When teaching teams how to better understand Value Objects and incorporate them more in their domain models, I've found the `DateTime`.NET type to be a useful example.

First, a quick reminder of what a Value Object is:

> A Value Object is an immutable type that is distinguishable only by the state of its properties. Any two Value Objects with the same properties can be considered equal.

## Can a Value Object or DateTime Stand Alone in a Model

When modeling a system, many developers struggle with when to use a value object, when to use an entity, and how to combine the two. It's not unusual to come up with a value object and expect it to act like an entity. I get questions like "can I just have a list of value objects in my model" to which the answer is almost always"no". Again this is where `DateTime` can help.

> Would it make sense to have a list of `DateTime`s in your domain model? What would that even mean?

A `DateTime` by itself, without context, has no meaning in your domain model. It's only when it's used to *describe* something in your model, typically an Entity, that it becomes useful. Here's an example:

```
2022-01-10
2022-01-11
2022-01-12
```

You find these in a domain model. What do they mean? What do they represent? You have no way of knowing.

How about now?

```csharp
var article = new Article
{
 CreationDate = new DateTime(2022,1,10),
 PublicationDate = new DateTime(2022,1,11),
 LastModifiedDate = new DateTime(2022,1,12)
};
```

The same three `DateTime` values now have context as they are used to describe an `Article` entity.

(A common one I see a lot is `Address`, but again this has no meaning by itself. It's only when you make it a `CustomerAddress` or a `ShipToAddress` that it has meaning.)

## Why is immutability important

Recall the definition of Value Object states that they are immutable. That means, once they're created, you should not be able to change them. Their properties should all be readonly. What's the point of this? I've talked about [why immutability is desirable before on my podcast](https://www.youtube.com/watch?v=a8l-_AFyQKA), but let's review here in the context of `DateTime`.

If you're been writing software in C#/.NET for a while, you've probably used the `DateTime` type many times. Now I want you to think for a moment:

> How many times have you ever had to check to see if a DateTime's properties were valid months, days, etc?

Did you ever check if the `Day` was more than 31, or otherwise out of range for a given month? Did you ever check if the `Month` was 13 or more? No? Why not?

> You don't need to validate instances of DateTime because it's impossible to create one in an invalid state, **and** they are immutable.

If you try to create a `DateTime` with invalid values, like this with a Month of 13, you will get an exception:

```csharp
var someDate = new DateTime(2022,13,1);
// System.ArgumentOutOfRangeException: Year, Month, and Day parameters describe an un-representable DateTime.
```

If you try to modify it to put it into such an invalid state, you will get a compilation error:

```csharp
var someDate = new DateTime(2022,12,1);
someDate.Month = 13;
// error CS0200: Property or indexer 'DateTime.Month' cannot be assigned to -- it is read only
```

There are other reasons why immutability is important, but from a domain modeling perspective this is the most important one. You gain confidence that these values are valid, and you eliminate a ton of duplicate code that would otherwise be necessary to confirm validity in many places. Your code is safer, simpler, and [DRYer](https://deviq.com/principles/dont-repeat-yourself).

### So how do you change them?

Value Objects can expose methods that"appear" to change them, but which actually produce new instances of the type. This is true of `DateTime` as well as `String` in the.NET Framework. Whether it's `AddDays()` or `ToLower()`, you'll find that any method you call on an instance of a value object should return a new instance, rather than modifying the state of the existing instance.

Remember this when designing your own value objects. Any methods you expose that would manipulate the state of the object should instead simply return a new instance with the updated values used to create that instance.

One obvious benefit of this approach is that your validation logic in the value object's constructor is guaranteed to be run for every modification method you expose without any need to duplicate any of it.

## More on Value Objects

I've written a few articles about Value Objects. Check them out if you're looking to improve your overall understanding:

- [Value Objects](https://deviq.com/domain-driven-design/value-object)
- [Refactoring to Value Objects](https://ardalis.com/refactoring-value-objects/)
- [Support for Value Objects in C#](https://ardalis.com/support-for-value-objects-in-csharp/) ([records are close](https://enterprisecraftsmanship.com/posts/csharp-records-value-objects/))
- [Working with Value Objects](https://ardalis.com/working-with-value-objects/)

## Summary

While Value Objects are most often discussed in the context of DDD, there are examples of them in frameworks you probably work with every day. In.NET, the `DateTime` (and string!) types are both examples of `Value Objects`, and keeping this in mind can help inform your design of these types in your own applications.

