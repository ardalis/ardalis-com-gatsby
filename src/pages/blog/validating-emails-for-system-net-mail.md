---
templateKey: blog-post
title: Validating Emails for System.Net.Mail
path: blog-post
date: 2011-08-12T08:51:00.000Z
description: If you’ve worked with the System.Net.Mail API to send out messages,
  you may have run into the fact that when you add an email address to a
  message, it will sometimes throw an exception if the email doesn’t appear to
  be valid
featuredpost: false
featuredimage: /img/email-3597088_1280.jpg
tags:
  - C#
  - email
  - smtp
category:
  - Software Development
comments: true
share: true
---
If you’ve worked with the System.Net.Mail API to send out messages, you may have run into the fact that when you add an email address to a message, it will sometimes throw an exception if the email doesn’t appear to be valid:

```
var myMessage = <span style="color: #0000ff">new</span> MailMessage();
myMessage.To.Add(<span style="color: #006080">"ssmith@somewhere,com"</span>); <span style="color: #008000">// invalid ','</span>
// <span style="color: #0000ff">do</span> more stuff
```

**Result:**

**FormatException – The specified string is not in the form required for an e-mail address.**

This is handy since it’s usually better to fail early rather than wait until you actually go to send the message to learn that the email is invalid. However, if you’re processing more than one email, you likely have code that might look like this:

```
<span style="color: #0000ff">using</span> (var smtpClient = <span style="color: #0000ff">new</span> SmtpClient())
{

    <span style="color: #0000ff">foreach</span> (var email <span style="color: #0000ff">in</span> Emails)

    {

      <span style="color: #0000ff">using</span> (var msg = <span style="color: #0000ff">new</span> MailMessage())
        {
           msg.Subject = <span style="color: #006080">"Foo"</span>;
           msg.Body = <span style="color: #006080">"Bar"</span>;
           msg.From = <span style="color: #0000ff">new</span> MailAddress(fromAddress);
           msg.CC.Add(ccAddress);
           msg.To.Add(email);
&nbsp;
           <span style="color: #008000">// set more properties</span>
           smtpClient.Send(msg);

        }

    }

}
```

(Note that both SmtpClient and MailAddress implement IDisposable and so should be accessed within using() blocks, as shown)

The above code looks great, but of course it’s lacking any kind of error handling, so the first time you get a bad email address, an exception will be thrown, and you’ll only have sent out some of the messages. Adding proper exception handling makes the code start to get ugly. Assume for the sake of argument that you have a requirement to log some specific information about which email address was invalid, which prevents you from simply wrapping the whole thing in a single try-catch block. Let’s also assume that we want to keep going if we encounter invalid emails, but we want to stop if we encounter an error actually sending the email.

```
<span style="color: #0000ff">using</span> (var smtpClient = <span style="color: #0000ff">new</span> SmtpClient())
{

    <span style="color: #0000ff">foreach</span> (var email <span style="color: #0000ff">in</span> Emails)

    {

        <span style="color: #0000ff">using</span> (var msg = <span style="color: #0000ff">new</span> MailMessage())

        {

            msg.Subject = <span style="color: #006080">"Foo"</span>;

            msg.Body = <span style="color: #006080">"Bar"</span>;

            <span style="color: #0000ff">try</span>

            {

                msg.From = <span style="color: #0000ff">new</span> MailAddress(fromAddress);

            }

            <span style="color: #0000ff">catch</span> (Exception ex)

            {

                LogError(<span style="color: #006080">"Invalid from address: "</span> + fromAddress, ex);

                <span style="color: #0000ff">continue</span>;

            }

            <span style="color: #0000ff">try</span>

            {

                msg.CC.Add(ccAddress);

            }

            <span style="color: #0000ff">catch</span> (Exception ex)

            {

                LogError(<span style="color: #006080">"Invalid cc address: "</span> + ccAddress, ex);

                <span style="color: #0000ff">continue</span>;

            }

            <span style="color: #0000ff">try</span>

            {

                msg.To.Add(email);

            }

            <span style="color: #0000ff">catch</span> (Exception ex)

            {

                LogError(<span style="color: #006080">"Invalid to address: "</span> + email, ex);

                <span style="color: #0000ff">continue</span>;

            }

&nbsp;

            <span style="color: #008000">// set more properties</span>

&nbsp;

            <span style="color: #0000ff">try</span>

            {
               smtpClient.Send(msg);

            }

            <span style="color: #0000ff">catch</span> (Exception ex)

            {

             LogError(<span style="color: #006080">"Error sending email"</span>, ex);
            <span style="color: #0000ff">throw</span>;

        }


        }


    }

}
```

