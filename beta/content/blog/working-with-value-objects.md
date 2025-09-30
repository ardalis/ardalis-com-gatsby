---
title: Working with Value Objects
date: "2011-07-12T00:00:00.0000000"
description: Some objects in your application simply describe attributes of other objects. These objects can be modeled as Value Objects, immutable and without identity. In this article, Steve introduces Value Objects and shows an example of how to implement them in a simple design.
featuredImage: /img/working-with-value-objects.png
---

## Introduction

A Value Object is an object that has no unique identity, but rather represents a characteristic of something else. For instance, the integer 7 can be used anywhere and always means the same thing - we don't think about this or that particular instance of the integer 7. Likewise, a given date like 11 July 2011 (GMT) is the same everywhere - it has no additional identity. In designing systems, it's useful to identify parts of the design that should be represented as Value Objects, as opposed to Entities, which each have a unique identity.

## Finding Value Objects in the Design

In [Domain Driven Design](http://t.co/FmnPsd2), Eric Evans describes Value Objects:

"An object that represents a descriptive aspect of the domain with no conceptual identity is called a VALUE OBJECT. VALUE OBJECTS are instantiated to represent elements of the design that we care about only for what they are, not who or which they are."

One of the nice things about VALUE OBJECTs is that they can be treated as immutable. That is, when created, they cannot be modified. Some more examples of basic value objects are colors and strings (which as it happens are immutable in.NET). At a higher level, a very common example of an object that should probably be captured as a Value Object but often isn't in my experience is customer data related to an order.

In a typical, naïve design of an order system, you might have something like this: a `Customer` has an `Order`, which has an `OrderItem`, which has a `Product`.

When this is persisted, naturally there will be foreign keys linking OrderItem to Product and Order to Customer. But what happens when, a year later, you want to see what a customer ordered and the corresponding Customer and Product records have since been updated? Maybe the price on the Product in question has gone up, or its name has changed. Maybe the customer has changed their address or billing contact. From the perspective of the Order at the time it was placed, the Product data and Customer data were important for their characteristics at that moment in time, not their identity. One possible solution to this problem is to introduce an Invoice that is most likely a Value Object itself, which captures all of this snapshot data. Another is to create separate Value Objects for the things the Order is concerned with that should be immutable from the Order's perspective.

You can think of the product and customer details related to the Order as being a snapshot of their values at the point in time at which the Order is created or placed. Since it certainly makes sense that there should be Product and Customer entities, with identities, in our system, we need a new type to represent these snapshots, which we might simply choose to name FooSnapshot, like so:

```csharp
public class ProductSnapshot
{
 private readonly string _name;
 public string Name { get { return _name; } }
 private readonly decimal _unitPrice;
 public decimal UnitPrice { get { return _unitPrice; } }

 public ProductSnapshot(string name, decimal unitPrice)
 {
 _name = name;
 _unitPrice = unitPrice;
 }

 public ProductSnapshot(Product product)
 {
 _name = product.Name;
 _unitPrice = product.UnitPrice;
 }

 public override bool Equals(object obj)
 {
 ProductSnapshot other = (ProductSnapshot) obj;
 return other!= null
 && this.GetType() == other.GetType()
 && Name.Equals(other.Name)
 && UnitPrice.Equals(other.UnitPrice);
 }
}
```

Now we have a simple way to create an immutable copy of the Product fields we are interested in at the time the Order was created, and we can modify OrderItem to refer to a ProductSnapshot rather than to a Product. One thing both our Product and our ProductSnapshot are missing is some kind of persistence-ignorant Stock Keeping Unit (SKU) number, which could be used to link a particular ProductSnapshot back to its parent Product if necessary.

Note that since Value Objects can be used interchangeably and should be immutable, we have made it impossible to change the properties of this object (without resorting to reflection) once it is created. We have also overridden the Equals() operation so that we can compared two separate instances of ProductSnapshot and if all of their properties are equal, we will consider the two objects to be equal. The code above is a modified version of code found in Jimmy Nilsson's excellent book, [Applying Domain Driven Design and Patterns](http://t.co/YHI1PoG) (chapter 5).

In terms of persistence, since the Value Object does not have an ID of its own, the simplest way to persist it is with the Entity it describes. In this case, we could choose to store values directly in the OrderItem table. This can result in duplicate data, but remember that the data is only duplicate by coincidence. Its meaning is unique to each OrderItem row, since any later change to the unit price or name of the product should not affect this row. It's no different than the quantity column of our OrderItem table, which likely has a lot of duplicate data as well. I doubt that anybody would suggest that we move Quantity's values of 1, 2, 3, etc. off to another table and assign some identities to these values in order to normalize OrderItem. That said, if space is a major concern, the snapshot values can be stored in a separate table and normalized, but care must be taken to ensure that this table is immutable, since otherwise it will be possible to corrupt the historic value of an OrderItem's product name and unit price.

## Summary

Value Objects can simplify the design of your system and improve its performance. By eliminating the need to track the state or to persist such objects, they can be more easily used within the design. It's also important to use value objects where immutability is important, in order to avoid corruption of older data as referenced entities change over time.

Originally published on [ASPAlliance.com](http://aspalliance.com/2068_Working_With_Value_Objects)

