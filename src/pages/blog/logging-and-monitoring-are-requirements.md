---
templateKey: blog-post
title: Logging and Monitoring are Requirements
path: blog-post
date: 2017-08-08T21:57:00.000Z
description: It’s common in many applications to see logging and monitoring
  added into the code as an afterthought. It’s rarely included in the
  specification for a feature or product, and it’s rarely tested.
featuredpost: false
featuredimage: /img/logging-and-monitoring-are-requirements.png
tags:
  - clean code
  - refactoring
  - testing
category:
  - Software Development
comments: true
share: true
---
It’s common in many applications to see logging and monitoring added into the code as an afterthought. It’s rarely included in the specification for a feature or product, and it’s rarely tested. Thus, it’s often inconsistently implemented. One approach to addressing this is to use techniques like [AOP](https://en.wikipedia.org/wiki/Aspect-oriented_programming) to broadly and consistently add logging via rules. However, this often falls short and doesn’t provide custom implementations that are frequently needed for specific, one-off scenarios. A better approach is to treat these requirements like actual Requirements, and verify they work with automated tests just like you (should) do with any other functional requirement.

Does this mean you should be verifying that every log statement in your code is doing what it should be? Probably not. But you should be prepared to verify that the ones that are critically important when something goes wrong in production are doing what they should. That’s just common sense, and again it’s a reason why just throwing automated log-every-method-call automation at your code is probably insufficient.

When you unit test a method, you typically want to test the “happy path”, which occurs when inputs are what you expect, things go smoothly, and the method returns or exits successfully. You should also consider one or more “sad paths” that may occur. What does the function do when inputs aren’t what you expect? What happens if a function your function calls raises an exception? If things go wrong, should the function handle the problem? Ignore it and let it bubble up? Return ‘false’? Whatever the behavior, you should write tests to document it.

Now that you’re documenting what should happen when things go wrong, this is often the place where logging and monitoring Requirements come into play. Perhaps you have a logging Requirement that states that any exception should be logged as an error. If you’re testing the error handling code in a function, that code should be logging the error. And you should be writing a unit test to prove that it is doing so properly.

What if the requirement includes different behavior based on environment or other details? For instance, maybe in development the logger should just no-op, but in production it should log to a database and send an email to the support team? For this, you can also write tests, but they will be integration tests. You won’t necessarily need as many of them, but it’s worthwhile to have a few to confirm things like:

1. When the logger logs an error in the production environment, it sends (or attempts to send) an email to the proper alias.
2. When the logger logs an error in the production environment, it inserts a new row into the exceptions table in the database.
3. When the logger logs an error in the development environment, it doesn’t send an email or write to the database.

You can probably write these tests once for the whole logging configuration subsystem, and then maybe just add another one or two tests for specific scenarios if you want to have more confidence they’re working properly.

Ok, so now you understand why you should treat certain logging requirements as Requirements, and thus you should verify they are working with tests. But your logging system isn’t (easily) testable. Maybe you have a static method call you use everywhere. Maybe you’re using the extension methods on the built-in [ILogger<T> in ASP.NET Core, which are difficult to test directly and painful to test through the non-extension methods](https://github.com/aspnet/Logging/issues/611). The solution to these pain points is to [refactor](https://www.pluralsight.com/courses/refactoring-fundamentals) your code, and to start treating logging like any other dependency your system has. Follow [SOLID principles](https://www.pluralsight.com/courses/principles-oo-design) to help keep your dependency on any particular logging implementation from spreading throughout your application, and don’t directly couple your functions to logger calls by using static methods (including extension methods).

In my next post, I’ll show some of the pain involved in testing logging when using extension methods, and how to refactor to overcome this code smell.