---
templateKey: blog-post
title: Tight Coupling, Legos, and Super Glue
path: blog-post
date: 2010-02-07T12:54:00.000Z
description: "Building software applications is sometimes compared with building
  structures out of smaller components. The children's toys, Legos (and their
  generic brethren), come to mind and in fact make for a good analogy. Given a
  set of components with varying characteristics "
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - software application
category:
  - Uncategorized
comments: true
share: true
---
Building software applications is sometimes compared with building structures out of smaller components. The children's toys, Legos (and their generic brethren), come to mind and in fact make for a good analogy. Given a set of components with varying characteristics (shape, color, etc, or in the case of software, objects with different behavior and state), it is possible to connect the components in order to create a larger structure, with (hopefully) more advanced capabilities.

The reason Legos can connect to other Legos is because of the raised cylinders that correspond with similarly shaped cavities in the bottoms of the pieces. These comprise the ***interface*** that allows these Legos to connect to one another. The beauty of Legos' design is that they have a very abstract interface that allows countless concrete implementations of Lego pieces to be connected, and swapped out in the future for other implementations. An individual Lego piece has no knowledge of any specific details of the piece(s) that can connect to it – it's a very clean abstraction and as a result Lego pieces are naturally ***loosely coupled*** with one another.

![legos and super glue](/img/legos-and-super-glue.jpg)

In software, this kind of loose coupling is achieved only when individual components have this same ignorance about their collaborators as Legos have. As soon as one of your classes knows exactly which concrete class it will call, it is **tightly coupled** to that class. You can certainly build working applications in this way, just as you can build Lego structures with super glue. In fact, with enough super glue, you don't even have to use the built-in abstraction provided by the Legos' interface – you can glue them side-to-side if you want. However, when you're done, you had better be happy with the result, because changing it will be a very painful process. Swapping out one component for another now becomes a great deal of work, with a lot of breaking and re-gluing required.

I asked my 7-year-old about whether it was a good idea to use super glue when building things with Legos. She responded, "No, then you wouldn't be able to take them apart and build something else." Of course! How obvious! Now ask yourself whether it makes sense to write code that is tightly coupled to its collaborators. It's incredibly easy to do.

In fact my analogy with Legos breaks down here, as it's often easier to glue together software components than to achieve the same results with loose coupling, especially if you're not familiar with the latter way of doing things; maybe by default one builds software with glue and bits of material, and it's only through experience and some good design skills that one creates Lego-like interfaces in the materials.

In the interests of providing some code to demonstrate my point, consider something as simple as sending an email to a customer to confirm their order. Perhaps you've written a simple business object to represent the Cart, and it has a Checkout() method (I use this same example in my article on [avoiding dependencies](/avoiding-dependencies)). You might do something like this:

```csharp
public void Checkout()
{
    // Do some other stuff
    System.Net.Mail.MailMessage myMessage =
         new MailMessage("store@acme.com",
           "someuser@domain.com",
           "Order Confirmation",
           "Your Order Was Received.");
   SmtpClient mySmtpClient = new SmtpClient("localhost");
   mySmtpClient.Send(myMessage);
}
```

Clearly, we've super-glued the functionality of emailing the user to the Checkout behavior of the shopping cart. It is now absolutely impossible, without going in and hacking around in the Checkout() method (thus violating the Open/Closed Principle), to change this behavior. What if the user has stated in the preferences that they do not want to receive an email? What if some users would prefer to get a text message notification? What if you want to add logging so that you know when and to whom you sent the message? Any of these will require changes to Checkout, and all of them introduce additional logic to the Checkout method **that has absolutely nothing to do with Checkout()'s main function**.

The solution to this specific problem is to use [Dependency Injection and the Strategy Pattern as described in my Avoiding Dependencies article](/avoiding-dependencies). By doing so, your `Checkout()` method will be much simpler, and will not be super-glued to any particular message-sending implementation:

```csharp
// Mailer's type is an interface.  Mailer is a class level field
public void Checkout()
{
    // Do some other stuff
    Mailer.SendMail("someuser@domain.com", "store@acme.com",
        "Order Confirmation", "Your Order Was Received.");
}
```

Of course, even this implementation might not afford us the ultimate in flexibility. What if the customer really does want a text message? How can we ensure that this method is as flexible as possible?

There are two answers to this. The first one is, YAGNI. You Aren't Gonna Need It. If in fact today all of your customers are perfectly happy with email confirmations, then there is little compelling reason to further abstract the message-sending part of your application. The above is loosely coupled enough that you could do so later without too much effort.

The second answer, assuming you really do need to do this, is to abstract notifications from sending emails. In this case, it might make sense to simply pass the entire contents of the Cart to a NotificationService, and leave the details of how this notification is achieved to the service. In this case the code might look something like this, where NotificationService is a class level variable of type INotificationService:

```csharp
public void Checkout()
{
    // Do some other stuff
    NotificationService.NotifyCheckout(this);
}
```

Now if the details of how you choose to notify customers (or not) change, they can easily be adjusted within the implementation of NotificationService. Further, you might have separate instances of NotificationService depending on the specifics of how you want to notify customers, be it via Email, Text Message, Twitter, or some aggregation of these various techniques. It would also be simple to create a LoggingNotificationService that added logging capabilities, again without having to change any of the specifics about how notifications are achieved, or how Carts are checked out.

## Build Great Apps, But Expect To Change Them

![lego tower](/img/lego-tower.jpg)

You're creating great software applications. You're making your business money, or saving it money, or both by providing better ways to work with data or to acquire new customers. You know that how your application works today will not be the best way it could work next year, so don't super-glue the pieces together. Write your software in a loosely-coupled fashion that, like Legos, allows the various pieces to be broken apart easily and reassembled in a way that might make more sense in response to changing business requirements. Your customers will be happier, and so will you, since it's far more fun to build things with Legos than to try and pry them apart after some jerk has super-glued them all together.
