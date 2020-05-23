---
templateKey: blog-post
title: Double Dispatch in C# and DDD
date: 2018-12-01
path: blog-post
featuredpost: false
featuredimage: /img/double-dispatch-in-csharp-and-ddd.png
tags:
  - C#
  - ddd
  - design patterns
  - domain driven design
  - double dispatch
category:
  - Software Development
comments: true
share: true
---

Double dispatch is a pattern you can use in C# to control how communication flows between two objects. A frequent use of the pattern is to pass "this" to a function on another class, allowing that class to communicate back to or manipulate the calling object instance. It can also be used to achieve polymorphic behavior. I have [a GitHub sample](https://github.com/ardalis/DoubleDispatchSamples) you can browse or download that demonstrates some of these techniques.

## Single Dispatch

Single dispatch occurs when you use early binding to determine which of several different methods will be invoked. In this case, the compiler determines which function to wire up based on the types of the objects involved at compile time, not runtime. Thus, in the following example, even though both calls to figure.Draw() pass in instances of type Pen, the second one uses the overload that accepts an Object:

public class SingleDispatchTest
{
    public class Pen { }
    public class Figure
    {
        private readonly StringBuilder \_stringBuilder;

        public Figure(StringBuilder stringBuilder)
        {
            \_stringBuilder = stringBuilder;
        }
        public void Draw(Pen pen)
        {
            \_stringBuilder.AppendLine("Figure drawn in pen.");
        }
        public void Draw(Object something)
        {
            \_stringBuilder.AppendLine("Figure drawn with something.");
        }
    }

    \[Fact\]
    public void Test()
    {
        var sb = new StringBuilder();
        var figure = new Figure(sb);

        figure.Draw(new Pen());
        object reallyAPen = new Pen();
        figure.Draw(reallyAPen);

        var result = sb.ToString();

        Assert.Equal(@"Figure drawn in pen." + Environment.NewLine +
                        "Figure drawn with something." + Environment.NewLine, result);

    }

## Double Dispatch

With double dispatch, the runtime type is used to determine which method is called. This allows us to better use polymorphism. In this example, the call to pen.Draw() will use the runtime type of Pen to determine which function to call (either red or black), rather than one known at compile time.

public abstract class Pen
{
    public abstract void Draw(StringBuilder sb);
}

public class RedPen : Pen
{
    public override void Draw(StringBuilder sb)
    {
        sb.Append("in red pen.");
    }
}

public class BlackPen : Pen
{
    public override void Draw(StringBuilder sb)
    {
        sb.Append("in black pen.");
    }
}

public class Figure
{
    private readonly StringBuilder \_stringBuilder;

