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

[Redis](https://redis.io/) is a popular open source cache server. When you have a web application that reaches the point of needing more than one front end server, or which has a database that's under too much load, introducing a Redis server between the application server and its database is a common approach. However, sometimes a single redis server is insufficient for the required load and performance requirements. When you need more performance than a single redis instance can offer, you need to consider how you're going to be [scaling redis](https://redis.io/docs/manual/scaling/) in your application's architecture. This article goes into detail on how to work with Redis and scale it using the built-in clustering tools. In addition, we'll look at an alternative using [ScaleOut StateServer's product, which offers several advantages over the built-in solution](https://www.scaleoutsoftware.com/featured/redis-vs-scaleout-what-you-need-to-know/).

**NOTE:** I've known the team at ScaleOut Software for over a decade. They're an extremely nice and talented group, and they provided me with a hosting environment and other consideration for this article and its associated video. While they did provide technical assistance on the tests and evaluation performed, any errors should be considered my own.

## Starting Small

Let's begin by assuming we have a need for a cache solution like Redis in the first place. Imagine you are working with a simple web app that talks to a backend database. Your initial architecture looks something like this:

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

You can use the [StackExchange.Redis client](https://stackexchange.github.io/) to connect to your Redis server from your .NET app. Typically you will apply the [cache aside pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/cache-aside), checking the cache first, and only fetching from the database when the item sought isn't in the cache (or has expired which equates to the same thing). After fetching from the database, the item is stored in the cache so it's available the next time it's requested.

After adding a Redis cache server to your architecture, things now look like this:

![screenshot showing browser-app-redis-sqldb](/img/scaling-redis-growing-app-single-redis.png)

Of course, for both scalability and availability reasons, we're going to want to horizontally scale the web app. And along with scaling the web servers, in order to remove the single point of failure, we'll also want to add additional Redis caches. An initial naive approach might look like this (scale the webserver-cache pairs):

![screenshot showing browser load balancer 3 web apps and 3 separate redis caches plus a sqldb](/img/scaling-redis-scaling-out-naive.png)

The problem with this design is data synchronization. The web apps are, presumably, stateless, but the Redis instances are not. A request may be served by the first app which has one version of the data in its cache, and the next request may be served by a different web app, with a separate redis instance associated with it and different, perhaps older, data in its cache. This can be mitigated through the use of [sticky sessions](https://www.linode.com/docs/guides/configuring-load-balancer-sticky-session/) at the load balancer, but that's not an ideal solution for scalability. What we need is a way to scale the redis servers while keeping their contents synchronized. Redis has a scaling solution - it's a Redis Cluster.

### Scaling Redis with Redis Cluster

From the docs:

> Redis scales horizontally with a deployment topology called Redis Cluster.
> Redis Cluster provides a way to run a Redis installation where data is automatically sharded across multiple Redis nodes.

We want to take our 3 separate Redis instances and make a cluster out of them, so that all three webservers get the same data back consistently when working with the cache. Let's follow the docs for setting up a redis cache.

### Redis Cluster 101

First, some background in the "Redis Cluster 101" section, which I'll summarize in bullets:

- Data is sharded automatically across multiple Redis nodes
- Some availability during partitions (Cluster can stay up when a node is disconnected or down)
- Requires two ports: 6379 (standard Redis port) and a *cluster bus port* 16379 (typically)
- Some considerations when running with Docker: must use *host networking mode*
- Keys belong to *hash slots*
- There are 16384 hash slots
- Hash slots are computed by taking the [CRC16 of the key](https://crccalc.com/), modulo 16384
- Each Redis node is responsible for a set of hash slots
- Moving hash slots becomes important when adding/removing nodes to/from the cluster
- Redis uses a master-replica model, with the replica acting as a hot backup of its master
- Redis does not guarantee **strong consistency**
- "it is possible that Redis Cluster will lose writes that were acknowledged ty the system to the client"
- There is a tradeoff between speed and consistency; Redis favors speed
- The node timeout configuration is very important to understand and consider regarding timeouts

Ok, on to the next section of the docs, "Redis Cluster configuration parameters.

### Redis Cluster configuration parameters

These are found and set in the **redis.conf** file.

- **cluster-enabled**. Obviously very important. Must be *yes* to use a cluster.
- **cluster-config-file**. The filename that will hold certain redis cluster settings (not a user file)
- **cluster-node-timeout**. How long a node can be unavailable (in milliseconds) before it fails over.

There were a few more settings but none I needed to use. Which brings us to the next section of the docs, "Create an use a Redis Cluster."

### Create and use a Redis Cluster

> To create a cluster, the first thing you need is to have a few Redis instances running in *cluster mode*.

Recall that we have 3 Redis instances from above, so we should just need to put them into "cluster mode". The docs go on to show the following as the minimal settings we need to configure in `redis.conf`:

![minimum configuration settings](/img/scaling-redis-minium-config.png)

**Note:** We don't want to change the default port so we'll keep 6379.

Ok, so to set this up we just need to [ssh into each linux VM](https://ardalis.com/connect-to-linux-ssh/) and edit its `redis.conf` file to make these changes. We have 3 nodes so it's a bit tedious but not so large a task that it's worth scripting (IMO). Here's an example of what you need:

```powershell
> ssh -i ".ssh/ss.pem" ss@dev1
Enter passphrase for key '.ssh/ss.pem':

> sudo nano /etc/redis/redis.conf
```

Note that path of `/etc/redis/redis.conf`. Nothing in the Redis Cluster docs tells you this is where the Redis configuration file is located (though it's probably mentioned elsewhere).

Oh, but what's this?

![minimal cluster size is 3 masters with 3 replicas "For deployment, we strongly recommend a six-node cluster, with three masters and three replicas."](/img/scaling-redis-minimal-cluster-size.png)

Great... so now I need to double the hardware I was planning on using. And also, twice as many config files to manually edit. But I guess this is how we live now.

![this is how we live now](/img/this-is-how-we-live-now-walking-dead.jpg)

Ok, so spin up 3 more linux machines/VMs, configure them for ssh, install Redis, ssh into them, edit the config files, set up the minimal settings. Whew!

#### Create a Redis Cluster

Now we're ready to use the `redis-cli` to create a cluster. The syntax is pretty straightforward; just pass in `--cluster create` and a list of IP:port combinations. If you're configuring replicas (we are), you need to add `--cluster-replicas 1` at the end (or however many replicas you want for each master). With 6 nodes (6 IP/port combos) and cluster-replicas 1, you'll get 3 master nodes and 3 replica nodes.

I run the command, and it fails with this:

```powershell
Could not connect to Redis at dev2:6379: Connection refused
```

#### Troubleshooting Redis Cluster Creation
