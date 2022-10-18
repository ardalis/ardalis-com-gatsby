---
templateKey: blog-post
title: Scaling Redis
date: 2022-10-17
description: Scaling Redis using a Redis Cluster or ScaleOut Software's StateServer.
path: blog-post
featuredpost: false
featuredimage: /img/connect-to-linux-ssh.png
tags:
  - software development
  - linux
  - ssh
category:
  - Software Development
comments: true
share: true
---

Redis is a popular open source cache server. When you have a web application that reaches the point of needing more than one front end server, or which has a database that's under too much load, introducing a Redis server between the application server and its database is a common approach. However, sometimes a single redis server is insufficient for the required load and performance requirements. When you need more performance than a single redis instance can offer, you need to consider how you're going to be scaling redis in your application's architecture. This article goes into detail on how to work with Redis and scale it using the built-in clustering tools. In addition, we'll look at an alternative using ScaleOut StateServer's product, which offers several advantages over the built-in solution.

**NOTE:** I've know the team at ScaleOut Software for over a decade. They're an extremely nice and talented group, and they provided me with a hosting environment and other consideration for this article and its associated video. While they did provide technical assistance on the tests and evaluation performed, any errors should be considered my own.

## Starting Small

Let's begin by assuming we have a need for a cache solution like Redis in the first place. Imaging you are working with a simple web app that talks to a backend database. Your initial architecture looks something like this:

![screenshot showing browser-app-sqldb](/img/scaling-redis-simple-growing-app.png)

Your initial architecture is incredibly simple. Browsers make requests to your app, and your app in turn makes requests to the database to get or modify data. However, as traffic has grown, load on the database has increased and the speed of responses to the browser has decreased during peak periods.

You decide the simplest solution to this problem is to introduce a cache server, namely Redis, and to modify your app to check if a given data result is in Redis before seeking it in the database itself.

## Adding a Single Redis Server Instance

It's pretty straightforward to install a single Redis instance. After provisioning a unix VM, just run the following commands:

```bash
$ sudo apt update
(done)
$ sudo apt install redis-tools
(done)
$ sudo apt install redis-server
(done)
redis-cli
127.0.0.1:6379> ping
PONG
```

You can use the [StackExchange.Redis client](https://stackexchange.github.io/) to connect to your Redis server from your app.

After adding a Redis cache server to your architecture, things now look like this:

![screenshot showing browser-app-redis-sqldb](/img/scaling-redis-growing-app-single-redis.png)

Of course, for both scalability and availability reasons, we're going to want to horizontally scale the web app. And with it, in order to remove the single point of failure, we'll also want to add additional Redis caches. An initial naive approach might look like this:

![screenshot showing browser load balancer 3 web apps and 3 separate redis caches plus a sqldb](/img/scaling-redis-scaling-out-naive.png)

The problem with this design is data synchronization. The web apps are, presumably, stateless, but the Redis instances are not. A request may be served by the first app which has one version of the data in its cache, and the next request may be served by a different web app, with a separate redis instance associated with it and different, perhaps older, data in its cache. This can be mitigated through the use of [sticky sessions](https://www.linode.com/docs/guides/configuring-load-balancer-sticky-session/) at the load balancer, but that's not an ideal solution for scalability.
