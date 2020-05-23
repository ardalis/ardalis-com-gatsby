---
templateKey: blog-post
title: Exposing Private Collection Properties to Entity Framework
path: blog-post
date: 2015-06-25T14:10:00.000Z
description: When following good object-oriented design principles and
  domain-driven design fundamentals, one should avoid exposing collection
  properties directly from the domain model.
featuredpost: false
featuredimage: /img/private-entity.png
tags:
  - clean code
  - ddd
  - domain driven design
  - ef6
  - entity framework
category:
  - Software Development
comments: true
share: true
---
When following [good object-oriented design principles](http://bit.ly/solid-smith) and [domain-driven design fundamentals](http://bit.ly/PS-DDD), one should avoid [exposing collection properties](http://deviq.com/exposing-collection-properties/) directly from the domain model. This can be a difficult goal to achieve with Entity Framework 6.x, since its collection properties generally must be of type ICollection, which includes methods that can manipulate the collection without the knowledge of the object exposing the collection property. Ideally, collections should be exposed as either read-only collections or even simply as enumerations (IEnumerable<T>), with care taken to ensure that client code cannot (willfully or otherwise) convert the type into a Collection or List that can then be manipulated.

Jimmy Bogard has written about how [EF lacks support for encapsulated collections](https://lostechies.com/jimmybogard/2014/04/29/domain-modeling-with-entity-framework-scorecard/) and [a rather convoluted workaround](https://lostechies.com/jimmybogard/2014/05/09/missing-ef-feature-workarounds-encapsulated-collections/), but I have a somewhat simpler approach that some may find useful (not to take anything away from Jimmy – I’m a huge fan). My approach has the advantage of simplicity but the disadvantage of breaking [Persistence Ignorance](http://deviq.com/persistence-ignorance/) on the domain entities. The trick is to expose to EF an expression that it can use to perform its mapping. EF’s code first mapping methods expect these expressions to be of type Expression<Func<EntityType, ICollection<CollectionItemType>>>. For instance, a Customer entity with an Orders collection would be mapped by EF as an Expression<Func<Customer, ICollection<Order>>>. In order to properly encapsulate your collection to avoid giving other code the ability to manipulate it without the owning object’s knowledge, you can expose it publicly like so:

```
public IEnumerable<Order> Orders
{
    get { return _orders.AsEnumerable(); }
}
```

Another option is to expose an IReadOnlyCollection, as this example demonstrates:

```
protected virtual List<Order> PrivateOrders { get; set; }
private IReadOnlyCollection<Order> _orders;
 
public IReadOnlyCollection<Order> Orders
{
    get
    {
        return _orders ?? (_orders = new ReadOnlyCollection<Order>(PrivateOrders));
    }
}
```

The above code ensures that calling code cannot access the underlying List<Order> by guessing its type and casting to it (either on purpose, which is evil, or by accident perhaps due to a convention within a framework).

In both of the above cases, entity framework cannot map the public-facing Orders property, since it doesn’t implement ICollection. However, access to the appropriate expression can be provided to EF via another property:

```
public class Customer
{
    public int Id { get; set; }
    public string Name { get; set; }
 
    public IEnumerable<Order> Orders
    {
        get { return _orders.AsEnumerable(); }
    }
 
    private List<Order> _orders { get; set; }
 
    public Customer()
    {
        _orders = new List<Order>();
    }
 
    public static Expression<Func<Customer, ICollection<Order>>> OrderMapping
    {
        get { return c => c._orders; }
    }
}
```

Now a mapping for Orders can be added to EF using the OrderMapping:

```
protected override void OnModelCreating(DbModelBuilder modelBuilder)
{
    base.OnModelCreating(modelBuilder);
    modelBuilder.Entity<Customer>().HasMany(Customer.OrderMapping);
}
```

I don’t much care for having OrderMapping as a public property, especially if there are potentially multiple different collection properties on the entity. Thus, I would encapsulate these mappings into an internal class with a name I would use consistently between all of my entities (perhaps defined in a common entity base class):

```
public class Customer
{
 
// contents omitted
 
    public class ORMappings
    {
        //public const string OrderCollectionName = nameof(Customer._orders);
        public const string OrderCollectionName = "_orders";
        public static Expression<Func<Customer, ICollection<Order>>> Orders
        {
            get { return c => c._orders; }
        }
    }
}
```

Note, the collection name may be necessary when using .Include() with EF queries, hence its inclusion here to allow us to follow [the DRY principle](http://deviq.com/don-t-repeat-yourself/). Also, the comment first line is some C# 6 syntax that will let us get rid of even the single magic string defining the name of the private collection, using the **nameof** operator.

Now the EF code to map the column is simply:

```
protected override void OnModelCreating(DbModelBuilder modelBuilder)
{
    base.OnModelCreating(modelBuilder);
    modelBuilder.Entity<Customer>().HasMany(Customer.ORMappings.Orders);
}
```

I think the above code is very clear in its intent, and it should be quite unlikely that some unsuspecting developer will do something with the ORMappings property without realizing its intended use. The ORMappings class has nothing to do with the domain responsibilities of Customer, and as such would be a good candidate for placing into a partial class.

Domain entities should be responsible for managing their state. Blindly exposing properties with automatic getters and setters breaks encapsulation, but so does exposing collection properties even if the collection itself cannot be set. Client code can easily add and remove items to such collection properties, or even clear their contents, all without the owning object’s knowledge. It’s important to protect against such direct access to collection state by exposing only the operations that make sense from the owning domain entity. Unfortunately, this can make working with some ORMs difficult, but with the workaround shown here, EF can be made to work with properly encapsulated collection properties in .NET. Try it out and let me know what you think.

**See Also:**

* [Properly Exposing Collection Properties](http://blog.falafel.com/properly-exposing-collection-properties/)