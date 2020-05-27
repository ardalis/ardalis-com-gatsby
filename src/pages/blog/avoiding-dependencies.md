---
templateKey: blog-post
title: Avoiding Dependencies
path: blog-post
date: 2008-09-17T16:35:00.000Z
description: I gave a one day class to about 20 developers today introducing
  Microsoft .NET, C#, and ASP.NET. As it was only one day and there were no
  hands-on labs, coverage was necessarily cursory, but overall things went very
  well.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Dependencies
category:
  - Uncategorized
comments: true
share: true
---
I gave a one day class to about 20 developers today introducing Microsoft .NET, C#, and ASP.NET. As it was only one day and there were no hands-on labs, coverage was necessarily cursory, but overall things went very well.

In the course of discussing the Base Class Library and specifically the areas of logging and sending emails (System.Diagnostics and System.Net), I was careful to emphasize to the class that they should definitely avoid making direct calls to these namespaces’ members for their logging and emailing needs. Instead, they should encapsulate their dependency on these classes using one of two patterns (and I’m inclined to favor the latter).**Specifically with regard to email, I gave the example that testing the application in a staging environment might really send out emails if there were no way to swap out that functionality.**It was clear from their reactions that several of the developers in the room could directly relate to this scenario.

Before showing the fix, let me demonstrate the problem by way of example. Let’s say you have a need to send emails in your application. You might have the following code inside a Cart class as part of an online store.

**Tightly Coupled Code**

C#

```
public void Checkout()
{
    // Do some other stuff
 
    System.Net.Mail.MailMessage myMessage =
        new MailMessage("store@acme.com",
            "someuser@domain.com",
            "Order Confirmation",
            "Your Order Was Received.");
    SmtpClient mySmtpClient = new SmtpClient("localhost");
    mySmtpClient.Send(myMessage);}
}
```

This works. It’s simple. The problem is, it’s quite inflexible and it’s tightly coupled to System.Net.Mail. If you have code like this all over your application, and you find a need to switch to another class for sending emails (which anyone who depended on System.Web.Mail should relate to, as it’s been deprecated in favor of System.Net.Mail now), you’ll have to touch many different parts of your application to make that one change. That definitely violates the [DRY principle](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself).