At this point it looks pretty clear that this is a DRY principle violation. We should be able to abstract out the “add an email address to some property of a MailMessage” work into a method call that would include the error handling in a common fashion. Unfortunately, this is not as straightforward as it seems, since some fields of MailMessage require a call to Add() and others are simply setters. Of course, this whole problem would go away if we were able to validate the emails in advance, but unfortunately neither MailMessage nor any other public API in System.Net.Mail exposes the validation functionality that MailMessage uses internally. We could go grab the ultimate email regular expression from [RegExLib.com](http://regexlib.com/) and use that, but unfortunately regular expressions for email addresses almost always include some number of false positives or false negatives (that is, they let invalid emails through and/or they block valid emails). That would be overkill for our current needs, and while we might consider adding that later, right now we are looking to refactor the above code, meaning we want it to still be functionally the same, but cleaner.

It turns out that we can in fact create our own simple email validator that will use the same validation logic as MailMessage. It may be possible to do this with reflection, but the example shown here is simpler and I’ve verified that it’s extremely fast even when faced with invalid emails (over 10,000 invalid emails per second, on my hardware).

### Creating an Email Address Validator For System.Net.Mail.MailMessage

```
<span style="color: #0000ff">public</span> <span style="color: #0000ff">bool</span> IsValid(<span style="color: #0000ff">string</span> emailAddress)
{
<span style="color: #0000ff">using</span> (var msg = <span style="color: #0000ff">new</span> System.Net.Mail.MailMessage())
  {

        <span style="color: #0000ff">try</span>

        {
        msg.To.Add(emailAddress);
        }

        <span style="color: #0000ff">catch</span>

        {
           <span style="color: #0000ff">return</span> <span style="color: #0000ff">false</span>;

        }

        <span style="color: #0000ff">return</span> <span style="color: #0000ff">true</span>;

    }

}
```

Once we have the ability to validate email addresses, we can write a few guard clauses that clean up our original code a bit. In this case I am changing the behavior slightly in that an invalid FROM or CC email will now return immediately rather than throwing and logging an exception for every single email.

```
<span style="color: #0000ff">if</span> (!IsValid(fromAddress))
{

    LogError(<span style="color: #006080">"Invalid from address: "</span> + fromAddress);

    <span style="color: #0000ff">return</span>;

}

<span style="color: #0000ff">if</span> (!IsValid(ccAddress))

{

    LogError(<span style="color: #006080">"Invalid cc address: "</span> + ccAddress);
    <span style="color: #0000ff">return</span>;

}

<span style="color: #0000ff">using</span> (var smtpClient = <span style="color: #0000ff">new</span> SmtpClient())
{

    <span style="color: #0000ff">foreach</span> (var email <span style="color: #0000ff">in</span> Emails)

    {

        <span style="color: #0000ff">if</span> (!IsValid(email))

        {
            LogError(<span style="color: #006080">"Invalid email address: "</span> + email);
            <span style="color: #0000ff">continue</span>;

        }

        <span style="color: #0000ff">using</span> (var msg = <span style="color: #0000ff">new</span> MailMessage())

        {

            <span style="color: #0000ff">try</span>

            {

                msg.Subject = <span style="color: #006080">"Foo"</span>;
                msg.Body = <span style="color: #006080">"Bar"</span>;
                msg.From = <span style="color: #0000ff">new</span> MailAddress(fromAddress);
                msg.CC.Add(ccAddress);
                msg.To.Add(email);

&nbsp;

                <span style="color: #008000">// set more properties</span>
                smtpClient.Send(msg);

            }

            <span style="color: #0000ff">catch</span> (Exception ex)
            {

            LogError(<span style="color: #006080">"Error sending email"</span>, ex);
            <span style="color: #0000ff">throw</span>;

            }

        }

    }

}
```

This is still pretty long, so one thing you might do to clean it up further is pull out the actual MailMessage bits into its own method:

```
<span style="color: #0000ff">if</span> (!IsValid(fromAddress))
{

    LogError(<span style="color: #006080">"Invalid from address: "</span> + fromAddress);

    <span style="color: #0000ff">return</span>;

}

<span style="color: #0000ff">if</span> (!IsValid(ccAddress))

{

    LogError(<span style="color: #006080">"Invalid cc address: "</span> + ccAddress);

    <span style="color: #0000ff">return</span>;

}

<span style="color: #0000ff">using</span> (var smtpClient = <span style="color: #0000ff">new</span> SmtpClient())

{

    <span style="color: #0000ff">foreach</span> (var email <span style="color: #0000ff">in</span> Emails)

    {

        <span style="color: #0000ff">if</span> (!IsValid(email))

        {

            LogError(<span style="color: #006080">"Invalid email address: "</span> + email);

            <span style="color: #0000ff">continue</span>;

        }

        SendMessage(fromAddress, ccAddress, email, smtpClient);

    }

}

...

<span style="color: #0000ff">private</span> <span style="color: #0000ff">void</span> SendMessage(<span style="color: #0000ff">string</span> fromAddress, <span style="color: #0000ff">string</span> ccAddress, <span style="color: #0000ff">string</span> email, SmtpClient smtpClient)

{

    <span style="color: #0000ff">using</span> (var msg = <span style="color: #0000ff">new</span> MailMessage())

    {

        <span style="color: #0000ff">try</span>

        {

            msg.Subject = <span style="color: #006080">"Foo"</span>;
            msg.Body = <span style="color: #006080">"Bar"</span>;
            msg.From = <span style="color: #0000ff">new</span> MailAddress(fromAddress);
            msg.CC.Add(ccAddress);
            msg.To.Add(email);
&nbsp;
            <span style="color: #008000">// set more properties</span>
            smtpClient.Send(msg);

        }

        <span style="color: #0000ff">catch</span> (Exception ex)

        {
            LogError(<span style="color: #006080">"Error sending email"</span>, ex);
            <span style="color: #0000ff">throw</span>;

        }

    }

}
```

Now, you might wonder, why didn’t we just do that in the original version? It would have helped a bit, but it still would have included a bunch of separate try-catch blocks, and none of them would have been able to call continue, so to preserve the behavior we want, we would have had to throw the exceptions back up to the calling code anyway, which then would have had to continue if the exception related to an email address, or throw if the exception was on the Send() call. More ugliness.

### Summary

When designing an API, it’s a good idea to consider how your clients will use the API. In this case, it seems clear to me (as a client) that I would really have liked a way to scrub the email addresses I’m working with at an earlier stage in my workflow than when I’m actually preparing to send the emails. Unfortunately, the System.Net.Mail API does not provide for this kind of workflow out-of-the-box. However, it’s fairly easy to achieve by faking it with a method like the IsValid(string emailAddress) method shown above, and fortunately in this case there are no side effects or major performance problems involved in this approach (that I’ve discovered). Once the validation can be separated from the mail sending workflow, the code can be made much clearer.