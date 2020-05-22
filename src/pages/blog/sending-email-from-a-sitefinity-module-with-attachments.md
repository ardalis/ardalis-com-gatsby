---
templateKey: blog-post
title: Sending Email from a Sitefinity Module with Attachments
path: blog-post
date: 2012-02-24T05:56:00.000Z
description: A fairly common use case in web applications is the need to send an
  email, and applications built on top of Telerik Sitefinity are no different.
  Since modules are simply .NET DLLs, you’re free to write whatever code you
  like, so it’s certainly possible for you to write a module that sends emails
  in a way that knows nothing about Sitefinity.
featuredpost: false
featuredimage: /img/newsletter.png
tags:
  - sitefinity
category:
  - Software Development
comments: true
share: true
---
A fairly common use case in web applications is the need to send an email, and applications built on top of Telerik Sitefinity are no different. Since modules are simply .NET DLLs, you’re free to write whatever code you like, so it’s certainly possible for you to write a module that sends emails in a way that knows nothing about Sitefinity. However, if you want to interact with Sitefinity, for instance making sure that you use the same SMTP server that is configured in the Sitefinity settings, or attaching a file from a Sitefinity library, then this post will show you how to do so. I strongly recommend that you allow the user to configure the way emails are sent via the Sitefinity UI if your module will be sending emails, as it will be confusing and annoying to users if this isn’t the case.

## Sitefinity Email Settings

You can find your Sitefinity email settings by going to Administration – Settings – Advanced – System – SMTP (Email Settings). You’ll also find a separate location with settings for sending Newsletters under Administration – Settings Advanced – Newsletters. You can use either one for your custom module’s settings – which one you choose really depends on what you’re doing. If you’re sending some kind of administrator alert, then the System one probably makes more sense. If you’re letting users sign up for notifications about updates to your site, then perhaps the Newsleters section is the more logical choice. You can see where to set them in the UI here:

![](/img/newsletter.png)

![](/img/email-settings.png)

In my example, I’m going to use the Newsletters section, but I’ve included the code for the System setting in a comment.

### Sending Email in Sitefinity

```
<span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> SendEmail(<span style="color: #0000ff">string</span> toEmail, <span style="color: #0000ff">string</span> fromEmail, <span style="color: #0000ff">string</span> subject, <span style="color: #0000ff">string</span> body)

{

       var manager = ConfigManager.GetManager();
       <span style="color: #0000ff">string</span> smtpHost = manager.GetSection&lt;NewslettersConfig&gt;().SmtpHost;
     <span style="color: #008000">//string smtpHost = manager.GetSection&lt;SystemConfig&gt;().SmtpSettings.Host;</span>

       var smtpClient = <span style="color: #0000ff">new</span> SmtpClient(smtpHost);

       var message =
        <span style="color: #0000ff">new</span> MailMessage(fromEmail, toEmail)
        {
           Subject = subject,

               Body = body

           };
    smtpClient.Send(message);

   }
```

## Adding an Attachment

In Sitefinity, you can use the Fluent API to work with most of the content in a site. For instance, to work with the documents in the site, you can simply write App.WorkWith().Documents() and follow this up with whatever commands you wish to send. If you need to get an instance of a document, you can call Get(). If you need to pull in the document’s raw data as a stream, you can use the DownloadContent(out stream) method. You can chain all of these things together into a single statement that gets a given document and its stream of data. One you have this, it’s easy to use the stream to add a file attachment to an email. In this example, we are simply attaching the first document that we find in the site’s document library – in the real world you would pick a particular document by its id or perhaps title.

### Sending Email with Attachment in Sitefinity

```
<span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> SendEmail(<span style="color: #0000ff">string</span> toEmail, <span style="color: #0000ff">string</span> fromEmail, <span style="color: #0000ff">string</span> subject, <span style="color: #0000ff">string</span> body)

{

    var manager = ConfigManager.GetManager();

    <span style="color: #0000ff">string</span> smtpHost = manager.GetSection&lt;NewslettersConfig&gt;().SmtpHost;
 <span style="color: #008000">//string smtpHost = manager.GetSection&lt;SystemConfig&gt;().SmtpSettings.Host;</span>
  var smtpClient = <span style="color: #0000ff">new</span> SmtpClient(smtpHost);

    var message =

        <span style="color: #0000ff">new</span> MailMessage(fromEmail, toEmail)

        {
       Subject = subject,
       Body = body

        };

    <span style="color: #008000">// attach a document from a sitefinity document library</span>

    <span style="color: #008000">// this example just gets the first document it finds</span>

    System.IO.Stream stream;

    var doc = App.WorkWith()
      .Documents()

        .First()

        .DownloadContent(<span style="color: #0000ff">out</span> stream)

     .Get();
 var fileAttachment =

        <span style="color: #0000ff">new</span> Attachment(stream, doc.MimeType);

    message.Attachments.Add(fileAttachment);

    smtpClient.Send(message);

}
```

As you can see, it’s pretty easy to work with email from within a Sitefinity module or widget, leveraging the existing settings and document libraries of the site. The Sitefinity API is quite extensive, and the Fluent API can provide a very intuitive and flexible way to interact with the system.