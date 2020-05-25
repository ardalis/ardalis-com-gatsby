---
templateKey: blog-post
title: Sending Emails with aspNetEmail and RapidMailer
path: blog-post
date: 2005-07-28T15:22:06.737Z
description: I had to send out a bunch of emails to some partners I work with
  and the easiest way for me to generate the list was via an SQL query of my
  database.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - .net
  - asp.net
category:
  - Uncategorized
comments: true
share: true
---
<!--StartFragment-->

I had to send out a bunch of emails to some partners I work with and the

easiest way for me to generate the list was via an SQL query of my

database. It wasn’t a huge list, just 30 or so emails, but enough that I

didn’t want to go and type them all into Outlook as BCC entries. My first

thought was to check with [Dave](http://weblogs.asp.net/dwanta)

[](http://weblogs.asp.net/dwanta)

[Wanta](http://weblogs.asp.net/dwanta), god of all things email in the .NET space. Dave wasn’t around,

so instead of bugging him personally I RTFM’d like I should have done to begin

with and browsed around [http://aspnetemail.com](http://aspnetemail.com/), where I quickly found

his [Online Examples](http://www.aspnetemail.com/examples.aspx).

From there I found his Mail Merge examples, and eventually a link to [Building a Newsletter Engine](http://www.aspnetemail.com/rapidmailer),

aka [RapidMailer](http://www.aspnetemail.com/rapidmailer).

Now, this is just cool. It’s a 100% free application, written as a C#

Windows Forms app, with source code. It’s more than just a quickie demo,

though. It includes a lot of great features like the ability to extract an

arbitrary set of data from any sql data source and the ability to use that same

schema with test data for test emails (so you could, for instance, test your

mail merge settings by sending yourself a test message). It also will let

you save all of your settings and load them, it will log the session so you can

debug issues, and it will, if desired, log every email that was sent.

The one feature I didn’t see immediately was the ability to specify a port

for the outgoing SMTP server. Since I was sending from my home and my

ISP blocks port 25 (so I’m using an alternate port), I had to code this myself,

but it only required one line of code and then everything worked great.

So, basically, if you need to send a bunch of emails based on a SQL query, or

if you have any email needs at all in your .NET applications, check out [aspNetEmail](http://aspnetemail.com/). It

rocks.

<!--EndFragment-->