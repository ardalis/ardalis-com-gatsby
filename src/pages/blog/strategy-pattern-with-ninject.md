---
templateKey: blog-post
title: Strategy Pattern With Ninject
path: blog-post
date: 2008-09-24T15:39:00.000Z
description: This is a follow-up to my post about avoiding dependencies with
  design patterns. It left off with something like this as a Cart object that
  uses the Strategy pattern to avoid a direct dependency on SMTP emails.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Ninject
category:
  - Uncategorized
comments: true
share: true
---
This is a follow-up to my post about [avoiding dependencies with design patterns](https://ardalis.com/avoiding-dependencies). It left off with something like this as a Cart object that uses the Strategy pattern to avoid a direct dependency on SMTP emails.

```
public class Cart
{
    private ISendEmail emailProvider;
    //public Cart()
    //{
    //    emailProvider = new LiveSmtpMailer();
    //}
 
    public Cart(ISendEmail emailProvider)
    {
        this.emailProvider = emailProvider;
    }
 
    public void Checkout()
    {
        // Do some other stuff
 
        this.emailProvider.SendMail("someuser@domain.com", "store@acme.com",
           "Order Confirmation", "Your Order Was Received.");
    }
}
```

Note that I’ve commented out the default constructor – I’ll explain why in a moment.

The next logical step in this series is to avoid the requirement of hard-coding in the class its default behavior of using a LiveSmtpMailer() instance to send email. We want to be able to manage these default implementations centrally, either via a class or some kind of configuration file. Tools that provide this functionality are collectively referred to as [Inversion-of-Control](http://en.wikipedia.org/wiki/Inversion_of_Control) containers, or IoC containers.[Ninject](http://ninject.org/) is one such tool.

Download Ninject, build it if necessary, and add a reference to Ninject.Core to get started. With this in place, we can do the necessary plumbing work to have Ninject instantiate our Cart class for us, rather than using the new keyword ourselves directly. Avoiding the new keyword is a necessary consequence of most IoC containers, as far as I can tell. To tell Ninject what to do when it finds it needs an ISendEmail interface implementation, you can create something like the following:

```
public class CustomModule : StandardModule
{
    public override void Load()
    {
        Bind<ISendEmail>().To<ConsoleTestMailer>();
    }
}
```

The ConsoleTestMailer is a new one I wrote for this example. It’s listed here:

```
public class ConsoleTestMailer : ISendEmail
{
    public void SendMail(string To, string From, string Subject, string Body)
    {
        Console.WriteLine("To: " + To);
        Console.WriteLine("From: " + From);
        Console.WriteLine("Subject: " + Subject);
        Console.WriteLine("Body: " + Body);
    }
}
```

All it does is dump the email information to the console.

Now we’re ready to write the Main() method of our console application:

```
class Program
{
    static void Main(string[] args)
    {
        CustomModule module = new CustomModule();
        IKernel kernel = new StandardKernel(module);
    
        Cart myCart = kernel.Get<Cart>();
        myCart.Checkout();
    }
}
```

And that’s it. The magic happens on line 8. If you leave the default constructor with the hardcoded implementation, then that’s what is used. Removing it and leaving only a constructor expecting an ISendEmail implementation allows Ninject to manage this dependency injection, and lets you manage it across your entire application from one location.