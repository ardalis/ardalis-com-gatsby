---
templateKey: blog-post
title: Entity Framework Core String Interpolation FromSql
path: blog-post
date: 2017-08-22T21:41:00.000Z
description: >
  String interpolation is one of my favorite features in C# 6. It lets us
  replace this kind of code:
featuredpost: false
featuredimage: /img/ef-core-string-interpolation.png
tags:
  - .net core
  - ef core
  - entity framework
category:
  - Software Development
comments: true
share: true
---
String interpolation is one of my favorite features in C# 6. It lets us replace this kind of code:

```
Console.WriteLine("{0} had a balance of {1}", customer.Name, customer.Balance);
```

with this:

```
Console.WriteLine($"{customer.Name} had a balance of {customer.Balance}");
```

In Entity Framework Core 1.x, you could use string interpolation for SQL queries, but it would just perform literal string interpolation. For example, consider this code:

```
string city = "London";
var londonCustomers = context.Customers
    .FromSql($"SELECT * FROM Customers WHERE City = {city}");
```

This will result in the literal SQL string:

```
SELECT * FROM Customers WHERE City = London
```

Running this on your database is likely to result in an error like this one:

```
Unhandled Exception: System.Data.SqlClient.SqlException: Invalid column name 'London'.
```

Of course, you could fix this by adding quotes, but YOU REALLY SHOULD NOT BE DOING THIS BECAUSE [SQL INJECTION](https://xkcd.com/327/).

So, what does Entity Framework Core 2.0 add to this conversation? What they could have done is tried to protect developers from going down this path by adding a warning or something if they noticed you were trying to compose your query using string interpolation (instead of using parameters, as one should). However, what they did is even better, and I think pretty amazing. They automatically convert the query to do the right thing. Take the exact code I showed running against EF Core 1.1 and run it using EF Core 2.0 and you’ll get this SQL generated:

```
SELECT * FROM Customers WHERE City = @p0
```

Check out this log output:

![](/img/ef-core-string-interpolation.png)

Kudos to the EF Core team for this cool feature that makes custom SQL queries safer and easier to use, using the default modern C# language features. However, there are some caveats. This only works if you create the query as I’ve shown here. If you build the query string somewhere else, it’s easy to still avoid query parameterization (and thus incur sql injection attack risks). [Nick Craver has a small sample](https://github.com/NickCraver/EFCoreInjectionSample/blob/master/Program.cs) showing a few of the different ways you can build queries with string interpolation demonstrating these risks.

I created a simple test application that demonstrates this feature – you can [grab it on GitHub](https://github.com/ardalis/EFCoreStringInterpolationDemo). Point it at a local copy of Northwind, or modify it slightly to point at your own database. See what happens when you change the two packages from 2.0.0 to 1.1.0 and back.