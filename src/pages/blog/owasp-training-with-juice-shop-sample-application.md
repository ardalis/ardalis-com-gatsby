---
templateKey: blog-post
title: OWASP Training with Juice Shop Sample Application
path: /owasp-training-with-juice-shop-sample-application
date: 2018-10-24
featuredpost: false
featuredimage: /img/juice-shop-home-760x360.png
tags:
  - docker
  - juice shop
  - owasp
  - security
category:
  - Security
comments: true
share: true
---
If you’re a web developer looking to get better at security (which should be to say, if you’re a web developer), you should check out the [OWASP Juice Shop application](https://www.owasp.org/index.php/OWASP_Juice_Shop_Project). It’s a purposely insecure web application that tracks your progress as you attempt to exploit it in various ways. As you do so, you unlock achievements and can track your progress. The various exploits range from the simple to the complex and difficult, with 6 different levels of vulnerabilities. There are several ways to run the application, but I favor the docker container approach. If you haven’t had a chance to play with docker yet, consider this your opportunity. I’ll walk you through the steps needed to get the Juice Shop running in a local docker container, and point you in the direction of your first successful hack against the site (spoiler alert – a little help coming at the end of this article).

## Install Docker

If you don’t have docker installed, install it first. I’ve successfully run the container on both Mac and Windows. It’s a linux container so if you’re installing on Windows (or have previously installed Docker for Windows) make sure you’re set up to host linux containers, not Windows containers.

## Pull and Run the Juice Shop Container

[![](/img/Juice-Shop-Docker-Mac-1024x330.png)](/img/Juice-Shop-Docker-Mac-1024x330.png)

To run the container, you need to pull the image from docker’s repository of images, and then run it, mapping ports as needed. Here are the two commands needed:

```powershell
docker pull bkimminich/juice-shop

docker run --rm -p 3000:3000 bkimminich/juice-shop
```

Once the application is running in the container, you can browse to it by going to **localhost:3000**.

Note that this application runs on node, but you don’t have the have node installed to run it! If you have docker installed, you can run applications that require any platform without having to install that platform itself. If you’re a .NET Core developer, for instance, and for whatever reason you don’t want to install the SDK, you can use a docker container to build your software (in addition to running the application itself, of course). With docker containers, it’s easy to build against different frameworks using command line build tools, instead of having to have VMs with different versions of SDKs or Visual Studio tools installed, for instance.

## Explore the Application (minor spoilers below)

Now that you have the application running, browse around it and explore. Check out the products. Add things to your cart. Check out. Leave reviews. Etc. As you look at the site’s features, think about how you might be able to get access to parts of the application you’re not authorized to reach. Consider using additional tools to see how the site is behaving, such as Chrome dev tools or Fiddler.

Two hints follow – read on if you want a bit of help getting started with a some guidance.

First, imagine that some parts of the site may be available, if only you can guess their URL. And sometimes, you don’t need to guess, so much as discover where the path to such things might be hidden. Sometimes, what’s shown in the browser isn’t the whole story, and you’ll be able to find additional information if you examine the source HTML, or the detailed requests/responses made to/from the site.

One of the first challenges you’re likely to discover is the existence of a list of challenges, which will track your progress:

[![](/img/Juice-Shop-Challenges.png)](/img/Juice-Shop-Challenges.png)

That’s the first hint. As you unlock challenges, you’ll get a banner in the web application, and your progress is tracked locally in a cookie. As long as you don’t clear your cookies (and you use the same browser), you can keep coming back to the application even if you kill the process and restart it, reboot your machine, etc.

The second hint is, be aware of SQL injection attacks. These are one of the OWASP Top 10 security flaws in web sites, still, though many data access frameworks and ORM tools make it more difficult today. Think about some parts of the site that might take user input and construct SQL queries from it. Frequently, these queries will take this form:

```
SELECT Columns
FROM table
WHERE Column = ' + userInput + '
AND otherConditions
```

If you’re able to drop your own text directly into such a query, you can do quite a lot. One way to detect whether such a vulnerability exists is to simply put a single quote (‘) into the form and see what results you get. If the system treats the single quote as input, you’ll probably just see that the query doesn’t return any matching results. But if a SQL Injection vulnerability exists, the single quote will break the query and you’ll get an error. If the application doesn’t handle errors appropriately, it might even show you details of the query it was running, which could help you with additional attempts to use the vulnerability in malicious ways.

## Summary

There are over 60 challenges in the Juice Shop application. I haven’t discovered them all, but I’ve learned a lot and had fun discovering a bunch of level 1-3 challenges. If you find this interesting, I recommend also checking out [Troy Hunt’s Hack Yourself First course on Pluralsight](https://www.pluralsight.com/courses/hack-yourself-first), which has a live site you can try to hack (but it doesn’t track your progress).