    public Figure(StringBuilder stringBuilder)
    {
        \_stringBuilder = stringBuilder;
    }
    public void Draw(Pen pen)
    {
        \_stringBuilder.Append("Figure drawn ");
        pen.Draw(\_stringBuilder);
        \_stringBuilder.AppendLine();
    }
}

public class DoubleDispatchTest
{
    \[Fact\]
    public void Test()
    {
        var sb = new StringBuilder();
        var figure = new Figure(sb);

        figure.Draw(new RedPen());
        figure.Draw(new BlackPen());

        var result = sb.ToString();

        Assert.Equal(@"Figure drawn in red pen." + Environment.NewLine +
                        "Figure drawn in black pen." + Environment.NewLine, result);

    }
}

## Aggregates

Aggregates are a useful DDD pattern that I describe in my [DDD Fundamentals course on Pluralsight](https://www.pluralsight.com/courses/domain-driven-design-fundamentals). An Aggregate has an Aggregate Root and some number of children, forming a tree structure. In this example, a purchase order (PO) is defined as an aggregate with the PO as the root and individual line items as children. The root is responsible for ensuring that the total cost of all items on the PO does not exceed its SpendLimit. At least in .NET and when using EF, it's a good idea to have one-directional references between entities, so I've modeled the aggregate to give the PurchaseOrder type a navigation property (collection) to LineItem, but LineItem does not have a navigation property to PurchaseOrder (this also avoids serialization issues due to circular references). Instead, a LineItem has a PurchaseOrderId property which can be used to get an instance of a PO from a repository any time one is needed.

A LineItem instance whose cost is being updated doesn't have enough information to determine whether the new cost will break the PO's invariant of its spending limit. Thus, we can use double dispatch to pass in the parent PO and have the LineItem instance pass itself to the parent PO so that it can perform the check. This requires that we pass in the parent PO instance to the TryUpdateCost method, which is problematic because there's nothing in the code that requires us to pass any particular PO instance. We're expecting the LineItem parent, but the code will allow any instance. Thus, we must perform runtime checks to ensure the correct instance has been passed.

Another approach is to use a repository as the second parameter, which is then used to fetch the appropriate parent PO by using the LineItem's PurchaseOrderId property. This is somewhat better since it ensures we always get the proper parent PO, but does require the calling code to get a repository instance for us to use.

public class PurchaseOrder // aggregate root
{
    public int Id { get; set; }
    private List<LineItem> \_items { get; } = new List<LineItem>();
    public IEnumerable<LineItem> Items => \_items.ToList();

    public decimal SpendLimit { get; set; }

    public bool CheckLimit(LineItem item, decimal newValue)
    {
        var currentSum = Items.Sum(i => i.Cost);
        decimal difference = newValue - item.Cost;

        return currentSum + difference <= SpendLimit;
    }

    public bool CheckLimit(LineItem newItem)
    {
        return Items.Sum(i => i.Cost) + newItem.Cost <= SpendLimit;
    }

    public bool TryAddItem(LineItem item)
    {
        if (CheckLimit(item))
        {
            \_items.Add(item);
            return true;
        }
        return false;
    }
}

public class LineItem
{
    public int Id { get; set; }
    public int PurchaseOrderId { get; set; } // avoid having circular reference between aggregate and children
    public LineItem(decimal cost)
    {
        Cost = cost;
    }
    public decimal Cost { get; private set; }

    public bool TryUpdateCost(decimal cost, PurchaseOrder parent)
    {
        if (parent.Id != PurchaseOrderId) throw new Exception("Incorrect parent PO.");
        // check if new cost would exceed PO
        if (parent.CheckLimit(this, cost))
        {
            Cost = cost;
            return true;
        }
        return false;
    }

    // alternate implementation
    public bool TryUpdateCost(decimal cost, IPurchaseOrderRepository purchaseOrderRepository)
    {
        var parent = purchaseOrderRepository.GetById(PurchaseOrderId);
        // check if new cost would exceed PO
        if (parent.CheckLimit(this, cost))
        {
            Cost = cost;
            return true;
        }
        return false;
    }
}

public interface IPurchaseOrderRepository
{
    PurchaseOrder GetById(int id);
}

public class InMemoryPurchaseOrderRepository : IPurchaseOrderRepository
{
    private Dictionary<int, PurchaseOrder> \_collection = new Dictionary<int, PurchaseOrder>();
    public void Add(PurchaseOrder purchaseOrder)
    {
        if (!\_collection.ContainsKey(purchaseOrder.Id))
        {
            \_collection.Add(purchaseOrder.Id, purchaseOrder);
        }
    }

    public PurchaseOrder GetById(int id)
    {
        if (!\_collection.ContainsKey(id)) return null;
        return \_collection\[id\];
    }
}

public class AggregateTest
{
    \[Fact\]
    public void AddItemAboveLimitReturnsFalse()
    {
        var po = new PurchaseOrder() { SpendLimit = 100 };
        po.TryAddItem(new LineItem(50));
        var item = new LineItem(51);
        Assert.False(po.TryAddItem(item));
    }

    \[Fact\]
    public void UpdateItemAboveLimitReturnsFalse()
    {
        var po = new PurchaseOrder() { SpendLimit = 100 };
        po.TryAddItem(new LineItem(50));
        var item = new LineItem(25);
        po.TryAddItem(item);

        Assert.False(item.TryUpdateCost(51, po));
    }

    \[Fact\]
    public void UpdateItemAboveLimitReturnsFalseWithRepository()
    {
        var repo = new InMemoryPurchaseOrderRepository();

        var po = new PurchaseOrder() { SpendLimit = 100 };
        repo.Add(po);

        po.TryAddItem(new LineItem(50));
        var item = new LineItem(25);
        po.TryAddItem(item);

        Assert.False(item.TryUpdateCost(51, repo)); // no longer possible to use wrong PO
    }
}

## Aggregates and Domain Services

Most of the time, I prefer to move behavior from services into entities. However,  sometimes behavior really belongs in a service. When this occurs (and this example isn't necessarily indicative of this case), you can use the same pattern we just saw with passing in a repository as a parameter, but do so with a domain service. In this final example, both the aggregate root and child both will delegate behavior to a service that's passed in as a function argument. Internally, the service will use a repository when needed to get an instance of the PO.

public interface IPurchaseOrderService
{
    bool WouldAddBeUnderLimit(PurchaseOrder order, LineItem newItem);
    bool WouldUpdateBeUnderLimit(int purchaseOrderId, LineItem existingItem, decimal newCost);
}

public class PurchaseOrderService : IPurchaseOrderService
{
    private readonly IPurchaseOrderRepository \_purchaseOrderRepository;

    public PurchaseOrderService(IPurchaseOrderRepository purchaseOrderRepository)
    {
        \_purchaseOrderRepository = purchaseOrderRepository;
    }
    public bool WouldAddBeUnderLimit(PurchaseOrder order, LineItem newItem)
    {
        return order.Items.Sum(i => i.Cost) + newItem.Cost <= order.SpendLimit;
    }

    public bool WouldUpdateBeUnderLimit(int purchaseOrderId, LineItem existingItem, decimal newCost)
    {
        var po = \_purchaseOrderRepository.GetById(purchaseOrderId);
        // check for null, check if item belongs to PO
        return po.Items.Sum(i => i.Cost) + (newCost - existingItem.Cost) <= po.SpendLimit;
    }
}

public class PurchaseOrder // aggregate root
{
    public int Id { get; set; }
    private List<LineItem> \_items { get; } = new List<LineItem>();
    public IEnumerable<LineItem> Items => \_items.ToList();

    public decimal SpendLimit { get; set; }

    public bool CheckLimit(LineItem item, decimal newValue)
    {
        var currentSum = Items.Sum(i => i.Cost);
        decimal difference = newValue - item.Cost;

        return currentSum + difference <= SpendLimit;
    }

    public bool CheckLimit(LineItem newItem)
    {
        return Items.Sum(i => i.Cost) + newItem.Cost <= SpendLimit;
    }

    public bool TryAddItem(LineItem item, IPurchaseOrderService poService)
    {
        if (poService.WouldAddBeUnderLimit(this, item))
        {
            \_items.Add(item);
            return true;
        }
        return false;
    }
}

public class LineItem
{
    public int Id { get; set; }
    public int PurchaseOrderId { get; set; } // avoid having circular reference between aggregate and children
    public LineItem(decimal cost)
    {
        Cost = cost;
    }
    public decimal Cost { get; private set; }

    public bool TryUpdateCost(decimal cost, IPurchaseOrderService poService)
    {
        if (poService.WouldUpdateBeUnderLimit(PurchaseOrderId, this, cost))
        {
            Cost = cost;
            return true;
        }
        return false;
    }
}

public interface IPurchaseOrderRepository
{
    void Add(PurchaseOrder purchaseOrder);
    PurchaseOrder GetById(int id);
}

public class InMemoryPurchaseOrderRepository : IPurchaseOrderRepository
{
    private Dictionary<int, PurchaseOrder> \_collection = new Dictionary<int, PurchaseOrder>();
    public void Add(PurchaseOrder purchaseOrder)
    {
        if (!\_collection.ContainsKey(purchaseOrder.Id))
        {
            \_collection.Add(purchaseOrder.Id, purchaseOrder);
        }
    }

    public PurchaseOrder GetById(int id)
    {
        if (!\_collection.ContainsKey(id)) return null;
        return \_collection\[id\];
    }
}

public class DomainServiceTest
{
    private IPurchaseOrderRepository \_purchaseOrderRepo;
    private IPurchaseOrderService \_purchaseOrderService;

    public DomainServiceTest()
    {
        \_purchaseOrderRepo = new InMemoryPurchaseOrderRepository();
        \_purchaseOrderService = new PurchaseOrderService(\_purchaseOrderRepo);
    }

    \[Fact\]
    public void AddItemAboveLimitReturnsFalse()
    {
        var po = new PurchaseOrder() { SpendLimit = 100 };
        \_purchaseOrderRepo.Add(po);

        po.TryAddItem(new LineItem(50), \_purchaseOrderService);
        var item = new LineItem(51);
        Assert.False(po.TryAddItem(item, \_purchaseOrderService));
    }

    \[Fact\]
    public void UpdateItemAboveLimitReturnsFalse()
    {
        var po = new PurchaseOrder() { SpendLimit = 100 };
        \_purchaseOrderRepo.Add(po);
        po.TryAddItem(new LineItem(50), \_purchaseOrderService);
        var item = new LineItem(25);
        po.TryAddItem(item, \_purchaseOrderService);

        Assert.False(item.TryUpdateCost(51, \_purchaseOrderService));
    }
}

## What about Dependency Injection?

Why do we need to pass these around as method parameters - why don't we just inject services into our aggregate/entities? There are a lot of reasons to avoid going down this path. You want to be able to create you entities and value objects anywhere, without dependencies. They should be POCOs for this reason. Also, you'll run into all kinds of problems trying to get your ORM to give you properly configured entities if, in addition to state from your data store, it also needs to populate its dependent services. Generally when looking at the different types in my domain and whether or not they should support DI, I use the following breakdown:

- Entity (including Aggregate and AggregateRoot) - No
- Value Object - No
- Domain Event - No
- Specification - No
- Domain Service - **Yes**
- Domain Event Handler - **Yes**

## Additional Reading

I didn't go deep into the C# intricacies of double dispatch (and how it's handled in other languages). For more on that, I recommend checking out the following articles:

- [Double Dispatch is a Code Smell](https://lostechies.com/derekgreer/2010/04/19/double-dispatch-is-a-code-smell/) (very detailed; it's not always a code smell)
- [Strengthening Your Domain with the Double Dispatch Pattern](https://lostechies.com/jimmybogard/2010/03/30/strengthening-your-domain-the-double-dispatch-pattern/)
- [Double dispatch in C#](https://stackoverflow.com/questions/42587/double-dispatch-in-c)

This article is kicking of the [2018 C# Advent Calendar. Check out the calendar for additional C# articles this month.](https://crosscuttingconcerns.com/The-Second-Annual-C-Advent)
