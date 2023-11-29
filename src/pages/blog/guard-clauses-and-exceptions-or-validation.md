---
templateKey: blog-post
title: Guard Clauses and Exceptions or Validation?
date: 2022-01-18
description: Guard Clauses provide an elegant way to ensure code inputs are valid, typically by throwing exceptions. Validation provides a solution to a similar problem, typically without the use of exceptions. When does it make sense to use each of these techniques?
path: blog-post
featuredpost: false
featuredimage: /img/guard-clauses-and-exceptions-or-validation.png
tags:
  - software architecture
  - software design
  - software engineering
  - guard clauses
  - .net
  - validation
  - exceptions
category:
  - Software Development
comments: true
share: true
---

Guard Clauses provide an elegant way to ensure code inputs are valid, typically by throwing exceptions. Validation provides a solution to a similar problem, typically without the use of exceptions. When does it make sense to use each of these techniques?

This article is a response to a question I received from one of [my tips newsletter](/tips) subscribers, [Chad Boettcher](https://chadboettcher.com/). He asked:

> I just have a quick question – well, I have many questions, but I’ll start with this one: I’m implementing several value objects and I’m torn between using Guard clauses for validation vs returning an [Ardalis.Result](https://www.nuget.org/packages/Ardalis.Result/).  One thing that I haven’t seen any example of is checking for the max string length in the various fields so I find myself wanting to using the result with all of the validation errors returned in the result rather than throwing an exception for each field so that the user gets all of the validation errors at once rather than one at a time...

I answered Chad via email, but he gave me permission to share his question and name so I could credit him when I wrote up a more detailed answer in this article.

**Update: 29 Nov 2023**: I recorded a YouTube video on the topic, [When to Validate and When to Throw Exceptions?](https://youtu.be/dpPcnAT7n7M)

## What is a Guard Clause?

A [guard clause](https://deviq.com/design-patterns/guard-clause) is just a technique for failing fast in a method, especially in a constructor. If a method (or object instance) requires certain values in order to function properly, and there's no way the system should ever try call the code with invalid inputs, then an exception-throwing guard clause makes sense.

Code without a guard clause:

```csharp
public int DoSomething(string requiredInformation)
{
  string server = requiredInformation.Substring(2,10);
  // other code
  return result;
}
```

Obviously this code will fail with a null or empty string, as well as strings that aren't at least 13 characters long. You can address this problem with a try/catch:

```csharp
public int DoSomething(string requiredInformation)
{
  try
  {
    string server = requiredInformation.Substring(2,10);
    // other code
    return result;
  }
  catch
  {
    return 0; // some default or error-indicating value
  }
}
```

While this can work, it doesn't help you to identify where the errant code is that is allowing the call with the invalid input.

Another non-guard clause approach would look like this:

```csharp
public int DoSomething(string requiredInformation)
{
  if(requiredInformation != null)
  {
    if(requiredInformation.Length > 12)
    {
      string server = requiredInformation.Substring(2,10);
      // other code
      return result;
    }
    else
    {
      throw new ArgumentException("Must be at least 13 characters long.");
    }
  }
  else
  {
    throw new ArgumentNullException(nameof(requiredInformation));
  }
}
```

The big problem with this one is how verbose it is. And it only gets worse with more than one parameter to check. To convert it to use guard clauses, simply invert the if statements and eliminate the else clauses.

```csharp
public int DoSomething(string requiredInformation)
{
  if(requiredInformation == null) throw new ArgumentNullException(nameof(requiredInformation));
  if(requiredInformation.Length <=> 12) throw new ArgumentException("Must be at least 13 characters long.");
  
  string server = requiredInformation.Substring(2,10);
  // other code
  return result;
```

If you want a standard way to work with guard clauses in your app, check out my nuget package, [Ardalis.GuardClauses](https://www.nuget.org/packages/Ardalis.GuardClauses), which have over 3M downloads as I'm writing this.

## Exceptions

We just saw how guard clauses work. They allow execution in methods to **fail fast** by immediately exiting (with an exception) when a problem is detected. This is appropriate for conditions **that should never happen** under normal circumstances in your code. In the example above, other code should already have ensured that the input string existed and was valid prior to the method in question being executed. By the time the application got to the point where it was ready to call the `DoSomething` method, the expectation is that it has everything it needs to do so. If it doesn't, something has gone terribly wrong and the application should not try to continue. It should abort the current operation, log the exception, and present the user with some friendly error message (and hopefully notify the dev team that there's a problem that must be addressed).

Guard clauses that throw exceptions are appropriate for *exceptional* circumstances. They're not appropriate for things like user input validation in which invalid inputs are *expected*, not *exceptional*.

## Validation

Validation is used to help prevent the inadvertent or malicious input of invalid data into the system. In many cases, to improve the user experience, it makes sense to validate a large number of data value, one by one and perhaps collectively, and then present the user with all cases of invalid data in a single operation. This is the opposite of the "fail fast" approach of guard clauses, and exceptions are not well-suited to this use case.

Can you use exceptions (and potentially guard clauses) to perform validation? Yes, of course, and I'm sure many system do so. But it shouldn't be your first choice for the reasons set forth here:

- Such validation failures are not exceptional. They're expected.
- Exceptions are expensive, in terms of performance
- Catching single exceptions and returning validation problems to the user one by one creates a poor user experience.
- Exceptions break program execution, and trying to code around this to collect multiple validation failures requires coding against the idiomatic usage of exceptions and exception handlers.

I'm a big fan of the [FluentValidation library](https://www.nuget.org/packages/FluentValidation/), and it's my preferred way of dealing with validation that goes beyond the basic [ASP.NET MVC model validation](https://docs.microsoft.com/aspnet/core/mvc/models/validation) support (as well as validation that belongs in your [DDD domain model](https://www.pluralsight.com/courses/fundamentals-domain-driven-design)).

## What about partially created types from caught exceptions

Chad also pointed out a potential problem when writing code like this in a constructor:

```csharp
public Customer(string firstName, string lastName)
{
  FirstName = Guard.Against.NullOrEmpty(firstName);
  LastName = Guard.Against.NullOrEmpty(lastName);
}
```

Ardalis.GuardClauses supports direct assignment from guard clauses, as shown in the listing above. Alternately, you can check each input, and then assign it, but that's more code:

```csharp
public Customer(string firstName, string lastName)
{
  Guard.Against.NullOrEmpty(firstName);
  Guard.Against.NullOrEmpty(lastName);

  FirstName = firstName;
  LastName = lastName;
}
```

In the first scenario, it might be possible to produce an instance of Customer with no LastName but otherwise correctly created:

```csharp
Customer customer;
try
{
  customer = new Customer("Ardalis", null);
}
catch {}

var output = customer.GetFullName(); // likely to fail since LastName is null
```

It's worth pointing out that one could apply the same try/catch statement to a type that does all of the checks first, and then the assignments, with the only difference being that no fields will have been assigned. I'm not sure that's that much better. But in any case, **don't do this**. There's no (good) reason to ignore the explicit guard clauses in the constructor of a type in your production code. I could imagine *maybe* someone would need this in a test scenario, but I would suggest any number of alternatives before this one. Use a mock. Use a fake. Create an alternate constructor. Use reflection to set the state of a valid instance of the object. But don't ignore constructor exceptions and expect to have a valid object instance as a result.

## Summary

Both guard clauses and validation frameworks perform input validation. The difference boils down to whether the invalid input is expected and part of the user experience, or unexpected. Only use exceptions for unexpected cases, and use a decent validation framework (like FluentValidation or ASPNET's model validation) for expected problems with incoming data.