**Facade Pattern ([reference](http://en.wikipedia.org/wiki/Facade_Pattern))**

Create a simple wrapper of the functionality required, exposing only those methods needed by your application. This has the effect of simplifying the API as well as limiting the dependency on the underlying class to one location. The resulting wrapper need not be static, but if we take a very simple example that sends an email, it might look like this:

```
public static class Mailer
{
    public static void SendMail(string To, string From,
        string Subject, string Body)
    {
        System.Net.Mail.MailMessage myMessage =
            new MailMessage(From, To, Subject, Body);
        SmtpClient mySmtpClient = new SmtpClient("localhost");
        mySmtpClient.Send(myMessage);
    }
}
```

With this wrapper class in place, the original tightly coupled code could be written simply as follows:

```
public void Checkout()
{
    // Do some other stuff
 
    Mailer.SendMail("someuser@domain.com", "store@acme.com",
        "Order Confirmation", "Your Order Was Received.");
}
```

**Strategy Pattern** ([reference](http://en.wikipedia.org/wiki/Strategy_pattern))

The Strategy pattern essentially describes one of the most common techniques for performing [Dependency Injection](http://en.wikipedia.org/wiki/Dependency_injection). Using the Strategy pattern to eliminate the dependency on System.Net.Mail, we would define an interface and then push that interface into the constructor of the class that currently is carrying the dependency. So if we imagine that this Checkout() method resides on a Cart class, we would modify the Cart class to include a private member variable of the interface’s type and create one or more constructors allowing this interface to be passed in when the object is created. Within the constructor, the local instance of the interface is assigned to the one being passed in. This is rather more involved, but far more powerful, than the simple static wrapper class approach, and has other benefits as well (like support for swapping out implementations without having to rebuild the application).

Let’s start with the interface. All we need it to do at the moment is send email, so we’ll call it ISendEmail.

```
public interface ISendEmail
{
    void SendMail(string To, string From, string Subject, string Body);
}
```

Now we can create a class that implements this interface. The Mailer class nearly does so – removing the static keywords does the trick (and noting adding the reference to the dependency, of course). We’ll also rename it so it’s clear that it really is sending mails via SMTP.

```
public class LiveSmtpMailer : ISendEmail
{
    public void SendMail(string To, string From, string Subject, string Body)
    {
        System.Net.Mail.MailMessage myMessage =
new MailMessage(From, To, Subject, Body);
        SmtpClient mySmtpClient = new SmtpClient("localhost");
        mySmtpClient.Send(myMessage);
    }
}
```

Next we need to modify the Cart to accept an ISendEmail instance via its constructor.

```
public class Cart
{
    private ISendEmail emailProvider;
    public Cart()
    {
        emailProvider = new LiveSmtpMailer();
    }
 
    public Cart(ISendEmail emailProvider)
    {
        this.emailProvider = emailProvider;
    }
}
```

Notice that the parameterless constructor now sets the ISendEmail local instance to LiveSmtpMailer, so its behavior remains unchanged by default. If you have existing code that has hard dependencies on concrete implementations, you can leave their functionality in place using this technique, but still provide the capability to alter the behavior by adding additional constructor overloads (or, alternately, property setters).

At this point we’re done. But for the latter case let’s go one step further and say we want to write a test for Checkout(). In the original and in the Facade pattern implementation, there is no way to remove the dependency on System.Net.Mail from the code as it is written. Thus, any tests written would need to be hacked to look for Smtp connection exceptions, or worse, they might actually send out emails. Compare that with the Strategy / Dependency Injection approach, which can easily be tested by mocking ISendEmail or by creating a simple test stub, like the following.

```
public class TestStubEmailer : ISendEmail
{
    public int MessagesSent;
    public string LastMessageTo;
    public string LastMessageFrom;
    public string LastMessageSubject;
    public string LastMessageBody;
 
    public void SendMail(string To, string From, string Subject, string Body)
    {
        MessagesSent++;
        LastMessageTo = To;
        LastMessageFrom = From;
        LastMessageSubject = Subject;
        LastMessageBody = Body;
    }
}
```

Writing the test is now a simple matter.

```
[Test]
public void CheckOutTest()
{
    string testTo = "test@test.com";
    string testFrom = "test2@test2.com";
    string testSubject = "Test Subject";
    string testBody = "Test Body";
    TestStubEmailer myEmailer = new TestStubEmailer();
    Cart myCart = new Cart(myEmailer);
    myCart.Checkout();
    Assert.AreEqual(testTo, myEmailer.LastMessageTo);
    Assert.AreEqual(testFrom, myEmailer.LastMessageFrom);
    Assert.AreEqual(testSubject, myEmailer.LastMessageSubject);
    Assert.AreEqual(testBody, myEmailer.LastMessageBody);
    Assert.AreEqual(1, myEmailer.MessagesSent);
}
```

**Not Just For Testing**

But there’s more benefit from the Strategy pattern approach than just testing. In fact, let me revisit the initial problem being discussed, which is that the application should not really send out emails when it is being tested, but there should be some way for the developers to know that emails would have been sent. Using the Strategy pattern approach (and especially if you couple it with an IoC container to make things easy), it would be a simple matter to have the default implementation of ISendEmail depend on a configuration setting. In a Stage environment, an implementation of ISendEmail that actually just logs the messages to an event log could be configured, while in production the configuration could wire up the actual LiveSmtpMailer class. Never again would you need to worry about accidentally sending emails out to customers while testing the application from the stage server. Clearly the result is more flexible code that is easier maintain, configure, and test.

It’s only been in the last year or so that I’ve really fallen in love with the Strategy pattern. Capabilities like this, as well as the ability to potentially swap out implementations using configuration or IoC containers, make it a much more flexible approach than simply inserting a concrete Facade class between the dependency and its consumers (which is how I typically approached the problem previously). If you find yourself struggling to remove dependencies in your application, the Strategy pattern as shown here may be helpful for you.

**Update**: Part 2 wraps up with the [Strategy Pattern With Ninject](https://ardalis.com/strategy-pattern-with-ninject)