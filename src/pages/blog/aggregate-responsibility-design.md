---
templateKey: blog-post
title: Aggregate Responsibility Design
path: blog-post
date: 2022-04-20
description: In Domain-Driven Design, Aggregates are groups of objects that are persisted as a unit, with the root object being responsible for ensuring the validity of the entire aggregate. But how should this responsibility influence our design?
featuredpost: false
featuredimage: /img/aggregate-responsibility-design.png
tags:
  - aggregates
  - aggregate-pattern
  - ddd
  - domain-driven design
  - oop
  - tell-dont-ask
  - anemic
category:
  - Software Development
comments: true
share: true
---

The [Aggregate Pattern](https://deviq.com/domain-driven-design/aggregate-pattern) comes from [Domain-Driven Design](https://www.pluralsight.com/courses/fundamentals-domain-driven-design) and provides a way to encapsulate business logic among several related objects. The pattern has a few rules that, when followed, can help to organize complexity by creating an encapsulation boundary somewhere between the individual entity or value object and the whole domain model.

The basic rules of the Aggregate pattern are:

- Every aggregate has a single entity as its root
- Aggregates are named for their root entity (the "aggregate root")
- Children within aggregates are not persisted individually, but only as part of the aggregate
- Aggregate roots are responsible for ensuring the validity of the full aggregate

## Designing an Aggregate

Julie Lerman and I talk a lot about aggregate design in our [Pluralsight course](https://www.pluralsight.com/courses/fundamentals-domain-driven-design). You should check it out if you haven't had a chance. One thing we talk about is how to design navigation properties with regard to aggregates. Specifically, we recommend a one-way relationship for navigation properties which should only exist from aggregate roots toward their children (and not vice versa nor between aggregates). This means the aggregate root should be able to get to any of its children (in code), while the children typically will only have an ID property for their parent.

The last rule above, about the root entity being responsible for the validity of the whole, is one that often trips up developers new to the pattern. They sometimes consider this to mean the code must **live** in the root entity. Remember that the root can delegate to its children while performing tasks for which it is responsible! Just because it's responsible doesn't mean it needs to be a micro-managing [god object](https://deviq.com/antipatterns/blob) that violates [SRP](https://deviq.com/principles/single-responsibility-principle) and a host of other [code smells](https://deviq.com/antipatterns/code-smells) to do it.

## An Example

Let's take a fairly simple example of an Order entity that has a collection of OrderItem entities. Order is the aggregate root, and the whole thing is called the Order Aggregate.

```csharp
public class Order : BaseEntity, IAggregateRoot
{
  // backing fields and other properties omitted
  public IEnumerable<OrderItem> OrderItems { get; private set;}
}

public class OrderItem : BaseEntity
{
  public int ProductId {get; set; }
  public int Quantity { get; set; }
}
```

Pretty simple. Let's consider some typical operations this aggregate might be expected to support:

- Create a new Order (maybe requiring at least one item)
- Add a new Order Item to an Order
- Update the quantity of an Order Item

Let's also consider a couple of business rules that describe valid orders:

- A valid Order has at least one OrderItem
- A valid Order's collection of OrderItems contains no duplicate ProductIds
- A valid Order Item has a positive Quantity

## A Naive Design

I've seen designs that take the approach of putting all of this logic and responsibility in the Order entity. The result looks something like this:

```csharp
public class Order : BaseEntity, IAggregateRoot
{
  public Order(OrderItem initialItem)
  {
    // initialize OrderItems with this item
  }

  // backing fields and other properties omitted
  public IEnumerable<OrderItem> OrderItems { get; private set;}

  public void AddItem(OrderItem item)
  {
    // if quantity is not positive, throw
    // if duplicate, add its quantity to existing item
    // else, add a new item
  }

  public void UpdateItemQuantity(int orderItemId, int quantity)
  {
    // if item not in OrderItems, throw
    // if quantity is not positive, throw
    // set item.Quantity = quantity
  }
}

public class OrderItem : BaseEntity
{
  public int ProductId {get; set; }
  public int Quantity { get; set; }
}
```

Do you see any problem with this design? I'm keeping it pretty small for demonstration purposes, but imagine that OrderItem actually has half a dozen or more properties that might be set on it. Do you notice that it's just a DTO, not really an object with behavior of its own?

The problem I have with this design is that OrderItem is anemic. It has not behavior, and it has no encapsulation. Its properties are directly settable so that they can be modified by methods living in Order, which violates the [Tell, Don't Ask principle](https://deviq.com/principles/tell-dont-ask) by working with OrderItem and then settings its state externally.

You can easily spot this antipattern in your own aggregates by looking for methods that include the child entity in their name, like *UpdateItemQuantity*. It's not manipulating the aggregate (Order) state, but the state of a related entity. Don't do that. Also since OrderItem has no encapsulation, its state can actually be set from anywhere, so it will constantly need to be verified to ensure it's still valid any time you want to work with it. It's always better to ensure the data can't be put into an invalid state (through encapsulation) than to have to have duplicate checks on it all over your codebase because you can't trust it.

## A Better Design

A better design ensures OrderItem is responsible for itself, and the aggregate root is only responsible for behavior that individual order items cannot do on their own (such as checking for duplicates within a collection).

```csharp
public class Order : BaseEntity, IAggregateRoot
{
  public Order(OrderItem initialItem)
  {
    // initialize OrderItems with this item
  }

  // backing fields and other properties omitted
  public IEnumerable<OrderItem> OrderItems { get; private set;}

  public void AddItem(OrderItem item)
  {
    // if duplicate, add its quantity to existing item
    // else, add a new item
  }
}

public class OrderItem : BaseEntity
{
  public OrderItem(int productId, int quantity)
  {
    // if productId is not positive, throw
    // if quantity is not positive, throw
  }

  public int ProductId {get; private set; }
  public int Quantity { get; private set; }

  public void UpdateQuantity(int newQuantity)
  {
    // if newQuantity is not positive, throw
    // Quantity = newQuantity
  }
}
```

Notice that in this design there are no external checks around OrderItem to see if its quantity is positive. We've designed the class so that it's impossible (without using reflection) to set its quantity to a non-positive value. We could (and probably should) go even further and use a value object instead of the primitive int type for this property, and enforce the rule on the type rather than the property. But that's a story for another article.

If we were to keep adding more properties to OrderItem which could be modified, the naive first design would have required us to keep adding more things to Order. With the updated design, OrderItem is responsible for its own state and enforcing its own rules. The Order aggregate, which is responsible for ensuring the aggregate's validity, can leverage OrderItem's behavior in doing so. There's no need for it to externally check OrderItem if it can trust that it's going to be internally valid, any more than you feel the need check if the Month property of a DateTime is less than 13. The type does this for check for you, so you can be confident it will be in a valid range if you have an instance of the type.

## Valid By Design

Many developers also think that the aggregate rule of ensuring the whole aggregate is "valid" requires a method to check validity. Sometimes this is helpful, but a better design is one that doesn't allow invalid values to exist in the first place. Again, consider the DateTime type. It doesn't have an `IsValid()` method that you call after creating one with year, month, day of (2022, 50, 50). It's simply not going to let you set its state to a month or day of 50. If you succeed in creating an instance of DateTime, you can trust that it's valid, and furthermore you can't use any of its methods to put it into an invalid state. This is the design approach you want to use with your aggregates and entities, too.

Don't rely on a method you have to call any time you want to ensure the state of the aggregate is valid. Design your aggregates (and entities) so they're always valid.

## Summary

Just because the aggregate root is responsible for ensuring the aggregate is in a valid state, that doesn't mean every operation performed on any member of the aggregate must live in the aggregate root. Nor does it mean the aggregate must have a method that performs validation. Using proper object-oriented design and ensuring your entities encapsulate and manage their own state provides a cleaner, better design.
