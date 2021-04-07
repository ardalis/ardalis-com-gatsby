---
templateKey: blog-post
title: Speed Up Docker Compose with Parallel Builds
date: 2021-04-05
description: Docker compose can take a while to execute, especially for a large set of containers. Fortunately there's a way to take advantage of extra processors (and any extra bandwidth you may have) by running the build step in parallel.
path: blog-post
featuredpost: false
featuredimage: /img/speed-up-docker-compose-with-parallel-builds.png
tags:
  - programming
  - PowerShell
  - performance
  - CLI
  - command line
  - docker
  - docker-compose
category:
  - Software Development
comments: true
share: true
---

I've been using docker-compose quite a bit lately for [a distributed app that includes 3 front end apps, 2 databases, RabbitMQ, and PaperCut (test email server)](https://github.com/ardalis/pluralsight-ddd-fundamentals/blob/main/docker-compose.yml). For the most part, this works great as a way to encapsulate all of these processes and run them in a containerized manner so that everything works together. But building this whole solution is pretty slow, by default.

When you work with docker-compose, you generally have two commands you run: build and up. Build is used to build all of the containers using their individual DOCKERFILEs (or just to download the image if it's a prebuilt and published image). Up is used to launch everything and run the app(s).

To measure how long it takes to run `docker-compose build`, you can [use the `Measure-Command` PowerShell commandlet which I described in my previous article](/measure-command-line-script-time-elapsed/). Here's the command I used to generate the images below:

```powershell
Measure-Command { docker-compose build | Out-Default}
```

First run:

![docker build time 1](/img/docker-compose-build-01.png)

Change something in a file (to force rebuild) and run again:

![docker build time 1](/img/docker-compose-build-02.png)

You can see the times are both just under 4 minutes: 3:43 and 3:56.

## Parallel Docker Build

Now let's try running them again using the parallel switch on the `docker-compose build` command, making it `docker-compose build --parallel`.

First run in parallel:

![docker build time 3](/img/docker-compose-build-03.png)

Change something in a file (to force rebuild) and run again (in parallel):

![docker build time 4](/img/docker-compose-build-04.png)

Looking at the times, now we get 2:11 and 2:05.

Looking at total seconds, the average build without parallel took 230 seconds. The average build using parallel took 128 seconds. That's a 44% drop in overall time for the build, which is pretty significant, especially when you're running this frequently while trying to troubleshoot a problem.

Of course, this won't help for every docker-compose or on every machine. But if you have a large number of containers being built and a bunch of CPU cores, it's definitely worth a try.

## Summary

Most computers these days, and especially most developer workstations, have a lot of CPU cores that can perform work in parallel. The problem is, a lot of software doesn't work in parallel by default. Fortunately, `docker-compose` can be made to take advantage of those extra CPU cores by adding the `--parallel` switch, which can yield pretty dramatic improvements in overall build time.
