---
templateKey: blog-post
title: Testing Email Sending
path: blog-post
date: 2010-06-17T15:09:00.000Z
description: Recently I learned a couple of interesting things related to
  sending emails. One doesn't relate to .NET at all, so if you're a developer
  and you want to easily be able to test whether or not emails are working
  correctly in your application without actually sending them and/or installing
  a real SMTP server on your machine, pay attention.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - email
  - smtp4dev
  - dotnet
  - .net
  - c#
category:
  - Software Development
comments: true
share: true
---
Recently I learned a couple of interesting things related to sending emails. One doesn't relate to .NET at all, so if you're a developer and you want to easily be able to test whether or not emails are working correctly in your application without actually sending them and/or installing a real SMTP server on your machine, pay attention. You can grab the [smtp4dev application from codeplex](http://smtp4dev.codeplex.com/), which will listen for SMTP emails and log them for you (and will even pop-up from the system tray to notify you when it receives them) – but it will never send them. Here's what the notification looks like:

![smpt4dev toast message](/img/smtp4dev-message-received.png)

The other interesting tidbit about emails that is specific to .NET is that the MailMessage class is IDisposable. I never realized that before, but I noticed it while reading through the [Ben Watson's C# 4 How To book](http://www.amazon.com/gp/product/0672330636?ie=UTF8&tag=aspalliancecom&linkCode=as2&camp=1789&creative=390957&creativeASIN=0672330636 "C# 4 How To")I picked up at TechEd last week (which is done cookbook style and has a ton of useful info in it). Looking at the MailMessage's Dispose() method in Reflector reveals that it only really matters if you're working with AlternateViews or Attachments (this.bodyView is also of type AlternateView):

![dispose method disassembled](/img/dispose-method-disassembled.png)

All the same, you should get in the habit of wrapping your calls to MailMessage in a `using() { … }` block. Here's some sample code showing how I would typically work with MailMessage:

**Bad Example (don't cut and paste and use):**

```csharp
string fromAddress = "nobody@somewhere.com";
string toAddress = "somebody@somewhere.com";
string subject = "Test Message from IDisposable";
string body = "This is the body.";
var myMessage = new MailMessage(fromAddress, toAddress, subject, body);

var myClient = new SmtpClient("localhost");
myClient.Send(myMessage);
```

And here's how that code would look once it's properly set up using IDisposable / using:

**Good Example (use this one!):**

```csharp
string fromAddress = "nobody@somewhere.com";
string toAddress = "somebody@somewhere.com";
string subject = "Test Message from IDisposable";
string body = "This is the body.";

using(var myMessage = new MailMessage(fromAddress, toAddress, subject, body))
using(var myClient = new SmtpClient("localhost"))
{
    myClient.Send(myMessage);
}
```

Note also that SmtpClient is also IDisposable, and that you can stack your using() statements without introducing extra { … } when you have instances where you need to work with several Disposable objects (like in this case).

Note that if you run Code Analysis in VS2010 (not sure which version you have to have – right click on a project in your solution explorer and look for Analyze Code) you will get warnings for any IDisposable classes you're using outside of using statements, like these:

[![code analysis errors](/img/code-analysis-2010.png)

## Summary

Sometimes things you don't expect to be Disposable are. It's good to run some code analysis tools from time to time to help find things like this. Visual studio has some nice static analysis built into some versions, or you can use less expensive tools like [Fx Cop](http://msdn.microsoft.com/en-us/library/bb429476%28VS.80%29.aspx) or [Nitriq](http://nitriq.com/).
