---
templateKey: blog-post
title: Configuring a Local Test Email Server
path: blog-post
date: 2020-05-04T01:22:00.000Z
description: It’s been a few years since I wrote about using a tool like
  Smtp4Dev for local test emails (and that article has issues), so here’s an
  update.
featuredpost: false
featuredimage: /img/email-server.png
tags:
  - email
  - test email servers
  - testing
category:
  - Software Development
comments: true
share: true
---
It’s been a few years since [I wrote about using a tool like Smtp4Dev for local test emails](https://ardalis.com/testing-email-sending) (and that article has issues), so here’s an update. If you’re working with code that should send emails sometimes, it’s really helpful to be able to let that code still run, but not actually send emails. That’s where running a local test email server on your development machine comes in. Here are a few options.

## Docker (Papercut)

If you’ve got Docker running, the simplest way to get started is to just run this command:

```
docker run --name=papercut -p 25:25 -p 37408:37408 jijiechen/papercut:latest
```

Which will[spin up a Papercut server locally in a Docker container](https://hub.docker.com/r/jijiechen/papercut)and have it listen on port 25 as well as host its web interface on port 37408 (feel free to change this one). Here’s what I get when I run it (make sure you have docker installed and running):

![](/img/win-power-shell.png)

Installing/running the first time.

Subsequent runs you won’t need to download anything and it will just start. If you get an error about the name already existing, it’s probably still running and you can either just use it or kill and restart it.

With the server running, you can send email from your application on localhost and you’ll get log output to the console showing that it received the email, and you can open a browser and navigate to localhost:37408 to see the details of the emails that have been sent.

![](/img/papercut.png)

Papercut server running in Docker.

## Papercut

Alternately you can install the Papercut client locally. [Download it here](https://www.softpedia.com/get/Internet/Servers/E-mail-Servers/Papercut-Krobertson.shtml) or [install it with Chocolatey](https://chocolatey.org/packages/papercut). Run it (make sure you don’t have another server listening on port 25). It does the same thing as the dockerized version.

I just installed it with `cinst papercut` using chocolatey and then ran `papercut` in my Powershell terminal and here’s what I got:

![](/img/papercut-2.png)

Papercut test email server.

## Smtp4Dev

My old favorite Smtp4Dev continues to work. You can [download it here](https://www.softpedia.com/get/Internet/Servers/E-mail-Servers/smtp4dev.shtml) or [install it from Chocolatey](https://chocolatey.org/packages/smtp4dev). You want the 2.x version. I recommend using Chocolatey (some of [my installed packages are listed in my tools page](https://ardalis.com/tools)).

After running `cinst smtp4dev` and then `smtp4dev` I get:

![](/img/smtp4dev.png)

smtp4dev test email server.

Note that it’s not listening on port 25 at the moment because I have the other programs, notably the docker instance, already listening on that port.

## Summary

Test email servers are a great tool when you’re doing integration or functional testing. You want to make sure that “real” behavior is happening but you don’t want to send real emails, or have to deal with email failures. These tools work great and I frequently use them in my workshops when I’m doing hands-on labs for [Domain Driven Design](https://www.pluralsight.com/courses/domain-driven-design-fundamentals), [Design Patterns](https://www.pluralsight.com/courses/patterns-library), and [Clean Architecture](https://github.com/ardalis/CleanArchitecture). Give them a try and see what you think!