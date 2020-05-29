---
templateKey: blog-post
title: Insidious Dependencies
path: blog-post
date: 2008-10-19T14:11:00.000Z
description: In the last year or so I’ve really seen the light on how to really
  write loosely-coupled code. I thought I knew something about this concept
  before – I mean, I knew loose coupling was good, generally speaking, and I
  knew data abstraction was one of the key ways to limit dependencies between
  classes.
featuredpost: false
featuredimage: /img/default-post-image.jpg
tags:
  - IFileSystem
category:
  - Uncategorized
comments: true
share: true
---
In the last year or so I’ve really seen the light on how to really write loosely-coupled code. I thought I knew something about this concept before – I mean, I knew loose coupling was good, generally speaking, and I knew data abstraction was one of the key ways to limit dependencies between classes. However, I didn’t realize that I was unintentionally adding all kinds of coupling into my applications despite my best efforts to the contrary. Let’s talk about some dependencies, including some obvious ones, as well as some insidious dependencies that lurk in most applications I’ve seen.

**Big Fat Obvious Dependencies**

Let’s assume you’re working with a .NET application. Guess what? You’re dependent on the .NET Framework, a particular CLR version, and most likely the Windows platform unless you’ve tested your application on Mono. Are you working with a database? If so, then you likely have a dependency on your database platform, and depending on how flexibly you architect your application, you’ll either be tightly or loosely coupled to your database implementation. Naturally it’s going to be better for maintenance and testing if you can easily swap out your data access and persistence provider. This is the canonical dependency that most people think about when they need to demonstrate a use for [Dependency Inversion / Injection](http://en.wikipedia.org/wiki/Dependency_injection). Consider a few others, however…

**Insidious Dependencies**

**The File System**

The file system is a clear dependency that should be abstracted behind an interface and passed into methods or objects that require it. This will allow tests to be written without regard for where files are located, and it makes it much easier to set up new test environments (such as when a new developer needs to get set up). This one is pretty obvious, but is easy to overlook. Look for references to System.IO in your project that aren’t in a particular implementation of an IFileSystem interface.

Update: [How to Refactor Code That Depends on the File System](http://ardalis.com/refactoring-file-system-access)

**Email**

I blogged recently about [avoiding dependencies](/avoiding-dependencies), with the example in that case being email. Direct calls to System.Net.Mail should be avoided – instead create an IEmailProvider or INotificationService interface that is responsible for abstracting the process of delivering messages.

**Web Services and Requests**

Anything that calls out of process is automatically something you should be looking at as a dependency for your application. Wrap calls to web services and other System.Net requests in interfaces so that you can easily implement test versions of their functionality. As with System.IO, be wary of any System.Net namespaces you find in your code that isn’t in a service implementing an interface you’ve set up to shield yourself from this dependency.

**DateTime.Now and DateTime.Today**

Definitely under the category of insidious. Having references to the system clock within your application code is a big time dependency that makes code much more difficult to test. For instance, what if you have a requirement that you only send emails on weekdays, not weekends – how are you going to test that it’s working correctly? Only run some tests on weekdays and other tests on weekends? A better alternative is to have an IDateTime or ICalendar interface and a default SystemDateTime implementation that provides access to the system clock. In tests, a separate StubDateTime (or a mock framework) can be used which can have specific values specified for its Now and Today methods. I have a ton of DateTime.Now calls in one of my applications that I’m slowly converting, but it’s good to see the code get better and the testing easier.

Update: [How to Refactor Code That Depends on the System Clock](http://ardalis.com/refactoring-static-system-clock-access)

**Configuration**

I didn’t realize until recently that even configuration files are dependencies that one might want to abstract out. I’d thought that config files were already loosely coupled, because they were easy to separate and alter independently from the application itself. However, as they grow in number and complexity, configuration files can quickly add significant overhead to setting up a new test or staging environment for an application. In one of our projects, configuration files hold certain file paths which vary based on the developer’s environment, so each dev has a separate, different copy of the config file with their own local paths specified. These files cannot go into source control (directly – a template is in source control) and so new devs must create their own config file. Further, these config files need to be deployed during testing, so MSTest must be configured to deploy them.

A better alternative – wrap all of the configuration logic behind an interface and in testing modes, have a simple config class that doesn’t read its setting from a file but simply returns back the reasonable test values. This combined with mocking out the File System would eliminate the need for complex configuration file set up and deployment within the test and dev environment. This is still on my TODO list for this project, so I’ll blog more once it’s done.

Update: [How to Refactor Code That Depends on Configuration](http://ardalis.com/refactoring-static-config-access)

**New**

Finally, the most insidious dependency of the bunch has to be the ***new*** operator. Every time you instantiate a concrete instance of a class, you’re establishing a dependency on that particular implementation. With an IoC container, it’s possible to minimize the number of places where you need to do this. Instead, wherever variation or coupling may exist, interfaces can be used in place of implementation classes, and the IoC container can be used to determine the concrete implementation used. Naturally you can’t get away from all instances of new in your project, but do realize that wherever you see it, it’s indicating a dependency in your code.

**Others?**

This is, I’m sure, not an exhaustive list. It represents some of the things I went looking for in one of my projects’ codebases this weekend. What other insidious dependencies have you uncovered in your own projects? How did you deal with them?