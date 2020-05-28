---
templateKey: blog-post
title: Prefer Custom Exceptions to Framework Exceptions
path: blog-post
date: 2017-05-10T02:59:00.000Z
description: An easy way to make your software easier to work with, both for
  your users and for developers, is to use higher level custom exceptions. Low
  level exceptions like NullReferenceException or ArgumentNullException should
  rarely be returned from business-level classes, where most of your custom
  logic should reside.
featuredpost: false
featuredimage: /img/aspnetcore-logo.png
tags:
  - antipattern
  - clean code
  - ddd
  - dddesign
  - dotnet
  - exceptions
category:
  - Software Development
comments: true
share: true
---
An easy way to make your software easier to work with, both for your users and for developers, is to use higher level custom exceptions. Low level exceptions like NullReferenceException or ArgumentNullException should rarely be returned from business-level classes, where most of your custom logic should reside. By using custom exceptions, you make it much more clear to everybody involved what the actual problem is.

For example, let’s say you’re writing an application that works with a database. Perhaps it’s an [ASP.NET Core application](http://aspnetcorequickstart.com/) in the medical or insurance industry, and it references individual customers as Subjects. Within some business logic dedicated to creating an invoice, recording a prescription, or filing a claim, there’s a reference to the Subject Id that is invalid. When your data layer makes the request and returns from the database, the result is empty.

`// get subject`\
`var subject = GetSubject(subjectId);`\
`subject.DoSomething();`

Obviously in the code above, if Subject is null, the last line is going to throw an exception (you can avoid this by using the[Null Object Pattern](http://deviq.com/null-object-pattern/)). Let’s further assume that we can’t handle this exception here – if the subject id is incorrect, there’s nothing else for this method to do but throw an exception, since it was going to return the subject otherwise. The current behavior for a user, tester, or developer is this:

`Unhandled Exception:`\
`System.NullReferenceException: Object reference not set to an instance of an object.
...`

One of the most annoying things about the NullReferenceException is that it is so vague. It never actually specifies which reference, exactly, was not set to an instance of an object. This can make debugging, or reporting problems, much more difficult. In the above example, we’re not specifically throwing any exception, but we are allowing a NullReferenceException to be thrown in the event that we’re unsuccessful in looking up a Subject for a given ID. It’s still a part of our design to rely on NullReferenceException, though in this case it’s implicit. What if instead of returning null from GetSubject we threw a SubjectNotFoundException? Or if we weren’t sure that an exception made sense in every scenario, what if we checked for null and then threw a better exception before moving on to work with the returned subject, like in this example:

`// get subject var subject = GetSubject(subjectId);`\
`if (subject == null) throw new SubjectNotFoundException(subjectId);`\
`subject.DoSomething();`

If we don’t follow this approach, and instead we let the NullReference propagate up the stack, it’s likely (if the application doesn’t simply show a Yellow Screen of Death or a default Oops page) that we will try to catch NullReferenceException and inform the user of what might be the problem. But by then we might be so far removed from the exception that even we can’t know for sure what might have been null and resulted in the exception being thrown. Raising a more specific, higher level exception makes our own exception handlers much easier to write.

## Writing Custom Exceptions

Custom exceptions are actually very easy to write. All you need to do is inherit from Exception and name them with an Exception suffix. I recommend for very specific ones that you also provide a default message, so that you don’t need to provide a message every time you throw the exception. You can also include additional parameters if that’s useful. If your exception is in response to a lower level one, be sure to provide a constructor parameter for innerException so that you can pass that in as well. Here’s how you might implement the SubjectNotFoundException described above:

`public class SubjectDoesNotExistException : Exception {
    public SubjectDoesNotExistException(int subjectId)
        : base($"Subject with ID "{subjectId}" does not exist.")     { }
}`

This example uses *constructor chaining* to pass arguments from its constructor to its base constructor (in this case, the base constructor accepts a string message). Now in the example above, with no error handling in place, the user will get a message stating “Subject with ID 123 does not exist.” instead of “Object reference not set to an instance of an object.” which is far more useful for debugging or reporting purposes. In general, you should avoid putting custom logic into your custom exceptions. In most scenarios, custom exceptions should consist only of a class definition and one or more constructors that chain to the base Exception constructor.

If you follow domain-driven design, I recommend placing most of your business-logic related exceptions in your Core project, with your domain model. You should be able to easily unit test that these exceptions are thrown when you expect them to be, from your entities and services.