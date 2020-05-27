---
templateKey: blog-post
title: Fixed Problem Connecting to Docker for Windows ASPNET  App
date: 2019-06-04
path: /fixed-problem-connecting-to-docker-for-windows-aspnet-app
featuredpost: false
featuredimage: /img/fixed-problem-connecting-to-docker-for-windows-aspnet-app.png
tags:
  - asp.net
  - docker
  - docker for windows
  - netstat
  - networking
  - ports
category:
  - Software Development
comments: true
share: true
---

Recently I was working on some WinForms and classic MVC (not Core) apps built with ASP.NET and migrating them to Azure using containers. There's [a repo with samples and an ebook on modernizing your .NET apps](https://github.com/dotnet-architecture/eShopModernizing) so they can take advantage of containers and cloud architecture. Check it out if this sounds like something you think you'll be doing.

Anyway, while running these apps locally using Docker for Windows, I got some weird errors. After running the in Docker, either I'd get an error in the browser (it would just time out) or I'd see in the logs something like "Problem occurred while listening on port 50005". After some searching, I came across [this article which solved my problem](http://blog.sixthimpulse.com/2019/01/docker-for-windows-port-reservations/).

Basically, something on my machine had reserved a block of IPs, including the one I was telling the container to use. Instead of just giving me a build error when running docker-compose, I was getting the error at runtime even though all of the docker tools showed the container was running and listening as directed.

To see if this is your issue, run

netstat -aon

And look for the port you're trying to use. You can use grep or find to help, like `netstat -aon | find "50005"`.

To see which ports are reserved run this:

netsh int ipv4 show excludedportrange protocol=tcp

Finally, run scripts like these to delete and reserve the range you need.

netsh int ipv4 delete excludedportrange protocol=tcp startport=50000 numberofports=50
 netsh int ipv4 add excludedportrange protocol=tcp startport=50000 numberofports=50

You may need to reboot and/or restart Docker or other services to get this to work. [See the original article for more details](http://blog.sixthimpulse.com/2019/01/docker-for-windows-port-reservations/) - I'm only copying some commands here in the event the original article disappears.

Assuming you have the flexibility to use another port, that should work as well, now that you know which ports are reserved and which are available.
