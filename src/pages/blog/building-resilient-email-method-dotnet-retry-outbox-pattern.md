---
templateKey: blog-post
title: Building a Resilient Email Sending Method in .NET with SmtpClient, Retry Support, and the Outbox Pattern
date: 2023-09-08
description: "Learn how to build a resilient email sending method in .NET using the SmtpClient class. This guide covers implementing retry logic for better reliability and introduces the Outbox pattern to preserve email content in case of failure. Master these techniques to make your email operations foolproof."
path: blog-post
featuredpost: false
featuredimage: /img/building-resilient-email-method-dotnet-retry-outbox-pattern.png
tags:
  - dotnet
  - Outbox Pattern
  - Retry Pattern
  - Email Sending
  - Reliability
category:
  - Software Development
comments: true
share: true
---

## Introduction

In the world of software applications, email sending functionalities are indispensable. From password resets to notifications, you can't afford to let a hiccup in the network or an SMTP server issue derail you. So how do you ensure reliability in email operations? In this post, we'll dive into creating a resilient email sending method in .NET using the `SmtpClient` class and incorporating retry logic. Plus, we'll go a step further by discussing how to use the Outbox pattern to preserve email content in case of failures.

> "If at first you don't succeed, try, try again." - *Classic Proverb*
> "Do or do not, there is no try." - *Yoda, Star Wars*

**NOTE:** If you're trying to add Retry to Web API calls, check out [Polly](https://www.thepollyproject.org/).

### What You'll Learn

- The fundamentals of the `SmtpClient` class in .NET
- Implementing retry logic for enhanced reliability
- How to preserve email contents using the Outbox pattern

## A Quick Look at SmtpClient

The `SmtpClient` class in .NET makes sending emails via Simple Mail Transfer Protocol (SMTP) a breeze. Below is a sample method for sending a basic email:

```csharp
using System.Net.Mail;

public void SendEmail(string to, string subject, string body)
{
    using (SmtpClient client = new SmtpClient("smtp.server.com")) // use localhost and a test server
    {
        MailMessage mailMessage = new MailMessage();
        mailMessage.From = new MailAddress("from@example.com");
        mailMessage.To.Add(to);
        mailMessage.Subject = subject;
        mailMessage.Body = body;

        client.Send(mailMessage);
    }
}
```

To test this code on your local machine, [install a test email server](https://ardalis.com/configuring-a-local-test-email-server/).

## Implementing Retry Logic

The above approach works, but it's far from foolproof. If the network goes down or the SMTP server crashes, your email sending operation could fail. That's where retry logic comes into play.

### Adding the Retry Mechanism

Here's how to add a simple retry mechanism:

```csharp
using System;
using System.Net.Mail;

public class EmailSender
{
    public void SendEmailWithRetry(string to, string subject, string body, int maxRetries = 3)
    {
        int attempts = 0;
        while (attempts < maxRetries)
        {
            try
            {
                using (SmtpClient client = new SmtpClient("smtp.server.com"))
                {
                    MailMessage mailMessage = new MailMessage();
                    mailMessage.From = new MailAddress("from@example.com");
                    mailMessage.To.Add(to);
                    mailMessage.Subject = subject;
                    mailMessage.Body = body;

                    client.Send(mailMessage);
                    return;
                }
            }
            catch (Exception)
            {
                attempts++;
                if (attempts == maxRetries)
                {
                    throw new InvalidOperationException("Failed to send email after multiple attempts.");
                }
            }
        }
    }
}
```

This approach ensures that your application will try to send the email up to three times before finally throwing an exception. But what happens to the email content if all the retries fail?

Unfortunately, **it's lost**.

## Preserving Email Content: The Outbox Pattern

To ensure that the email contents are not lost when all retry attempts fail, you can implement the Outbox pattern. The idea is to persist the email message into an "outbox" database table before attempting to send it. Once the email is successfully sent, the outbox entry is marked as processed or deleted.

### Implementing the Outbox Pattern

Here's a simplified example using Entity Framework Core:

```csharp
public void SendEmailWithRetryAndOutbox(string to, string subject, string body, int maxRetries = 3)
{
    EmailOutboxEntity outboxEntity = new EmailOutboxEntity
    {
        To = to,
        Subject = subject,
        Body = body,
        IsProcessed = false
    };
    dbContext.EmailOutbox.Add(outboxEntity);
    dbContext.SaveChanges();

    int attempts = 0;
    while (attempts < maxRetries)
    {
        try
        {
            using (SmtpClient client = new SmtpClient("smtp.server.com"))
            {
                MailMessage mailMessage = new MailMessage();
                mailMessage.From = new MailAddress("from@example.com");
                mailMessage.To.Add(to);
                mailMessage.Subject = subject;
                mailMessage.Body = body;

                client.Send(mailMessage);

                outboxEntity.IsProcessed = true;
                dbContext.SaveChanges();

                return;
            }
        }
        catch (Exception)
        {
            attempts++;
            if (attempts == maxRetries)
            {
                throw new InvalidOperationException("Failed to send email after multiple attempts. Check the outbox for unprocessed messages.");
            }
        }
    }
}
```

## Conclusion

Ensuring the resilience and reliability of email sending operations involves a multifaceted approach. Not only do you need the `SmtpClient` class to send emails and retry logic to overcome transient failures, but the Outbox pattern also ensures that you won't lose your email content when things go south.

If you're looking for more tips like this, [subscribe to my weekly tips newsletter](/tips) and be sure to follow me on [YouTube](https://www.youtube.com/ardalis?sub_confirmation=1).
