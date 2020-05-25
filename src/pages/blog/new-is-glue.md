---
templateKey: blog-post
title: New is Glue
path: blog-post
date: 2012-04-13T01:54:00.000Z
description: When you’re working in a strongly typed language like C# or Visual
  Basic, instantiating an object is done with the new keyword.
featuredpost: false
featuredimage: /img/new-glue.png
tags:
  - C#
  - clean code
  - dependencies
  - design
  - oop
  - software craftsmanship
  - tip
category:
  - Software Development
comments: true
share: true
---
When you’re working in a strongly typed language like C# or Visual Basic, instantiating an object is done with the **new** keyword. It’s important that we recognize the significance of using this keyword in our code, because I would venture to say that well over 90% of developers don’t give it a second thought. Most developers have, at one time or another, heard the practice of building software applications likened to building something out of LEGO bricks (I’ve even written about [LEGOs and software](http://ardalis.com/Tight-Coupling,-Legos,-and-Super-Glue) in the past). A few days ago, it occurred to me that I could sum up my thoughts on this topic in three words, which I might hope would be memorable enough to “stick” in developers’ minds:

## New is Glue

**Update:**\
Since originally publishing this article, Hollywood produced [an entire movie](http://www.imdb.com/title/tt1490017/?ref_=fn_al_tt_1) centered on this principle, in which the LEGO bad-guy was trying to glue pieces together. Don’t be that guy.

![](/img/new-glue.png)

Any time you use the new keyword, you are gluing your code to a particular implementation. You are permanently (short of editing, recompiling, and redeploying) hard-coding your application to work with a particular class’s implementation.

That’s **huge**.

[![](<>)](http://flic.kr/p/4B6vxi)That’s like your code’s getting married, forever and ever, until redeployment do us part. Once you’ve said the words (*new*) and exchanged some vows (type metadata) and exited the church (deployed), changing your code’s chosen partner becomes a very expensive endeavor. This is a big decision for you and your application. You need to be very sure that this is the one and only implementation your code will ever need to work with, or else think about calling the whole thing off.

> Using new isn’t wrong, it’s a design decision. Like all design decisions, it should be an informed decision, not a de facto one.

The marriage metaphor is taking things a bit far, I know, but let me add one more bit before we leave it behind us. It’s quite likely that your code is going to need behavior from more than one other class. In fact, it’s quite common that you’ll need to work with other classes in virtually every class within your application. If you go the *new* route, that’s a lot of overlapping marriages that all need to stay happy for your application to work effectively.

But what if the behavior or service you need is only found in one place? Maybe it’s not the perfect, now-and-forever class, but it’s the one that has what you need *right now*? What am I suggesting, that one forego leveraging any other classes, and just do everything yourself? Not at all, but let’s go with another metaphor now.

## Favor Contractors over Employees

Your application requires certain services to do its job. Think of your application like a small business. There are things your application does, and things it needs to do its job. A small business might need office space, and beyond that, certain utilities like electricity, phone service, internet service, shipping, etc. In a business, relationships you have with service providers and contractors are relatively easy to change, while relationships you have with employees can be somewhat more difficult (for purposes of this analogy, pretend we’re talking about a country where firing people is very difficult/expensive). Now think about which approach to running a small business makes more sense.

In the first scenario, your business’s needs are each met by a full-time resource. You have Bob, the electrician, who ensures your electricity works, Joan, the telecom expert, who ensures your phone service is connected, and Joe, the truck driver, who takes care of delivering everything you ever need to send. You also need an office to hold all of these people, which of course you leased with a 5 year lease that’s every expensive to get out of.

In the second scenario, your business’s needs are all met by service providers or contractors. You use standard utility companies for electricity, phone, internet, and you can switch from one to another with only a small amount of pain if one fails you. You ship with FedEx, USPS, UPS, etc. based on whichever one fits your needs of the day. Your office space is just big enough for you, and since you’re still growing and aren’t sure how your needs will change, you’re paying month-to-month.

Which of these two scenarios provides the greater degree of freedom for the business to adapt to future needs? Which one is locked into a particular implementation and will be hard-pressed to change when needed?

## Decoupling Services from Providers

New is Glue. It binds your code to a particular collaborator. If there is any chance you’ll need to be flexible about which implementation your code will need, it’s worth introducing an interface to keep your code loosely coupled. It doesn’t matter what the service is you need – you can always replace it with an interface even if your class is the only one that uses it. Let’s say your code needs send an email, with default code that looks like this:

```
using (var client = new SmtpClient())
using (var message = new MailMessage(fromEmail, toEmail))
{
    message.Subject = subject;
    message.Body = bodyHtml;
    message.IsBodyHtml = true;
    client.Send(message);
}
```

Note the two new keywords here, gluing whatever else this class is doing to this implementation of message sending. This can be replaced with an interface like this one:

```
public interface IEmailClient
{
    void SendHtmlEmail(string fromEmail, string toEmail, 
                       string subject, string bodyHtml);
}
```

Now the code that used to contain the first block of code can be rewritten to simply use the interface:

```
public class SomeService
{
    private readonly IEmailClient _emailClient;
    public SomeService(IEmailClient emailClient)
    {
        _emailClient = emailClient;
    }
    public void DoStuff(User user)
    {
        string subject = "Test Subject";
        string bodyHtml = GetBody(user);
        _emailClient.SendHtmlEmail("noreply@whatever.com", user.EmailAddress, subject, bodyHtml);
    }
}
```

***Edited:** Please assume that DoStuff() does some useful value-added work, and that sending an email to the user is just something it does as a side effect, perhaps only when it’s successful, and not that it’s the main intent of the method, if that helps you think about the value of removing the dependency on SmtpClient.*

How many new keywords are in this class, now? Run a search in Visual Studio to find how many instances of new you’re using in your solution, and where. Use ctrl-shift-F to find in files, search for “new”, Entire Solution, Match case, Match whole word, and Look at these file types: *.cs.

![](/img/find-replace.png)

Have a look at the total numbers, the numbers of files, etc. In one very small ASP.NET MVC application I’m working on now, this search yields 280 matching lines in 25 files out of 47 files searched. Four of the files and 28 of the matches are in my tests project. The lion’s share of the rest of the matches are from SqlHelper.cs. My controllers have a total of 7 matching lines, and all of these relate to creating model/viewmodel types, not services.

## When is it Acceptable to use New?

Using new isn’t wrong, it’s a design decision. Like all design decisions, it should be an informed decision, not a de facto one. Use it when you don’t expect you’ll need flexibility in the future. Use it when it won’t adversely affect the usability of your class by its clients. Consider the transitivity of the dependencies you take on within your class – that is, how the things you depend on in turn become dependencies for classes that use your classes. Consider too how your design decisions and considerations today may change in the future. One common example of this is applications that hard-code dependencies on local system resources like the file system, local memory (session, cache, global collections), and local services like email. When the application needs to scale out to multiple front-end machines, problems ensue. Loosely coupling these resources together would make implementing a webfarm- or cloud-optimized version of these services trivial, but thousands of new statements gluing implementations together can take a long time to fix.

One last thing to think about, if you actually do search your code for new, is how many duplicate lines you find. Remember the [Don’t Repeat Yourself](http://deviq.com/don-t-repeat-yourself/) (DRY) and [Single Responsibility](http://deviq.com/single-responsibility-principle/) (SRP) principles. If you’re instantiating the same class in the same way in more than one place in your code (e.g. 10 places where you new up a new SqlConnection), that’s a DRY violation. If you have ten different classes that all do some kind of work, AND need to know how to create a SqlConnection, that’s an SRP violation. Knowledge of how to talk to the database should be in only one location, the responsibility of a single class. The same is true for any other resource that you find you’re commonly instantiating in many different classes. The exceptions here would be low-level intrinsics like strings, datetimes, and things like exceptions that generally are created only in exceptional cases.

## Moving Forward

Learn to look for new in your code and in code reviews. Question whether it’s appropriate when you see it. Work on pushing the responsibility of choosing which classes your code will work with into as few classes as possible, and see if your code doesn’t start to become more loosely coupled and easier to maintain as a result.