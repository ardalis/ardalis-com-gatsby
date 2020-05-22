---
templateKey: blog-post
title: Nulls Break Polymorphism
path: blog-post
date: 2015-10-26T14:01:00.000Z
description: "Sir Charles Hoare has called it his “billion dollar mistake.” The
  .NET exception related to it is one of the most common, most hated, and often
  most useless exceptions the system provides (since the variable in question is
  never specified by the exception). "
featuredpost: false
featuredimage: /img/nulls-break-polymorphism-760x360.png
tags:
  - clean code
  - design patterns
  - exceptions
  - liskov substitution
  - lsp
  - "null"
  - solid
category:
  - Software Development
comments: true
share: true
---
[Sir Charles Hoare](https://en.wikipedia.org/wiki/Tony_Hoare) has called it his “billion dollar mistake.” The .NET exception related to it is one of the most common, most hated, and often most useless exceptions the system provides (since the variable in question is never specified by the exception). Yes, I’m talking about **null**. One of the reasons null references are so problematic in object-oriented programming languages like C# is that null references break polymorphism and violate the [Liskov Substitution Principle](http://deviq.com/liskov-substitution-principle/). This can easily be demonstrated with a simple example:

```
public class Program
{
    public static void Main(string[] args)
    {
        var employees = GetEmployees();
 
        foreach (var employee in employees)
        {
            Console.WriteLine("{0} {1}: {2} days", employee.FirstName,
        employee.LastName, employee.TenureInDays());
        }
        Console.ReadLine();
    }
 
    private static List<Employee> GetEmployees()
    {
        var employees = new List<Employee>();
        employees.Add(new Employee()
        {
            FirstName = "Steve",
            LastName = "Smith",
            DateHired = new DateTime(2014, 6, 1)
        });
        employees.Add(new Employee()
        {
            FirstName = "John",
            LastName = "Doe",
            DateHired = new DateTime(2015, 6, 1),
            DateTerminated = new DateTime(2015, 7, 1)
        });
        employees.Add(GetEmployee());
        return employees;
    }
 
    private static Employee GetEmployee()
    {
        return null;
    }
}
 
public class Employee
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public DateTime DateHired { get; set; }
    public DateTime? DateTerminated { get; set; }
 
    public int TenureInDays(DateTime? currentDate = null)
    {
        DateTime endDate = currentDate ?? DateTime.Now;
        if (DateTerminated.HasValue)
        {
            endDate = DateTerminated.Value;
        }
        return (endDate - DateHired).Days;
    }
}
```

Look first at the main method. It’s relying on the language to provide it with instances of type Employee for each iteration through the foreach loop. The compiler will even “guarantee” that indeed the type of employee is Employee, and not some other kind of object that might cause a mismatch. However, the above code fails, even though it’s not even trying to be polymorphic (with multiple sub-classes of Employee).

At the root of the problem is the assumption in .NET that all types, and therefore all instances of types, are objects. Specifically, they inherit from System.Object. However, this is not true for null instances, which cannot be substituted for their non-null counterparts (hence the LSP violation). The language has developed a number of workarounds for this deficiency since its introduction:

## Null Coalescing Operator

The ?? (null coalescing) operator will return the left side of the expression if it isn’t null, otherwise it will return the right side. It can replace longer conditional expressions, though it can’t be used to access properties of the potentially-null instance.

```
return Foo ?? "Undefined"; // cannot be used with value types
```

## Null Conditional

Also known as the [Safe Navigation Operator](http://blogs.msdn.com/b/jerrynixon/archive/2014/02/26/at-last-c-is-getting-sometimes-called-the-safe-navigation-operator.aspx).

```
if(foo?.Length > 0) // first checks if foo != null, then accesses property
{}
```

These new features certainly help us to deal with nulls, but they don’t address the underlying problem. What if we could define a type as non-nullable? Unfortunately, [implementing non-nullable types in C#](http://twistedoakstudios.com/blog/Post330_non-nullable-types-vs-c-fixing-the-billion-dollar-mistake) is a very difficult problem, and not one I expect to see corrected in the near future.

## Extension Methods

Perhaps ironically, since usually static methods make code *less* flexible, extension methods can actually allow you to do some things with null objects that instance methods will not. For instance, while the original foreach loop above results in a null exception when one is encountered in the collection of Employees, displaying the employees using an extension method like this one:

```
public static class EmployeeExtensions
{
    public static string ToDisplayString(this Employee employee)
    {
        if(employee != null)
        {
            return String.Format("{0} {1}: {2} days", employee.FirstName,
        employee.LastName, employee.TenureInDays());
        }
        return "Unknown employee";
    }
}
```

works just fine. And here’s the calling code:

```
var employees = GetEmployees();
 
foreach (var employee in employees)
{
    Console.WriteLine(employee.ToDisplayString());
}
```

This is still very clean – cleaner than the original code, I would say – and now is immune to null reference exceptions. Extension methods can be very useful for performing validation on variables and parameters that may be null, and for performing null-safe formatting or mapping of types. Keep them in mind as one more weapon in your fight against null reference exceptions (though be careful with them as they may lead you to violate the [Tell Don’t Ask principle](http://deviq.com/tell-dont-ask/)).

## Null Object Pattern

The [Null Object Design Pattern](http://deviq.com/null-object-pattern/) is another way to deal with nulls (by not dealing with them, by not returning them). It works by substituting an actual type in place of null, and simply ensuring its properties and methods encapsulate the behavior that the application would need if it encountered a null instance. For example, integer properties might return 0, string properties might return “Not found” or “Not set”, etc. Typically the null object is defined as a named, static property of the type it represents, so you might refer to it using syntax like Customer.NotFound or Color.NotSet. Consistent use of the Null Object Pattern can greatly simplify the need for null checks throughout a codebase.

## Summary

Nulls are a huge source of exceptions and bugs in many programming languages today. The code required to try to check for and properly handle cases where an instance is null often exceeds the code needed for the non-null case. Avoiding the use of and reliance upon nulls within your applications by using patterns like the Null Object pattern can reduce the amount of repetitive code needed throughout your codebase, and extension methods can also be used in some scenarios.