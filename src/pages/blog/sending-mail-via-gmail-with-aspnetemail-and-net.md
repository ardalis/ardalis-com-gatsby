---
templateKey: blog-post
title: Sending Mail via GMail with AspNetEmail and .NET
path: blog-post
date: 2009-01-26T09:08:00.000Z
description: Periodically, I need to send out announcements to a list of emails
  pulled from a database. This is a pretty common problem, and a long time ago I
  found RapidMailer from Dave Wanta aka AdvancedIntellect which does a pretty
  good job and has all the source.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - Gmail
  - .NET
category:
  - Uncategorized
comments: true
share: true
---
Periodically, I need to send out announcements to a list of emails pulled from a database. This is a pretty common problem, and a long time ago I found [RapidMailer](http://www.aspnetemail.com/rapidmailer) from Dave Wanta aka [AdvancedIntellect](http://advancedintellect.com/) which does a pretty good job and has all the source. However, I’d been using it with my web host provided SMTP/POP3 provider for years, but since I recently moved my accounts to Google Apps (for the tons of free storage), I had to figure out how to configure RapidMailer to work with GMail.

After some searching, I[found a post by Dave himself describing the necessary pieces for sending mail via GMail and AspNetMail](http://www.advancedintellect.com/forum_viewpost.aspx?forum=1&post=2058).. Specifically, since Google requires TLS security, or “Transport Level Security,” it turns out that [this is really just a fancy way of saying SSL](http://mail.google.com/support/bin/answer.py?answer=13287) (Secure Socket Layer). In this post, The code looks pretty much like this:

```
EmailMessage m = <span style="color: #0000ff">new</span> EmailMessage( <span style="color: #006080">&quot;smtp.gmail.com&quot;</span> );
m.Username = <span style="color: #006080">&quot;test@gmail.com&quot;</span>;
m.Password = <span style="color: #006080">&quot;test&quot;</span>;
&#160;
<span style="color: #008000">//create the ssl socket</span>
AdvancedIntellect.Ssl.SslSocket ssl = <span style="color: #0000ff">new</span> AdvancedIntellect.Ssl.SslSocket();
m.LoadSslSocket( ssl );
&#160;
<span style="color: #008000">//logging on the ssl socket</span>
ssl.Logging = <span style="color: #0000ff">true</span>;
ssl.LogPath = <span style="color: #006080">&quot;c:ssl.log&quot;</span>;
&#160;
<span style="color: #008000">//rest of aspNetEmail properties</span>
m.Port = 587;
m.To = <span style="color: #006080">&quot;test@123aspx.com&quot;</span>;
m.FromAddress = <span style="color: #006080">&quot;test@gmail.com&quot;</span>;
m.Subject = <span style="color: #006080">&quot;test&quot;</span>;
m.Body = <span style="color: #006080">&quot;test&quot;</span>;
&#160;
m.Logging = <span style="color: #0000ff">true</span>;
m.LogPath = <span style="color: #006080">&quot;c:email.log&quot;</span>;
m.Send();
```

However, I couldn’t get this to compile because my project had no idea what AdvancedIntellect.Ssl.SslSocket was. A little bit more digging yielded the fact that this was a separate DLL, available from AdvancedIntellect.com for free.

[Download AdvancedIntellect.Ssl.dll](http://advancedintellect.com/download.aspx)

Once I grabbed the DLL and added a reference to it in my RapidMailer project, everything was happy and I was able to send emails through GMail. The only other thing I had to do was get the program to send attachments, and that turned out to be only a couple more lines of code.

All in all, if you need to do anything in .NET surrounding email, you really should start with Dave’s tools at AdvancedIntellect.com. He’s been doing this stuff for nearly 10 years now and even owns the leading help web sites for [SystemNetMail](http://www.systemnetmail.com/) and [SystemWebMail](http://www.systemwebmail.com/) problems.